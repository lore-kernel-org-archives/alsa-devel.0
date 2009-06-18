From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC] I2S and LEFT_J
Date: Thu, 18 Jun 2009 15:58:29 +0800
Message-ID: <4A39F3A5.5030109@gmail.com>
References: <20090608165328.GB14026@rakim.wolfsonmicro.main>	
	<1244481992.17327.22.camel@brutus>
	<20090608180656.GH7858@sirena.org.uk>	
	<1244494349.17327.174.camel@brutus>	
	<f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>	
	<1244672649.25905.70.camel@brutus>	
	<f17812d70906110634i623eb236ib277e164678a7a34@mail.gmail.com>	
	<1244730992.21356.50.camel@brutus>	
	<f17812d70906150145p763002det5e2699442673d532@mail.gmail.com>	
	<1245077824.24109.51.camel@brutus>
	<20090615150433.GF6106@sirena.org.uk>
	<1245086420.24109.159.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f197.google.com (mail-pz0-f197.google.com
	[209.85.222.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 02665103825
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Jun 2009 09:58:46 +0200 (CEST)
Received: by pzk35 with SMTP id 35so830042pzk.16
	for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2009 00:58:45 -0700 (PDT)
In-Reply-To: <1245086420.24109.159.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Daniel Ribeiro wrote:
> Em Seg, 2009-06-15 =E0s 16:04 +0100, Mark Brown escreveu:
>>> For what it matters, the only difference on I2S/LEFT_J vs DSP_A/DSP_B
>>> should be the SSPSFRM duration as it is needed to emulate the LRCLK.
>> Assuming no extra bit clocks.  Extra bit clocks do something different
>> in I2S due to the fact that LRCLK falling edge is signifigcant.
> =

> Yes, assuming that we will not do the envelope thing.
> =

> But you have to consider that a codec that _requires_ 64 bits frames for
> 2*16bits I2S audio is not exactly I2S compliant.
> =

> Quoting the specifications:
> =

> "It isn't necessary for the transmitter to know how many bits the
> receiver can handle, nor does the receiver need to know how many bits
> are being transmitted.
> =

> When the system word length is is greater than the transmitter word
> length, the word is truncated (least significant data bits are set to
> '0') for data transmission. If the receiver is sent more bits than its
> word length, the bits after the LSB are ignored. On the other hand, if
> the receiver is sent fewer bits than its word length, the missing bits
> are set to zero internally. And so, the MSB has a fixed position,
> whereas the position of the LSB depends on the word length. The
> transmitter always sends the MSB of the next word one clock period after
> the WS changes."
> =

> =

> Anyway, my interpretation of the I2S specifications, is that we don't
> need to do this enveloping thing at all. Codecs that requires this are
> simply broken, and are _not_ considering LRCLK edges as they are
> supposed to.
> =

> And finally, if the codec does this enveloping thing, it can't work if
> PXA is slave of LRCLK. The PXA-SSP port is definitely not I2S compliant,
> as it just ignores the LRCLK falling edge. We can workaround this using
> network mode with 4 slots and with slots 1|3 active, but this implies
> knowing the sample/frame width in advance, which by itself is an I2S
> spec violation.
> =

> I have hope that Daniel Mack's codec, which supposedly only works with
> 64 bits frames _is_ I2S compliant, and he just got to the wrong
> conclusion that it needs 64 bits frames after a lot of trial and error,
> and failing to fix the real issue. (setting 16bits frames(DataSize(16))
> for 2*16bit samples is simply wrong).
> =

>>> (and of course, the fact that I2S/LEFT_J are stereo only and that
>>> network mode can't be supported)
>> You should be able to support at least modes using the first TDM
>> timeslot I'd have thought.
> =

> Right, I2S/LEFT_J can be networked with DSP_A/DSP_B pcm formats, but
> I2S/LEFT_J has to be the first slot.
> =

> =

> But...
> =

> Transmitter is sending 16 bits samples, and the receiver expecting 32
> bits samples. This is perfectly valid according to I2S, the receiver
> would append zeros to the LSBs of each sample.

Daniel,

Could you give me an example of how can I setup the I2S in-compatible
mode with S_16LE, 64bitfs with your current patch? Thanks.
