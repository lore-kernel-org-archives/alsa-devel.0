From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK plugin 2/2] jack: Support to connect
	multiple JACK ports with same ALSA channel
Date: Thu, 24 Jan 2019 15:42:55 +0100
Message-ID: <1548340975-32610-3-git-send-email-twischer@de.adit-jv.com>
References: <1548340975-32610-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1548340975-32610-1-git-send-email-twischer@de.adit-jv.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

The following example will connect ALSA channel 0 to JACK port
"system:playback_1" and "system:playback_3" and ALSA channel 1 to JACK
port "system:playback_2" and "system:playback_4":

pcm.jack {
	type jack
	playback_ports {
		0 [ system:playback_1 system:playback_3 ]
		1 [ system:playback_2 system:playback_4 ]
	}
}

The old syntax with only one port for one channel is still supported:
playback_ports {
	0 system:playback_1
	1 system:playback_2
}

Without this patch an additional JACK client has to be used to
automatically connect the second JACK port but this could take some
time. Therefore it misses for example the first audio period on the
second port.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 724cbc2..16826cb 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -31,13 +31,21 @@
 
 #define MAX_PERIODS_MULTIPLE 64
 
+typedef struct snd_pcm_jack_port_list {
+	struct snd_pcm_jack_port_list *next;
+	/* will always be allocated with size of the string.
+	 * See snd_pcm_jack_port_list_add().
+	 */
+	char name[0];
+} snd_pcm_jack_port_list_t;
+
 typedef struct {
 	snd_pcm_ioplug_t io;
 
 	int fd;
 	int activated;		/* jack is activated? */
 
-	char **port_names;
+	snd_pcm_jack_port_list_t **port_names;
 	unsigned int num_ports;
 	snd_pcm_uframes_t boundary;
 	snd_pcm_uframes_t hw_ptr;
@@ -53,6 +61,32 @@ typedef struct {
 	bool xrun_detected;
 } snd_pcm_jack_t;
 
+
+/* adds one element to the head of the list */
+static int snd_pcm_jack_port_list_add(snd_pcm_jack_t *jack,
+				      const unsigned int channel,
+				      const char * const name)
+{
+	const size_t name_size = strlen(name) + 1;
+	const size_t elem_size = sizeof(snd_pcm_jack_port_list_t) + name_size;
+	snd_pcm_jack_port_list_t *elem = NULL;
+
+	if (name == NULL)
+		return -EINVAL;
+
+	elem = calloc(1, elem_size);
+	if (elem == NULL)
+		return -ENOMEM;
+
+	strncpy(elem->name, name, name_size);
+	elem->name[name_size-1] = 0x00;
+	elem->next = jack->port_names[channel];
+
+	jack->port_names[channel] = elem;
+
+	return 0;
+}
+
 /* snd_pcm_ioplug_avail() was introduced after alsa-lib 1.1.6 */
 #if SND_LIB_VERSION < 0x10107
 static snd_pcm_uframes_t snd_pcm_ioplug_avail(const snd_pcm_ioplug_t *io,
@@ -113,9 +147,19 @@ static void snd_pcm_jack_free(snd_pcm_jack_t *jack)
 	if (jack->port_names) {
 		unsigned int i;
 
-		for (i = 0; i < jack->num_ports; i++)
-			free(jack->port_names[i]);
+		for (i = 0; i < jack->num_ports; i++) {
+			snd_pcm_jack_port_list_t *port_elem =
+					jack->port_names[i];
+
+			while (port_elem != NULL) {
+				snd_pcm_jack_port_list_t *next_port_elem =
+						port_elem->next;
+				free(port_elem);
+				port_elem = next_port_elem;
+			}
+		}
 		free(jack->port_names);
+		jack->port_names = NULL;
 	}
 	if (jack->fd >= 0)
 		close(jack->fd);
@@ -298,17 +342,22 @@ static int snd_pcm_jack_prepare(snd_pcm_ioplug_t *io)
 	jack->activated = 1;
 
 	for (i = 0; i < io->channels && i < jack->num_ports; i++) {
-		if (jack->port_names[i]) {
+		const char * const own_port = jack_port_name(jack->ports[i]);
+		snd_pcm_jack_port_list_t *port_elem;
+
+		for (port_elem = jack->port_names[i]; port_elem != NULL;
+		     port_elem = port_elem->next) {
 			const char *src, *dst;
 			if (io->stream == SND_PCM_STREAM_PLAYBACK) {
-				src = jack_port_name(jack->ports[i]);
-				dst = jack->port_names[i];
+				src = own_port;
+				dst = port_elem->name;
 			} else {
-				src = jack->port_names[i];
-				dst = jack_port_name(jack->ports[i]);
+				src = port_elem->name;
+				dst = own_port;
 			}
 			if (jack_connect(jack->client, src, dst)) {
-				fprintf(stderr, "cannot connect %s to %s\n", src, dst);
+				fprintf(stderr, "cannot connect %s to %s\n",
+					src, dst);
 				return -EIO;
 			}
 		}
@@ -416,7 +465,7 @@ static int jack_set_hw_constraint(snd_pcm_jack_t *jack)
 static int parse_ports(snd_pcm_jack_t *jack, snd_config_t *conf)
 {
 	snd_config_iterator_t i, next;
-	char **ports = NULL;
+	snd_pcm_jack_port_list_t **ports = NULL;
 	unsigned int cnt = 0;
 	unsigned int channel;
 
@@ -431,7 +480,7 @@ static int parse_ports(snd_pcm_jack_t *jack, snd_config_t *conf)
 			continue;
 		cnt++;
 	}
-	jack->port_names = ports = calloc(cnt, sizeof(char*));
+	jack->port_names = ports = calloc(cnt, sizeof(jack->port_names[0]));
 	if (ports == NULL)
 		return -ENOMEM;
 	jack->num_ports = cnt;
@@ -439,13 +488,31 @@ static int parse_ports(snd_pcm_jack_t *jack, snd_config_t *conf)
 		snd_config_t *n = snd_config_iterator_entry(i);
 		const char *id;
 		const char *port;
+		int err;
 
 		if (snd_config_get_id(n, &id) < 0)
 			continue;
 		channel = atoi(id);
-		if (snd_config_get_string(n, &port) < 0)
+		if (snd_config_get_string(n, &port) >= 0) {
+			err = snd_pcm_jack_port_list_add(jack, channel, port);
+			if (err < 0)
+				return err;
+		} else if (snd_config_get_type(n) == SND_CONFIG_TYPE_COMPOUND) {
+			snd_config_iterator_t k, next_k;
+
+			snd_config_for_each(k, next_k, n) {
+				snd_config_t *m = snd_config_iterator_entry(k);
+
+				if (snd_config_get_string(m, &port) < 0)
+					continue;
+				err = snd_pcm_jack_port_list_add(jack, channel,
+								 port);
+				if (err < 0)
+					return err;
+			}
+		} else {
 			continue;
-		ports[channel] = port ? strdup(port) : NULL;
+		}
 	}
 
 	return 0;
-- 
2.7.4
