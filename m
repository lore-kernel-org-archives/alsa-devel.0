Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A5FC43334
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jul 2022 13:25:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF86117A2;
	Wed, 20 Jul 2022 15:25:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF86117A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658323557;
	bh=4gxar5AEPCnR9+FK95tI+w/Lpiv0BWnqimOZ6dlY+h8=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tt8sOPoCSHepFeKoGGx6Sal9JgforW2rbpPSlEqSqX/aWRzmkbxP5K+qB1e30sft+
	 gRcaN+8Z7zV37Z4j9+STzv/P9LNOEnA2+GLvoyWvFAOM6jxmyQ7WYoetLQn0qQfWo5
	 vaOVKK6SzCG6NeV0+oe7V14TUnQaQSXw2uMyNAgs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A809F80269;
	Wed, 20 Jul 2022 15:25:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25276F8025D; Wed, 20 Jul 2022 15:25:05 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 435E4F80118;
 Wed, 20 Jul 2022 15:24:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 435E4F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="MTnCDdDC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658323502; x=1689859502;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=4gxar5AEPCnR9+FK95tI+w/Lpiv0BWnqimOZ6dlY+h8=;
 b=MTnCDdDCRLog9lYBPH98B6I9VBhJSO2PayY5Tk09We5vZlDpNKGCttFw
 eNM6gdn04NLu72DrbKIZHqgi1bKjqOOfQ4rcXHG2uh4oe5Uhqeku15nH6
 YdmtrfjSWUVLOgsHGXitxeLO5cN1fZLmSWyr/EkG18w74qUQHxLdjmmkZ
 h8JkvPV5JYLCFiVEdtiDhpqxwq2Ziw/N810C5X4xeWJnaHVsTUh6j1TTs
 +ohA+OFE4RinUSX+GjH4cCOEQIqRUBhDh+M6K52fuO+QG1um//wqm0VRA
 mqHbpRs902BvBIoUj24rxFIRSW/uZeqkmFzBOseLvloThzbeN7tPLVYq1 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="273614605"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; d="scan'208";a="273614605"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2022 06:24:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; d="scan'208";a="573303123"
Received: from tgeorge1-mobl.amr.corp.intel.com (HELO [10.212.79.208])
 ([10.212.79.208])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2022 06:24:53 -0700
Message-ID: <8c839963-4244-3e22-3dea-f060603883c1@linux.intel.com>
Date: Wed, 20 Jul 2022 08:24:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] ASoC: SOF: imx: Add i.MX8ULP HW support
Content-Language: en-US
To: Shengjiu Wang <shengjiu.wang@gmail.com>
References: <1658208367-24376-1-git-send-email-shengjiu.wang@nxp.com>
 <a2fd9907-d098-7a38-c423-aeb167ab6d37@linux.intel.com>
 <CAA+D8AM3xwacUg2C-W-TFB4AHbvqd-4bSqRqeFAsmFKseT0zVA@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAA+D8AM3xwacUg2C-W-TFB4AHbvqd-4bSqRqeFAsmFKseT0zVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, yung-chuan.liao@linux.intel.com,
 Liam Girdwood <lgirdwood@gmail.com>, krzysztof.kozlowski+dt@linaro.org,
 Fabio Estevam <festevam@gmail.com>, sound-open-firmware@alsa-project.org,
 peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
 NXP Linux Team <linux-imx@nxp.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, kai.vehmanen@linux.intel.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
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



On 7/20/22 03:57, Shengjiu Wang wrote:
>     > +static int imx8ulp_resume(struct snd_sof_dev *sdev)
>     > +{
>     > +     struct imx8ulp_priv *priv = (struct imx8ulp_priv
>     *)sdev->pdata->hw_pdata;
>     > +     int i;
>     > +
>     > +     imx8_enable_clocks(sdev, priv->clks);
>     > +
>     > +     for (i = 0; i < DSP_MU_CHAN_NUM; i++)
>     > +             imx_dsp_request_channel(priv->dsp_ipc, i);
>     > +
>     > +     return 0;
> 
>     is the assymetry between suspend and resume intentional? You are missing
>     the update_bit for EXECUTE_BIT?
> 
> 
> Yes, intentional. After resume the firmware is reloaded and  EXECUTE_BIT
> will be updated at trigger DSP start.

That's worthy of a comment to help reviewers, thanks.
