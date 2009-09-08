From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Patch for au88x0 driver. Fix audacious issue and
	add auto reset in case of hardware ADB ctrl failure.
Date: Tue, 8 Sep 2009 11:41:16 +0800
Message-ID: <4f3252890909072041x64bab9c3te4641d128244e993@mail.gmail.com>
References: <4f3252890909061847j7ec20f10x87362f155bc3bbc5@mail.gmail.com>
	<21ed1c370909070232v42f31fa9y303def4cc4002b19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f173.google.com (mail-pz0-f173.google.com
	[209.85.222.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EA3A24149
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Sep 2009 05:41:18 +0200 (CEST)
Received: by pzk3 with SMTP id 3so1389155pzk.28
	for <alsa-devel@alsa-project.org>; Mon, 07 Sep 2009 20:41:16 -0700 (PDT)
In-Reply-To: <21ed1c370909070232v42f31fa9y303def4cc4002b19@mail.gmail.com>
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

2009/9/7 Manuel Jander <manuel.jander@gmail.com>

> Hi Raymond,
>
> On Mon, Sep 7, 2009 at 3:47 AM, Raymond Yau<superquad.vortex2@gmail.com>
> wrote:
> > On Thursday 03 September 2009 21:10, Manuel Jander wrote:
> >> does anybody still have a AU88x0 card ? I know they are quite ancient
> >> now, but if anyone could give the attached patch a try ? Would be
> >> nice.
> >> I made the patch against linux-2.6.30.4
> >> http://micro.homelinux.net/~mjander/au88x0.diff.gz<http://micro.homelinux.net/%7Emjander/au88x0.diff.gz><
> http://micro.homelinux.net/%7Emjander/au88x0.diff.gz>
> >>
> >> Best Regards,
> >> Manuel
> >
> > Which version of audaicous (1.5.x or 2.1) are you testing ?
> > (alsa-gapless or alsa-ng plugin)
> >
> > au88x0 most likely cannot support 1 sample per period because of the
> > FIFO as described in patent 6167465.
>
> Well, that is clear to me now. Using a DMA transfer that is smaller
> than one audio sample is not really a good idea.
> I would be better off using PIO instead of DMA.
>
> > if you look at the source code of alsa-ng and alsa-gapless plugin
> > both of them use the own way to calculate the buffer size instead of
> > using snd_pcm_hw_params_get_buffer_size()
> >
> >
> >
> http://hg.atheme.org/audacious-plugins/file/2c0a9bba77d7/src/alsa-ng/alsa-core.c#l1
> >
> > CHECK_FAIL (snd_pcm_hw_params_set_access (pcm_handle, hwparams,
> > SND_PCM_ACCESS_RW_INTERLEAVED), "snd_pcm_hw_params_set_access");
> > CHECK_FAIL (snd_pcm_hw_params_set_format (pcm_handle, hwparams, afmt),
> > "snd_pcm_hw_params_set_format");
> > CHECK_FAIL (snd_pcm_hw_params_set_channels (pcm_handle, hwparams, nch),
> > "snd_pcm_hw_params_set_channels");
> > CHECK_FAIL (snd_pcm_hw_params_set_rate (pcm_handle, hwparams, rate, 0),
> > "snd_pcm_hw_params_set_rate");
> > CHECK_FAIL (snd_pcm_hw_params (pcm_handle, hwparams),
> "snd_pcm_hw_params");
> > bitwidth = snd_pcm_format_physical_width(afmt);
> > bps = (rate * bitwidth * nch) >> 3;
> > buf_size = MAX(aud_cfg->output_buffer_size, 100);
> > ringbuf_size = buf_size * bps / 1000;
>
> I increased the minimum period bytes value to 256 in that patch.
> Audacious version 2 (Debian SID)
> works for me.
>

well,  audacious.i386    1.5.1-9.fc10   cannot play any music (alsa plugin)
on my au8830 with your patch, it only play music with (oss plugin)

Use xmms instead of audacious since they have similar UI


256 seem much bigger than the figures mentioned in the patent , may be it is
the practical limit on your VIA ITX


In one embodiment of the present invention, the FIFO buffer is 32 samples or
words in depth, which would withstand a maximum bus latency of about 4
microseconds. By way of example, if 48 DMA channels trigger simultaneously,
with a trigger level set at half the buffer size (16 samples), each DMA
channel can wait 16 samples (20 microseconds per sample), or approximately
320 microseconds before running out of data.


By way of example, CPU 210 may update-sub-buffer tables 380(0)-380(x)
routinely every 10 milliseconds. The periodic checks may be initiated by
audio processing peripheral 230 by way of interrupts, or may be scheduled
independently by the driver




> > How do you get the "ADB Ctrl failure" error ?
>
> I do not know how to reproduce that. Sometimes it happens, and its not
> possible
> to recover without a hardware reset (unload and load module). Somehow
> it semes to
> happen when my computer gets really hot (watching an MPEG-4 video, or
> compiling the kernel...).
> Its a old VIA ITX board, with a 1.3GHz processor (on demand cpufreq).
>
> The patch tries to reset the audio card if all PCM streams are
> released once such a
> condition was detected. This is the situation were the windows driver
> used to crash the
> whole machine.
>


it work quite well on my two motherbroad using intel chipset


> > There are two main problem of the au88x0 driver
> > 1) alsa is unable to calculate the correct value for the three
> > functions snd_pcm_hw_params_set_buffer_time_near() ,
> > snd_pcm_hw_params_set_period_time_near() and snd_pcm_set_params()
> >
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1724
> >
> > Test case :
> >
> > alsa-lib/test/pcm_min.c ( change default to hw:0,0 )
> >
> > Real world case:
> >
> > gstreamer and winealsa.drv
>
> I will try that. I had no idea about that bugs.
>

A simple workaround is add another constraint

snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 4096
);

however winealsa.drv will be using a larger period bytes than  wineoss.drv



>
> > 2) unable to recover when the number of available src is not enough
> > (FATAL: ResManager: resource type 1 exhaust)
> >
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2228
> >
> > test case :
> >
> > running application to use 15 src ( 7 stereo and one mono stream ) and
> > open another stereo stream
>
> Hmm, the good ol' resource manager :) OK, I will try to find a
> solution. I have not much
> time these days, but maybe it rains again, and I get bored, who knows :D
>
> Best Regards,
> Manuel
>


simple fix may be adding counts of the resource and check that all resources
are enough before allocating them
