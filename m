Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E548AC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 15:54:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B32C61924
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 15:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B32C61924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E88E852;
	Mon, 22 Mar 2021 16:53:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E88E852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616428448;
	bh=TIXRNJWCNLPAZ9soVuWT27eU9csbVlQfHK2EJXHOo5U=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vmSrSy6uQdBcWEEXyWenL609BdK4AWF+uAfKSUYy73Dj11h9mwNvSfISGUW5TjbcC
	 2W4DedRtsZiqLHFWjv34rkJdtgS4ClNPwb8Exj08rIwPHG9IYeUNPtfZGpZZiwLkEh
	 tVYPsHez7ZbB7sMU1WsK7Nsr9d42/R85jbKqb4rk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CEEA8F80156;
	Mon, 22 Mar 2021 16:53:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33D40F8016B; Mon, 22 Mar 2021 16:53:16 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88658F8012F
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 16:53:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88658F8012F
IronPort-SDR: QaiBkw4JLmklP4euLFpSuxWWQF+R51W6jJOR+LE6oFJtIIjKENo5++7XvoiJJJUaM3WFjVxxjH
 oCRoUKFUs8CQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="177870635"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="177870635"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 08:53:07 -0700
IronPort-SDR: Z47juyE8m6ITb/B8rH3nG+QDylFyKXbk4DrllZ4mIzp4j9yqTR7dwTRtgnQcCikwZ2MaEmvjyq
 O4Adoixoz2qA==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="451782523"
Received: from kaschuma-mobl1.amr.corp.intel.com (HELO [10.212.220.31])
 ([10.212.220.31])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 08:53:05 -0700
Subject: Re: [PATCH v4 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To: Perry Yuan <perry979106@gmail.com>, "Yuan, Perry" <Perry.Yuan@dell.com>,
 "pobrn@protonmail.com" <pobrn@protonmail.com>,
 "oder_chiou@realtek.com" <oder_chiou@realtek.com>,
 "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
 "hdegoede@redhat.com" <hdegoede@redhat.com>,
 "mgross@linux.intel.com" <mgross@linux.intel.com>,
 "Limonciello, Mario" <Mario.Limonciello@dell.com>
References: <20210301093753.16300-1-Perry_Yuan@Dell.com>
 <551e30d2-0211-f3cb-fbb8-ee5b2f22a851@linux.intel.com>
 <SJ0PR19MB4528E7C88C955D2EE96CE3B484939@SJ0PR19MB4528.namprd19.prod.outlook.com>
 <ab14a0b2-3f3a-3796-8baf-76e635d82340@linux.intel.com>
 <58d2e2f2-e552-6ecf-b1c3-bf38ad5d2e35@gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7e0fc125-5a26-47d6-aa2a-7cd1b2580adf@linux.intel.com>
Date: Mon, 22 Mar 2021 09:49:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <58d2e2f2-e552-6ecf-b1c3-bf38ad5d2e35@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>
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


> As you suggested,I should add the alignment change in another patch.
> But if i keep the old alignment, the code will be very odd.
> Seems like that I have to change the below code to new alignment in this 
> patch.
> 
> if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
>      dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) { <<--- changed back
>      if (!privacy_valid)
>              has_privacy = true;
>      else
>              has_privacy = false;
>      if (!has_privacy) {
>          micmute_led_cdev.brightness <<----------- new alignment
>          ...
>      }
> ...
> }

I don't get the point, sorry. The code above doesn't seem properly 
indented or there were spurious tab/spaces conversions?
