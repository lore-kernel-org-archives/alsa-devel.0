Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3CBC433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Oct 2022 20:07:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9894AB12C;
	Wed, 19 Oct 2022 22:06:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9894AB12C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666210060;
	bh=y1+VYj3WcpmFqxc8mjctJlZ58JDh9xyPU+J6w3H/nxU=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CWeHIN023PozwMhXBFhSSulYMiWBX5xkZ0a8RBUMwxC2ZVgK+9Nb/qECHuvwx0SSF
	 AuioF0xG72onzbA5hDGZ7WMLr2hO5S4EKQnDSdpTYpDUBXgjkpp2/QjQKr4z6JJR3U
	 hL1luSOFx0kOD9ovHSyraZSfDwi+acnvBiZcWme4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4083DF80166;
	Wed, 19 Oct 2022 22:06:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52E15F804CC; Wed, 19 Oct 2022 22:06:49 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2A3E4F80166
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2022 22:06:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A3E4F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="TobfTDnz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666210007; x=1697746007;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=y1+VYj3WcpmFqxc8mjctJlZ58JDh9xyPU+J6w3H/nxU=;
 b=TobfTDnzQZLy153rLx+ngD5iPJlrhs9kJy4K+LPfVIp6cn0jdk3YYd96
 8MzavYUHCduay/vVpySA8/zL8rrr6/bI7YcsVw63EGOUTHH7xEBcff1aG
 7m/kXnqVSpI5Te9VkihfwLi6cvfJMPFrWAveaCgyL+H0SFWl6Ys8UXJak
 T7Zq13XLDZ69/ugmGz5C8/wxzofe4dm61g0kf80ufPqNJhY6bcEWyuZRt
 Hw5/unPGTQaWogTeO/cGcdpng/NysQtfXxRQpGsvfpkFbh4ligUyX90fl
 wMpaFdEI7vkI7Hn3UzZdM/hJuzFkzsXrs8uh+9E8axkRqNHSSt39GMITr A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="306508701"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; d="scan'208";a="306508701"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2022 13:06:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607261706"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; d="scan'208";a="607261706"
Received: from afsinurr-mobl.amr.corp.intel.com (HELO [10.212.16.185])
 ([10.212.16.185])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2022 13:06:30 -0700
Message-ID: <eb7971c2-f5fe-afb5-9333-4b941b958355@linux.intel.com>
Date: Wed, 19 Oct 2022 15:06:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v2] ASoC: core: clarify the driver name initialization
Content-Language: en-US
To: Jaroslav Kysela <perex@perex.cz>,
 ALSA development <alsa-devel@alsa-project.org>
References: <20220929143754.345144-1-perex@perex.cz>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220929143754.345144-1-perex@perex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>
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

Hi Jaroslav,

On 9/29/22 09:37, Jaroslav Kysela wrote:
> The driver field in the struct snd_ctl_card_info is a valid
> user space identifier. Actually, many ASoC drivers do not care
> and let to initialize this field using a standard wrapping method.
> Unfortunately, in this way, this field becomes unusable and
> unreadable for the drivers with longer card names. Also,
> there is a possibility to have clashes (driver field has
> only limit of 15 characters).
> 
> This change will print an error when the wrapping is used.
> The developers of the affected drivers should fix the problem.

How should we fix this problem?

I see all kinds of errors thrown in our first CI results based on 6.1-rc1:

[   12.684893] kernel: cml_rt1011_rt5682 cml_rt1011_rt5682: ASoC: driver
name too long 'sof-cml_rt1011_rt5682' -> 'sof-cml_rt1011_'

[   12.219660] kernel: bxt_da7219_max98357a glk_da7219_mx98357a: ASoC:
driver name too long 'sof-glkda7219max' -> 'sof-glkda7219ma'

I have no idea what is expected here in terms of naming. It's far from
obvious to respect the 15-character limit AND have something
readable/sensible given the proliferation of hardware skews.

Any suggestions?

Thanks,
-Pierre

