From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: trouble with dosemu and alsa oss emulation (and a
 fix for alsa)
Date: Mon, 8 Sep 2003 09:14:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309080913350.30087@pnote.perex-int.cz>
References: <20030906200943.GA5128@quark.fsb.hr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030906200943.GA5128@quark.fsb.hr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Vedran Rodic <vedran@quark.fsb.hr>
Cc: alsa-devel@lists.sourceforge.net, linux-msdos@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, 6 Sep 2003, Vedran Rodic wrote:

> Hi.
>
> I'm having trouble with latest ALSA and oss emulation. I'm using dosemu to
> play some DOS games and I've noticed that sound in DOS apps stops playing
> after short time (depending on the app).
>
>
> I'm regulary updating both alsa and dosemu, I suspected dosemu first, since
> I had no problems whatsoever with alsa oss emulation.
>
> It turned out that this was not dosemu problem, but alsa oss emulation problem.
> I've tracked it down to a change in  alsa-kernel/core/oss/pcm_oss.c.
> The change is here:
> http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/alsa/alsa-kernel/core/oss/pcm_oss.c.diff?r1=1.40&r2=1.41

Please, try patch bellow.

					Jaroslav


Index: pcm_oss.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/oss/pcm_oss.c,v
retrieving revision 1.47
diff -u -r1.47 pcm_oss.c
--- pcm_oss.c	3 Sep 2003 13:43:41 -0000	1.47
+++ pcm_oss.c	8 Sep 2003 07:12:58 -0000
@@ -1394,6 +1394,10 @@
 	}
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DELAY, &delay);
+		if (err == -EPIPE || err == -ESTRPIPE) {
+			err = 0;
+			delay = 0;
+		}
 	} else {
 		err = snd_pcm_oss_capture_position_fixup(substream, &delay);
 	}
@@ -1454,7 +1458,12 @@
 	} else {
 		if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DELAY, &avail);
-			avail = runtime->buffer_size - avail;
+			if (err == -EPIPE || err == -ESTRPIPE) {
+				avail = runtime->buffer_size;
+				err = 0;
+			} else {
+				avail = runtime->buffer_size - avail;
+			}
 		} else {
 			err = snd_pcm_oss_capture_position_fixup(substream, &avail);
 		}

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
