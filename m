From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: What is exact definition of "normal/inverted"
	FSYNC signal polarity?
Date: Mon, 31 Aug 2015 21:17:51 +0200
Message-ID: <55E4A85F.7010208@metafoo.de>
References: <CAOMFOmXwfBydswh0BiSOB42KMa0T+0-W1mj0=d4AhisToFxkVg@mail.gmail.com>	<20150831180250.GT12027@sirena.org.uk>
 <CAOMFOmVfE2qiXN=h7i1pJ38JJL3J94UgrN_q+ratYTu=nr372w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id 48B3126052B
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 21:18:01 +0200 (CEST)
In-Reply-To: <CAOMFOmVfE2qiXN=h7i1pJ38JJL3J94UgrN_q+ratYTu=nr372w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?B?6Zmz56uL5bOw?= <albertchen@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ben Zhang <benzh@google.com>, Dylan Reid <dgreid@google.com>, lengo@google.com
List-Id: alsa-devel@alsa-project.org

On 08/31/2015 09:05 PM, Anatol Pomozov wrote:
> Hi
> 
> Thanks.
> 
> On Mon, Aug 31, 2015 at 11:02 AM, Mark Brown <broonie@kernel.org> wrote:
>> The simplest thing to do is look at the datasheets for Wolfson parts
>> like the wm8731, they have some very clear diagrams of all the data
>> modes we support.
> 
> I looked at http://www.rockbox.org/wiki/pub/Main/DataSheets/WM8731_8731L.pdf
> spec and it is what I see
> 
> "normal" bitclock means data sensing happens at rising edge of BCLK.
> It is the same as TegraX1 and rt5677 examples above.
> 
> As of FSYNC - the wm8731 driver uses Reg0x7[4] to set FSYNC polarity.
> If FSYNC is inverted then bit set to 1. According to the spec:
> 
> DACLRC phase control (in left, right or I2S modes)
> 1 = Right Channel DAC data when DACLRC high
> 0 = Right Channel DAC data when DACLRC low
> (opposite phasing in I2S mode)
> or
> DSP mode A/B select (in DSP mode only)
> 1 = MSB is available on 2nd BCLK rising edge after DACLRC rising edge
> 0 = MSB is available on 1st BCLK rising edge after DACLRC rising edge
> 
> 
> Thus "normal" FSYNC for this driver means that the frame (L channel)
> starts at rising edge of FSYNC (wm8731 datasheet calls it DACLRC).
> "inverted" means frame starts at the falling edge. It differs both
> from TegraX1 and rt5677 above.
> 
> For TDM mode A the chip seems always expect to see "normal" polarity
> FSYNC (frame starts at rising edge of FSYNC).
> 
> 
> 
> 
> It looks like each driver uses its own definition of FSYNC polarity.
> To avoid compatibility problems between different codecs/socs there
> should be a clean definition of what is FSYNC polarity is. I would
> propose something simple like:
>     ****  "normal" FSYNC means frame starts at rising edge of FSYNC,
> and "inverted" frame starts at falling FSYNC edge ****
> i.e. the same as for 8731.

The modes supported by the wm8731 is DSP A (framesync precedes first data by
1 bit clock cycle) and DSP B(framesync happens during the first bit clock
cycle).

But otherwise agreed rising edge = normal framesync, falling edge = inverted
framesync
