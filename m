Return-Path: <SRS0=DIBW=MN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6CAC12002
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jul 2021 13:12:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C2E6120A
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jul 2021 13:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C2E6120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB90D16DB;
	Wed, 21 Jul 2021 15:11:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB90D16DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626873140;
	bh=6+uWwxsXwVzuZXZyzFfMVwQmXako1DHdj4hP+TOvGmg=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fhfo7fuMe5z1ADaLyjQYQzzOAfrrNTT9sS3bSBNiQsOANgavO2EMR/rz4hhxoRdKS
	 o8ZLZBLyUjZFw5qC+yxalwTSZSWLiLv3VZkflwY/YQjzAxbSDSQaLPMd69ZVyCPaL4
	 5eeG6JKxY6x+XACEKqGj6xdiSI9OZXev0NJdbGAE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5652AF804AB;
	Wed, 21 Jul 2021 15:11:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3A0CF804AC; Wed, 21 Jul 2021 15:11:28 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52E09F800FD
 for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2021 15:11:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52E09F800FD
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="233231676"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; d="scan'208";a="233231676"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2021 06:11:18 -0700
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; d="scan'208";a="658279113"
Received: from tamoore1-mobl3.amr.corp.intel.com (HELO [10.209.131.176])
 ([10.209.131.176])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2021 06:11:18 -0700
Subject: Re: Any way of making this Intel SoC sound cluster work?
To: Valentin Villenave <vvillenave@hypra.fr>, alsa-devel@alsa-project.org
References: <2b85cc42-7446-2f7b-734c-1c3edbe3bcdd@hypra.fr>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f1d9a696-a462-1187-0dd9-14884ed9e97c@linux.intel.com>
Date: Wed, 21 Jul 2021 08:11:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2b85cc42-7446-2f7b-734c-1c3edbe3bcdd@hypra.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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


> I recently found myself with a rather atypical laptop from a niche Chinese manufacturer (relying on an old J3455 SoC); the `Intel Smart Sound Technology` output does work under Windows with the appropriate drivers, but under GNU/Linux (no matter which distro or release I test: Debian, Ubuntu, ClearLinux,…) no audio output is reportedly available other than HDMI. Lspci does list an “Audio Cluster” [10ec:10fc] and supposedly handles it with snd_hda_intel, but that’s as far as I got.
> This looks to me like a missing firmware issue, but I’ve spent hours trawling the Internets to no avail.
> 
> I also tried fiddling with the modules, by either blacklisting snd_hda_intel or loading snd_soc_skl and virtually every other combination I could think of. If there is an arcane option to be passed to snd_hda_intel, I have yet to find which one.
> Attached are the alsa-info output, the verbose lspci output and (just in case) the output of `wmic path win32_pnpentity` on Windows.
> 
> If some of you fine alsa-devel experts could give me any pointers, I’d greatly appreciate it!

The PCI ID points to an ApolloLake Intel device [8086:5a98]

{ PCI_DEVICE(0x8086, 0x5a98), /* BXT-P (ApolloLake) */

The audio codec seems to be an ESSX chip

/sys/bus/acpi/devices/ESSX8336:00/status 	 15

This configuration looks similar to another "Chuwi Hi10x" configuration reported in this issue:

https://github.com/thesofproject/linux/issues/2955

the difference is that configuration was with GeminiLake, which is a more recent versions of SOC but the audio subsystem is identical so the same solution will address both platforms.

Short story: snd-hda-intel is not relevant, it's meant for HDAudio platforms and it would only deal with the HDMI devices - which is what you've observed experimentally. If you want to support the ESSX codec, you have to use a DSP-based driver, which will require a firmware and topology file.

There is a hack suggested at https://github.com/yangxiaohua2009/GLK-ES8336, but if you want upstream support for this configuration there's some work needed.

What is needed is 
1) a table entry to provide the firmware and topology file for that configuration. I provided a first suggestion in https://github.com/thesofproject/linux/pull/2962, you could try to build on it to add the information for your device.

2) a machine driver for apl-es8316 and glk-es8336

I suggest we continue the thread on the GitHub issue 2955, it's easier to add information without spamming this list. It shouldn't be too hard to solve this, the main problem is that Intel folks don't have access to the device and that it can be complicated to get information on actual schematics (which SSP is used and connected to which port on the codec, which GPIO is used for jack detection, etc), and getting information on codec settings to generate a UCM file.

Hope this helps
-Pierre
