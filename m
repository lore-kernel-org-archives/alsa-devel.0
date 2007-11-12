From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: rate plugin issue
Date: Mon, 12 Nov 2007 22:25:17 +0300
Message-ID: <4738A89D.9060601@aknet.ru>
References: <s5hwssnx58j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030607080206000201030704"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id C2A7724474
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 20:24:06 +0100 (CET)
In-Reply-To: <s5hwssnx58j.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030607080206000201030704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Takashi Iwai wrote:
> I committed your patch now on HG tree, as it's likely OK from the
> possible breakage on other apps, too.
OK, first I have to apologize for
not providing a test-case - its still
in my todo if you need it. There are
still a few things unclear, like, for
example, how it fixes the portaudio,
if, as you say, such an apps are not
touching the code in question.

Anyway... as I said already, there are
few more problems that were hidden
before and are not any more. (I really
tried to warn you :)
For example, mpg123 will now consume
100% of CPU because of the nasty loop
in snd_pcm_write_areas()...
I am using something like the attached
patch, but maybe you can come up with
the better solution.
Quick summary: mpg123 sets avail_min=1,
so the loop spins without any rest.
Before, the value was "adjusted", so
it didn't spin that nasty way.

> Anyway, I swear that I'll never read any mails during my next
> vacation.  That was so exhausting to be dragged to a lengthy
> discussion for band-aiding a badly designed compoment... :)
But now, unfortunately, you won't get
away from that. :)
The hack used to cover more problems...


--------------030607080206000201030704
Content-Type: text/x-patch;
 name="pcm.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcm.c.diff"

--- pcm.c.old	2007-11-04 17:57:01.000000000 +0300
+++ pcm.c	2007-11-07 21:34:59.000000000 +0300
@@ -6465,19 +6465,35 @@
 			goto _end;
 		}
 		if ((state == SND_PCM_STATE_RUNNING &&
-		     (snd_pcm_uframes_t)avail < pcm->avail_min &&
 		     size > (snd_pcm_uframes_t)avail) ||
 		    (size >= pcm->xfer_align &&
 		     (snd_pcm_uframes_t)avail < pcm->xfer_align)) {
+			snd_pcm_sframes_t avail_min, orig_avail_min;
+			snd_pcm_sw_params_t params;
 
 			if (pcm->mode & SND_PCM_NONBLOCK) {
 				err = -EAGAIN;
 				goto _end;
 			}
 
+			avail_min = (size < pcm->period_size ?
+				size : pcm->period_size);
+			orig_avail_min = pcm->avail_min;
+			if (avail_min != pcm->avail_min) {
+				snd_pcm_sw_params_current(pcm, &params);
+				params.avail_min = avail_min;
+				snd_pcm_sw_params(pcm, &params);
+			}
+
 			err = snd_pcm_wait(pcm, -1);
 			if (err < 0)
 				break;
+
+			if (orig_avail_min != pcm->avail_min) {
+				params.avail_min = orig_avail_min;
+				snd_pcm_sw_params(pcm, &params);
+			}
+
 			goto _again;			
 		}
 		if ((snd_pcm_uframes_t) avail > pcm->xfer_align)

--------------030607080206000201030704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030607080206000201030704--
