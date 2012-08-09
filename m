From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: how to calculate dma size in tdm mode
Date: Thu, 9 Aug 2012 11:38:14 +0100
Message-ID: <20120809103812.GJ24328@opensource.wolfsonmicro.com>
References: <CAHG8p1Am-FcJ0CO9Mo-Wc1-i=LHrX1-46rVe4w9nXyCs7iD10w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C2F02662D1
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 12:08:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAHG8p1Am-FcJ0CO9Mo-Wc1-i=LHrX1-46rVe4w9nXyCs7iD10w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 09, 2012 at 05:56:57PM +0800, Scott Jiang wrote:

> If user app use 2 channels but codec need 8 channels in tdm mode, I
> need to copy this data from user space to dma buffer. I wonder how to
> calculate dma size, snd_pcm_hardware.buffer_bytes_max or
> buffer_bytes_max * tdm_channels / channels_min?

I'm not sure which data you mean here?  It sounds like your hardware
doesn't support stereo DMA, if that's the case your capabilites should
reflect it.  With most hardware you'd just do a normal stereo playback
here, the unused TDM timeslots would not be visible outside of the DAI.
