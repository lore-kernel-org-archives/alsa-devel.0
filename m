Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B058C4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 13:46:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D6860FF2
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 13:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3D6860FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7CA241788;
	Mon,  2 Aug 2021 15:45:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7CA241788
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627912000;
	bh=RBGXfcmJzmVrkyFFhM+h9bg7nhO1s+REUxZJqtRMuNI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KjUPgco+0cmvGD4voJ7qw/zIYUhvMvrBoFzY1xkmbUkScR8qlEdfpgzJgFdFrR1vC
	 piA3b4n5nS6OiZudZEvQlqpqB7PWJpCzzm2dArAV91kK6Fzst2tqF504HMx2/nda//
	 4hJX23osXOd0WLTozTqpDSXjtmq6l/W2b+Pn7onk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB647F801F7;
	Mon,  2 Aug 2021 15:45:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92EC4F8025F; Mon,  2 Aug 2021 15:45:48 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2563F8014D
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 15:45:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2563F8014D
X-IronPort-AV: E=McAfee;i="6200,9189,10063"; a="299047727"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; d="scan'208";a="299047727"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 06:45:37 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; d="scan'208";a="436670830"
Received: from skshirsa-mobl1.amr.corp.intel.com (HELO [10.209.189.56])
 ([10.209.189.56])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 06:45:36 -0700
Subject: Re: [PATCH 4/6] ASoC: Intel: bytcr_rt5640: Add support for a second
 headphones output
To: Hans de Goede <hdegoede@redhat.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
References: <20210801210431.161775-1-hdegoede@redhat.com>
 <20210801210431.161775-5-hdegoede@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <101f39fb-03e3-5512-a9fc-2c569fcb98fc@linux.intel.com>
Date: Mon, 2 Aug 2021 08:45:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210801210431.161775-5-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Bard Liao <bard.liao@intel.com>
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



On 8/1/21 4:04 PM, Hans de Goede wrote:
> Some devices (HP Elitepad 1000 G2) have a second headphones output
> (1 on the dock, 2nd on the tablet itself) which is implemented through
> the line-out output of the codec combined with an external hp-amp
> which gets enabled through the codec's GPIO1 pin.
> 
> Add support for this through a new BYT_RT5640_LINEOUT_AS_HP2 quirk.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  sound/soc/intel/boards/bytcr_rt5640.c | 36 +++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index 70faba13450c..51fb44ad9b4b 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -74,6 +74,7 @@ enum {
>  #define BYT_RT5640_MCLK_25MHZ		BIT(23)
>  #define BYT_RT5640_NO_SPEAKERS		BIT(24)
>  #define BYT_RT5640_LINEOUT		BIT(25)
> +#define BYT_RT5640_LINEOUT_AS_HP2	BIT(26)

The definitions aren't fully clear to me. It seems that the two quirks
above are mutually exclusive if I read the code below

+	if (byt_rt5640_quirk & BYT_RT5640_LINEOUT_AS_HP2)
+		lineout_string = " cfg-hp2:lineout";
+	else if (byt_rt5640_quirk & BYT_RT5640_LINEOUT)
 		lineout_string = " cfg-lineout:1";

But in the following patch the two are mixed:

+		.driver_data = (void *)(BYT_RT5640_DMIC2_MAP |
+					BYT_RT5640_MCLK_EN |
+					BYT_RT5640_LINEOUT |
+					BYT_RT5640_LINEOUT_AS_HP2 |
+					BYT_RT5640_HSMIC2_ON_IN1),

so maybe the test above should be

if (byt_rt5640_quirk & BYT_RT5640_LINEOUT) {
	if (byt_rt5640_quirk & BYT_RT5640_LINEOUT_AS_HP2)
		lineout_string = " cfg-hp2:lineout";
	else
 		lineout_string = " cfg-lineout:1";
}


I am also not very clear on the hp2 support, is there any sort of jack
detection or will this require always an explicit user choice?
