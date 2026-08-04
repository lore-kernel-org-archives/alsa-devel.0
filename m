Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7C9C55184
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Aug 2026 06:47:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99A83601F3;
	Tue,  4 Aug 2026 08:47:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99A83601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785826071;
	bh=ibQFH33HuZxup+LsPpPiJaBBwerq3csbTkIzsNdUSpc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZEhHAgOz89R2xS1d2IMcou3RnfTEAJ7oPfu2XgZIwRcVN5KnLPkQO/i7gtj1sRsZv
	 B54bJPCZtFMZZOXf9unc2tx6eV+/nEOk/h00YNdAAb1GadhQvGYBnOcja6O3SUWBOK
	 itE3KnyHLBN+6OCzjInBptMSjHAEoSZcyGyCRF4I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F5D2F802BE; Tue,  4 Aug 2026 08:47:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CDD65F805F0;
	Tue,  4 Aug 2026 08:47:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4390F805A8; Tue,  4 Aug 2026 08:47:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785826030;
	b=Ud2Fu10AckBbMHB6gEJ0fItcooThetw+BL0A9UVHP64riqFVRbfGAcvW5IitEN0XOnky
	 JVriXRTI1VG/apfrEDsSZMrgIvCUvVInHI/SocKEFK6FRseKoL6AxV0Ul2tB5ooCA1ZEb
	 49c0yxdaCsRPo3NYRkfdu0i1nRL7GqInFnZ9cRQshP9c5h0LbS92Lw04gMZHnz51gCrwO
	 u2Tx1zWlB/M8vICAqNGQrSD0V56F8DbFaNwX2ChY1LeSNywWNq4djykeVJJO2vxYTOGwL
	 rH4GFIa/txuF5B1TTjlNYHEn5cD6Ja2zLnmrnXq2kYuzGlHcGvzyssjCRXqjcgsO65w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785826030;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=ibQFH33HuZxup+LsPpPiJaBBwerq3csbTkIzsNdUSpc=;
	b=ng/BDrm5Ljcz5YQd24kdu7Bupe7lCtNRDZJARsHj7oRDFIWrgm9d0fJmDPLpWZzapw4r
	 Y4xA1gG7li625iruNKxfVEiC89CI3GjTGf5tFdwxGEuPM+mJgErfLKKcBFjQtE+4brcw2
	 Yvhv04qOeTkRBqqgPHFMK0O8OpvERSTJLyGLswuwGHB6xeX+yPSueb+ZqTNXWYWQSenYr
	 H7ow7tDf59BSg0ezfR2y8RCQldrkjPIQAnb0lU41TtYTlZGAXMVwT05WHyNzPobP5wM/c
	 pmkqwOevqVNltogvUXdHE8lsadduF3ZZSGII42kFiEg5T8PD6oGpHo6czzop+afnimg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="FQY/n3aV";
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CD283F802BE
	for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2026 08:47:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD283F802BE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FQY/n3aV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785826030; x=1817362030;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ibQFH33HuZxup+LsPpPiJaBBwerq3csbTkIzsNdUSpc=;
  b=FQY/n3aVJJ5bF1yZQlkUs6+Y5LeDGFWwm09Nwy9bCVgvKnmV+JRs1bhS
   Ejt4N4cdkoc2fnUspQtRUtVPlZ7+eGnVzYG3G6KB47+O/SxjvlzEEPG2P
   tEvOSSGI1h4zYLjxNNxUoaiJRHu//51EpeP5qFUgMNBHg9rnzpLhfmJuW
   lY19gzgnttg/HK4GL8BYGtrVr/5RRkdVRWC2kjVGJtfkZMMVSWKGLfbjX
   H8aLOSGLeGc5+rXl0t6WBlH5Ej0Lw6vk+1P9KXxDA3YbzRAZCeJ4K1Uzl
   i/1FMku1McvBJCg8G4iWy0XbhPcPvamDp2vaynlbPeyvpkCfrL8h86TZ4
   A==;
