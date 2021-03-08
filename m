Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4D7C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:11:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5708165210
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5708165210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E05F718B5;
	Mon,  8 Mar 2021 17:11:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E05F718B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615219917;
	bh=qGEiNv3XtT8Dee8z7bNAHkrMMqPt+dH+2YpKTirYi/8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vd92NrepCoLC4jfJ6COrC+FK6hB0zBBOYDZBZlZVwHzZ2qBux4hW2I4oUwcnqSYTM
	 2nvG2UakijxyfsO0dwRZDgqSVGUFmhJUN8Bjfc03Keio05pNnkuKENhtiyvfQXnlIZ
	 2lgWmOh7OcGWbKNWb+E0MVR9WZW/PUg5XM5YHQXc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5506F804DF;
	Mon,  8 Mar 2021 17:08:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8A92F804B0; Mon,  8 Mar 2021 17:08:40 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F39E8F80482
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 17:08:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F39E8F80482
IronPort-SDR: 1nB8SUxLTmu5wj/4et1ULmfY7zxKHoNV5XtgmN3eWDCWFEmjmbG0HeT0iM1zFGGTt1pkQitp1M
 twiHt6It2yag==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="273083300"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; d="scan'208";a="273083300"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2021 08:08:33 -0800
IronPort-SDR: 7xvXDaBmiRvJYe8eucLvrGEutIsDjhWs721psE+w0KtQcP+foNbzbNi3+dKN+SxV2UKfPdlkAt
 84ncFQ9wuRqg==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; d="scan'208";a="430418999"
Received: from dbdavenp-mobl1.amr.corp.intel.com (HELO [10.212.234.206])
 ([10.212.234.206])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2021 08:08:31 -0800
Subject: Re: [PATCH v3 3/4] ALSA: hda/cirrus: Add jack detect interrupt
 support from CS42L42 companion codec.
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20210306111934.4832-1-vitalyr@opensource.cirrus.com>
 <20210306111934.4832-4-vitalyr@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3ddc27d5-7d6d-e244-51fa-6ac17ee9779a@linux.intel.com>
Date: Mon, 8 Mar 2021 09:35:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210306111934.4832-4-vitalyr@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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




> @@ -38,6 +39,15 @@ struct cs_spec {
>   	/* for MBP SPDIF control */
>   	int (*spdif_sw_put)(struct snd_kcontrol *kcontrol,
>   			    struct snd_ctl_elem_value *ucontrol);
> +
> +	unsigned int cs42l42_hp_jack_in:1;
> +	unsigned int cs42l42_mic_jack_in:1;
> +
> +	struct mutex cs8409_i2c_mux;

what does this protect? there isn't any comment or explanations in the 
commit message.


