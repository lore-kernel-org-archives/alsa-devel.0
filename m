Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7E0EF8FF4
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:26:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A36FE6023E;
	Wed,  4 Mar 2026 16:26:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A36FE6023E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772638009;
	bh=2VD19bgJI0x1UihI0HQnWOMNn1lZUKuSVwf2lYt80Jc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MUt5OiOJWhmA9QyQI8c/HeZeZh6qZtCB1p1IdbNMtRG3sZIyKKnZRRd9KOGO3PTCF
	 4krWDj68GxEKtbqnYqHITzqIq/Os75QwXxW50L9371EWZmksMb/ATn1N5FgHA6jJHe
	 MowRUrvAo06wyA1KLRMHy1NnrjWG/FVv2PeudXlA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22D66F8060E; Wed,  4 Mar 2026 16:25:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B3C94F8060E;
	Wed,  4 Mar 2026 16:25:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 43F1CF80254; Thu,  8 Jan 2026 11:20:15 +0100 (CET)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com
 [95.215.58.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7C49FF80075
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2026 11:20:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C49FF80075
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=SOuU5chI
Message-ID: <d748ba7c-165d-420a-bd33-a860acf2f01d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767867610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWP8qNiTUYkgDHDv2lHzz407A0e6GIIDf4QiSGW83mk=;
	b=SOuU5chIxERZv0IG+kefqFLuMnTPZFyNcZQ26ld9sOig12FzmlhV0YbBA2t8ndCNMFl8+C
	WxBZnUd7Wx70MFDN7dw1UenXFJfaAEEiugAyyn+95yGfOGDUxkacIEoho/P8vfjVZIlzcV
	5cTTL2pKK/49x70BcBiI8XFgWpG54qw=
Date: Thu, 8 Jan 2026 11:10:13 +0100
MIME-Version: 1.0
Subject: Re: [BUG] Samsung Galaxy Book 4 Ultra - MAX98390 speakers not
 supported on MTL platform
To: =?UTF-8?Q?Jos=C3=A9_Augusto_de_Almeida_Neto?= <jaalneto@hotmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
References: 
 <PH3PPF0A8D5CDB5873FA91A7F768F4E2F10D984A@PH3PPF0A8D5CDB5.namprd10.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: 
 <PH3PPF0A8D5CDB5873FA91A7F768F4E2F10D984A@PH3PPF0A8D5CDB5.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-MailFrom: pierre-louis.bossart@linux.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 7IVNP5VUYWTSOGKRBYONXBOB6DYZDKWO
X-Message-ID-Hash: 7IVNP5VUYWTSOGKRBYONXBOB6DYZDKWO
X-Mailman-Approved-At: Wed, 04 Mar 2026 15:25:49 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7IVNP5VUYWTSOGKRBYONXBOB6DYZDKWO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 1/7/26 23:26, José Augusto de Almeida Neto wrote:
> Hi ALSA developers,
> 
> I'm reporting a hardware support issue with the Samsung Galaxy Book 4 Ultra
> (NP960XGL-XG1BR) running on Intel Meteor Lake (MTL) platform.
> 
> SUMMARY:
> The laptop has MAX98390 smart speaker amplifiers that are not supported in
> the current Linux kernel. Headphones work (ALC298 HDA codec) but speakers
> are completely non-functional.
> 
> HARDWARE:
> - System: Samsung Galaxy Book 4 Ultra (NP960XGL-XG1BR)
> - CPU: Intel Meteor Lake-P
> - Audio Controller: Intel MTL HD Audio (8086:7728)
> - HDA Codec: Realtek ALC298 (working for headphones)
> - Speaker Amps: 4x Maxim MAX98390 on I2C bus 2 (addresses 0x38, 0x39, 0x3C, 0x3D)
> - Kernel: 6.17.9 (also tested on 6.8.0 mainline)
> 
> ROOT CAUSE:
> 1. No machine driver match in soc-acpi-intel-mtl-match.c for Samsung + MAX98390
> 2. No SOF topology file for MTL + HDA + MAX98390 combination
> 3. NHLT only shows SSP2 (Bluetooth), no SSP configured for speakers
> 4. SOF falls back to generic skl_hda_dsp_generic (2-channel HDA only)
> 
> VERIFICATION:
> - MAX98390 chips respond on I2C (revision 0x42 confirmed on all 4 chips)
> - ACPI device MAX98390:00 present (status 15 - enabled)
> - ALC298 speaker DAC receives audio but no output from physical speakers
> - No I2S/TDM connection to MAX98390 amplifiers
> 
> I have collected detailed technical information including:
> - DSDT and NHLT ACPI tables
> - Full HDA codec dump
> - I2C bus scans and MAX98390 register reads
> - dmesg logs showing current SOF behavior
> 
> Full detailed report: BUG_REPORT.md attached
> 
> QUESTION:
> Is there ongoing work to support MAX98390 on Meteor Lake platforms?

This has nothing to do with SOF, the main issue is that the amplifier needs to be configured by HDAudio verbs which are translated by the HDaudio codec in I2C commands. The problem is to reverse-engineer what those verbs might be, usually with a Windows setup. There was a Wiki for this sort of things, see https://thesofproject.github.io/latest/getting_started/intel_debug/suggestions.html#reverse-engineer-the-windows-audio-driver

