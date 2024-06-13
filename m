Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24F9C27C4F
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Jun 2024 14:17:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EC41DF9;
	Thu, 13 Jun 2024 16:17:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EC41DF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718288239;
	bh=uBGfPGLSDyS35xi21zQqLpJGf1TpgfpdYOVUVFNA1uA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gtCUQoYN83QKq99PA62pGjJqLzwbkWkIUFKLkG8BIC2sW3/P0S4/Mbq4/VhQ6Wbd/
	 EGcFzVxbcfv0TVRhc4KSNB4aRWZvr++yH0vvPqxCWm0jPcixdK40wq8y0iYi5r3Lzl
	 PWQUCJH5p3/romnfoXIlDn/ebiwu72mlDGVEH1fs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DF231F802DB; Thu, 13 Jun 2024 16:16:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A75AAF80589;
	Thu, 13 Jun 2024 16:16:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B7D59F80448; Thu, 13 Jun 2024 16:16:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 78B7CF800FA
	for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2024 16:16:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78B7CF800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FOvGqvhN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718288202; x=1749824202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uBGfPGLSDyS35xi21zQqLpJGf1TpgfpdYOVUVFNA1uA=;
  b=FOvGqvhNhLeejguNqsMVtOu4zh25lHdIiVnD1ixZxt3jsyqByWMF1Og7
   DblL75F4Nm0tTrBYm4n4b3nlts7taP/OvRHVw2Xf17bpwI1g4K8ejbIjJ
   dpp3AsqNTRINC1M8sgayPa6P1+uBbECCuas3XvIZHQaP+LgJKQ5QvRqcW
   pIBIatNGz/OLr2Mu8UIy8MihLhxEwpDfrtPVdmqKvYnonl9+Y9hVQLAmG
   gL8VC6CSBooYP4YAsPnWcoOcfwzj/0qlQaUiWbcpvbr8M4oQeM3ZljpvH
   GziWattMN8Gi3AMCdUSxiy3tER93sJMb06rhxNqSdJAvGlBWo8daWSdpt
   w==;
X-CSE-ConnectionGUID: CuFbd4B0Ti2ZpHjAPYclZw==
X-CSE-MsgGUID: bWuAAn/JRM6E4MN6aUrWRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32653734"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000";
   d="scan'208";a="32653734"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 07:16:38 -0700
X-CSE-ConnectionGUID: 7+CzAEukS3mJZljMZ8g8Ow==
X-CSE-MsgGUID: AntsQNkkTfCJ6ZJxEr5JHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000";
   d="scan'208";a="40795601"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.246.108])
 ([10.245.246.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 07:16:35 -0700
Message-ID: <d7d06d90-d714-4fe6-a191-57c641cff01c@linux.intel.com>
Date: Thu, 13 Jun 2024 16:16:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ALSA/PCI: add PantherLake audio support
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20240612064709.51141-1-pierre-louis.bossart@linux.intel.com>
 <878qz9nih2.wl-tiwai@suse.de>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <878qz9nih2.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: UDYTEHUUPDFTUIDRIYXXKISVWUPQCZDT
X-Message-ID-Hash: UDYTEHUUPDFTUIDRIYXXKISVWUPQCZDT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UDYTEHUUPDFTUIDRIYXXKISVWUPQCZDT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 6/13/24 14:19, Takashi Iwai wrote:
> On Wed, 12 Jun 2024 08:47:06 +0200,
> Pierre-Louis Bossart wrote:
>>
>> Add the PCI ID for PantherLake.
>>
>> Since there's a follow-up patchset for ASoC, these 3 patches could be
>> applied to the ASoC tree. Otherwise an immutable branch would be
>> needed.
>>
>> Pierre-Louis Bossart (3):
>>   PCI: pci_ids: add INTEL_HDA_PTL
>>   ALSA: hda: hda-intel: add PantherLake support
>>   ALSA: hda: intel-dsp-config: Add PTL support
> 
> Applied now to for-next branch.
> 
> There were duplicated Reviewed-by tags by Peter as checkpatch
> complained, so I removed the one. 

Thanks Takashi, how do we proceed to get those changes into AsoC?

the first patch is a dependency for the patchset "[PATCH v2 0/5]
ASoC/SOF/PCI/Intel: add PantherLake support"
