From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: Re: [PATCH v2 1/5] ASoC: add mt6351 codec driver
Date: Sat, 21 Apr 2018 07:49:24 +0800
Message-ID: <1524268164.3290.31.camel@mtksdaap41>
References: <20180416003252.4177-1-kaichieh.chuang@mediatek.com>
 <20180416003252.4177-2-kaichieh.chuang@mediatek.com>
 <20180418164040.GG10061@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 5629F2673D4
 for <alsa-devel@alsa-project.org>; Sat, 21 Apr 2018 01:49:32 +0200 (CEST)
In-Reply-To: <20180418164040.GG10061@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, chipeng.chang@mediatek.com, wsd_upstream@mediatek.com
List-Id: alsa-devel@alsa-project.org

sorry for replying this early comment now,
i have to study on tlv first.

> > +/* dl pga gain */
> > +static const char *const dl_pga_gain[] = {
> > +	"8Db", "7Db", "6Db", "5Db", "4Db",
> > +	"3Db", "2Db", "1Db", "0Db", "-1Db",
> > +	"-2Db", "-3Db", "-4Db", "-5Db", "-6Db",
> > +	"-7Db", "-8Db", "-9Db", "-10Db", "-40Db",
> > +};
> 
> These gains should be put in TLVs rather than an enum so userspace can
> handle them (also it should be dB not Db).  You can handle irregular
> step sizes like these with DECLARE_TLV_DB_SCALE(), there's several
> examples in the code already.

We declare this enum for user space to operate on enum directly,
unlike alsa-lib, we use tinyalsa in Android, if declared in tlv,
the mixer control just become a integer control, which is not
informative for user space.

> > +static int dl_pga_get(struct snd_kcontrol *kcontrol,
> > +		      struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
> > +	struct mt6351_priv *priv = snd_soc_codec_get_drvdata(codec);
> > +
> > +	ucontrol->value.integer.value[0] = priv->ana_gain[kcontrol->id.device];
> > +
> > +	if (ucontrol->value.integer.value[0] == 0x1f)	/* reg idx for -40dB*/
> > +		ucontrol->value.integer.value[0] = ARRAY_SIZE(dl_pga_gain) - 1;
> 
> Why do this rewriting?

A little awkward gain register here,
the range is  for 8dB ~ -10dB and -40dB, corresponding to reg index 0 ~
18 and 31.

00000: +8dB.
00001: +7dB.
10010: -10dB
11111: -40dB(Mute).

and where 19 ~ 30 is not defined, and shouldn't be set.

i think tlv not yet support this kind of gain control?

Maybe i'll just declare 8dB ~ -10dB for now.
