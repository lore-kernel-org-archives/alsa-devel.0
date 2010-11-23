From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA throwing buffers away?
Date: Tue, 23 Nov 2010 18:40:06 +0100
Message-ID: <4CEBFC76.80109@ladisch.de>
References: <AANLkTikppY6oP0Ha7_Hej9uNBubbOUs87cp85yq3SS-X@mail.gmail.com>	<4CEBF3C5.2050108@ladisch.de>
	<AANLkTinShg1ZAnew63WL8h0BRZszsh5W0f4owp_OAkMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 6A011103928
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 18:37:50 +0100 (CET)
In-Reply-To: <AANLkTinShg1ZAnew63WL8h0BRZszsh5W0f4owp_OAkMA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Radivoje Jovanovic wrote:
> > Radivoje Jovanovic wrote:
> > > I am developing driver for a really simple hardware. Hardware has codec that
> > > supports mono/stereo and the amplifier that supports only one speaker so the
> > > driver has to be mono driver and the codec is setup to manage mono data. I
> > > have setup ALSA with following parameters:
> > >
> > > .info =            (SNDRV_PCM_INFO_NONINTERLEAVED |
> >
> > Better use SNDRV_PCM_INFO_INTERLEAVED; this is the format used by almost
> > all (stereo) sound cards, and so it is expected even for mono files
> > (where there actually isn't any difference).
> 
> I am worried about this approach since if I want to play stereo sound  I
> would have to increase .channels_max = 2,

No, ALSA can automatically convert the sample format.

> Here is my pointer callback:
> 
> offset=READ_REG16(AUDIO_CONFIG_DMA_CUR_ADDR_HIGH))<<16) | READ_REG16(AUDIO_CONFIG_DMA_CUR_ADDR_LOW);
> 
> offset = offset - substream->runtime->dma_addr;

This offset looks as if it is in bytes, but you have to return a value
measured in frames.  Use bytes_to_frames().

>     if (offset >= runtime->buffer_size)
>         offset = 0;

Remove this check; the ALSA framework already checks this and outputs
debugging info if this happens.


Regards,
Clemens
