Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83473C04FFE
	for <alsa-devel@archiver.kernel.org>; Wed,  8 May 2024 13:18:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFAC1DEE;
	Wed,  8 May 2024 15:18:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFAC1DEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1715174297;
	bh=l99SSYYgUarZwFUL8X6JnYSQ7YCqlp1K/sehN4H8WYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dihlvZdlrvSF9e3YSFKVNGrYQvmN0JubsrPbDTodJy5JP7d5+UB5YZhj68v+dBT45
	 nKpubaOQXDsZp/B5MG3tAoSVDqAimt3cFuLbg+RuqIBn92IXoudkgV4EPRykzEosjt
	 nSbM4oq9S7VVHXlSAMd24Y6/AtRkeQrFdrt/Im/k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F89DF80687; Wed,  8 May 2024 15:16:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EACF6F80675;
	Wed,  8 May 2024 15:16:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5590FF805D2; Wed,  8 May 2024 15:16:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E16B7F805AE
	for <alsa-devel@alsa-project.org>; Wed,  8 May 2024 15:16:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E16B7F805AE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cP05qGu/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715174180; x=1746710180;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l99SSYYgUarZwFUL8X6JnYSQ7YCqlp1K/sehN4H8WYA=;
  b=cP05qGu/HJIbZ265CL5ydlLfuz0H1/yHapQzHOAUGnBWq3UlxKJQJ8QI
   RhypTj36mbsH5LurIR0VA9cNkIiL6cbssXgt5mgXmv2c8fGzLruiOKpKA
   72rYCZ+qxPJcG+pwP4z2zU5K6u/BT5iWmVKqiAlQ41DsG8FoeUekiJTLm
   Eg2SGyI1Ny6mBDjWmbEoq5BzkGUpfXciX1DMv0Ga912kogiy4r+Z78HeA
   S862Tdp2JMSfk8L+8wZX4ds103lyhGsWCIq3VrmfG5nnpXzMmKshlvU2z
   pmV6DqhMcUUt8mCrF3Ibq9lpbjiS6VAIiqNiSH3W6bcm5hp2lSC5ATM6M
   g==;
X-CSE-ConnectionGUID: jh4t6TDNQ5uwQWbr1j7HxQ==
X-CSE-MsgGUID: dNGW76iOThCDPi5IAi762w==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="36413275"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000";
   d="scan'208";a="36413275"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 06:16:18 -0700
X-CSE-ConnectionGUID: LkpahC3rQNmkL/KTma1Kew==
X-CSE-MsgGUID: lmGKK0rbQMGnIMdH9b7Rdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000";
   d="scan'208";a="33356806"
Received: from sskolar-mobl.amr.corp.intel.com (HELO [10.212.67.115])
 ([10.212.67.115])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 06:16:17 -0700
Message-ID: <54b79b7b-49e6-418e-9a6b-11bcbada8398@linux.intel.com>
Date: Tue, 7 May 2024 16:26:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 27/39] ASoC: Introduce SND kcontrols to select sound
 card and PCM device
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
 corbet@lwn.net, lgirdwood@gmail.com, andersson@kernel.org,
 krzk+dt@kernel.org, gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
 broonie@kernel.org, bgoswami@quicinc.com, tiwai@suse.com,
 bagasdotme@gmail.com, robh@kernel.org, konrad.dybcio@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240507195116.9464-1-quic_wcheng@quicinc.com>
 <20240507195116.9464-28-quic_wcheng@quicinc.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240507195116.9464-28-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: JLY6YZ4OVABJQVZ5PPD5KQGOOSHWGAUB
X-Message-ID-Hash: JLY6YZ4OVABJQVZ5PPD5KQGOOSHWGAUB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JLY6YZ4OVABJQVZ5PPD5KQGOOSHWGAUB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 5/7/24 14:51, Wesley Cheng wrote:
> Add SND kcontrol to SOC USB, which will allow for userpsace to determine
> which USB card number and PCM device to offload.  This allows for userspace
> to potentially tag an alternate path for a specific USB SND card and PCM
> device.  Previously, control was absent, and the offload path would be
> enabled on the last USB SND device which was connected.  This logic will
> continue to be applicable if no mixer input is received for specific device
> selection.
> 
> An example to configure the offload device using tinymix:
> tinymix -D 0 set 'USB Offload Playback Route Select' 1 0
> 
> The above command will configure the offload path to utilize card#1 and PCM
> stream#0.

I don't know how this is usable in practice. Using card indices is
really hard to do, it depends on the order in which devices are
plugged-in...
