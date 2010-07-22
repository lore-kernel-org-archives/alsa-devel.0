From: <matti.j.aaltonen@nokia.com>
Subject: Re: [PATCH v2 0/1] *** SUBJECT HERE ***
Date: Thu, 22 Jul 2010 14:11:27 +0200
Message-ID: <A1C7E76B4973664FBB6C554A75234AC62BEEEB72A7@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1279791534-20028-1-git-send-email-matti.j.aaltonen@nokia.com>
	<20100722094832.GC4737@rakim.wolfsonmicro.main>
	<A1C7E76B4973664FBB6C554A75234AC62BEEEB72A5@NOK-EUMSG-02.mgdnok.nokia.com>,
	<20100722120208.GF4737@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 230552414C
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 14:15:10 +0200 (CEST)
In-Reply-To: <20100722120208.GF4737@rakim.wolfsonmicro.main>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org


________________________________________
From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-project.org] On Behalf Of ext Mark Brown [broonie@opensource.wolfsonmicro.com]
Sent: Thursday, July 22, 2010 2:02 PM
To: Aaltonen Matti.J (Nokia-MS/Tampere)
Cc: alsa-devel@alsa-project.org; Ujfalusi Peter (Nokia-MS/Tampere); lrg@slimlogic.co.uk
Subject: Re: [alsa-devel] [PATCH v2 0/1] *** SUBJECT HERE ***

>On Thu, Jul 22, 2010 at 01:18:32PM +0200, matti.j.aaltonen@nokia.com wrote:
>> From: ext Mark Brown [broonie@opensource.wolfsonmicro.com]
>
>> OK, sorry... The problem in a sense is that the codec supports three
>> different modes: BT, FM RX and FM TX. All digital audio goes over a
>> single McBSP connection. The BT part handles the audio routing, which
>> is completely external to the radio driver and this codec. And the user
>> of the codec is in principle responsible for keeping the codec mode in
>> sync with the route setting. And the soc_card driver needs to know the
>> setting also to do its thing.
>
>Which is...
>
>You've still not provided any information about what use this will be
>put to.

Yes, sorry I didn't get your point. I guess I tought that it's irrelevant, what
the soc_card driver actually does. But it actually does this:

	switch (wl1273_get_codec_mode(codec)) {
	case WL1273_MODE_FM_RX:
	case WL1273_MODE_FM_TX:
		fmt =	SND_SOC_DAIFMT_I2S |
			SND_SOC_DAIFMT_NB_NF |
			SND_SOC_DAIFMT_CBM_CFM;

		break;
	case WL1273_MODE_BT:
		fmt =	SND_SOC_DAIFMT_DSP_A |
			SND_SOC_DAIFMT_IB_NF |
			SND_SOC_DAIFMT_CBM_CFM;

		break;
	default:
		return -EINVAL;
	}

	r = snd_soc_dai_set_fmt(cpu_dai, fmt);

Cheers,
Matti A.






_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