X-CSE-ConnectionGUID: xZQ/DBkbS3ebDl4cYCy6xA==
X-CSE-MsgGUID: ZiFRGMUAT1ORSqSeCoOsGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103772861"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000";
   d="scan'208";a="103772861"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 23:47:04 -0700
X-CSE-ConnectionGUID: m1pKRamiQVaiJyP5UqyhBQ==
X-CSE-MsgGUID: kGnIZA9pR0CTZzNkKzjo7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000";
   d="scan'208";a="286076238"
Received: from unknown (HELO [10.227.10.59]) ([10.227.10.59])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 23:47:01 -0700
Message-ID: <aae83f3e-c2c8-4c5e-abba-ebaba6a30a39@linux.intel.com>
Date: Tue, 4 Aug 2026 14:46:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ASoC: Intel PTL missing SoundWire machine match for RT712 +
 4x TAS2783 speakers
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Michael <michael.aug@proton.me>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "cezary.rojewski@intel.com" <cezary.rojewski@intel.com>,
 "peter.ujfalusi@linux.intel.com" <peter.ujfalusi@linux.intel.com>,
 "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "Ding, Shenghao" <shenghao-ding@ti.com>, "Liao, Bard" <bard.liao@intel.com>
References: 
 <0yjEfELdq8KgSJpwXwJvW10Htk7nW2uES5-hrdsx3iQUTRo3m_gxNgy9pTHxQinv0XiP2d8GWccuIbm3LuZthqwX7FQc_LAg5rncuoCx-70=@proton.me>
 <b0bba73d-0ce4-4472-affe-e5dd6f4bbdc2@linux.dev>
Content-Language: en-US
From: "Liao, Bard" <yung-chuan.liao@linux.intel.com>
In-Reply-To: <b0bba73d-0ce4-4472-affe-e5dd6f4bbdc2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: S4U3AP2LVLKESX4RTZTJHQIIDHXCYZE5
X-Message-ID-Hash: S4U3AP2LVLKESX4RTZTJHQIIDHXCYZE5
X-MailFrom: yung-chuan.liao@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S4U3AP2LVLKESX4RTZTJHQIIDHXCYZE5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 8/3/2026 6:35 PM, Pierre-Louis Bossart wrote:
> 
>> The expected configuration appears to be:
>>
>> |link 2:   4 x TAS2783 (mfg_id 0x0102, part_id 0x0000) link 3:   RT712
>> SDCA (mfg_id 0x025d, part_id 0x0712) |
> 
> 
> There's a similar configuration with another bug report, see
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=221782
> 
> the symptoms are different but clearly this configuration isn't well
> handled just yet.

There is a similar issues reported in
https://github.com/thesofproject/linux/issues/5816

> 
>> Could you confirm whether this configuration is expected to be
>> supported, and if so whether a PTL machine-table entry/topology is still
>> missing?
> 
> It's my understanding that the function topologies are expected now,
> machine table entries are no longer required.
> 
> In the dmesg log, what's suspicious to me is those lines:
> 
> [  225.115571] acpi device:1d: function type only supported as DisCo
> constant
> [  225.115930] acpi device:1f: function type only supported as DisCo
> constant
> [  225.116271] acpi device:21: function type only supported as DisCo
> constant
> [  225.116612] acpi device:23: function type only supported as DisCo
> constant
> [  225.117313] acpi device:25: SDCA function UAJ (type 6) at 0x1
> [  225.117317] acpi device:26: SDCA function SmartMic (type 3) at 0x2
> [  225.117320] acpi device:27: SDCA function HID (type 10) at 0x3
> 
> not sure why the 4 amps report information that's not well parsed, if
> the amps were recognized as such you'd see a clearer log. For now only
> the rt712 is handled correctly.

I believe that you will see blow log if options
snd_sof_intel_hda_generic dyndbg=+pmf is enabled.
snd_sof_intel_hda_generic:is_endpoint_present: soundwire
sdw:0:1:0102:0000:01:a: Endpoint DAI type 1 not found

Which means the driver can't find the amp's SDCA function property.
It needs a BIOS update and AFAIK HP and TI is working on it.

