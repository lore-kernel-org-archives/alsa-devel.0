Return-Path: <SRS0=MRBS=MI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CA4C12002
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jul 2021 18:44:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2F1613F8
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jul 2021 18:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2F1613F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D00D1691;
	Fri, 16 Jul 2021 20:43:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D00D1691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626461085;
	bh=q7556uojeO0TLiF81wagje53SrKDidTKmDOf/RmeBa4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VI5st2Ebqe7GlHG4G7NyMbhOGDa4t1LSNpsDqrwbXisbhglWEY/RlONBYh0QUVB3L
	 YhT//sldYmbsrQd0ZcuAAtqcsLhUCx5uSIq2FFUwFiuf66bALQUCqw11qPN7e/oLoy
	 skbr6ReZWOK/8GZdI2p2TzlqWQYibKVAB5mIS/XM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA74AF80253;
	Fri, 16 Jul 2021 20:43:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C938CF80254; Fri, 16 Jul 2021 20:43:52 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24BCDF8013C
 for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2021 20:43:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24BCDF8013C
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="198038360"
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; d="scan'208";a="198038360"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2021 11:43:46 -0700
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; d="scan'208";a="497102536"
Received: from mohalshu-mobl2.amr.corp.intel.com (HELO [10.212.40.103])
 ([10.212.40.103])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2021 11:43:45 -0700
Subject: Re: [PATCH] ASoC: Intel: Handle device properties with software node
 API
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
References: <20210322110638.2681-1-heikki.krogerus@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <050073c4-5ea0-183d-5bd0-7df388fcce33@linux.intel.com>
Date: Fri, 16 Jul 2021 13:43:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210322110638.2681-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

Hi Heikki,
Going back to this initial patch, I have a doubt based on Andy Shevchenko's comment on an update [1]

> The function device_add_properties() is going to be removed.
> Replacing it with software node API equivalents.

The replacement pattern takes this one line:

> -	ret = device_add_properties(sdw_dev, props);

which gets replaced by

> +	fwnode = fwnode_create_software_node(props, NULL);
> +	if (IS_ERR(fwnode)) {
> +		return PTR_ERR(fwnode);
>  	}
>  
> +	ret = device_add_software_node(sdw_dev, to_software_node(fwnode));
> +
> +	fwnode_handle_put(fwnode);

is the fwnode_handle_put() actually required here? This seems to work fine in our tests but I wasn't able to find in the code a matching _get().

Thanks for any pointers/comments!
-Pierre

[1] https://github.com/thesofproject/linux/pull/3041#discussion_r671450168

