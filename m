From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: ASoC: how to calculate dma size in tdm mode
Date: Fri, 10 Aug 2012 10:46:53 +0800
Message-ID: <CAHG8p1DC3hY0RFtyfGYnnR=eo9RKyvmOa2xn8iSfjprs3Wb+cQ@mail.gmail.com>
References: <CAHG8p1Am-FcJ0CO9Mo-Wc1-i=LHrX1-46rVe4w9nXyCs7iD10w@mail.gmail.com>
 <20120809103812.GJ24328@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A53082663B3
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 04:17:08 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so1475469obb.38
 for <alsa-devel@alsa-project.org>; Thu, 09 Aug 2012 19:46:53 -0700 (PDT)
In-Reply-To: <20120809103812.GJ24328@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/8/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Thu, Aug 09, 2012 at 05:56:57PM +0800, Scott Jiang wrote:
>
>> If user app use 2 channels but codec need 8 channels in tdm mode, I
>> need to copy this data from user space to dma buffer. I wonder how to
>> calculate dma size, snd_pcm_hardware.buffer_bytes_max or
>> buffer_bytes_max * tdm_channels / channels_min?
>
> I'm not sure which data you mean here?  It sounds like your hardware
> doesn't support stereo DMA, if that's the case your capabilites should
> reflect it.  With most hardware you'd just do a normal stereo playback
> here, the unused TDM timeslots would not be visible outside of the DAI.

I'm not sure what stereo DMA mean. Our hardware supports mask that
choose which slot is active,but I can't solve the problem that app
channel order is different from that required by codec.
For example, app is 1L1R2L2R, ad1836 requires 1L2Lxx1R2Rxx.
So I choose to copy one by one.
