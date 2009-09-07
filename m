From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Patch for au88x0 driver. Fix audacious issue and
	add auto reset in case of hardware ADB ctrl failure.
Date: Mon, 7 Sep 2009 09:47:52 +0800
Message-ID: <4f3252890909061847j7ec20f10x87362f155bc3bbc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f176.google.com (mail-px0-f176.google.com
	[209.85.216.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 941CA24133
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 03:47:53 +0200 (CEST)
Received: by pxi6 with SMTP id 6so1820887pxi.16
	for <alsa-devel@alsa-project.org>; Sun, 06 Sep 2009 18:47:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 03 September 2009 21:10, Manuel Jander wrote:
> does anybody still have a AU88x0 card ? I know they are quite ancient
> now, but if anyone could give the attached patch a try ? Would be
> nice.
> I made the patch against linux-2.6.30.4
> http://micro.homelinux.net/~mjander/au88x0.diff.gz <http://micro.homelinux.net/%7Emjander/au88x0.diff.gz>
>
> Best Regards,
> Manuel

Which version of audaicous (1.5.x or 2.1) are you testing ?
(alsa-gapless or alsa-ng plugin)

au88x0 most likely cannot support 1 sample per period because of the
FIFO as described in patent 6167465.

if you look at the source code of alsa-ng and alsa-gapless plugin
both of them use the own way to calculate the buffer size instead of
using snd_pcm_hw_params_get_buffer_size()


http://hg.atheme.org/audacious-plugins/file/2c0a9bba77d7/src/alsa-ng/alsa-core.c#l1

CHECK_FAIL (snd_pcm_hw_params_set_access (pcm_handle, hwparams,
SND_PCM_ACCESS_RW_INTERLEAVED), "snd_pcm_hw_params_set_access");
CHECK_FAIL (snd_pcm_hw_params_set_format (pcm_handle, hwparams, afmt),
"snd_pcm_hw_params_set_format");
CHECK_FAIL (snd_pcm_hw_params_set_channels (pcm_handle, hwparams, nch),
"snd_pcm_hw_params_set_channels");
CHECK_FAIL (snd_pcm_hw_params_set_rate (pcm_handle, hwparams, rate, 0),
"snd_pcm_hw_params_set_rate");
CHECK_FAIL (snd_pcm_hw_params (pcm_handle, hwparams), "snd_pcm_hw_params");
bitwidth = snd_pcm_format_physical_width(afmt);
bps = (rate * bitwidth * nch) >> 3;
buf_size = MAX(aud_cfg->output_buffer_size, 100);
ringbuf_size = buf_size * bps / 1000;


How do you get the "ADB Ctrl failure" error ?

There are two main problem of the au88x0 driver
1) alsa is unable to calculate the correct value for the three
functions snd_pcm_hw_params_set_buffer_time_near() ,
snd_pcm_hw_params_set_period_time_near() and snd_pcm_set_params()

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1724

Test case :

alsa-lib/test/pcm_min.c ( change default to hw:0,0 )

Real world case:

gstreamer and winealsa.drv

2) unable to recover when the number of available src is not enough
(FATAL: ResManager: resource type 1 exhaust)

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2228

test case :

running application to use 15 src ( 7 stereo and one mono stream ) and
open another stereo stream
