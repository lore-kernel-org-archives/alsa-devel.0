From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [PATCH] Kernel crash
Date: Mon, 13 Sep 2004 22:07:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040913220729.466531ce.pochini@shiny.it>
References: <s5h7jr7whqj.wl@alsa2.suse.de>
	<XFMail.20040907095502.pochini@shiny.it>
	<20040911210212.317d930b.pochini@shiny.it>
	<s5hekl6tdru.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hekl6tdru.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 13 Sep 2004 17:00:21 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> > I added some code in the hw_free callback to avoid the crash and some debug
> > lines in pcm_native.c and I got this trace:
> > 
> > pcm_trigger start
> > [...]
> > pcm_native.c:1241: snd_pcm_playback_drain (state=RUNNING)
> > pcm_native.c:1294: snd_pcm_playback_drain not empty
> > pcm_native.c:1204: snd_pcm_change_state(DRAINING)
> > pcm_native.c:1457: snd_pcm_capture_drop (state=DRAINING)
> > pcm_native.c:1204: snd_pcm_change_state(SETUP)
> >
> >  This changes the state of both substreams to SETUP, so
> >  snd_pcm_playback/capture_drain/drop() functions will not call _stop()
> >  anymore.
> >
> > pcm_native.c:1359: snd_pcm_playback_drop (state=SETUP)
> > pcm_hw_free(play) <--- BUG!
> > pcm_close
> > pcm_native.c:snd_pcm_capture_drop (state=SETUP)
> > pcm_hw_free(capt)
> > pcm_close
>
> I see.
>
> > I developed this patch, but I'm not sure it's ok. The first part probably is
> > not required but it seems more correct IMHO.
>
> The first one should be ok.
> I'm also not 100% sure about the second one after the short glance.
>
> The problem is that we have no DMA running state in runtime struct.
> DMA is supposed to be running in DRAINING state for playback, while
> it's to be stopped in DRAINING capture.

I guessed the DMA is going on in RUNNING and DRAINING states only. Actually
I just noticed that my patch is wrong: in PREPARED state DMA is off and
snd_pcm_stop() should not be called if state is SNDRV_PCM_STATE_XRUN because
snd_pcm_xrun() already stopped it.

(compiled and tested ok)


--- pcm_native.c_orig	Sat Sep 11 15:29:51 2004
+++ pcm_native.c	Mon Sep 13 21:51:05 2004
@@ -1280,7 +1280,8 @@
 		break; 
 	}
 
-	if (runtime->status->state == SNDRV_PCM_STATE_RUNNING) {
+	if (runtime->status->state == SNDRV_PCM_STATE_RUNNING ||
+	    runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
 		if (snd_pcm_playback_empty(substream)) {
 			snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
 			goto _end;
@@ -1464,9 +1465,14 @@
 		if (res < 0)
 			goto _end;
 		/* Fall through */
-	case SNDRV_PCM_STATE_PREPARED:
 	case SNDRV_PCM_STATE_DRAINING:
+		if (snd_pcm_update_hw_ptr(substream) >= 0) {
+			snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
+			break;
+		}
+		/* Fall through */
 	case SNDRV_PCM_STATE_XRUN:
+	case SNDRV_PCM_STATE_PREPARED:
 		snd_pcm_change_state(substream, SNDRV_PCM_STATE_SETUP);
 		break;
 	default: 



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
