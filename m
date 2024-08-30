Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CF9CA0EFB
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2024 10:12:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C0AAA4A;
	Fri, 30 Aug 2024 12:12:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C0AAA4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1725012764;
	bh=WjrGopvfWBwqadCF5AMZbTn86mU67OhWuakpxI4+ldA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=axnSFwyDbgRKohnBSqOHhllcLQ1CJ34+H/GswWo/5bJUk8UAt/fXxFxL6rMUbA+BW
	 c5TZQ/3b7bcZ2v5NRX2cz+RAzOz09OMIkGytz65uEqXQf18USKpsaBhE+YRCSnh9/3
	 jhR8n5lODiUvPEpsqOsdbciRyuTb9QnojyiK8dAc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3C34F805D3; Fri, 30 Aug 2024 12:11:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CFA2F805D3;
	Fri, 30 Aug 2024 12:11:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D799F805D3; Fri, 30 Aug 2024 12:11:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 75506F80087
	for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2024 12:11:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75506F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=edk/qeRS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725012695; x=1756548695;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WjrGopvfWBwqadCF5AMZbTn86mU67OhWuakpxI4+ldA=;
  b=edk/qeRSpRocz+zvk5XqqwMqIzrfhVkjq/nAwrs5rjOYFFqcndCn0u7V
   Bq74etYRJFQxIcYybgCMWCFqV6DqywYsUNBm7HwsaPKn9pJ3qNTGYT02f
   1nQfDdawJJoHrnFOYL4OM8CGwzbVzLP8ViIYp8d+YW2ksdYBofGbONrko
   DKu+kH/VxzAeyWO+BUTP7I1FoQPCiBqd0NSV+vYZvDTetQpdSDRJYHu/b
   DJBsl9zQlkuYRB4lzEFhjJtNw3oZyMoTszDiiyttXwnwP0iceMbxoHzqe
   CrZTngZRl4dH6UNslPpa7rCJwKsEgdCZgHZLv4fMUgQzfQAHbFpDVPMne
   g==;
X-CSE-ConnectionGUID: iDxhPETETpSomAuzWE9eJg==
X-CSE-MsgGUID: 0qm+jqDHSgGpYjufHdt+Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34218721"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600";
   d="scan'208";a="34218721"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2024 03:11:33 -0700
X-CSE-ConnectionGUID: fdk8jU+yTuSP5Li9jQhozA==
X-CSE-MsgGUID: iX//HswMRjeENxKXJX8Byw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600";
   d="scan'208";a="63481353"
Received: from ltuz-desk.ger.corp.intel.com (HELO [10.245.246.101])
 ([10.245.246.101])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2024 03:11:27 -0700
Message-ID: <fedfc810-fcc2-49fa-9165-34003b111fc5@linux.intel.com>
Date: Fri, 30 Aug 2024 10:34:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 11/33] ALSA: usb-audio: Check for support for
 requested audio format
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com, corbet@lwn.net, broonie@kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com, krzk+dt@kernel.org,
 Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com, robh@kernel.org,
 gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-input@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-doc@vger.kernel.org, alsa-devel@alsa-project.org
References: <20240829194105.1504814-1-quic_wcheng@quicinc.com>
 <20240829194105.1504814-12-quic_wcheng@quicinc.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240829194105.1504814-12-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: EJDGZRO2JPOBA256PCHBGL6WUP2QHLEB
X-Message-ID-Hash: EJDGZRO2JPOBA256PCHBGL6WUP2QHLEB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EJDGZRO2JPOBA256PCHBGL6WUP2QHLEB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 8/29/24 21:40, Wesley Cheng wrote:
> Allow for checks on a specific USB audio device to see if a requested PCM
> format is supported.  This is needed for support when playback is
> initiated by the ASoC USB backend path.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

