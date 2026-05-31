Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D04CCD6E4C
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:12:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD94D6023E;
	Mon,  1 Jun 2026 10:12:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD94D6023E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780301567;
	bh=D2b96bpT//bRq15xL4d2iEh1wwnmcO9QOqblE0YyH98=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SQFU2kc/3B1pLzMsF/vdcVh32D06gcMMtsf7Kl594MIlOM88loXCvfRbi21VBc8sI
	 2I1baiopRZodnpEQjEetVuq007VYwXlIVDyjINr6ulvr1hXr1mQtyKSqs9P8FY5zDy
	 g4Epc6c07qpA4o0MK5vZnzXMcdsDRfbLGFjs3zfM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B61BF80696; Mon,  1 Jun 2026 10:11:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 67E85F80691;
	Mon,  1 Jun 2026 10:11:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56421F805B0; Sun, 31 May 2026 15:21:21 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3E296F800E2
	for <alsa-devel@alsa-project.org>; Sun, 31 May 2026 15:21:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E296F800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=H2Ghbqlb
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 23195601D6;
	Sun, 31 May 2026 13:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5CC1F00893;
	Sun, 31 May 2026 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780233676;
	bh=ucei/Km5pTxeBW0GqGAGxBN/tmGyfgYst8kZ8KmZjaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H2GhbqlbA4jVp+/XBpaAJWcxUhFfRoJi9+gKEit8tscC/y1lF2Vt1DVIa8avsg9yi
	 ZV3i3WfprvWXekEeWWWvofPCJngCFGRHbNTrZKmvsQYNVG6trArcYERMREnzK+IOWg
	 KsJNJfLeMfjap/QwcEcBtFbEPrV4ltGGP+RGV3b89QkqqQ5lILu6Wh/j0EO24q3x1t
	 RrQBzDMXPHee5/A9BXxOgIwiqZv+OdHF9SoHgl5bvcL7sm/iF6qeJN3cajL5rxkI2U
	 CRuVqXQMLjKeAsV7fjLCP2G5Fyaen336T4FmjVjJCGVEfEasGxfhPeHSBgvpFNkodf
	 UxfQ9w5u3JzZw==
Message-ID: <cf379972-6b2d-42e5-9660-32d031516862@kernel.org>
Date: Sun, 31 May 2026 15:21:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] HDA controller MMIO unreadable on Intel
 5-series PCH (Ibex Peak) since v6.16
Content-Language: en-US
To: Filippe Duke <fduke@greennet.ua>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "tiwai@suse.com" <tiwai@suse.com>
References: <5e54aea4a97f1cbbe866d9d8f3f25f9f2958e1c9.camel@greennet.ua>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <5e54aea4a97f1cbbe866d9d8f3f25f9f2958e1c9.camel@greennet.ua>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MailFrom: superm1@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: R3E2RXSBNAPYVXZHKWBWJRBITIYFS5CH
X-Message-ID-Hash: R3E2RXSBNAPYVXZHKWBWJRBITIYFS5CH
X-Mailman-Approved-At: Mon, 01 Jun 2026 08:11:21 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/R3E2RXSBNAPYVXZHKWBWJRBITIYFS5CH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 5/29/26 20:26, Filippe Duke wrote:
> #regzbot introduced: 4d4c10f763d7
> 
> Hi,
> 
> The HDA controller on old Intel 5-series PCH (Ibex  Peak) becomes non- 
> functional since 6.16.
> PCI configuration space is ok;
> PCI function power state appears to be D0;
> However MMIO always reads 0xFFFF, causing CORB timeouts;
> ALC269VB codec enumeration fails (no AFG/MFG node found).
> HW works on v6.15.x and earlier and works under WinPE on the same machine.
> 
> Bisected to first bad commit:
> 4d4c10f763d7 PCI: Explicitly put devices into D0 when initializing
> 
> On top of v6.16, commenting out the single call to
> |pci_pm_power_up_and_verify_state(dev)| in |pci_pm_init()| (drivers/pci/ 
> pci.c:3273)
> is sufficient to restore working audio. The one-line diff is attached.
> 
> HW:
> ---
> DMI:  Acer Aspire 4745G / JV41_CP, BIOS V1.25 03/16/2011 (Insyde)
> CPU: Intel Core i7 M 640
> PCH: Intel 5-series (Ibex Peak)
> HDA: 0000:00:1b.0 [8086:3b56] rev 05, SSID [1025:0357]
> Codec: Realtek ALC269VB
> GPU: Switchable:  Intel HD (Ironlake, 8086:0046) +
> AMD Radeon HD Cedar (1002:68e0, 01:00.0)
> 
> Symptom (dmesg):
> ---
> snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
> snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops 
> intel_audio_component_bind_ops [i915])
> snd_hda_intel 0000:00:1b.0: number of I/O streams is 30, forcing 
> separate stream tags
> snd_hda_intel 0000:00:1b.0: CORB reset timeout#2, CORBRP = 65535
> hdaudio hdaudioC0D0: no AFG or MFG node found
> hdaudio hdaudioC0D1: no AFG or MFG node found
> hdaudio hdaudioC0D2: no AFG or MFG node found
> hdaudio hdaudioC0D3: no AFG or MFG node found
> snd_hda_intel 0000:00:1b.0: no codecs initialized
> 
> Hence the sound device is missing from ALSA.
> HDMI audio on AMD (01:00.1) is not affected by the issue.
> Attaching you lshw, lspci, DSDT, dmesg and diff.
> 
> Best regards
> 
> -- 
> 
> Filippe Duke
> System Engineer
> 
> GREENNET
> Kyiv, 7B Lesi Ukrainky St.,
> Cell.: +380672772879
> Email: fduke@greennet.ua
> Web: https://greennet.ua
> 

There have been a few commits that have adjusted the behavior due to the 
commit you identified.  So I believe it's potentially the tip of the 
iceberg.

Can you please see if this issue still exists on 7.1-rc5?

This is the most recent commit (from 7.1-rc3) that I know of changing it.

https://git.kernel.org/torvalds/c/909f7bf9b080c

Thanks!
