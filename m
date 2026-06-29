Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11107C43458
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2026 23:26:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF423601F9;
	Tue, 30 Jun 2026 01:26:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF423601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782775608;
	bh=IKxzFqy+ECezCQip3OVrJ/O+P/IWfiGVXkpRZhqnNds=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=f88MrmyvfcanVUw1/BID0RagrB79ri0oENRIKq3PJKjWe4URcG/dtgknFpiSA8rm1
	 WRVQAPfoBILqXlNXd2tQ3A81XLj4qwhusD3UHPgLxWFGUSoY8QGRM/Pd06wOlP2EqP
	 P7AB02EpOUyOBr7ojN5xmT5VwPXPFMC3XQ5/T+k8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D91DF805FC; Tue, 30 Jun 2026 01:26:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A9B09F80602;
	Tue, 30 Jun 2026 01:26:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67E57F80587; Tue, 30 Jun 2026 01:26:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782775564;
	b=F0mslhtloQzlOef3sOzKAp88gOH1bEH5yESoGWZM8gjvVYY1loQG8dwZGTgtX2CSPm3P
	 mVUC7zMHMBctkIF6TertYunCw55bWnddcGLelfNcDKYf80ODxULny59x84BYUWxUDy1mP
	 h40N3V7lsGD1VC4Zt59lvFFvWeBKwtj48vlitGC70Z4w1TzfWdEVZ6fD/9o9VZHcRM5Jb
	 N0hxS2PHMEt2kOKHzlf3FqZOxSs4RbEHo3ivbleE2irg8tJFPI26ClT6hzETO0lvPnYOQ
	 LGSe24gcmWOJm53zUfPlFqTXPVEeLMcg1yYNYx2lRu6dT6oO5WuJYBMOA7J/pdKHmcA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782775564;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=IKxzFqy+ECezCQip3OVrJ/O+P/IWfiGVXkpRZhqnNds=;
	b=DwV1ArLY87YGi5MOdDZvc4RNeYBV6I9pbe711+WDgVeNY8OpZMkiubeaORMA98oUNgCg
	 yiFFs1Az5N+erviPkcOf5APJ6jeE90OzWPMrLzOkbIkqO0XZhAl0OusmYsLpqtYRChYeI
	 xRF0A6X7izc+1oA8Ckhy2Ufuj8XkpiSmqR1WHvc6EGij9t1ldu+j+PjLflXkcECyMT29Z
	 PxGOWgMJ/lbDEZzSrMkty+bSicH5lCsA9WKENMvXCB+sb5PJyMfpsdjms9u+ma8gHnTT9
	 suhn+BBpFUvCcHJrRNI6ffwyWZMtQ5w0viExY/G1JPNNcvM3UFaKmHentA3mtxJUcWQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id C0826F80423
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2026 01:26:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0826F80423
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bdb0edfd53bc00-webhooks-bot@alsa-project.org>
In-Reply-To: <18bdb0edfd486600-webhooks-bot@alsa-project.org>
References: <18bdb0edfd486600-webhooks-bot@alsa-project.org>
Subject: Annoying sound when restarting an HP computer running Linux Mint with
 Intel components.
Date: Tue, 30 Jun 2026 01:26:05 +0200 (CEST)
Message-ID-Hash: XL7EFPLKLJDPMNB3POYVPHWPFRSPYIWK
X-Message-ID-Hash: XL7EFPLKLJDPMNB3POYVPHWPFRSPYIWK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XL7EFPLKLJDPMNB3POYVPHWPFRSPYIWK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #801 was edited from thisangelo:

### Brief description of the problem / regression
Since the update to version `1.2.10-1ubuntu5.11` of `alsa-ucm-conf`, a loud "pop" sound is heard from the **left speaker** on my HP laptop every time the system starts up, right after the kernel loads the audio drivers.

### Hardware / System information
- **Model:** HP Laptop 14
- **Codec:** Realtek ALC236
- **SSID:** 103c:0000
- **Audio Driver:** `sof-audio-pci-intel-tgl`
- **OS:** Linux Mint (Ubuntu 24.04 Noble base)
- **Kernel:** `7.0.0-14-generic`

### Steps to reproduce
1.  Install `alsa-ucm-conf` version `1.2.10-1ubuntu5.11`.
2.  Reboot the system.
3.  Listen to the "pop" sound from the left speaker.

### Expected behavior
There should be no "pop" sound on boot. The previous version, `1.2.10-1ubuntu5`, works flawlessly and does not produce the issue.

### Workaround
- Downgrading to `alsa-ucm-conf=1.2.10-1ubuntu5` completely eliminates the "pop" sound. After downgrading, I'm holding the package with `sudo apt-mark hold alsa-ucm-conf`.

### Additional context / diff analysis
The problematic change seems to be related to the handling of the `Master Playback Switch` in the files:
- `conf.d/sof-hda-dsp/sof-hda-dsp.conf`
- `conf.d/sof-hda-dsp/sof-skl_hda_card.conf`
- `conf.d/sof-skl_hda_card/sof-hda-dsp.conf`
- `conf.d/sof-skl_hda_card/sof-skl_hda_card.conf`

**The change is:**
```diff
-   True.FixedBootSequence [
-       sysw "-/class/sound/ctl-led/speaker/card${CardNumber}/attach:Master Playback Switch"
-   ]
+   True.Macro [{ SetLED { LED="speaker" Action="detach" CtlId="Master Playback Switch" } }]

### ANALISYS

Although this condition is intended for Needle "dell-laptop", my HP laptop is also incorrectly triggering it, causing the speaker to "pop" on boot. This confirms the regression introduced in version 1.2.10-1ubuntu5.11.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/801
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
