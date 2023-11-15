Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C54C47074
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Nov 2023 08:19:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F33C984A;
	Wed, 15 Nov 2023 09:18:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F33C984A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700036355;
	bh=DeGz/PZtITqZi+IpmokuVnt5rC6x2ogyzPLY+iXwvF8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DmYRDXhTcN+HWN+Rr2u+1SePe42tfXJiUCh/kjQWU34lIleIYYtXdBoyjL+y0P3a0
	 QkpvsHLO9mzTjWCZVKlj3mjTWcAR8JnXTBJ2NYSUdG57nAIHcrvRKbteV+nIa4wZZS
	 uhK5/CLYZi21uP7MZGF/9OGgoQ9gXJBr2FTWtF5c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31F07F8055C; Wed, 15 Nov 2023 09:17:38 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9671FF8055B;
	Wed, 15 Nov 2023 09:17:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27F32F801D5; Wed, 15 Nov 2023 09:16:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2555DF800ED
	for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2023 09:16:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2555DF800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FF9dlDzX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700036176; x=1731572176;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DeGz/PZtITqZi+IpmokuVnt5rC6x2ogyzPLY+iXwvF8=;
  b=FF9dlDzXZpXLmad6UXJo8ffkV2OUuaeyIKeC92FgAROi1lm0sEfj9ykK
   S0ck0gi1r9JeWeDTYM+ozpi6vzBdL8bh0HXHr1IlGRRy2cpJqE6sNc0w0
   k7iW4YCC5FFb4vZuEo9EeBAXjdx9cxnMJy2Nt+9Ymi4uczKst0hXDzeUb
   xi04l+a+QfbL/v6eG9Sau+mbHxqC8ns2OL5Jv2eCWEfFFRKwfPEG6Yx3o
   M4kOZpLOfNnCTaQbJ0DHAbiz7VzzyO+AczW7JSLLDGAAgVEfWtfVIlv1N
   YePfZY+sROoUhmvFzSMV8qm+0rkPxJO4iCUBa8kjVjs7Sr24XyCIhiIk3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="381228870"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200";
   d="scan'208";a="381228870"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 00:16:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="938406132"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200";
   d="scan'208";a="938406132"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 00:16:07 -0800
Date: Wed, 15 Nov 2023 10:15:53 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Takashi Iwai <tiwai@suse.de>
cc: "Saarinen, Jani" <jani.saarinen@intel.com>,
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
    Jani Nikula <jani.nikula@linux.intel.com>,
    =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
    "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
    "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
    "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
    "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>
Subject: Re: [Intel-xe] [PATCH 11/14] ALSA: hda/intel: Move snd_hdac_i915_init
 to before probe_work.
In-Reply-To: <87jzqkp99j.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2311150901200.14041@eliteleevi.tm.intel.com>
References: <20231002193847.7134-1-maarten.lankhorst@linux.intel.com>
 <20231002193847.7134-11-maarten.lankhorst@linux.intel.com>
 <ZVNUxZzCGcxQzqJX@intel.com> <87bkbwsebl.fsf@intel.com>
 <569f8832-25f1-45be-bb60-50f5a76d8e44@linux.intel.com>
 <DM8PR11MB5655518A6F21A2E4CA2E76D3E0B2A@DM8PR11MB5655.namprd11.prod.outlook.com>
 <87jzqkp99j.wl-tiwai@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID-Hash: 4RAGCULH5QXF5SOFJH6VNHEVEUKUPLWI
X-Message-ID-Hash: 4RAGCULH5QXF5SOFJH6VNHEVEUKUPLWI
X-MailFrom: kai.vehmanen@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4RAGCULH5QXF5SOFJH6VNHEVEUKUPLWI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

On Tue, 14 Nov 2023, Takashi Iwai wrote:

> On Tue, 14 Nov 2023 14:31:25 +0100, Saarinen, Jani wrote:
> > Was this series tested on CI  ever as Ville saying no? How this got merged? 
> 
> Hm, I somehow believed that patches have been tested by intel people,
> as they came from intel.  (Also thought that drm-tip or whatever tree
> also drags the recent changes from sound.git tree for relevant part.)

ack, this is squarely on us Intel folks to ensure the test runs get done. 
This series did go through a number of Intel test setups, but 
unfortunately, as it now seems, not through the i915 CI setup that covers 
the affected configuration (audio DSP not used, HDA controller on the PCH, 
tests on the display audio codec).

Reproduced the problem now one one local setup and can confirm the fix 
Takashi and Maarten posted, does work.
 
Br, Kai
