From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Re: pcm_jack multi-channel and configurability patch
Date: Mon, 17 Feb 2003 16:54:55 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030217165455.6baa71c8.mdeboer@iua.upf.es>
References: <20030217165312.7464ccdd.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__17_Feb_2003_16:54:55_+0100_0844cd28"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030217165312.7464ccdd.mdeboer@iua.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart_Mon__17_Feb_2003_16:54:55_+0100_0844cd28
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I wrote:
> Attach you find another pcm_jack patch, that contains some major
> changes.

Forgot to attach it.

Maarten

--Multipart_Mon__17_Feb_2003_16:54:55_+0100_0844cd28
Content-Type: text/plain;
 name="pcm_jack_patch_multichannel_and_conf.diff"
Content-Disposition: attachment;
 filename="pcm_jack_patch_multichannel_and_conf.diff"
Content-Transfer-Encoding: 7bit

Index: include/pcm_plugin.h
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/include/pcm_plugin.h,v
retrieving revision 1.6
diff -u -r1.6 pcm_plugin.h
--- include/pcm_plugin.h	12 Feb 2003 21:57:50 -0000	1.6
+++ include/pcm_plugin.h	17 Feb 2003 15:49:43 -0000
@@ -187,6 +187,8 @@
  *  Jack plugin
  */
 int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
+					snd_config_t *playback_conf,
+					snd_config_t *capture_conf,
 		      snd_pcm_stream_t stream, int mode);
 int _snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
                        snd_config_t *root, snd_config_t *conf,
Index: src/pcm/pcm_jack.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_jack.c,v
retrieving revision 1.4
diff -u -r1.4 pcm_jack.c
--- src/pcm/pcm_jack.c	14 Feb 2003 19:26:35 -0000	1.4
+++ src/pcm/pcm_jack.c	17 Feb 2003 15:49:44 -0000
@@ -27,30 +27,13 @@
  */
 
 #include "config.h"
-#ifdef HAVE_JACK
-#define USE_JACK
-#endif
 
 #include <byteswap.h>
 #include <sys/shm.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include "pcm_local.h"
-#ifdef USE_JACK
 #include <jack/jack.h>
-#endif
-
-#if 1
-#define JACK_PLAYBACK_PORT1	"alsa_pcm:playback_1"
-#define JACK_PLAYBACK_PORT2	"alsa_pcm:playback_2"
-#define JACK_CAPTURE_PORT1	"alsa_pcm:capture_1"
-#define JACK_CAPTURE_PORT2	"alsa_pcm:capture_2"
-#else
-#define JACK_PLAYBACK_PORT1	"alsa_pcm:out_1"
-#define JACK_PLAYBACK_PORT2	"alsa_pcm:out_2"
-#define JACK_CAPTURE_PORT1	"alsa_pcm:in_1"
-#define JACK_CAPTURE_PORT2	"alsa_pcm:in_2"
-#endif
 
 #define PCM_JACK_DEBUG
 
@@ -74,12 +57,16 @@
 	snd_pcm_uframes_t appl_ptr;
 	snd_pcm_uframes_t hw_ptr;
 
+	char** playback_ports;
+	char** capture_ports;
+	unsigned int playback_ports_n;
+	unsigned int capture_ports_n;
+
 	unsigned int channels;
+	snd_pcm_channel_area_t *areas;
 
-#ifdef USE_JACK
 	jack_port_t **ports;
 	jack_client_t *client;
-#endif
 } snd_pcm_jack_t;
 
 #endif /* DOC_HIDDEN */
@@ -92,11 +79,20 @@
 #ifdef PCM_JACK_DEBUG
 	printf("snd_pcm_jack_close\n"); fflush(stdout);
 #endif
-#ifdef USE_JACK
 	if (jack->client)
+	{
 		jack_client_close(jack->client);
-#endif
+		jack->client = 0;
+	}
+
+	if (jack->playback_ports)
+		free(jack->playback_ports);
+	if (jack->capture_ports)
+		free(jack->capture_ports);
+	if (jack->areas)
+		free(jack->areas);
 	free(jack);
+
 	return err;
 }
 
@@ -198,38 +194,43 @@
 	return 0;
 }
 
