From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Mixer volume/decibel mapping
Date: Tue, 25 May 2010 10:38:33 +0200
Message-ID: <4BFB8C89.3010207@ladisch.de>
References: <201005191834.57919.vand2@gmx.de>	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>	<4BF629B3.9020904@ladisch.de>	<201005210951.36495.peter.ujfalusi@nokia.com>	<4BF658C6.4030404@ladisch.de>
	<AANLkTikXWtp87B0Gq_B-vQZXZlBl_MEBqbuHt6N5cTbi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 95245103867
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 10:38:36 +0200 (CEST)
In-Reply-To: <AANLkTikXWtp87B0Gq_B-vQZXZlBl_MEBqbuHt6N5cTbi@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Jon Smirl <jonsmirl@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> 2010/5/21 Clemens Ladisch <clemens@ladisch.de>
> > Peter Ujfalusi wrote:
> > > The DB_SCALE also provides linear mapping:
> > > For example, if the HW volume control has a range 0 .. 100
> > > In HW these means:
> > > 0 == -10dB, 1 == -9.8dB, 2 == -9.6dB .. 99 = 9.8dB, 100 = 10dB
> > > So it is linear.
> >
> > This is not what is meant by "linear", because dB values are not linear.
> >
> > DB_LINEAR means that the mixer control value is a multiplier for the
> > PCM sample value, as James wrote.  A DB_LINEAR mapping has

... in practice ...

> > 0 == -infinity dB, full scale == 0 dB, and the mapping between mixer
> > control values and corresponding dB values it _not_ linear.
> >
> > TLV_DB_LINEAR_ITEM is a quite misleading name, but it actually means
> > "dB mapping for a mixer control whose value has a linear effect on the
> > sound output", _not_ a linear value <-> dB mapping.
> 
> seem max(full scale) is more then 0dB for some codecs , only three drivers
> have 0dB as max and TLV_DB_GAIN_MUTE  (-99999.99dB) as min

And these three are for hardware that use it as a plain multiplier.

All the others seem to be mistakes:

> soc/codecs/stac9766.c:static const DECLARE_TLV_DB_LINEAR(master_tlv, -4600, 0);
> soc/codecs/stac9766.c:static const DECLARE_TLV_DB_LINEAR(record_tlv, 0, 2250);
> soc/codecs/stac9766.c:static const DECLARE_TLV_DB_LINEAR(beep_tlv, -4500, 0);
> soc/codecs/stac9766.c:static const DECLARE_TLV_DB_LINEAR(mix_tlv, -3450, 1200);

These are wrong, both the AC'97 spec and the STAC9766 datasheet say
that there is a linear register value/dB mapping; these should all use
DECLARE_TLV_DB_SCALE.

> soc/codecs/wm8350.c:static DECLARE_TLV_DB_LINEAR(pre_amp_tlv, -1200, 3525);
> soc/codecs/wm8350.c:static DECLARE_TLV_DB_LINEAR(out_pga_tlv, -5700, 600);

According to the datasheet, these should use DECLARE_TLV_DB_SCALE (like
all the others in this file).

> soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(rec_mix_tlv, -1500, 600);
> soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(in_pga_tlv, -1650, 3000);
> soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(out_mix_tlv, -2100, 0);
> soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(out_pga_tlv, -7300, 600);
> soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(out_omix_tlv, -600, 0);
> soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(out_dac_tlv, -7163, 0);
> soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(in_adc_tlv, -7163, 1763);
> soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(out_sidetone_tlv, -3600, 0);
> soc/codecs/wm8400.c:    0,7, TLV_DB_LINEAR_ITEM(-1200, 600),
> soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(rec_mix_tlv, -1500, 600);
> soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(in_pga_tlv, -1650, 3000);
> soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(out_mix_tlv, 0, -2100);
> soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(out_pga_tlv, -7300, 600);
> soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(out_omix_tlv, -600, 0);
> soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(out_dac_tlv, -7163, 0);
> soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(in_adc_tlv, -7163, 1763);
> soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(out_sidetone_tlv, -3600, 0);
> soc/codecs/wm8990.c:    0, 7, TLV_DB_LINEAR_ITEM(-1200, 600),

Same here.


Regards,
Clemens
