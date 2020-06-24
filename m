Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13328C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:14:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9771220738
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rIvsuJ/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9771220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BAB3185E;
	Wed, 24 Jun 2020 18:13:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BAB3185E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593015262;
	bh=fJWogUJPu4OIGecqxgurMMIEsc50FTP/CXsEPZ90Keg=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rIvsuJ/SMYHC/7d6kHAmKRyGucYorByk0ih2uJW/uqaWoNoO87Qz07UvlBz2Z+h3d
	 ODc2yRnGEZZCmjWPeqptqfDgNDXF2FW5Js7vWXO7VJaO42Hpqh42JAVRiWA4JZbLDa
	 hQTajXrvBdbco/87zXIGB9yg9Zfga6l5PK274Q+I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 675D9F800B2;
	Wed, 24 Jun 2020 18:13:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93364F8015B; Wed, 24 Jun 2020 18:13:29 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00332F800B2
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 18:13:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00332F800B2
IronPort-SDR: KQ0dAT2DgFo29ETpOgoTc1TanDQpu+oPuwX9KmTz4/JeZfdGa/VnQxYzkXWAbWtcZcgmSpb3ln
 Yglj1wJ5SzpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="142752874"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; d="scan'208";a="142752874"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2020 09:13:17 -0700
IronPort-SDR: BoL2Q8FpwmGNUhuHvxSbAVSKhjee5XzYKaAtGYajyyAtE/BPcQDc4VfAHsAR9JgdwsO1oOMznS
 pv72QGsIyqwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; d="scan'208";a="279521081"
Received: from bkorrapa-mobl1.amr.corp.intel.com (HELO [10.254.109.185])
 ([10.254.109.185])
 by orsmga006.jf.intel.com with ESMTP; 24 Jun 2020 09:13:17 -0700
Subject: Re: [PATCH] ALSA: core: Warn on empty module
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
References: <20200624160300.21703-1-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8d9cd8bf-9023-f3f7-e62d-167da5263714@linux.intel.com>
Date: Wed, 24 Jun 2020 11:13:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624160300.21703-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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



On 6/24/20 11:03 AM, Takashi Iwai wrote:
> The module argument passed to snd_card_new() must be a valid non-NULL
> pointer when the module support is enabled.  Since ASoC driver passes
> the argument from each snd_soc_card definition, one may forget to set
> the owner field and lead to a NULL module easily.
> 
> For catching such an overlook, add a WARN_ON() in snd_card_new().
> Also, put the card->module assignment in the ifdef block for a very
> minor optimization.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/core/init.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/sound/core/init.c b/sound/core/init.c
> index b02a99766351..0478847ba2b8 100644
> --- a/sound/core/init.c
> +++ b/sound/core/init.c
> @@ -203,7 +203,10 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
>   	mutex_unlock(&snd_card_mutex);
>   	card->dev = parent;
>   	card->number = idx;
> +#ifdef MODULE
> +	WARN_ON(!module);
>   	card->module = module;
> +#endif
>   	INIT_LIST_HEAD(&card->devices);
>   	init_rwsem(&card->controls_rwsem);
>   	rwlock_init(&card->ctl_files_rwlock);

Would it make sense to also change the ASoC code to use THIS_MODULE 
instead of card->owner?

/* card bind complete so register a sound card */
ret = snd_card_new(card->dev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
		card->owner, 0, &card->snd_card);

A quick grep shows we are setting .owner = THIS_MODULE pretty much all 
the time for machine drivers.
