Return-Path: <SRS0=cglx=GB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E8EC433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Dec 2020 13:59:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E03E207B6
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Dec 2020 13:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E03E207B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 980C817CC;
	Tue, 29 Dec 2020 14:58:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 980C817CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609250384;
	bh=LYjT57ahnRyu03nigwyfKIa+ozxSFKXRGx/oZWQdszk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h6c4A/ZU+3qBwiw2RTOf5VRrNxV+4U2gGywop3cTZ1aeA68MrOtGoqh4OcJnjP8+K
	 rTirJg5elt3IYJabYocNSD3Ok99t8K6zIWbhZVykdbyRmQ9h9kXjlJBg4lOKFHXl4z
	 p/HB0xpNH4NVTKtRy3O/fmTqnA5BD7+IXdWS7XzY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02AA4F804C1;
	Tue, 29 Dec 2020 14:58:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1FA98F804C2; Tue, 29 Dec 2020 14:58:47 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00A6FF802A9
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2020 14:58:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00A6FF802A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="VcoP1o1+"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0BTDs2MC009613; Tue, 29 Dec 2020 07:58:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=sH6bhPitT+ABUEhoCeCGPLY9qdXnjsWa0mKSh75GJGY=;
 b=VcoP1o1+sAR/ALOW2VHAztJyUqzZ1MMPL9lsmfKbmp5p0XBhPUvvuKd5TesFAYX2K3Il
 Q+EuhrcseMR/tV5GNkT0YBEUZvnoQdII+XQZ34Pi+MOLdnvZBSTCrJeE7vzbR2d2tGsO
 v/l9iXPtc42Lw4GTg6/4WtO7QfX/lFTfFtJLwak6gMvhRu40GtUfX12ymQm943P3iZME
 diQJ8rHq2TJUFnWuiKrybwsb+Wq9X3EVY8PWJhMBX+mfdh7U+58QJbsUTT4YJGga3EDt
 gC61jPri3qqBLS6TjUujGKLzu4+7tDvBn67ICJnaIcRqNA91NF41fjH0konu9pQUu43L ng== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 35p3f7aawn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 29 Dec 2020 07:58:38 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 29 Dec
 2020 13:58:36 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 29 Dec 2020 13:58:36 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1BF2E11CB;
 Tue, 29 Dec 2020 13:58:36 +0000 (UTC)
Date: Tue, 29 Dec 2020 13:58:36 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 13/14] ASoC: Intel: bytcr_wm5102: Add machine driver for
 BYT/WM5102
Message-ID: <20201229135836.GO9673@ediswmail.ad.cirrus.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-14-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201227211232.117801-14-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012290087
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Mark Brown <broonie@kernel.org>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Lee Jones <lee.jones@linaro.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Sun, Dec 27, 2020 at 10:12:31PM +0100, Hans de Goede wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Add a new ASoc Machine driver for Intel Baytrail platforms with a
> Wolfson Microelectronics WM5102 codec.
> 
> This is based on a past contributions [1] from Paulo Sergio Travaglia
> <pstglia@gmail.com> based on the Levono kernel [2] combined with
> insights in things like the speaker GPIO from the android-x86 android
> port for the Lenovo Yoga Tablet 2 1051F/L [3].
> 
> [1] https://patchwork.kernel.org/project/alsa-devel/patch/593313f5.3636c80a.50e05.47e9@mx.google.com/
> [2] https://github.com/lenovo-yt2-dev/android_kernel_lenovo_baytrail/blob/cm-12.1/sound/soc/intel/board/byt_bl_wm5102.c
> [3] https://github.com/Kitsune2222/Android_Yoga_Tablet_2-1051F_Kernel
> 
> The original machine driver from the Android ports was a crude modified
> copy of bytcr_rt5640.c adjusted to work with the WM5102 codec.
> This version has been extensively reworked to:
> 
> 1. Remove all rt5640 related quirk handling. to the best of my knowledge
> this setup is only used on the Lenovo Yoga Tablet 2 series (8, 10 and 13
> inch models) which all use the same setup. So there is no need to deal
> with all the variations with which we need to deal on rt5640 boards.
> 
> 2. Rework clock handling, properly turn off the FLL and the platform-clock
> when they are no longer necessary and don't reconfigure the FLL
> unnecessarily when it is already running. This fixes a number of:
> "Timed out waiting for lock" warnings being logged.
> 
> 3. Add the GPIO controlled Speaker-VDD regulator as a DAPM_SUPPLY
> 
> This only adds the machine driver and ACPI hooks, the BYT-CR detection
> quirk which these devices need will be added in a separate patch.
> 
> Co-authored-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Just a couple really minor comments.

> +static int byt_wm5102_prepare_and_enable_pll1(struct snd_soc_dai *codec_dai, int rate)
> +{
> +	struct snd_soc_component *codec_component = codec_dai->component;
> +	int sr_mult = ((rate % 4000) == 0) ?
> +		(WM5102_MAX_SYSCLK_4K / rate) :
> +		(WM5102_MAX_SYSCLK_11025 / rate);
> +	int ret;
> +
> +	/* Reset FLL1 */
> +	snd_soc_dai_set_pll(codec_dai, WM5102_FLL1_REFCLK, ARIZONA_FLL_SRC_NONE, 0, 0);
> +	snd_soc_dai_set_pll(codec_dai, WM5102_FLL1, ARIZONA_FLL_SRC_NONE, 0, 0);
> +
> +	/* Configure the FLL1 PLL before selecting it */
> +	ret = snd_soc_dai_set_pll(codec_dai, WM5102_FLL1, ARIZONA_CLK_SRC_MCLK1,
> +				  MCLK_FREQ, rate * sr_mult);
> +	if (ret) {
> +		dev_err(codec_component->dev, "Error setting PLL: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = snd_soc_component_set_sysclk(codec_component, ARIZONA_CLK_SYSCLK,
> +					   ARIZONA_CLK_SRC_FLL1, rate * sr_mult,
> +					   SND_SOC_CLOCK_IN);
> +	if (ret) {
> +		dev_err(codec_component->dev, "Error setting ASYNCCLK: %d\n", ret);

Error message should say SYSCLK not ASYNCCLK.

> +		return ret;
> +	}
> +
> +	ret = snd_soc_component_set_sysclk(codec_component, ARIZONA_CLK_OPCLK, 0,
> +					   rate * sr_mult, SND_SOC_CLOCK_OUT);
> +	if (ret) {
> +		dev_err(codec_component->dev, "Error setting OPCLK: %d\n", ret);
> +		return ret;
> +	}

OPCLK is a clock that can be outputted on the CODECs GPIOs. Is
that being used to clock some external component? If so it should
be added to the DAPM graph, if not you might as well remove this
call.

> +
> +	ret = snd_soc_dai_set_sysclk(codec_dai, ARIZONA_CLK_SYSCLK,
> +				     rate * 512, SND_SOC_CLOCK_IN);
> +	if (ret) {
> +		dev_err(codec_component->dev, "Error setting clock: %d\n", ret);
> +		return ret;
> +	}
> +

The rate you set here doesn't actually matter, on wm5102 this
just links the DAI to a specific clock domain and as they all
default to SYSCLK you can omit this call if you want. Although no
harm is caused by leaving it in.

Thanks,
Charles
