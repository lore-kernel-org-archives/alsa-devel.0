From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: [PATCH] make JACK client name unique
Date: Wed, 04 Feb 2004 22:17:19 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1075929438.12299.163.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-WbczFC+juBNM5l87Bxu7"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-WbczFC+juBNM5l87Bxu7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Now that dmix is working well, I felt like trying something new. :)

This patch changes the JACK plugin to use a unique client name, which
allows for multiple ALSA streams to share a JACK server.

Unfortunately, as reported earlier, some apps hang with the JACK plugin,
and some even fail, e.g.

ogg123: pcm_plug.c:884: snd_pcm_plug_hw_params: Assertion `err >= 0'
failed.

I can provide output from pcm_params.c built with RULES_DEBUG defined if
that's useful.


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer

--=-WbczFC+juBNM5l87Bxu7
Content-Disposition: inline; filename=alsa-pcm-jack-unique-client-name.diff
Content-Type: text/x-patch; name=alsa-pcm-jack-unique-client-name.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: src/pcm/ext/pcm_jack.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/ext/pcm_jack.c,v
retrieving revision 1.4
diff -p -u -r1.4 pcm_jack.c
--- src/pcm/ext/pcm_jack.c	28 Oct 2003 18:19:09 -0000	1.4
+++ src/pcm/ext/pcm_jack.c	4 Feb 2004 19:18:07 -0000
@@ -697,6 +697,8 @@ int snd_pcm_jack_open(snd_pcm_t **pcmp, 
 	snd_pcm_jack_t *jack;
 	int err;
 	int fd[2];
+	static unsigned int num = 0;
+	char jack_client_name[32];
 	
 	assert(pcmp);
 #ifdef PCM_JACK_DEBUG
@@ -723,17 +725,24 @@ int snd_pcm_jack_open(snd_pcm_t **pcmp, 
 
 	if (stream == SND_PCM_STREAM_PLAYBACK) {
 		jack->channels = jack->playback_ports_n;
-		jack->client = jack_client_new("alsaP");
 	}
 	else {
 		jack->channels = jack->capture_ports_n;
-		jack->client = jack_client_new("alsaC");
 	}
 
 	if (jack->channels == 0) {
 		SNDERR("define the %s_ports section\n", stream == SND_PCM_STREAM_PLAYBACK ? "playback" : "capture");
 		goto _free;
 	}
+
+	if (snprintf(jack_client_name, sizeof(jack_client_name), "alsa%s.%d.%d",
+		     stream == SND_PCM_STREAM_PLAYBACK ? "P" : "C", getpid(), num++)
+	    >= sizeof(jack_client_name)) {
+		fprintf(stderr, "%s: WARNING: JACK client name '%s' truncated to %d characters, might not be unique\n",
+			__func__, jack_client_name, strlen(jack_client_name));
+	}
+
+	jack->client = jack_client_new(jack_client_name);
 
 	if (jack->client==0) {
 		err = -ENOENT;	

--=-WbczFC+juBNM5l87Bxu7--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
