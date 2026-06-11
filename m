Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBACCD98CC
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2026 22:26:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E06760203;
	Fri, 12 Jun 2026 00:26:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E06760203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781216807;
	bh=x1nCbf5ghR1G3xSq1vGVB8/nzoGCxFfR0PzVnKOAoTY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=f6356oBZ+P9mKu475NT9HkLykd+UfidR+UkbJHQcSPyJ1HGTAl4sxv2Qll3lnlWDZ
	 5EabDRsuHYpwpGHcibp8mAXkfjYppCkRtNgNN0ybK6r2yVbehca7/xhU5yIi0PdgEc
	 IcNyNYnAcRc0XYDGNvGKJz9jJpBCuwC/liN9vNvk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A88D2F805FC; Fri, 12 Jun 2026 00:26:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 212BFF805FC;
	Fri, 12 Jun 2026 00:26:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B771F80579; Fri, 12 Jun 2026 00:26:04 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781216763;
	b=AAfxe1q1u0VahPvIqtE5/DjEW6DqrWxrCbiFz2iq0SwX1I1qXbPTy2mvHWWoRGOSaMVv
	 OF7RnfmOa+wYxBidyksqiMJkhqDrTwP0w+VQ87Fl4MNEBD1itw8C7VszV6bLKLdY9Kr8s
	 eJLppRHWR1gGQyWmxEcab9W+FB8hVR+4vBYXNqt95RMAloDH2zVh07P2zLsyl8B73QYpE
	 phCaOYWbDxE2DNe/CP+UhUXniEp70p3BQ/Gpf/6k9SMCgGE7cz+KjxzT8qEn403boDgAX
	 cmAud8ulmPrRg8hCZr7JSblAI8g8RZ6fZxu2oSsKoVzUD/SJrRYvMcoW1r0RGNvIrqw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781216763;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=x1nCbf5ghR1G3xSq1vGVB8/nzoGCxFfR0PzVnKOAoTY=;
	b=fymREvgOZ037bREOpfU0wUQfdJON6E2SW5skz1jo9GOfFEJNQvC6JyrbK94XOaYZmAdh
	 yKUIJaGLYMMv6K+tppU+VXzll+jnsAQees9MEWSVmo8FdE7KwiH9S0be3me/V22O5zzC/
	 yOrABlXeBLKRKxVaHXjL7G5wD78Gl2GPMQkF0KPfh+4uww/P63ki278Eey8OONlSchhik
	 Gn/bRllR5uNG+TuYDDEb5CnWWW/F0eWkR5Ow9yJRgx4RxVQZ4Of/vex4TDqANKQQ2lUSN
	 gDMJ7BCpCsvuvZpIMrk7vZW9mliXzbePNJK4etYg+l3gp/As0VpXxqXNm1Tfy6KNZEQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 417E5F80510
	for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2026 00:26:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 417E5F80510
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b827352445d300-webhooks-bot@alsa-project.org>
In-Reply-To: <18b82735241e5800-webhooks-bot@alsa-project.org>
References: <18b82735241e5800-webhooks-bot@alsa-project.org>
Subject: [Regression] No sound / Deferred binding [RR] on MSI Prestige 16 AI+
 C3MG (Panther Lake SoundWire) after UCM update
Date: Fri, 12 Jun 2026 00:26:04 +0200 (CEST)
Message-ID-Hash: YKE2UZFDNHIAP3FAHBK7OSYMA52IQZSN
X-Message-ID-Hash: YKE2UZFDNHIAP3FAHBK7OSYMA52IQZSN
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YKE2UZFDNHIAP3FAHBK7OSYMA52IQZSN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #784 was opened from tarabelo:

Hello,

A recent update to the `alsa-ucm-conf` package has introduced a regression on the MSI Prestige 16 AI+ C3MG laptop. The audio subsystem falls back to a deferred state, muting all physical outputs (Speakers and Headphone jack). 

The hardware uses an Intel Panther Lake DSP routing audio over a SoundWire bus (4SDCA topology) to Realtek codecs. The SOF firmware loads correctly and the kernel modules are probed, but ALSA fails to map the endpoints with the latest UCM profiles, leaving the controls locked in a `[RR]` (deferred) state in alsamixer.

Downgrading `alsa-ucm-conf` to the previous version completely restores all audio functionality.

### Hardware / System Information:
* **Vendor:** Micro-Star International Co., Ltd.
* **Product:** Prestige 16 AI+ C3MG
* **Board:** MS-2622
* **OS:** Ubuntu 26.04
* **Kernel:** 7.0.0-22-generic
* **DSP:** Intel Panther Lake Smart Sound Technology (SST)
* **Codecs (via SoundWire):** * Realtek ALC1320 (Amps) - mfg_id 0x025d part_id 0x1320
  * Realtek ALC713 (Jack) - mfg_id 0x025d part_id 0x0713

### Symptoms & Logs:
1. `dmesg` shows SOF loading the topology but ALSA defers the binding:
   `sof_sdw sof_sdw: ASoC: Parent card not yet available, widget card binding deferred`
2. `lsmod` confirms `snd_soc_rt1320_sdw` and `snd_soc_rt712_sdca` are loaded.
3. `alsamixer` shows the `sof-soundwire` card, but `Speaker` and `Headphone` elements are locked in `[RR]`.

### Steps to Reproduce:
1. Boot with the latest `alsa-ucm-conf` package on this specific hardware.
2. Check `aplay -l` (only HDMI/DP nodes are visible).
3. Check `alsamixer` (controls deferred).

### Workaround / Proof of Regression:
Reverting `alsa-ucm-conf` from version  1.2.15.3-1ubuntu1.2 to 1.2.15.3-1ubuntu1 and clearing the WirePlumber state (`rm -rf ~/.local/state/wireplumber/`) immediately restores the hardware mapping and functionality.

I can provide the unified diff of the `usr/share/alsa/ucm2` directory between the working and broken versions if needed, or test any proposed patches.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/784
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
