Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D58CC433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Mar 2022 17:31:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08352172B;
	Mon,  7 Mar 2022 18:31:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08352172B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646674315;
	bh=1RKOb8u27Yj5tV+Tkzspim+JdeLHJ5+iNWbNylaJfdg=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pKOBkN22fK9nJI7ys54paf7OB16aZeuPFV5eIZo5xZH1mO8sn1LsxIlJf9TqN/hPu
	 zjAtQ/x/BoXOERQRJK9IcHKZ2U0FQsS9mR3mwLE7z9ri3fHXT9qkVZPtdhrgqrV6ND
	 kzHlz36BhaWSvlo9HqNKBJRJ3DpjAuamx2UXzVeE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DE2AF800D1;
	Mon,  7 Mar 2022 18:31:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74307F80132; Mon,  7 Mar 2022 18:31:03 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9753BF800D1
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2022 18:30:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9753BF800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ErETGWp2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646674261; x=1678210261;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1RKOb8u27Yj5tV+Tkzspim+JdeLHJ5+iNWbNylaJfdg=;
 b=ErETGWp238iW5QJGzwmp7Fy87h/qYv4uxy6wKvCtBJ69KwCgiTWiwOL2
 WZz4rAAOJzqAD44LuXhh5whvGCh2WSk0KqaSDY9dnGGop5VhoOZ58pnem
 NVSGAKP0M+dCv+bYhb262gHEfEv+yIfG63MwACem474qrmVp3GRwnW0XL
 zhwMpe/ILIHX+5NDOkhlKz83SYVj/UlfPeE7WgLRnAHTZEUb1RZJbAy0u
 iA3W3u9NUilyxc3B5H6c/XLVDV0qRZbifo6FDTZw4QiQjjAZ3xbX6Xi3V
 54+whrmoud/TpZQvtUw1VPzCM7Pe33GkvmaNGPAXnSC3DOts8lrNN45PT A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="252027835"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; d="scan'208";a="252027835"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2022 09:30:57 -0800
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; d="scan'208";a="509783129"
Received: from zhaojohn-mobl1.amr.corp.intel.com ([10.254.24.100])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2022 09:30:56 -0800
Message-ID: <9f4cbf5a720aa66d6a540092187ad88b3adb5525.camel@linux.intel.com>
Subject: Re: [PATCH v3 11/17] ASoC: Intel: avs: Firmware resources
 management utilities
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
Date: Mon, 07 Mar 2022 09:30:55 -0800
In-Reply-To: <f70be289-ee9c-51b5-4003-7bc567e87a54@intel.com>
References: <20220304145755.2844173-1-cezary.rojewski@intel.com>
 <20220304145755.2844173-12-cezary.rojewski@intel.com>
 <66e20563567955124488eb9f9b53ea6a2bc5d744.camel@linux.intel.com>
 <d7676598-27bc-fe5d-1167-c82795e533f7@intel.com>
 <a571f334944f3ae7762068572003299c34fd187a.camel@linux.intel.com>
 <f70be289-ee9c-51b5-4003-7bc567e87a54@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: upstream@semihalf.com, harshapriya.n@intel.com, rad@semihalf.com,
 tiwai@suse.com, pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
 broonie@kernel.org, amadeuszx.slawinski@linux.intel.com,
 cujomalainey@chromium.org, lma@semihalf.com
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

On Mon, 2022-03-07 at 18:13 +0100, Cezary Rojewski wrote:
> > This is the part that's hard to follow without seeing the actual
> > code
> > where this new library is loaded. When does a libray get loaded?
> > When
> > you start streaming and you realize that the stream requires a
> > module
> > that is not built into the base FW? Can this be done during
> > topology
> > loading instead?
> 
> 
> But that's already done during topology load! If there is no
> topology 
> 
> telling the driver: "hey, load this lib for me!", nothing gets
> loaded 
> 
> regardless of how your /lib/firmware looks like. Libraries get
> loaded 
> 
> during soc-component's (platform component) ->probe(). This is place 
> 
> where snd_soc_tplg_component_load() is called.
> 
> 
> 
> However, if platform has no IMR capability, driver has to re-load 
> 
> libraries for all platform components of bound sound cards on every 
> 
> pm_runtime_resume().

And if it done during pm_runtime_resume(), where would the problem with
synchronizing arise from? userspace apps do not get resumed until after
the PCI device is resumed isnt it?

Thanks,
Ranjani

