Return-Path: <SRS0=ClfJ=BA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EBFC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 23:49:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808CE20720
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 23:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SIJ6v+yY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808CE20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D4831664;
	Wed, 22 Jul 2020 01:48:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D4831664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595375358;
	bh=XheyT8ugjZEhER2n/wfgO5AQsrIw4OqkZsXBMCfMgQI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SIJ6v+yYcU00qlrqjzVoOLNCQ6ECL5yaB3bSjJGNPAXRdvo5E0hcC1qfF56CkCIx6
	 Iatjr66f3/Yw81asT/z1+3fC55P4/HDcrLwhdRpzvd22uiWM+QfhPwY4BMEapusGyk
	 cJ/nbrp8Lu8tXSSgi6vBmcyt0k+BvJQ+1jmcD8N0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30165F802BE;
	Wed, 22 Jul 2020 01:46:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD7EDF8028B; Wed, 22 Jul 2020 01:46:15 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 236ABF80117
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 01:46:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 236ABF80117
IronPort-SDR: SxyVTOEG2lo2J9NF1Cb3sEvECcqVxENzIob0VsYS9qFg652Rq2YicO6yWHEQjJPMq86veeMHV3
 aKALFmoqECqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="151576928"
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; d="scan'208";a="151576928"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2020 16:46:08 -0700
IronPort-SDR: MMOeo2/Dfs4n33AjN7IWa6gd0dbQP6GDc/LDiygHgeiRJQr7ssztFCvpExHJSdyrfvoo3kiWwF
 YAWsvo7SYnQw==
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; d="scan'208";a="362539381"
Received: from krlloyd-mobl.amr.corp.intel.com (HELO [10.255.231.6])
 ([10.255.231.6])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2020 16:46:07 -0700
Subject: Re: [RFC PATCH v2 1/6] ALSA: compress: move codec parameter check to
 a function
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <20200721170007.4554-2-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ce83d990-d00d-5dbc-ddcb-6c3ad48f5483@linux.intel.com>
Date: Tue, 21 Jul 2020 14:56:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721170007.4554-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
 vkoul@kernel.org
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



On 7/21/20 12:00 PM, Srinivas Kandagatla wrote:
> Move codec parameter checking to dedicated function so that other
> callers do not duplicate it. This is in preparedness for adding

preparation?

> snd_compr_set_codec_params() support.
> 

