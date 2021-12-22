Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A7BC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Dec 2021 17:22:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5658D17CB;
	Wed, 22 Dec 2021 18:21:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5658D17CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640193729;
	bh=5dL73oot1k/+QQ0q/bKmbJFyU8YokyOQ7yIYy2CvGYU=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ve9HL179BQBsXbUygSYLm3Zr9pf9o0YWtZknUPC7xItWgFvcHTu036vF8tm9NbeH0
	 AG9rnNkv8n5P1eA4Rvk+U14s5Ia53yL7dc+aF5fplKEMJUpipOhWsMjuEAPe92Vm+c
	 daqVJFpsLwJuM4AA9ArnoiPUD9ump8OkHSTZKcdM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F136AF80107;
	Wed, 22 Dec 2021 18:21:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D349AF80109; Wed, 22 Dec 2021 18:21:17 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35097F80084
 for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2021 18:21:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35097F80084
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Ctm/DTWy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640193672; x=1671729672;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=5dL73oot1k/+QQ0q/bKmbJFyU8YokyOQ7yIYy2CvGYU=;
 b=Ctm/DTWys5pBNYEW2SEyY9e54FG8fpf/Wth/4xHPqBc2ZxXVIsvmHZop
 MQ3StI+cuVPxwJNjdP1x3c+HkjAY6Ra8fR5YyKd6+zhmqaDZz+ECtNTlB
 t8JdHuwjvhmoaDMwpnkjwrqdvltFqfwE9tDiG2W/NTehDiRvhkRLMwx/l
 h6wBBk1Vz99IdYn4kzXbHGaCEhF9soopWc6aOpZ7/WpOX0A9BehL0shjA
 gIcX+ZemK+EyHiO57yhZ9CItoa7umY6tBpk713p9L6a57b5FnA/RMfF4R
 2FBYlqY2dlR6tIPXYEWdYaHCl+MZShEP6D1Vd1ddigP7G6b5xvlUkQk3e g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="239419449"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; d="scan'208";a="239419449"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2021 09:05:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; d="scan'208";a="468233654"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2021 09:05:43 -0800
Date: Wed, 22 Dec 2021 18:57:43 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] ALSA: hda/hdmi: Disable silent stream on GLK
In-Reply-To: <20211222145350.24342-1-ville.syrjala@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2112221851510.1661468@eliteleevi.tm.intel.com>
References: <20211222145350.24342-1-ville.syrjala@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Harsha Priya <harshapriya.n@intel.com>, intel-gfx@lists.freedesktop.org,
 stable@vger.kernel.org, Emmanuel Jillela <emmanuel.jillela@intel.com>,
 Takashi Iwai <tiwai@suse.de>
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

Hi,

On Wed, 22 Dec 2021, Ville Syrjala wrote:

> The silent stream stuff recurses back into i915 audio
> component .get_power() from the .pin_eld_notify() hook.
> On GLK this will deadlock as i915 may already be holding
> the relevant modeset locks during .pin_eld_notify() and
> the GLK audio vs. CDCLK workaround will try to grab the
> same locks from .get_power().
>
> Until someone comes up with a better fix just disable the
> silent stream support on GLK.

decoupling the call to get_power() is a non-trivial change
(especially as it's done from generic hda_codec.c code),
so I'd say let's go with this patch for GLK:

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Br, Kai