-#ifdef USE_JACK
 int
 snd_pcm_jack_process_cb (jack_nframes_t nframes, snd_pcm_t *pcm)
 {
 	snd_pcm_jack_t *jack = pcm->private_data;
 	const snd_pcm_channel_area_t *areas;
 	snd_pcm_uframes_t xfer = 0, samples;
-	snd_pcm_channel_area_t area;	
 	char buf[1];
-
+	unsigned int channel;
+	
 #ifdef PCM_JACK_DEBUG
-	printf("PROCESS!\n");
+	printf("PROCESS %d!\n",jack->state);
 #endif
 
-	area.addr = jack_port_get_buffer (jack->ports[0], nframes);
-	area.first = 0;
-	area.step = pcm->sample_bits;
-
+	for (channel = 0; channel < jack->channels; channel++) {
+		jack->areas[channel].addr = 
+			jack_port_get_buffer (jack->ports[channel], nframes);
+		jack->areas[channel].first = 0;
+		jack->areas[channel].step = pcm->sample_bits;
+	}
+		
 	if (jack->state != SND_PCM_STATE_RUNNING) {
-		if (pcm->stream == SND_PCM_STREAM_PLAYBACK)
-			snd_pcm_area_silence(&area, 0, nframes, pcm->format);
-		return 0;
+		if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
+			for (channel = 0; channel < jack->channels; channel++) {
+				snd_pcm_area_silence(&jack->areas[channel], 0, nframes, pcm->format);
+			}
+			return 0;
+		}
 	}
-
-	areas = snd_pcm_mmap_areas(pcm);
 	
+	areas = snd_pcm_mmap_areas(pcm);
+
 	while (xfer < nframes)
 	{
 		snd_pcm_uframes_t frames = nframes - xfer;
 		snd_pcm_uframes_t offset = snd_pcm_mmap_hw_offset(pcm);
 		snd_pcm_uframes_t cont = pcm->buffer_size - offset;
-		
+
 		if (cont < frames)
 			frames = cont;
 
@@ -238,17 +239,20 @@
 			(int)offset,(int)jack->hw_ptr,(int)nframes,(int)frames,(int)pcm->buffer_size); fflush(stdout);
 #endif
 
-		if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
-			snd_pcm_area_copy(&area, xfer, &areas[0], offset, frames, pcm->format);
-		} else {
-			snd_pcm_area_copy(&areas[0], offset, &area, xfer, frames, pcm->format);
+		for (channel = 0; channel < jack->channels; channel++)
+		{
+			if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
+				snd_pcm_area_copy(&jack->areas[channel], xfer, &areas[channel], offset, frames, pcm->format);
+			} else {
+				snd_pcm_area_copy(&areas[channel], offset, &jack->areas[channel], xfer, frames, pcm->format);
+			}
 		}
 		
 		snd_pcm_mmap_hw_forward(pcm,frames);
 		xfer += frames;
 	}
 
-        if (pcm->stop_threshold < pcm->boundary) {
+	if (pcm->stop_threshold < pcm->boundary) {
 		samples = snd_pcm_mmap_avail(pcm);
 		if (samples >= pcm->stop_threshold) {
 			gettimeofday(&jack->trigger_tstamp, 0);
@@ -256,7 +260,7 @@
 			jack->avail_max = samples;
 		}
 	}
-                         	
+	                         	
 	write(jack->fd,buf,1); /* for polling */
 
 #ifdef PCM_JACK_DEBUG
@@ -265,7 +269,6 @@
 	
 	return 0;      
 }
