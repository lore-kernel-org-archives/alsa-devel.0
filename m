Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F42C4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Nov 2023 13:41:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3AA474C;
	Tue, 14 Nov 2023 14:40:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3AA474C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699969263;
	bh=IxbnVp92CtiiW6TO1K5s/oZfAKHXB6pZjhSjijIYkm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Zru6Vk4CLk+dlksMvR3s1HLkKw4VJRdlmR707jF6pU9rnBf0UdbzUD94G7hNebGiK
	 FLdxIEQgRa7CgULZZtPnuM9BXylwBMKRz+2hgosDkGQ1xSOtw2ZlT+8mX1Bi4uL74D
	 GQhNBixAj5P9bjfMqBA9pfPuqluT2+7zubSvV9iM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B59DF80152; Tue, 14 Nov 2023 14:40:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D868CF801D5;
	Tue, 14 Nov 2023 14:40:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A8A97F801D5; Tue, 14 Nov 2023 14:40:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 21251F80093
	for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2023 14:40:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21251F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=M+oXnx9l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699969207; x=1731505207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IxbnVp92CtiiW6TO1K5s/oZfAKHXB6pZjhSjijIYkm4=;
  b=M+oXnx9lTewXRPuW6udtfr5vy7lit1eD2fN+oBsj5QZWJtt82qbnuj9f
   RLOcKymJYJA+iNB3ThTyEy6SuTMI0izz37N/i5OnOVzOPIPUoGV6ZgC4Y
   5frnPGLfZG4qUndCqomwf3aVpcmSgrgJqJV/58+mDppQtB77NxTMXJScH
   ZJdHS9n7mqP+wORMKBF+2wkyaakGVS99UG6kh0h4amUKdfisWDNz4bApr
   UhqrtKkibviZcWmVoTk329rEIZYznQB1m4Ir6Z2BKbMTWRsaUI+8yIVWb
   EjXWRUedRZ/ORWeOgJj6X46B5rgBVUJhieimkb5hnPziRpQr2bw/YrncP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="370853404"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200";
   d="scan'208";a="370853404"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 05:40:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="758176952"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200";
   d="scan'208";a="758176952"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 14 Nov 2023 05:39:58 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Tue, 14 Nov 2023 15:39:57 +0200
Date: Tue, 14 Nov 2023 15:39:57 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: maarten.lankhorst@linux.intel.com, Takashi Iwai <tiwai@suse.de>,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	alsa-devel@alsa-project.org,
	"Saarinen, Jani" <jani.saarinen@intel.com>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>
Subject: Re: [Intel-xe] [PATCH 11/14] ALSA: hda/intel: Move
 snd_hdac_i915_init to before probe_work.
Message-ID: <ZVN4rQjLxROOjTE-@intel.com>
References: <20231002193847.7134-1-maarten.lankhorst@linux.intel.com>
 <20231002193847.7134-11-maarten.lankhorst@linux.intel.com>
 <ZVNUxZzCGcxQzqJX@intel.com>
 <87bkbwsebl.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bkbwsebl.fsf@intel.com>
X-Patchwork-Hint: comment
Message-ID-Hash: 6ZFWCEDZME7JOAIXKAQS7BLP4JKBJ43R
X-Message-ID-Hash: 6ZFWCEDZME7JOAIXKAQS7BLP4JKBJ43R
X-MailFrom: ville.syrjala@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6ZFWCEDZME7JOAIXKAQS7BLP4JKBJ43R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Nov 14, 2023 at 02:35:10PM +0200, Jani Nikula wrote:
> On Tue, 14 Nov 2023, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> > On Mon, Oct 02, 2023 at 09:38:44PM +0200, maarten.lankhorst@linux.intel.com wrote:
> >> From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >> 
> >> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
> >> the snd_hdac_i915_init into a workqueue.
> >> 
> >> Use the -EPROBE_DEFER mechanism instead, which must be returned in the
> >> probe function.
> >
> > This completely broke i915 audio!
> >
> > I also can't see any trace of this stuff ever being posted to 
> > intel-gfx so it never went through the CI.
> >
> > Please fix or revert ASAP.
> 
> Cc: Jani, Suresh
> 
> Ville, please file a bug at gitlab so we can track this, thanks.

https://gitlab.freedesktop.org/drm/intel/-/issues/9671

-- 
Ville Syrjälä
Intel
