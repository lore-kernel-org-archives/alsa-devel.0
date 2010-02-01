From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] alsa: Add support for timberdale I2S block
Date: Mon, 1 Feb 2010 16:46:24 +0000
Message-ID: <20100201164624.GA21643@rakim.wolfsonmicro.main>
References: <4AE59E01.9000802@mocean-labs.com>
	<20091026130931.GA18781@sirena.org.uk>
	<4B66F146.2050201@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 855D12438F
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 17:46:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B66F146.2050201@mocean-labs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard =?iso-8859-1?Q?R=F6jfors?= <richard.rojfors@mocean-labs.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 01, 2010 at 04:20:38PM +0100, Richard R=F6jfors wrote:
> Mark Brown wrote:

> > Without having investigated in any great detail I'd really expect this
> > driver to be done within ASoC if it's producing generic I2S output.  If
> > it's producing I2S out then presumably system designers will be able to
> > attach whatever CODECs they desire and if those CODECs require any soft
> > control then there will be a need to interoperate with CODEC drivers.

> This thing produces raw I2S/captures raw I2S as you say. It's used to
> connect to bluetooth chips and radio DSP:s. So there are no CODEC:s
> involved. Does it make sense to do it within ASoC?

Presumably there's nothing intrinsic in the hardware which makes this
specific to bluetooth and other radios?  If it's just vanilla I2S out
I'd be shocked if nobody ever decided to hook it up to a CODEC for some
reason or other, even if that CODEC is just being used to hook up to an
analogue baseband that's been selected for some reason.

In any case, due to mobile phones things like the bluetooth are getting
represented in ASoC and it's trivial to provide a stub for them where
they aren't so it seems sensible to have the option to hook the device
up in ASoC.
