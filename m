From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK plugin v2 1/2] jack: Refactoring: Lower
	indentation
Date: Tue, 29 Jan 2019 15:30:55 +0100
Message-ID: <1548772256-30547-2-git-send-email-twischer@de.adit-jv.com>
References: <1548772256-30547-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1548772256-30547-1-git-send-email-twischer@de.adit-jv.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, patch@alsa-project.org
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

to full fill 80 character limit of next commit.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index b2bc213..724cbc2 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -105,23 +105,25 @@ static int pcm_poll_unblock_check(snd_pcm_ioplug_t *io)
 
 static void snd_pcm_jack_free(snd_pcm_jack_t *jack)
 {
-	if (jack) {
+	if (jack == NULL)
+		return;
+
+	if (jack->client)
+		jack_client_close(jack->client);
+	if (jack->port_names) {
 		unsigned int i;
-		if (jack->client)
-			jack_client_close(jack->client);
-		if (jack->port_names) {
-			for (i = 0; i < jack->num_ports; i++)
-				free(jack->port_names[i]);
-			free(jack->port_names);
-		}
-		if (jack->fd >= 0)
-			close(jack->fd);
-		if (jack->io.poll_fd >= 0)
-			close(jack->io.poll_fd);
-		free(jack->areas);
-		free(jack->ports);
-		free(jack);
+
+		for (i = 0; i < jack->num_ports; i++)
+			free(jack->port_names[i]);
+		free(jack->port_names);
 	}
+	if (jack->fd >= 0)
+		close(jack->fd);
+	if (jack->io.poll_fd >= 0)
+		close(jack->io.poll_fd);
+	free(jack->areas);
+	free(jack->ports);
+	free(jack);
 }
 
 static int snd_pcm_jack_close(snd_pcm_ioplug_t *io)
@@ -418,31 +420,34 @@ static int parse_ports(snd_pcm_jack_t *jack, snd_config_t *conf)
 	unsigned int cnt = 0;
 	unsigned int channel;
 
-	if (conf) {
-		snd_config_for_each(i, next, conf) {
-			snd_config_t *n = snd_config_iterator_entry(i);
-			const char *id;
-			if (snd_config_get_id(n, &id) < 0)
-				continue;
-			cnt++;
-		}
-		jack->port_names = ports = calloc(cnt, sizeof(char*));
-		if (ports == NULL)
-			return -ENOMEM;
-		jack->num_ports = cnt;
-		snd_config_for_each(i, next, conf) {
-			snd_config_t *n = snd_config_iterator_entry(i);
-			const char *id;
-			const char *port;
-
-			if (snd_config_get_id(n, &id) < 0)
-				continue;
-			channel = atoi(id);
-			if (snd_config_get_string(n, &port) < 0)
-				continue;
-			ports[channel] = port ? strdup(port) : NULL;
-		}
+	if (conf == NULL)
+		return 0;
+
+	snd_config_for_each(i, next, conf) {
+		snd_config_t *n = snd_config_iterator_entry(i);
+		const char *id;
+
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+		cnt++;
 	}
+	jack->port_names = ports = calloc(cnt, sizeof(char*));
+	if (ports == NULL)
+		return -ENOMEM;
+	jack->num_ports = cnt;
+	snd_config_for_each(i, next, conf) {
+		snd_config_t *n = snd_config_iterator_entry(i);
+		const char *id;
+		const char *port;
+
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+		channel = atoi(id);
+		if (snd_config_get_string(n, &port) < 0)
+			continue;
+		ports[channel] = port ? strdup(port) : NULL;
+	}
+
 	return 0;
 }
 
-- 
2.7.4