-#endif
 
 static int snd_pcm_jack_prepare(snd_pcm_t *pcm)
 {
@@ -281,7 +284,6 @@
 
 	jack->appl_ptr = jack->hw_ptr = 0;
 
-#ifdef USE_JACK
 	jack->ports = calloc (pcm->channels, sizeof(jack_port_t*));
 	for (i = 0; i < pcm->channels; i++)
 	{
@@ -329,53 +331,48 @@
 	jack->activated = 1;
 
 	if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
-		for (i = 0; i < pcm->channels; i++)
-		{
-			if (jack_connect (jack->client, jack_port_name (jack->ports[i]), JACK_PLAYBACK_PORT1))
-			{
-				fprintf (stderr, "cannot connect output ports\n");
-				return -EIO;
-			}else{
-#ifdef PCM_JACK_DEBUG
-				printf("connected %s to alsa_pcm:playback_1",jack_port_name(jack->ports[i]));
-#endif
-			}
-			if (jack_connect (jack->client, jack_port_name (jack->ports[i]),JACK_PLAYBACK_PORT2))
-			{
-				fprintf (stderr, "cannot connect output ports\n");
-				return -EIO;
-			}else{
-#ifdef PCM_JACK_DEBUG
-				printf("connected %s to alsa_pcm:playback_2",jack_port_name(jack->ports[i]));
+		for (i = 0; i < pcm->channels && i < jack->playback_ports_n; i++)
+		{	
+			if ( jack->playback_ports[i]) {
+				if (jack_connect (jack->client, 
+					jack_port_name (jack->ports[i]), 
+					jack->playback_ports[i]))
+				{
+					fprintf(stderr, "cannot connect %s to %s",
+						jack_port_name(jack->ports[i]),
+						jack->playback_ports[i]);
+					return -EIO;
+				}
+#ifdef PCM_JACK_DEBUG
+				printf("connected %s to %s\n",
+					jack_port_name(jack->ports[i]),
+					jack->playback_ports[i]);
+				fflush(stdout);
 #endif
 			}
 		}
-	} else {
-		for (i = 0; i < pcm->channels; i++)
-		{
-			if (jack_connect (jack->client, 
-				JACK_CAPTURE_PORT1,jack_port_name (jack->ports[i])))
-			{
-				fprintf (stderr, "cannot connect input ports\n");
-				return -EIO;
-			}else{
-#ifdef PCM_JACK_DEBUG
-				printf("connected %s to alsa_pcm:capture_1",jack_port_name(jack->ports[i]));
-#endif
-			}
-			if (jack_connect (jack->client, 
-				JACK_CAPTURE_PORT2,jack_port_name (jack->ports[i])))
-			{
-				fprintf (stderr, "cannot connect input ports\n");
-				return -EIO;
-			}else{
-#ifdef PCM_JACK_DEBUG
-				printf("connected %s to alsa_pcm:capture_2",jack_port_name(jack->ports[i]));
+	}else{
+		for (i = 0; i < pcm->channels && i < jack->capture_ports_n; i++)
+		{	
+			if ( jack->capture_ports[i]) {
+				if (jack_connect (jack->client, 
+					jack->capture_ports[i],
+					jack_port_name (jack->ports[i])))
+				{
+					fprintf(stderr, "cannot connect %s to %s",
+						jack->capture_ports[i],
+						jack_port_name(jack->ports[i]));
+					return -EIO;
+				}
+#ifdef PCM_JACK_DEBUG
+				printf("connected %s to %s\n",
+					jack->capture_ports[i],
+					jack_port_name(jack->ports[i]));
+				fflush(stdout);
 #endif
 			}
 		}
 	}
-#endif
 	
 	jack->state = SND_PCM_STATE_RUNNING;
 
@@ -385,7 +382,6 @@
 static int snd_pcm_jack_drop(snd_pcm_t *pcm)
 {
 	snd_pcm_jack_t *jack = pcm->private_data;
-	unsigned int i;
 	
 #ifdef PCM_JACK_DEBUG
 	printf("snd_pcm_jack_drop\n"); fflush(stdout);
@@ -614,6 +610,46 @@
 	mmap_commit: snd_pcm_jack_mmap_commit,
 };
 
+static int parse_ports(snd_config_t *conf,char*** ret_ports,int *ret_n)
+{
+	snd_config_iterator_t i, next;
+	char** ports = NULL;
+	unsigned int cnt = 0;
+	unsigned int channel;
+
+	if (conf) {
+		snd_config_for_each(i, next, conf) {
+			snd_config_t *n = snd_config_iterator_entry(i);
+			const char *id;
+			if (snd_config_get_id(n, &id) < 0)
+				continue;
+			cnt++;
+		}
+		ports = calloc(cnt,sizeof(char*));
+		for (channel = 0; channel < cnt; channel++)
+			ports[channel] = NULL;
+		
+		snd_config_for_each(i, next, conf) {
+			snd_config_t *n = snd_config_iterator_entry(i);
+			const char *id;
+			const char *port;
+
+			if (snd_config_get_id(n, &id) < 0)
+				continue;
+
+			channel = atoi(id);
+
+			if (snd_config_get_string(n, &port) < 0)
+				continue;
+
+			ports[channel] = port ? strdup(port) : NULL;
+		}
+	}
+	*ret_ports = ports;
+	*ret_n = cnt;
+	return 0;
+}
+
 /**
  * \brief Creates a new jack PCM
  * \param pcmp Returns created PCM handle
@@ -626,6 +662,8 @@
  *          changed in future.
  */
 int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
+	snd_config_t *playback_conf,
+	snd_config_t *capture_conf,
 	snd_pcm_stream_t stream, int mode)
 {
 	snd_pcm_t *pcm;
@@ -634,31 +672,53 @@
 	int fd[2];
 	
 	assert(pcmp);
+#ifdef PCM_JACK_DEBUG
 	printf("snd_pcm_jack_open\n"); fflush(stdout);
+#endif
 	jack = calloc(1, sizeof(snd_pcm_jack_t));
 	if (!jack) {
 		return -ENOMEM;
 	}
-	jack->channels = 2;	/* FIXME: should be configurable */
 
-#ifdef USE_JACK
-	if (stream == SND_PCM_STREAM_PLAYBACK)
+	jack->playback_ports = NULL;
+	jack->playback_ports_n = 0;
+
+	jack->capture_ports = NULL;
+	jack->capture_ports_n = 0;
+	
+	err = parse_ports(playback_conf,
+		&jack->playback_ports,&jack->playback_ports_n);
+	if (err)
+		goto _free;
+
+	err = parse_ports(capture_conf,
+		&jack->capture_ports,&jack->capture_ports_n);
+	if (err)
+		goto _free;
+
+	if (stream == SND_PCM_STREAM_PLAYBACK) {
+		jack->channels = jack->playback_ports_n;
 		jack->client = jack_client_new("alsaP");
-	else
+	}
+	else {
+		jack->channels = jack->capture_ports_n;
 		jack->client = jack_client_new("alsaC");
-	
-	if (jack->client==0)
-		return -ENOENT;	
-#endif
+	}
+
 
+	if (jack->client==0) {
+		err = -ENOENT;	
+		goto _free;
+	}
+	
 	jack->state = SND_PCM_STATE_OPEN;
 
 	err = snd_pcm_new(&pcm, SND_PCM_TYPE_JACK, name, stream, mode);
 	
 	if (err < 0) {
-		free(jack);
-		return err;
+		goto _free;
 	}
+
 	pcm->ops = &snd_pcm_jack_ops;
 	pcm->fast_ops = &snd_pcm_jack_fast_ops;
 	pcm->private_data = jack;
@@ -671,11 +731,35 @@
 	pcm->poll_fd = fd[1];
 	pcm->poll_events = POLLIN;
 
+	jack->areas = calloc(jack->channels,sizeof(snd_pcm_channel_area_t));
+
 	snd_pcm_set_hw_ptr(pcm, &jack->hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &jack->appl_ptr, -1, 0);
 	*pcmp = pcm;
 
 	return 0;
+
+_free:
+	if (jack) {
+		if (jack->playback_ports)
+		{
+			unsigned int k;
+			for (k = 0; k < jack->playback_ports_n; k++)
+				if (jack->playback_ports[k])
+					free(jack->playback_ports[k]);
+			free(jack->playback_ports);
+		}
+		if (jack->capture_ports)
+		{
+			unsigned int k;
+			for (k = 0; k < jack->capture_ports_n; k++)
+				if (jack->capture_ports[k])
+					free(jack->capture_ports[k]);
+			free(jack->capture_ports);
+		}
+		free(jack);
+	}
+	return err;
 }
 
 /*! \page pcm_plugins
@@ -702,6 +786,10 @@
 		       snd_pcm_stream_t stream, int mode)
 {
 	snd_config_iterator_t i, next;
+	snd_config_t *playback_conf = NULL;
+	snd_config_t *capture_conf = NULL;
+	int err;
+	
 	snd_config_for_each(i, next, conf) {
 		snd_config_t *n = snd_config_iterator_entry(i);
 		const char *id;
@@ -709,10 +797,32 @@
 			continue;
 		if (snd_pcm_conf_generic_id(id))
 			continue;
+		if (strcmp(id, "playback_ports") == 0) {
+			if (snd_config_get_type(n) != SND_CONFIG_TYPE_COMPOUND) {
+				SNDERR("Invalid type for %s", id);
+				return -EINVAL;
+			}
+			playback_conf = n;
+			continue;
+		}
+		if (strcmp(id, "capture_ports") == 0) {
+			if (snd_config_get_type(n) != SND_CONFIG_TYPE_COMPOUND) {
+				SNDERR("Invalid type for %s", id);
+				return -EINVAL;
+			}
+			capture_conf = n;
+			continue;
+		}
 		SNDERR("Unknown field %s", id);
 		return -EINVAL;
 	}
-	return snd_pcm_jack_open(pcmp, name, stream, mode);
+
+	err = snd_pcm_jack_open(pcmp, name, 
+		playback_conf,
+		capture_conf,
+		stream, mode);
+		
+	return err;
 }
 #ifndef DOC_HIDDEN
 SND_DLSYM_BUILD_VERSION(_snd_pcm_jack_open, SND_PCM_DLSYM_VERSION);

--Multipart_Mon__17_Feb_2003_16:54:55_+0100_0844cd28--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
