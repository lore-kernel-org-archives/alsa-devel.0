Return-Path: <SRS0=4IlU=II=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C11AC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 15:45:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BCF64F8B
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 15:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BCF64F8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47680175F;
	Wed, 10 Mar 2021 16:44:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47680175F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615391118;
	bh=2ffeJRedd29bql479gzQ4PwXm9VWcsqowu2Eo/GMKQw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fGPLGTaVYNUxuD0rKKWhg/ghdqGbIQpzHShw0FuxFJlsu6fo7PcX7B4s1YW3fMQJC
	 cDaK2jcUtrXH7zU4CA+WIoh1vuRgj/5TVqkgYVXkYQ+Nox3zIueIu51CYgRzr4//Lk
	 JeXwn3Epo38nC1QpPru2YKuqCJV2/lWQf87YYu5o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8567F8014E;
	Wed, 10 Mar 2021 16:44:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE4E0F801D8; Wed, 10 Mar 2021 16:44:25 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3FD52F8014E
 for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2021 16:44:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FD52F8014E
IronPort-SDR: /4COdxnnp47q38LIPh3nMIrJWJtbrUch+G6iWimLvSYmsZr7IaBFqdFfxS67vjGnjoLdlbi/9c
 +XGZc989okrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188589387"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; d="scan'208";a="188589387"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 07:44:10 -0800
IronPort-SDR: qQdbsx34tWrJf+GmQW+EKuGyeK/eQQYhdUGeCwXB+UxTZeY7fC0J3xMO6Ff8cfkpnszZbGYf04
 TQ4s6vwjFdAw==
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; d="scan'208";a="403721850"
Received: from huiyingw-mobl.amr.corp.intel.com (HELO [10.212.214.84])
 ([10.212.214.84])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 07:44:08 -0800
Subject: Re: [PATCH V2] ASoC: soc-core: Prevent warning if no DMI table is
 present
To: Mark Brown <broonie@kernel.org>
References: <20210303115526.419458-1-jonathanh@nvidia.com>
 <91480f92-a3f5-e71f-acdc-ea74488ab0a1@linux.intel.com>
 <20210310133534.GD4746@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6a2352e6-f2b7-def1-de58-52fbeb7846e5@linux.intel.com>
Date: Wed, 10 Mar 2021 09:44:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310133534.GD4746@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>
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



On 3/10/21 7:35 AM, Mark Brown wrote:
> On Tue, Mar 09, 2021 at 01:41:45PM -0600, Pierre-Louis Bossart wrote:
> 
>> The problem is that the cards are platform devices created by the parent
>> (which itself may be a PCI or ACPI device) and have nothing to do with ACPI.
> 
>> Could we flip the logic and instead explicitly detect OF devices? That
>> restores functionality for us.
> 
> Just change it to a system level check for ACPI, checking for OF would
> leave problems for board files or any other alternative firmware
> interfaces.

did you mean if (!IS_ENABLED(CONFIG_ACPI)) ?
