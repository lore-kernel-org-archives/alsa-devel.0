Return-Path: <SRS0=sQP2=IP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68645C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Mar 2021 17:01:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2F164E90
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Mar 2021 17:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2F164E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F91B16D2;
	Wed, 17 Mar 2021 18:00:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F91B16D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616000482;
	bh=AIwI9pF4eQZeiZNwAsNV/muDQcbuoe6oxgT0dt576Jc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U2eYay+mzjsXfH15Ycgxb8f3TfBjFZHbyfEuHnz6rsYu6ySLCecvAYVuN75Y2bQkW
	 28Wp2zgztCuP3dyJd+SlJ4pMaTVjGo7HXnZfjiCIgBJzuG9qkmWy3FaKVZ4rLpO6xn
	 9I57AahofiGoeMRf4dH9uqeGyJiVflC4MF+Qncgk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ACBE4F801F7;
	Wed, 17 Mar 2021 18:00:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B61BF8021C; Wed, 17 Mar 2021 18:00:28 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8FF7F80148
 for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2021 18:00:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8FF7F80148
IronPort-SDR: ky0bDgiaaDjpkVHgFYtH3r4pfYIM67JJDn+FNDzgm1q+BpGPKU+sr5bwL9ugNalBHLWvX1l45L
 Q0t6BRHxgNmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="187134716"
X-IronPort-AV: E=Sophos;i="5.81,256,1610438400"; d="scan'208";a="187134716"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2021 10:00:19 -0700
IronPort-SDR: im8DkSnsEPEeH8ESw7q5MtKr9QwKE9Ox0AlR9DV+mWIoCfRVtQ5rQsqq8o7g9Vd0hHY8Klpu9k
 nr1QVUTMv7oA==
X-IronPort-AV: E=Sophos;i="5.81,256,1610438400"; d="scan'208";a="511792045"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.237.180.75])
 ([10.237.180.75])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2021 10:00:17 -0700
Subject: Re: ASoC topology loading vs card bind
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 pierre-louis.bossart@linux.intel.com, broonie@kernel.org
References: <09c77d7e-3def-0643-b838-94d748529333@linaro.org>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Message-ID: <4a4c96df-b145-5bb7-ad91-e5d3644f704c@linux.intel.com>
Date: Wed, 17 Mar 2021 18:00:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <09c77d7e-3def-0643-b838-94d748529333@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
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

On 3/17/2021 4:16 PM, Srinivas Kandagatla wrote:
> Hi All,
> 
> Am trying to load a FrontEnd/pcm dai definition from ASoC topology 
> however I hit a catch 22 situation here. Topology is loaded as part of 
> component probe() but component probe is only called as part of 
> sound-card bind().
> 
> Any pointers on how is this supposed to work?
> 
> 
> Thanks,
> srini
> 

Hi,

I would say I partially described how it works, when writing topology 
kunit tests, here is link to cover letter:
https://lore.kernel.org/alsa-devel/20210120152846.1703655-1-amadeuszx.slawinski@linux.intel.com/

To sum it up, there is no predefined order in which component and card 
should be created. After each one of them is created ASoC tries to 
rebind everything together and it should call component probe if 
everything connects correctly.

I'm not sure what problem you are seeing, but if you look at topology 
test cases I only define BE in it, no FEs. So I guess you can look at it.

You can also look at skylake (sound/soc/intel/skylake) or SOF 
(sound/soc/sof/) driver code which are real use cases of topology.

skylake and SOF code have pcm part which creates component and registers 
probe function responsible for loading topology. Separate part are 
machine drivers which create card (sound/soc/intel/boards).

