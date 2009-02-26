From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 4/7] ASoC: Fix Zylonite voice interface
	stereo configurations
Date: Thu, 26 Feb 2009 10:59:16 +0100
Message-ID: <74d0deb30902260159ob8e750drcd539a63285a0c09@mail.gmail.com>
References: <20090225104701.GA20221@rakim.wolfsonmicro.main>
	<1235558902-20314-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20090225160617.GH11203@buzzloop.caiaq.de>
	<20090225162241.GE31637@sirena.org.uk>
	<20090225164113.GI11203@buzzloop.caiaq.de>
	<20090225165458.GF31637@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 3725C103808
	for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2009 10:59:17 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 6so365245ywa.2
	for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2009 01:59:16 -0800 (PST)
In-Reply-To: <20090225165458.GF31637@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 25, 2009 at 5:54 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Wed, Feb 25, 2009 at 05:41:13PM +0100, Daniel Mack wrote:
>
>> Is there a thread you can point me to or where have people reported such
>> things? Grep'ing the archives did unveil anything regarding this.
>
> Private e-mail only, sorry.

Seconded.

I've got a Philips UDA1380 codec with its digital input pins connected
to a PXA272's SSP1 port. From the diagrams in the codec's datasheet,
I'd expect it to understand I2S formats with anything >=3D 8 bits per
channel.
But when driving it with the current pxa-ssp code, I only ever get one
channel output to both left and right speakers. Whether this is the
left or the right channel depends on the frame clock polarity setting
(SSPSP[SFRMP]).

>> > The I2S frame length depends on the number of bits per sample.
>
>> Well, as far as I got it, these are different things in the register
>> set. The I2S frame is 64 bits per definition (32 bits for each channel),
>> and this is what the cs4270 requires to use.
>
> Ah, that's not true of I2S devices in general - most only require as
> many bit clocks as they have data. =A0I've only ever tested with such
> devices.
>
>> The particular problem with the PXA SSP mode is that I've not yet seen a
>> configuration (neighter in slave nor in master mode) where it sends out
>> 16 bits of left channel information, followed by 16 bits of zeros, then
>> 16 bits of right channel and finally another 16bits of zeros (which
>> exactly what they talk about in the 'i2s via ssp' application note).
>> Has anyone ever got that?
>
> Not to my knowledge.

I think I've tried to do this by setting network mode with four slots
=E0 16 bit data width, with a SFRMWDTH of 32 and only the first and
third slot active (SSTSA[TTSA] =3D 0x5). During the inactive slots,
SSPTXD should be forced low, as long as SSPSP[ETDS] is not set.
It didn't work out, but I'm not sure whether I've set up everything
correctly. My whole understanding of this SSP busineess is rather
cloudy.

Is that 'i2s via ssp' application note downloadable somewhere?

regards
Philipp
