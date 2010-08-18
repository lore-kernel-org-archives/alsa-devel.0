From: Randolph Chung <rchung42@gmail.com>
Subject: Re: Problem with MX27 ASoC audio
Date: Wed, 18 Aug 2010 16:58:12 +0800
Message-ID: <AANLkTinm96norAT4YQhTqg+eP80gwoeZf13V2QQa0_QV@mail.gmail.com>
References: <AANLkTikAybX=rP-DfWm5z8eVcC1EaujyEofsSoSJQ1M8@mail.gmail.com>
	<20100812125625.GA27749@pengutronix.de>
	<AANLkTinCWxRNBeXxTHRFBDgmgM6vZTqTKgoCubNYSV5u@mail.gmail.com>
	<20100812150145.GC11362@sirena.org.uk>
	<AANLkTiks+PBmKf6UrxwfLR2jGHO47-p4=o10Y-EE0kJw@mail.gmail.com>
	<4C690693.80706@eukrea.com>
	<AANLkTi=Jst17bqqH6H=jdPYZSGdz5G7yiOJQ=aRLm-3x@mail.gmail.com>
	<AANLkTimSMLLcOVzxocQV_nQ57wwxKLUGQUt7wn2wPa2p@mail.gmail.com>
	<20100818084137.GA26804@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 33CE724460
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 10:58:14 +0200 (CEST)
Received: by iwn8 with SMTP id 8so433270iwn.38
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2010 01:58:13 -0700 (PDT)
In-Reply-To: <20100818084137.GA26804@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 18, 2010 at 4:41 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Aug 18, 2010 at 03:53:16PM +0800, Randolph Chung wrote:
>> > Nonetheless, the system still doesn't behave properly when record and
>> > playback are happening at the same time. Here's a simple test:
>
>> Actually the problem is due to "mismatched" recording and playback
>> rates. My test was recording at 8kHz and playing back at 48kHz. The
>> codec driver only supports playback rate =3D capture rate. When the
>> playback starts the codec starts clocking at 48kHz which causes the
>> xruns.
>
>> Will see if the codec driver (tlv320aic3x) can be fixed up.
>
> If the CODEC has only a single LRCLK pin then it should be setting the
> symmetric_rates flag in its DAI. =A0The core will then take care of the
> symmetry requirements for it.
>

The codec (at least the variant of tlv320aic3x that I am using) can
have two pins in the hardware, but it's up to the board whether it's
hooked up that way. The codec driver as currently implemented assumes
the rates are symmetric, but it need not be.

I see that there is a symmetric_rates flag for the dai_link too.
Thanks for the pointer.

randolph
