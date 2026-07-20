Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B564C44520
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:26:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 234CB601FD;
	Mon, 20 Jul 2026 13:25:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 234CB601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784546763;
	bh=CJX8fznzPc9Nj5imz58fb6QIOpYCrCWvGYvGxBv5MH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RP1ozeLbXGE8DFrZ+hLm1hr+9/SiNMzgBYK3yYLgeuVviOy6/eghYsaSqgE/gCcNS
	 kjPJ87lQefI4CvuaPheiOak3Mvf6akzC0qjhbW9ZL69Ahgc8zLlRquavPaCJ+InLJu
	 j8jrxBsHxVVXZH/AE7mf00hFihtqjLjfQegFOFuE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 92465F805F9; Mon, 20 Jul 2026 13:25:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CA236F80600;
	Mon, 20 Jul 2026 13:25:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A6ECF80496; Mon, 20 Jul 2026 13:25:23 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784546721;
	b=iecLB3Uc9McWd0BNizCDd2iOF0+3WOfDSHRkrqugUNl5OhSUTrwQodF9t61VU5leVqY9
	 AoDUPiAsm4UFIgifjyvkok0gwxr/vSKPKgDbYf/yZWxlTPINUICp0Qx7loF8dRjsCAjek
	 zWV/f85FXcFV9bRiiul5v1nl7zaFEznO9zi2RbGdmg7TC1RohnJ+ccOsb1CVhW/vs75b0
	 NYhe28lOXNOpq75mk1wmvbGMNtHBQCPYUmT18IlMMz5gJ0ABB38BL/R9H8nrekf33kEci
	 NpIIzFHDnGSvSDEWELfF/X7LLUFRUYJwmYWE5x5FYGDG4bF/7uaKrTp1qehEXtg64Qg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784546721;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=CJX8fznzPc9Nj5imz58fb6QIOpYCrCWvGYvGxBv5MH0=;
	b=UNV6WtFZ+tVigjZ5hgEb6Mep4J+KhMqy5/qYXb3ySNES9D2yofXT+7eys2lSIG9oDOBL
	 a7Y/3QrvWHvLWvYE5bwygp8kNP9LjzD4rDgdfDFTEzje3qACebSoIAgu8o1VDuuYFBkcy
	 awVPwDY9VVfFexKWWgw+42fwwCFJXTfQVbi9CIqerXV/ASIFN/HTmdxzxgWC0sOcudaGD
	 oNXc69C9PDxRosXcu9if9tnry7USNoNmeYeOxrZ1FUtnqKvUtMD8Mw/Iinm8Z921pdmq1
	 YYRZgl5OYgDuKgBDCvTCpFC6oevkOrFMx5oUWMAv/h/oo+qI0RogW/kzMzncnrd6KSg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bFmx7EUL;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1A1FEF8010B
	for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2026 13:25:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A1FEF8010B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bFmx7EUL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784546721; x=1816082721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CJX8fznzPc9Nj5imz58fb6QIOpYCrCWvGYvGxBv5MH0=;
  b=bFmx7EULaL8aXwmqlljY4shpibQ+Ctj0mpfJk5oS/lbB2WjumqXP4155
   VhqE/vbohqSD+g39nllAtO/2XAnbJ3m6KVvsL+/gMe4kybpq7Xb1HNue/
   xZGfB+ZKIR35radJZs4ig3e/esy6bsFC7QrbPtpjnnwDsxb61WdbSQ83h
   sqtj5stdmw4jXjWgqnmngRTjMYo6tRM22nTev3vSZmGVrM/kNt74DDfNn
   JIIyWeQWLD2Elxw/vluOkxpQmcD4xJqF6EkWprt5bBRuKDCr9CmM2hdPh
   9Zo9iAZ+D39twNtbi+P4pTVFTV1foDvATnyONo66jmEb7sKT/uiWPQYm4
   g==;
X-CSE-ConnectionGUID: 4JEkAOlKTACWkzH6ivMuag==
X-CSE-MsgGUID: hPJ5nWeXRVGX4bthJGB6Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="88947213"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000";
   d="scan'208";a="88947213"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 04:25:16 -0700
X-CSE-ConnectionGUID: p4Al4b5hTry/r7sRPCQT6Q==
X-CSE-MsgGUID: 2taNrxjPQwWJ2eB9d9FEtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000";
   d="scan'208";a="256256367"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.175])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 04:25:13 -0700
Date: Mon, 20 Jul 2026 14:25:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, spatakok@qti.qualcomm.com,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	ravi.hothi@oss.qualcomm.com, dakr@kernel.org
Subject: Re: [DISCUSSION] fw_devlink: incorrect ancestor fallback for
 intermediate bus topologies breaks audio dependency resolution
Message-ID: <al4Flj5ntmqCKbH4@ashevche-desk.local>
References: <20260701131733.870079-1-ajay.nandam@oss.qualcomm.com>
 <d224b1e5-99a0-4794-b043-d6335f98753c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d224b1e5-99a0-4794-b043-d6335f98753c@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
Message-ID-Hash: HZAPIVUPE3UFGLHLWEKFWRA4VKLZR5QC
X-Message-ID-Hash: HZAPIVUPE3UFGLHLWEKFWRA4VKLZR5QC
X-MailFrom: andriy.shevchenko@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HZAPIVUPE3UFGLHLWEKFWRA4VKLZR5QC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Jul 20, 2026 at 04:42:21PM +0530, Ajay Kumar Nandam wrote:
> Hi All,
> 
> Gentle Ping on this discussion.

> CC'ing Danilo Krummrich and Andy Shevchenko

I'm not sure how I can be helpful here, but it would be nice to see a small
summary (a few sentences) to understand what this is all about.


> On 7/1/2026 6:47 PM, Ajay Kumar Nandam wrote:
> > Hi Saravana Kannan,

And yes, Saravana, is the main expert in FW devlinks AFAIK.

-- 
With Best Regards,
Andy Shevchenko


