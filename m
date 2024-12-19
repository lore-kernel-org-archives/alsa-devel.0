Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302B7E77184
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Dec 2024 14:09:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 319586026D;
	Thu, 19 Dec 2024 15:09:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 319586026D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1734617358;
	bh=c7D41ZzagNhqWWNZmCWnkgbrWY21o93XuI9h6+fDFlY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UeN43zLcW8LujmuxC63x1g/pLrI12+rIOc6eVRN7gdxyDzYHrzsa0LWawBpS0oO90
	 K2zFSZRTEZSywBSjmdZe6bYqwV9Qmqnp9Exe4j5oV/mSFc4iPkHZa7+HiEX9KG0JZe
	 KwiltVCLuVhg8a4R5IQirJD10Cf5ekdjncNbVmyo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4AF8F805C3; Thu, 19 Dec 2024 15:08:42 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A774F805BB;
	Thu, 19 Dec 2024 15:08:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4F2DF8014C; Thu, 19 Dec 2024 15:08:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 123F3F800B0
	for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2024 15:08:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 123F3F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MuR9MP/q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734617314; x=1766153314;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c7D41ZzagNhqWWNZmCWnkgbrWY21o93XuI9h6+fDFlY=;
  b=MuR9MP/qTLMfzEjJZabbMfDBEUw8AnO4q8Dq6j9NeTiuihRprqeKhl7W
   nrjJXD9Niy/QJNeS3P6/XyDKnQ3M9OVwtD6ExksZt0tThKXpVcBEaL/zH
   i7UkNA0d1Eh5rL0XIcDHlUDKjv9WbQoQ+TRSmTdgrV38RhEAWLqK9j4vb
   R58Q2Lc7zbJdtp4B3OgKG5twSc+ZCS29MS/NZGrYeWRKefMkQOYYvVw9a
   429YdmPqCPg2AopZLbgiYWbWvXbz7Vi0kT6vT7upyvGxMKHuBaM5auwyW
   tNzrJsoibrcf2RDCJZHhDeBEts4XOTgJbEEOhNNlWA9MglWVexw05otty
   Q==;
X-CSE-ConnectionGUID: dMYPbyL9TCa9yv7KIk0rMA==
X-CSE-MsgGUID: SIzOyoowRYKWlpEWgxVDtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="45725112"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600";
   d="scan'208";a="45725112"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 06:08:25 -0800
X-CSE-ConnectionGUID: maLhaODsQK20okSYH5k8dQ==
X-CSE-MsgGUID: KEG5wSuUQqamjpXHiNQyeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600";
   d="scan'208";a="98262780"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 06:08:23 -0800
Date: Thu, 19 Dec 2024 16:00:08 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Lucas De Marchi <lucas.demarchi@intel.com>
cc: Takashi Iwai <tiwai@suse.de>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
    Daniel Vetter <daniel.vetter@ffwll.ch>,
    Alsa-devel <alsa-devel@alsa-project.org>,
    Jani Nikula <jani.nikula@linux.intel.com>,
    Chris Wilson <chris@chris-wilson.co.uk>,
    Maarten Lankhorst <dev@lankhorst.se>, dri-devel@lists.freedesktop.org
Subject: Re: hda: how to implement component master_unbind?
In-Reply-To: <itxamqrgaiukl3u63zz73brvqpfr6kjdwifrvx7ntjvzdewrlb@miy5fjm4v7ds>
Message-ID: <alpine.DEB.2.22.394.2412191343280.14041@eliteleevi.tm.intel.com>
References: 
 <alpine.DEB.2.22.394.2109221456080.3554566@eliteleevi.tm.intel.com>
 <s5ha6jxnekp.wl-tiwai@suse.de>
 <itxamqrgaiukl3u63zz73brvqpfr6kjdwifrvx7ntjvzdewrlb@miy5fjm4v7ds>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID-Hash: I4XRLOISTYRHRLYUF43IFV6RKQAEYKJO
X-Message-ID-Hash: I4XRLOISTYRHRLYUF43IFV6RKQAEYKJO
X-MailFrom: kai.vehmanen@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I4XRLOISTYRHRLYUF43IFV6RKQAEYKJO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

On Fri, 13 Dec 2024, Lucas De Marchi wrote:

> Thanks Kai to pointing me to this thread, trying to revive it.
> Also adding dri-devel as it may be relevant there and Maarten who worked
> on the xe integration recently

ack, given fresh wave of bugs this year (even if these are all (?) bugs 
triggered in test configurations), probably warrants another look.

[1) prevent/block the unbind if audio device is busy]
> and there's no way to block unbind from the pci level neither, so this
> is not really possible. There's nothing blocking someone to unplug the
> card if it's on a hotplug-capable bus and/or someone calling
> 
> 	# echo 0000:00:02.0 > /sys/module/xe/drivers/pci:xe/unbind
> 
> to tell the module to unbind from the device. If that involves multiple

Ack, I think we can put this option to rest. 

[unbind the ALSA card]
> yeah, since it depends on the i915/xe side to power up the display
> engine, I think handling that esssentially the same as a hotplug would
> be ideal
[...]
> I'm not yet very familar with the sound side and checking if something changed
> from when this thread started: for cards that can't work without the
> other component, would it be hard to escalate that event to handle it
> the same as a hotplug? Because from this thread it seems usb/pci hotplug
> is already available.

I don't think much has changed. I think this is (still) a doable option, 
but just requires effort put in (which so far has not happened). I think 
the problem can be roughly divided in two categories:

1) discrete graphics - controller on discrete PCI device

Here the problem is more acute (as may affect register accesses done from 
audio driver), but potentially also easier to fix. There is a single 
driver (snd-hda-intel) to handle this case in ALSA and the sound card 
created only exposes the HDMI/DP PCMs, so if graphics side unbinds, 
disconnecting the ALSA card seems ok as well. The open I have is how do we 
recreate the ALSA card. Audio driver probe is triggered by attach of the 
PCI device, but here the PCI device is not unplugged, just unbound by one 
of the drivers. But doesn't sound like a unique problem to audio, so I'm 
sure there's some example solution to follow.

2) integrated display codecs

The regular laptop case is a bit more iffy as there are more audio drivers 
using the display codec driver stack (each need support), and in most 
cases, the ALSA card is a mix of HDMI/DP but also internal codec and 
speaker PCMs. If we use the card disconnect infra in ALSA (i.e. same infra 
as USB hotplug), this means display unbind will not just disconnect the 
HDMI/DP PCM device, but alsl the interal audio codec and speakers. And 
there's a bigger issue how we reenumerate the full card again.

I think the longterm solution is to move the HDMI/DP PCMs to their own 
ALSA card. We in fact some work going on to this direction in the SOF 
driver, but it's far from complete, and we are not sure whether we can 
change the existing platforms to use this approach (as changing the card 
topologies will be visible to user-space as well and potentially break
stuff).

I did file a bug to track this in SOF 
https://github.com/thesofproject/linux/issues/5276 .

Br, Kai
