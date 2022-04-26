Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C01CC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Apr 2022 18:43:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5AA391751;
	Tue, 26 Apr 2022 20:42:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5AA391751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650998627;
	bh=9+KFtjL6DqziZHflCdlupEuWBC+Qd2ZkQ6uM8Aute1k=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q4beuJEc4kowZj3ird4Cvel4jnEmpI5vSjtAqJx/ayMuYFg08gboWd77pmgL47quj
	 zc2n4Lcso0jy92cpVU1/MlpTsR82Uy5SuLibJ4c/72mPitIrsDSDPKbNGfzT5HoLMd
	 uc7t8Ky1bpMMd4IOR5ylZB43FJtHwWkpT/Md406g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFF62F80105;
	Tue, 26 Apr 2022 20:42:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 77378F80171; Tue, 26 Apr 2022 20:42:51 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A1D8F80105
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2022 20:42:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A1D8F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="T01BHBRR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650998569; x=1682534569;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9+KFtjL6DqziZHflCdlupEuWBC+Qd2ZkQ6uM8Aute1k=;
 b=T01BHBRRsNGPtogPOMk9X7L4y4+uI1SensJEw1Pzc+OZc2YoltcmtGYj
 Zw6w8S5TXgQqvLkJG+hNpvGXJitPZLJCL9eK8IyomfMohrvS61R1iYxn4
 WUNd1tWlww5DSiQkaLHiHslgx3aqoRfh/v7QzLmHMCCfgUslLSAdLs2TL
 gxESeYiRFw82ClLSj9awLpWf+0gA+WlIb7OPd4vAw4SkSpuMqvht4IN7U
 nFoVlldFTl5mCPCpKElsFwa/PkhVfBDc7YXnXxZGVpDpvZm7zVAt3HtK3
 jyjvO0OVyGm50jTJbJMZ+INbcUDYrQdKGMHuw4iQgzgcGZywddu8DbrJi Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="245609334"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; d="scan'208";a="245609334"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 11:42:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; d="scan'208";a="628658829"
Received: from jzhang96-mobl.amr.corp.intel.com (HELO [10.212.151.202])
 ([10.212.151.202])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 11:42:45 -0700
Message-ID: <a318a2f3-6381-515f-9c0a-4936315cfc1f@linux.intel.com>
Date: Tue, 26 Apr 2022 13:42:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] ASoC: Intel: avs: Depend on CONFIG_ACPI
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <20220426115454.685787-1-amadeuszx.slawinski@linux.intel.com>
 <eab567f0-73a4-bf23-76bf-8d576fa942f0@linux.intel.com>
 <YmgnE/HKNmI+agNs@sirena.org.uk>
 <726c58e5-241d-053f-8b4c-d56a5a228f0f@intel.com>
 <Ymg5CAbwf/UxUOff@sirena.org.uk>
 <ba9e90de-94ad-d6c9-b6df-1fe6f802e9d6@linux.intel.com>
 <Ymg8HTcdxprUZBjH@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Ymg8HTcdxprUZBjH@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 kernel test robot <lkp@intel.com>, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>
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



On 4/26/22 13:38, Mark Brown wrote:
> On Tue, Apr 26, 2022 at 01:26:08PM -0500, Pierre-Louis Bossart wrote:
> 
>> my suggestion was the following:
> 
>> depends on PCI
>> depends on COMMON_CLK
>> select SND_SOC_ACPI if ACPI
> 
> The X86 || COMPILE_TEST that's there currently is also sensible given
> that this can only actually be used on x86 hardware.

right, I only commented on the ACPI dependency. 

X86 || COMPILE_TEST is also what we use for SOF.
