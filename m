From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: Re: [V3 2/2] ASoC: max98373: Added Amplifier Driver
Date: Fri, 5 Jan 2018 17:10:35 +0000
Message-ID: <CY1PR11MB08413C66C71341011E4877BAE71C0@CY1PR11MB0841.namprd11.prod.outlook.com>
References: <1515004757-22267-1-git-send-email-ryans.lee@maximintegrated.com>
 <20180104171345.GI10774@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0095.outbound.protection.outlook.com [104.47.36.95])
 by alsa0.perex.cz (Postfix) with ESMTP id 97324267AA0
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 18:10:39 +0100 (CET)
In-Reply-To: <20180104171345.GI10774@sirena.org.uk>
Content-Language: en-US
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
Cc: "bryce.ferguson@rockwellcollins.com" <bryce.ferguson@rockwellcollins.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "arnd@arndb.de" <arnd@arndb.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "afd@ti.com" <afd@ti.com>, "m-stecklein@ti.com" <m-stecklein@ti.com>, "romain.perier@collabora.com" <romain.perier@collabora.com>, "dannenberg@ti.com" <dannenberg@ti.com>, "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>, "supercraig0719@gmail.com" <supercraig0719@gmail.com>, "jbrunet@baylibre.com" <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

>-----Original Message-----
>From: Mark Brown [mailto:broonie@kernel.org]
>Sent: Thursday, January 4, 2018 9:14 AM
>To: Ryan Lee <RyanS.Lee@maximintegrated.com>
>Cc: lgirdwood@gmail.com; perex@perex.cz; tiwai@suse.com; arnd@arndb.de;
>afd@ti.com; robert.jarzmik@free.fr; supercraig0719@gmail.com;
>jbrunet@baylibre.com; dannenberg@ti.com; romain.perier@collabora.com;
>bryce.ferguson@rockwellcollins.com; kuninori.morimoto.gx@renesas.com; m-
>stecklein@ti.com; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org;
>ryan.lee.maxim@gmail.com
>Subject: Re: [V3 2/2] ASoC: max98373: Added Amplifier Driver
>
>On Wed, Jan 03, 2018 at 10:39:17AM -0800, Ryan Lee wrote:
>
>This looks mostly good.  There are a few smaller issues but I think at this point
>it's most sensible to apply and fix those incrementally so I'll do that, please
>follow up with patches fixing the remaining issues.

Thank you. Let me follow up with patches fixing the remaining issues.

>
>> --- /dev/null
>> +++ b/sound/soc/codecs/max98373.c
>> @@ -0,0 +1,971 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2017, Maxim Integrated */
>
>SPDX headers are supposed to be C++ comments, please send a followup patch
>fixing this.
>
>> +static int max98373_get_bclk_sel(int bclk) {
>> +	int i;
>> +	/* match BCLKs per LRCLK */
>> +	for (i = 0; i < ARRAY_SIZE(bclk_sel_table); i++) {
>> +		if (bclk_sel_table[i] == bclk)
>> +			return i + 2;
>> +	}
>> +	return 0;
>> +}
>> +static int max98373_set_clock(struct snd_soc_codec *codec,
>
>Missing blank line between the functions.
OK. Thanks.
>
>> +	}
>> +	/* set DAI_SR to correct LRCLK frequency */
>
>Another missing blank line.
OK. Let me fix.
>
>> +static int max98373_dai_tdm_slot(struct snd_soc_dai *dai,
>> +	unsigned int tx_mask, unsigned int rx_mask,
>> +	int slots, int slot_width)
>> +{
>> +	struct snd_soc_codec *codec = dai->codec;
>> +	struct max98373_priv *max98373 =
>snd_soc_codec_get_drvdata(codec);
>> +	int bsel = 0;
>> +	unsigned int chan_sz = 0;
>> +	unsigned int mask;
>> +	int x, slot_found;
>> +
>> +	max98373->tdm_mode = true;
>
>This should really also support disabling TDM mode - if the parameters are all 0
>just turn TDM off.  Again can be fixed in a followup.
OK. Let me apply it.
>
>> +SOC_SINGLE_TLV("DHT Gain Min", MAX98373_R20D1_DHT_CFG,
>> +	MAX98373_DHT_SPK_GAIN_MIN_SHIFT, 9, 0,
>> +max98373_dht_spkgain_min_tlv), SOC_SINGLE_TLV("DHT Rot Pnt",
>MAX98373_R20D1_DHT_CFG,
>> +	MAX98373_DHT_ROT_PNT_SHIFT, 15, 0,
>max98373_dht_rotation_point_tlv),
>> +SOC_SINGLE_TLV("DHT Attack Step", MAX98373_R20D2_DHT_ATTACK_CFG,
>> +	MAX98373_DHT_ATTACK_STEP_SHIFT, 4, 0,
>max98373_dht_step_size_tlv),
>> +SOC_SINGLE_TLV("DHT Release Step",
>MAX98373_R20D3_DHT_RELEASE_CFG,
>> +	MAX98373_DHT_RELEASE_STEP_SHIFT, 4, 0,
>max98373_dht_step_size_tlv),
>
>You should add a Volume on the end of these control names so that userspace
>knows how to display them properly; it's a little confusing as they're not
>actually gains but it tends to work out better.  Same for most of the other TLV
>controls.
OK. Thanks for your feedback.
