Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF81FC43458
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2026 23:18:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 548B0601EB;
	Tue, 30 Jun 2026 01:18:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 548B0601EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782775093;
	bh=kGwmzTgCTf1W7DjIIfPHco/2kxQ+N4BS1EsIW6eu4pc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=lCqjycK8UqjOg9NBPqy7fQ2VUs227cPutnzYAlqPuRp2YKonbRhRF1ADovxnmrIU8
	 ajgSZkAsK/YSzP5siJvu7nEwpY6kL9Pu/RG9Q0hYIxKOmqU/Ezpwwq14bIUZHAylQp
	 Y/mlKWXiZAvuNvrmGR4EEOPhGcNej0jDqjVVoF8U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06698F805FF; Tue, 30 Jun 2026 01:17:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B52E1F805FC;
	Tue, 30 Jun 2026 01:17:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67175F80587; Tue, 30 Jun 2026 01:17:23 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782775042;
	b=S7B4nMqIMQW+PWWjCxfDL9XX66O7XFsABsFk/tAjrjd+kHS8Xk1ndy8C5b661PRaPbFG
	 Or9QCeK8egfhH/ZpRnoeTUA1XSlWqikLbkOivIaWd+d5Z1wbrOkoiC+jfthZRWoYvSeop
	 nuNEaxsU3eePwBTbTMjKWbE3Kbg9fnD0XXPil352+VU6XClSaQHxjEHjRTHE1KqmOGHOq
	 m/NCtCSTV+D5NyWrMfso5p5Klf8Z2lzoWgEbhru4nZc11k6GbbATi3sZn/kjozDHTczs2
	 H5pl+ZnfCIL96+rNNwOp0ySkSIgzFK0qq/LfSLM3+6CqJGtQz0WE9gcvxHM+QFy3MaA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782775042;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=kGwmzTgCTf1W7DjIIfPHco/2kxQ+N4BS1EsIW6eu4pc=;
	b=CNNJCWD6xcDjSwWxh9q32ktQyOhhBKF6HoaWXlp6/OoYBJ3aP3H3kkr3aa/cHbs7UGYL
	 JhPx6cjQD/Iun1/J4O03rC7AST1ftQ87bRFznDoY2rIvla5LSLd6Tv0Ducp5JkrfrRCbS
	 jcwPHt/Zv+KZoTeRaIAZ7xqV9VfC3xqsKfAsybRB5jMDSStxy+wX2jPZbTuB3yZO4xTFU
	 lrZbcJo4/n0IbwMut+UegGE8Gz0eo0WnR59xX1fdSB82Q0lfclO5qiixtSGOmkcHs9lnG
	 NQuzIk6t2gYd0SS8l1B6ttIvTgCyXdn/OUbWmfi8CxZllRAJBW/61xy8zdVDcRP9zmw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A6B4F8053D
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2026 01:17:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A6B4F8053D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bdb07427edee00-webhooks-bot@alsa-project.org>
In-Reply-To: <18bdb07427baf100-webhooks-bot@alsa-project.org>
References: <18bdb07427baf100-webhooks-bot@alsa-project.org>
Subject: Annoying sound when restarting an HP computer running Linux Mint with
 Intel components.
Date: Tue, 30 Jun 2026 01:17:23 +0200 (CEST)
Message-ID-Hash: OARTCZWUOXKPVWW7ZSTTGZ7YBKY4RBJB
X-Message-ID-Hash: OARTCZWUOXKPVWW7ZSTTGZ7YBKY4RBJB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OARTCZWUOXKPVWW7ZSTTGZ7YBKY4RBJB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #801 was opened from thisangelo:

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

Although this condition is intended for Needle "dell-laptop", my HP laptop is also incorrectly triggering it, causing the speaker to "pop" on boot. This confirms the regression introduced in version 1.2.10-1ubuntu5.11.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/801
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
