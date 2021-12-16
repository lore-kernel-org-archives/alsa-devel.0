Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DD5C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Dec 2021 18:05:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 69AD02801;
	Thu, 16 Dec 2021 19:04:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 69AD02801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639677915;
	bh=dL22H0g7NySCli5k58c/KdjxGCpWykDZ/ovmeuBr/8E=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VjEbZWHm8W20Sk9RgvI+tpW+H8TNPOCUE3HdjgrODcdPhbfMyCET+WZ3uBQR52Vzm
	 S4roR87g9qX5Ur/ZBxGeTWFLb/Lpwpvb+gTDVXnepicj/3nh9UIpMl4s9A+yX2VsFj
	 ku9tmnxvLDVgK2hCzubH5oH7j2L+HIBGi3FqMoaQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10B24F80116;
	Thu, 16 Dec 2021 19:04:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 429E0F8014C; Thu, 16 Dec 2021 19:04:23 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 583FFF800DE
 for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2021 19:04:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 583FFF800DE
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="263727181"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; d="scan'208";a="263727181"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2021 10:04:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; d="scan'208";a="756192424"
Received: from kloriaal-mobl2.amr.corp.intel.com (HELO [10.213.169.180])
 ([10.213.169.180])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2021 10:04:10 -0800
Subject: Re: [PATCH 4/5] ASoC: Intel: catpt: Drop SND_SOC_ACPI_INTEL_MATCH
 dependency
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20211216115743.2130622-1-cezary.rojewski@intel.com>
 <20211216115743.2130622-5-cezary.rojewski@intel.com>
 <4a8afa77-217a-9d1a-7704-909ee895c4c7@linux.intel.com>
 <2377ff39-2ee2-c1fe-844b-aa9749f4e026@intel.com>
 <261b8815-6c8e-7e0a-4b34-e7948efb6884@linux.intel.com>
 <9da26018-aad9-76a6-ad93-8941a68c645f@intel.com>
 <124db869-d829-006a-e1dc-0e41d21d5361@linux.intel.com>
 <b4eebba5-a510-a5e5-7939-e8211ee2bc8c@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <687da06e-67e0-c648-7d92-88fc2ed7078f@linux.intel.com>
Date: Thu, 16 Dec 2021 12:04:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b4eebba5-a510-a5e5-7939-e8211ee2bc8c@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, tiwai@suse.com
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



>>>> I don't really see the point about the number of fields, this is a
>>>> generic descriptor used for I2S/SoundWire devices so mechanically there
>>>> are things are are not used in all platforms.
>>>>
>>>> Another example is the quirks field, it's only meant to be used when
>>>> there's actually a quirk.
>>>>
>>>> Note that I am planning to remove the sof_fw_filename field since it's
>>>> redundant with what is part of the PCI descriptor, but the topology
>>>> will
>>>> remain there: it has to match with the machine driver.
>>>
>>> That's why no new struct is declared. Simply the tables are moved
>>> locally, and there is nothing wrong with that. Cohesiveness and
>>> readability outweighs the duplication of ACPI _HID.
>>
>> If I follow your logic, I could move all the tables for glk, cnl, cfl,
>> cml, icl, jsl, tgl, ehl, adl into the SOF driver. That really doesn't
>> seem sensible.
> 
> Hmm.. doesn't it really? Are the glk/cnl/cfl/cml/icl/jsl/tgl/ehl/adl
> tables "common" for the Intel audio drivers? There are not used by
> anything except for SOF. It seems reasonable to have them present
> locally too. SOF solution becomes more cohesively organized in such
> case, just like catpt is after this patch.

We could also move the boards/ while we're at it, on the grounds they
are not all used by all drivers.

My take is that unless a new feature is added that warrants moving the
tables around, let's keep the existing code as is.
