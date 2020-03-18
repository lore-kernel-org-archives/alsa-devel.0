Return-Path: <SRS0=W6oB=5D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012DEC10DCE
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:06:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D5E20767
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Wfmz76WZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D5E20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1248174C;
	Wed, 18 Mar 2020 11:05:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1248174C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584525990;
	bh=1PhYEWiPdz6rd/xZVfABh9wmY5MkzRDbBkI+dmMa668=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wfmz76WZDYsp5TGBFvFqcTGdpl6wJ96yojuCLST55wy9VOizt3PFZMNy0dmwYh997
	 p2n0cwTY0DlWijMigSUHQ6oaLWE7C/s5yffVbTNf+drwMSII46FltjCAN0wxPdKSfy
	 wfQBwy62XVKTn7A19LH2JpMPyttcIP1ZD7YJk2I4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33031F80132;
	Wed, 18 Mar 2020 11:05:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 187AFF80139; Wed, 18 Mar 2020 11:05:36 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9ED99F800B7
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 11:05:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9ED99F800B7
IronPort-SDR: nsd4b1SwV3L1t53svAy1mqIh3V+DMaM08hzkymm/FQfWkT6NWiuoSww8sImS7Yg6dHZUfh/n9o
 QGKTTgi4MBuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2020 03:05:25 -0700
IronPort-SDR: PVmGYa6s/4SlBw7rAL0UALyV4G0Zc+YoYHVpfMvuAd7hV4GpJ7RsaIQBgu/+YxAA236+zZsEG4
 K2JPwMnApV8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,566,1574150400"; d="scan'208";a="248122449"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.155.222])
 ([10.249.155.222])
 by orsmga006.jf.intel.com with ESMTP; 18 Mar 2020 03:05:22 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To: Dominik Brodowski <linux@dominikbrodowski.net>
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <66c719b3-a66e-6a9f-fab8-721ba48d7ad8@intel.com>
 <20200318095745.GA133849@light.dominikbrodowski.net>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <fafed002-5f7f-dd2b-0787-265da7ec7c7a@intel.com>
Date: Wed, 18 Mar 2020 11:05:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318095745.GA133849@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, yang.jie@linux.intel.com, tiwai@suse.com,
 liam.r.girdwood@linux.intel.com, broonie@kernel.org
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

On 2020-03-18 10:57, Dominik Brodowski wrote:
>>>
>>> Unfortunately, I cannot bisect this issue easily -- i915 was broken for
>>> quite some time on this system[*], prohibiting boot...
>>
>> Hmm, sounds like that issue is quite old. DSP for Haswell and Broadwell is
>> available for I2S devices only, so this relates directly to legacy HDA
>> driver. Compared to Skylake+, HDAudio controller for older platforms is
>> found within GPU. My advice is to notify the DRM guys about this issue.
>>
>> Takashi, are you aware of problems with HDMI on HSW/ BDW or should I just
>> loop Jani and other DRM peps here?
> 
> Well, it works on v5.5, so this issue is not really "quite old" (the "no
> context buffer need to restore!" message seen there seems harmless).
> 
> Thanks again, and best wishes,
> 	Dominik
> 

Was commenting the "i915 was broken for quite some time on this 
system[*], prohibiting boot...". Unless I misunderstood you, this ain't 
a DSP driver issue but HDAudio/iDisp one. Essentially, these are two 
issues you mentioned here.

Czarek
