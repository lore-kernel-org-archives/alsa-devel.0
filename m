Return-Path: <SRS0=6Vr6=3D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999E9C33CB2
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 19:49:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1FD24655
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 19:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I4T8SwFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1FD24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 737EE17A6;
	Tue, 14 Jan 2020 20:49:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 737EE17A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579031397;
	bh=4OQBtnoXWWveSc7opHZe1j5aRTotnuGiiZLC/DcEh7I=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I4T8SwFqYrPoX4vdmsYR/+9q6anLBKSQaOUS/pWIMPZ5gArRSdATluqygShLmUyJW
	 qZ2VZhP4x486HECQU3u9Rw0dvNBFFvOTIlASKr13W6JCHt7Gu0B9EDIeKZiqylbUbg
	 jJ/Fj9t/EM91mQWW3ByO76FM1C6kFEe3onRFfnEg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88384F8014D;
	Tue, 14 Jan 2020 20:49:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8556CF8014E; Tue, 14 Jan 2020 20:49:04 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B743AF80121
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2020 20:48:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B743AF80121
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jan 2020 11:48:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; d="scan'208";a="248153170"
Received: from cfrupp-mobl1.amr.corp.intel.com (HELO [10.252.130.148])
 ([10.252.130.148])
 by fmsmga004.fm.intel.com with ESMTP; 14 Jan 2020 11:48:53 -0800
To: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org
References: <20191220164450.1395038-1-marex@denx.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9fd0bdd7-4599-a84d-9807-c33541035b4a@linux.intel.com>
Date: Tue, 14 Jan 2020 13:48:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220164450.1395038-1-marex@denx.de>
Content-Language: en-US
Cc: Igor Opaniuk <igor.opaniuk@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
 Mark Brown <broonie@kernel.org>, festevam@gmail.com
Subject: Re: [alsa-devel] [PATCH V2 1/2] regulator: core: Add
 regulator_is_equal() helper
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


> +static inline bool
> +regulator_is_equal(struct regulator *reg1, struct regulator *reg2);
> +{
> +	return false;
> +}
>   #endif

this breaks my build... shouldn't this be:


diff --git a/include/linux/regulator/consumer.h 
b/include/linux/regulator/consumer.h
index 2c89d886595c..6a92fd3105a3 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -596,7 +596,7 @@ regulator_bulk_set_supply_names(struct 
regulator_bulk_data *consumers,
  }

  static inline bool
-regulator_is_equal(struct regulator *reg1, struct regulator *reg2);
+regulator_is_equal(struct regulator *reg1, struct regulator *reg2)
  {
         return false;
  }
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
