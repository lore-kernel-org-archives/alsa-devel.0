From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH] usbus428.c.patch_1.4_1.5
Date: Sun, 5 Oct 2003 21:25:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310052125.27113.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nAHg/vrnxsHCepF"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_nAHg/vrnxsHCepF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi,

this enables DRAINING.
Here it is a really bugfix for using us428 with snd & alsaplayer.
Please commit.
What do you think about the us428control stuffs I sent you last week?

best,
Karsten

--Boundary-00=_nAHg/vrnxsHCepF
Content-Type: text/x-diff;
  charset="us-ascii";
  name="usbus428.c.patch_1.4_1.5"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usbus428.c.patch_1.4_1.5"

? .directory
? alsa-driver/cscope.files
? alsa-driver/cscope.out
? alsa-driver/usb/us428/cscope.out
? alsa-lib/cscope.files
Index: alsa-driver/usb/us428/usbus428audio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/us428/usbus428audio.c,v
retrieving revision 1.3
diff -u -r1.3 usbus428audio.c
--- alsa-driver/usb/us428/usbus428audio.c	30 Sep 2003 08:54:47 -0000	1.3
+++ alsa-driver/usb/us428/usbus428audio.c	5 Oct 2003 19:10:30 -0000
@@ -401,13 +401,15 @@
 	}
 
 	if (pcm_captsubs)
-		if (pcm_captsubs->runtime->status->state == SNDRV_PCM_STATE_RUNNING)
+		if (pcm_captsubs->runtime->status->state == SNDRV_PCM_STATE_RUNNING
+		    || pcm_captsubs->runtime->status->state == SNDRV_PCM_STATE_DRAINING)
 			runtime = pcm_captsubs->runtime;
 	if (NULL == runtime){
 		snd_us428_substream_t *playsubs = captsubs->stream->substream + SNDRV_PCM_STREAM_PLAYBACK;
 		snd_pcm_substream_t *pcm_playsubs = playsubs->pcm_substream;
 		if (pcm_playsubs)
-			if (pcm_playsubs->runtime->status->state == SNDRV_PCM_STATE_RUNNING)
+			if (pcm_playsubs->runtime->status->state == SNDRV_PCM_STATE_RUNNING
+			    || pcm_playsubs->runtime->status->state == SNDRV_PCM_STATE_DRAINING)
 				runtime = pcm_playsubs->runtime;
 		
 	}

--Boundary-00=_nAHg/vrnxsHCepF--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
