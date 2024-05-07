Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E7FC19F4F
	for <alsa-devel@archiver.kernel.org>; Wed,  8 May 2024 13:19:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2657839;
	Wed,  8 May 2024 15:18:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2657839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1715174348;
	bh=lifN/agSpUEsjctyCIsr+TXeYS3JFwPNhUXnrldJp2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=e/jj+Xg9ffYqQc28TdSU3pkdY1toD69WEiNZJ0DWxYNKQ7OS/nOwwhuEeYcraLZcc
	 +M/jpzm99O7FaMNWSr1tnsBRdQ+PvFu8T0aHiE77VJUbi4nsSUaqbnNv3G6oFpLxbX
	 BaE2dfGPP2Q2XM34LjoRFrFoi5s2A74SdPpPMjkE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15767F806D5; Wed,  8 May 2024 15:16:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 10F85F806D4;
	Wed,  8 May 2024 15:16:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D231FF80622; Wed,  8 May 2024 15:16:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B498AF80604
	for <alsa-devel@alsa-project.org>; Wed,  8 May 2024 15:16:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B498AF80604
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WWBo6Ksu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715174187; x=1746710187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lifN/agSpUEsjctyCIsr+TXeYS3JFwPNhUXnrldJp2g=;
  b=WWBo6KsuMTBlxfulma3mUZsmYaH4qrr2yqL01poCGmYRfYKFMwjqrdhN
   a6lvT37m1Vy4AKzhX3mP6GVc0R+ubqi1JTQBoXi7kQEE5wjJOpQcHxF+G
   B3xg6l9la4iDYTusM4bHr85xD/1jN7xB/YTto3c+9a3wFeNn3sILT4SwK
   Qv2af46i9XilBH9+gO5mh91TubGbGqgBS6vn02t3NXhfJAhiyU5+1p5JK
   hbffdLNbn2uzVjKBLmOkRkQlDg1P04XhiLkc2UuyKJMdy3vPBAJEPqvGz
   QG9muW3sZrfe3YbcmMGgszMmG14S2mE+HcHcAnINC388TOFKNfQjbDMdV
   Q==;
X-CSE-ConnectionGUID: swwFf5pLQk+vm2BfijuN+Q==
X-CSE-MsgGUID: DSqk6mBHR3eKbJ26HQ+X5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="36413334"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000";
   d="scan'208";a="36413334"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 06:16:25 -0700
X-CSE-ConnectionGUID: bsu1eEYFR6+cMJK2ATzrUg==
X-CSE-MsgGUID: w3/raNdzSdGFMemhzhWL4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000";
   d="scan'208";a="33356862"
Received: from sskolar-mobl.amr.corp.intel.com (HELO [10.212.67.115])
 ([10.212.67.115])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 06:16:23 -0700
Message-ID: <cb864ea4-95e3-4e99-920d-341188006291@linux.intel.com>
Date: Tue, 7 May 2024 16:40:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 38/39] ASoC: qcom: Populate SoC components string
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
 corbet@lwn.net, lgirdwood@gmail.com, andersson@kernel.org,
 krzk+dt@kernel.org, gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
 broonie@kernel.org, bgoswami@quicinc.com, tiwai@suse.com,
 bagasdotme@gmail.com, robh@kernel.org, konrad.dybcio@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240507195116.9464-1-quic_wcheng@quicinc.com>
 <20240507195116.9464-39-quic_wcheng@quicinc.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240507195116.9464-39-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: HDTEFMQSTDVHKQMUJRROQKI6BCRS6FMU
X-Message-ID-Hash: HDTEFMQSTDVHKQMUJRROQKI6BCRS6FMU
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HDTEFMQSTDVHKQMUJRROQKI6BCRS6FMU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 5/7/24 14:51, Wesley Cheng wrote:
> For userspace to know about certain capabilities of the current platform
> card, add tags to the components string that it can use to enable support
> for that audio path.  In case of USB offloading, the "usboffldplybk: 1" tag

usboffloadplayback?

same question as before, do we need spaces?

And if we have controls, why do we need component strings? The component
string is not dynamic to the best of my knowledge, this could be
problematic if the card is no longer capable of supporting this stream,
while a control can be updated at will.

