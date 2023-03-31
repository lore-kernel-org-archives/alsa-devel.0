Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC26BC6FD18
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Mar 2023 07:15:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB26B201;
	Fri, 31 Mar 2023 09:14:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB26B201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680246906;
	bh=xcBXT6nGLUiM5Q0jAej2peZ853JsCqe4BX/FKHNwqy0=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=E9qXF3GtIUr8p67AOcl0CkVUh/mIQMOluTLMlHYR2UxuzsNpNaMilAPjVmU3iqDeA
	 ouEf+DLOpWUa1wSldeLKYLMnzLoOjWIMAJByYE87/51l7W/vVNOx2N0icq/R2ZNOuY
	 dAJNCtj69Oc9KtIXUpvSSuYM+/BlHEpfkfcFGg6U=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AE7A8F80272;
	Fri, 31 Mar 2023 09:13:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 82F4FF80272; Fri, 31 Mar 2023 09:13:48 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1261FF80114
	for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2023 09:13:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1261FF80114
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SO1EwrRR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680246824; x=1711782824;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xcBXT6nGLUiM5Q0jAej2peZ853JsCqe4BX/FKHNwqy0=;
  b=SO1EwrRRRfuCBG9sRYvfEFp+A8xuAoNqp2ZVpzG+dE8jv4imDdRozZaf
   uRw3SGvJmuISAcDv514yNwgp0r8GMvWO4wOI4YHNKXonPdxKa74mMCckV
   8JBBGUqzckDcB/PgBPrK6Qbb2LvuQxVOf8lMyB9teMWguyft8xb5YCvLU
   qYbaqGcRYLqEc7AypWsfAZMR0H7GlWd6NU7G117QXjjPjRECtzJCNOIq2
   AHi0rumc/hm6jCZk7AMTPjXZzFImb/Lmt+SCBdvOqzZ1ZkgPVTIoPAT4z
   7Q3l++RsZV38JyZdjWeOJG4Q+6o2RgkonRJGR5MY+pdHXVugsXhw81PPG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427660016"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400";
   d="scan'208";a="427660016"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2023 00:13:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="635190290"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400";
   d="scan'208";a="635190290"
Received: from acaviglx-mobl1.ger.corp.intel.com (HELO [10.251.209.247])
 ([10.251.209.247])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2023 00:13:38 -0700
Message-ID: <80f2a9e2-a2fb-4543-b381-251bb07876ef@linux.intel.com>
Date: Fri, 31 Mar 2023 10:14:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [bug report] ASoC: SOF: avoid a NULL dereference with unsupported
 widgets
To: Dan Carpenter <error27@gmail.com>, guennadi.liakhovetski@linux.intel.com
References: <4826f662-42f0-4a82-ba32-8bf5f8a03256@kili.mountain>
Content-Language: en-US
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <4826f662-42f0-4a82-ba32-8bf5f8a03256@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: HVRCAQDDBE5U2WZ6B5AR4IFCWNY5WVUN
X-Message-ID-Hash: HVRCAQDDBE5U2WZ6B5AR4IFCWNY5WVUN
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HVRCAQDDBE5U2WZ6B5AR4IFCWNY5WVUN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Dan,

On 31/03/2023 09:58, Dan Carpenter wrote:
> Hello Guennadi Liakhovetski,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch e3720f92e023: "ASoC: SOF: avoid a NULL dereference with 
> unsupported widgets" from Mar 29, 2023, leads to the following Smatch 
> complaint:
> 
> sound/soc/sof/ipc4-topology.c:2353 sof_ipc4_route_setup()
> error: we previously assumed 'sink_fw_module' could be null (see line 2351)
> 
> sound/soc/sof/ipc4-topology.c:2353 sof_ipc4_route_setup()
> error: we previously assumed 'src_fw_module' could be null (see line 2351)
> 
> sound/soc/sof/ipc4-topology.c
>   2350	
>   2351		if (!src_fw_module || !sink_fw_module) {
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> One of these is NULL.
> 
>   2352			/* The NULL module will print as "(efault)" */
>   2353			dev_err(sdev->dev, "source %s or sink %s widget weren't set up properly\n",
>   2354				src_fw_module->man4_module_entry.name,
>   2355				sink_fw_module->man4_module_entry.name);
>                                 ^^^^^^^^^^^^^^
> Both are dereferenced.  The comment is very puzzling.

if src_fw_module is NULL then the print will be:
source (efault) or sink sink.module.name widget weren't set up properly

Guennadi is relying on some black magic in the printk system to handle
the printing instead of open coding.

-- 
Péter
