Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857E0C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Feb 2022 02:42:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF0A41AF5;
	Fri, 25 Feb 2022 03:41:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF0A41AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645756928;
	bh=1T8qQIgXjOHky5IINNc+a264inzVIf/i/kkX8NCkHGo=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G0g1Y9tlSXeKriwdsML94FT+IbRELgq41A2Vn1fOMD/K2MkMEEl+gaggTUFY7pA+4
	 BZbRWh3ONimqvxQzPHnbgZEvfzn3Qh5u8KqJeV2DNgHYG76gxsxqmUGEyU5RQRwjJC
	 2Kuh4Iu9Z0b53/hkBYiRMH/3UpUqoBfmN4nzZUhw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B22BF80525;
	Fri, 25 Feb 2022 03:39:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B95CF80310; Fri, 25 Feb 2022 03:39:28 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B406F80169
 for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2022 03:39:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B406F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="m4DT+LkZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645756766; x=1677292766;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1T8qQIgXjOHky5IINNc+a264inzVIf/i/kkX8NCkHGo=;
 b=m4DT+LkZjFTpfOXUxA7CMPOh52YOrtDa6hvfdgt+YXKbUBfyS2bMg3tn
 c473/CX8RA5xef9LBTL9U+V8j1p/ASEMpDEY9TdNthQRiVH9jNhYOP2uX
 5rynZqYOEKjj5TQvlzzZvZaMzprKyklCKCH0CjZZBWAzE6wZR0BW/Ammh
 VI9Fg5ao+gUHE01rvmvkkcWRFI3lc6r0fihJvMotqEIYmOJbdJApYJkms
 RDlIyb+BzAplQafNuMQ4n/7r5jYczuP6XuVfEyV7rCxspb5zwhOD4bd8E
 L/6el7eObqcr8yYVZ9Om1OogvsIAhT1ldxQGHMl9NabuWAkDbZGN/2KLD w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="277036165"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="277036165"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 18:39:24 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="491832672"
Received: from jsegev-mobl1.ger.corp.intel.com (HELO [10.212.99.193])
 ([10.212.99.193])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 18:39:23 -0800
Message-ID: <dc117645-7a4b-09be-bfe8-befcc4a9bc17@linux.intel.com>
Date: Thu, 24 Feb 2022 19:53:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 11/17] ASoC: Intel: avs: Firmware resources management
 utilities
Content-Language: en-US
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20220207122108.3780926-1-cezary.rojewski@intel.com>
 <20220207122108.3780926-12-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220207122108.3780926-12-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: upstream@semihalf.com, harshapriya.n@intel.com, rad@semihalf.com,
 tiwai@suse.com, hdegoede@redhat.com, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com, cujomalainey@chromium.org,
 lma@semihalf.com
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



On 2/7/22 06:21, Cezary Rojewski wrote:
> With basefw runtime parameter handlers added, implement utility
> functions to ease pipeline and module allocation. IDA is enlisted to
> help with that. Also, as firmware is modular and multiple binaries can
> be loaded throughout the lifetime of a driver, custom firmware caching
> mechanism is added.

It's not clear what the 'lifetime' refers to. Did you mean that the
binaries can be loaded/unloaded on-demand depending on use cases without
having to reboot the DSP, or that at each reboot a different set of
binaries can be used.



