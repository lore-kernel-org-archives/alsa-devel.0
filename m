From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Device-drivers-devel] [PATCH] Add driver
	for	Analog Devices ADAU1701 SigmaDSP
Date: Mon, 7 Mar 2011 11:44:01 +0000
Message-ID: <20110307114400.GB1829@sirena.org.uk>
References: <1299460302-15392-1-git-send-email-cliff.cai@analog.com>
	<AANLkTinGyn8tujw-TrLibuDuj_Xqb4_YEPfLPFUy4WdO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C08E10382B
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 12:44:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTinGyn8tujw-TrLibuDuj_Xqb4_YEPfLPFUy4WdO@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: cliff.cai@analog.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, akpm@linux-foundation.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 06, 2011 at 09:44:49PM -0500, Mike Frysinger wrote:
> On Sun, Mar 6, 2011 at 20:11,  <cliff.cai@analog.com> wrote:

> > +static u32 adau1701_read_register(struct snd_soc_codec *codec,
> > + ?? ?? ?? u16 reg_address, u8 length)
> > +{

> this func has "u32" for ret, and you return the raw register value
> below.  but here you try returning -EIO.  shouldnt it be "int" so the
> caller can check for "< 0" ?

This is the interface we have, unfortuantely.  It's not ideal but it'd
be a complete pain to change it and the actual benefit in production is
questionable given our lack of options for dealing with them in typical
systems beyond moaning in logs.

> > +struct snd_soc_dai_driver adau1701_dai = {
> > + ?? ?? ?? .name = "ADAU1701",

> i think the standard is to use all lower case

Typically, yes.

> > +MODULE_DESCRIPTION("ASoC ADAU1701 SigmaDSP driver");
> > +MODULE_AUTHOR("Cliff Cai");
> > +MODULE_LICENSE("GPL");

> MODULE_ALIAS() ?

That's not needed for I2C devices, it's handled by MODULE_DEVICE_TABLE()
for I2C.
