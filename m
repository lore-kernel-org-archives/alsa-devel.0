From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [xvoice] Hacking ViaVoice, part 4
Date: Sat, 12 Jul 2003 20:56:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307122025230.1101-100000@pnote.perex-int.cz>
References: <20030712135025.GA6553@alinoe.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030712135025.GA6553@alinoe.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlo Wood <carlo@alinoe.com>
Cc: "xvoice@yahoogroups.com" <xvoice@yahoogroups.com>, "kai.vehmanen@wakkanet.fi" <kai.vehmanen@wakkanet.fi>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 12 Jul 2003, Carlo Wood wrote:

> On Sat, Jul 12, 2003 at 02:08:34PM +0200, Carlo Wood wrote:
> > Hence, the problem is now reduced to the question:
> > Why is snd_pcm_update_hw_ptr_interrupt not called anymore
> > after we did run into an xrun?
> 
> I added a few more printk's and already I can guess
> what is the reason that the 'blackbox' (the rest)
> stops calling snd_pcm_update_hw_ptr_interrupt:
> 
> I thought it was said that an xrun should simply be ignored?

Yes, but at another level - in the OSS emulation code.

> What is the correct way to recover from this, to continue
> recording in this case, after the xrun?

Call read() or poll(POLLIN) again. I think that your problem might be that 
poll(POLLIN) does not trigger the input in the current ALSA code. Please, 
try this patch with ViaVoice (the patch is also in the ALSA CVS tree):

Index: pcm_oss.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/oss/pcm_oss.c,v
retrieving revision 1.38
diff -u -r1.38 pcm_oss.c
--- pcm_oss.c	4 Jul 2003 08:49:53 -0000	1.38
+++ pcm_oss.c	12 Jul 2003 18:54:30 -0000
@@ -1990,12 +1990,20 @@
 	}
 	if (csubstream != NULL) {
 		snd_pcm_runtime_t *runtime = csubstream->runtime;
+		enum sndrv_pcm_state ostate;
 		poll_wait(file, &runtime->sleep, wait);
 		snd_pcm_stream_lock_irq(csubstream);
-		if (runtime->status->state != SNDRV_PCM_STATE_RUNNING ||
+		if ((ostate = runtime->status->state) != SNDRV_PCM_STATE_RUNNING ||
 		    snd_pcm_oss_capture_ready(csubstream))
 			mask |= POLLIN | POLLRDNORM;
 		snd_pcm_stream_unlock_irq(csubstream);
+		if (ostate != SNDRV_PCM_STATE_RUNNING && runtime->oss.trigger) {
+			snd_pcm_oss_file_t ofile;
+			memset(&ofile, 0, sizeof(ofile));
+			ofile.streams[SNDRV_PCM_STREAM_CAPTURE] = pcm_oss_file->streams[SNDRV_PCM_STREAM_CAPTURE];
+			runtime->oss.trigger = 0;
+			snd_pcm_oss_set_trigger(&ofile, PCM_ENABLE_INPUT);
+		}
 	}
 
 	return mask;


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
