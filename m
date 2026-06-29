Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894C1C43458
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2026 20:22:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E9A1601F2;
	Mon, 29 Jun 2026 22:22:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E9A1601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782764538;
	bh=c7dcMz+0p8Y9MbBHev/DNumh991S4S6rkhjr9/qa4ts=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Rj2n2PYlMx3HrJBFDAizgjoWwgbpDiAh8NomsuxcVSG6fXbERTVqT1OYvdKUg37MH
	 YCA7p19ffic+abCWgUu3MeN9nh5WPwMKx+45T2fjMk07QI+WE5IdbPiR/b5XPWvw/V
	 r7nZmahZKgbw8GOHRNgMbk/WsIKv3KUqOtDNUYvw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54290F80602; Mon, 29 Jun 2026 22:21:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EAB30F80601;
	Mon, 29 Jun 2026 22:21:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B5EEF80495; Mon, 29 Jun 2026 22:21:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782764491;
	b=rsilYcW66UjeOslEc6cFGSoSwi/tI8JEEutjIPLoOCZo58NNY8mbg8/FfinqifYDaZen
	 zUrkvsiW35U/uPM6F8vqchKbz89rqtryuLYLJQYlrZgw+J6gNuMEQ0SW3EGZB3B33pmkx
	 K4CjL3kV5biTkYz0oJrTGLCIH5m/lKwlfgJQrfdk/ufLwKTn0mp7xj7weeTLLzMVQzO2l
	 D1CFI+9pI0D8m0lqIQqsp7zTFX/nd8H/gSLPKPlhraCSjcEzgWizKLpbxQIRcrAllR3yP
	 XVorylaWg3eZW/hv+hhD2EFbfqbmWsDAmma+5klj1KK0cfEue/r4z/9iT6naQZ3tMXg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782764491;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=c7dcMz+0p8Y9MbBHev/DNumh991S4S6rkhjr9/qa4ts=;
	b=YzMZw8KG+yyMboPFc0KpyGbDPl8I/w8vNHC5UTxBjk0iEzFfN1QcdI6SBkDBcZ5bZ2k3
	 CIr7hKeELNn0StBxzYd2d4qexC3av8RxK8/iCZM46vy55utNUgws5YLz8tFj+6VBvaLnP
	 5JG9AYoJnP6Hw89TATaDWJOVaYRlQPaCqKl/1AO6pBWp89LwLJd2PeUbqion5nina0cG2
	 AdhPJfSUJ5by40+0KicUy3bqlDl2It9SG1gOC7CDNM25+fvojjv6EmRWF2sW7ZXBRSUGW
	 O0xHyofNyeBE3UVr3bLKlhq0KhRL9BaXqnz4FJslZVIFJKj4FpxYGNrDgeZoi1NATRA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id DE9D0F80423
	for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2026 22:21:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE9D0F80423
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bda6db755cb600-webhooks-bot@alsa-project.org>
In-Reply-To: <18bda6db75062300-webhooks-bot@alsa-project.org>
References: <18bda6db75062300-webhooks-bot@alsa-project.org>
Subject: Regression introduced on DellInc.-Latitude9420-05379Y
Date: Mon, 29 Jun 2026 22:21:32 +0200 (CEST)
Message-ID-Hash: AGRABVCTWVMLVZLCJCTLSEO3SIP6RCFQ
X-Message-ID-Hash: AGRABVCTWVMLVZLCJCTLSEO3SIP6RCFQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AGRABVCTWVMLVZLCJCTLSEO3SIP6RCFQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #800 was opened from ondrejkolin:

Hello, 

My speakers are not detected anymore (in wireplumber) after the PR was merged: https://github.com/alsa-project/alsa-ucm-conf/pull/775
````
 0 [pcsp           ]: PC-Speaker - pcsp
                      Internal PC-Speaker at port 0x61
 1 [sofsoundwire   ]: sof-soundwire - sof-soundwire
                      DellInc.-Latitude9420-05379Y
````
Relevant (hopefully) parts from the kernel journal. 

```
kernel: software IO TLB: area num 8.
kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
kernel: software IO TLB: mapped [mem 0x000000004feb0000-0x0000000053eb0000] (64MB)
kernel: integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
kernel: integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
kernel: integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
kernel: integrity: Loaded X.509 cert 'Microsoft Option ROM UEFI CA 2023: 514fbf937fa46fb57bf07af8bed84b3b864b1711'
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: enabling device (0000 -> 0002)
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 0x040100
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: bound 0000:00:02.0 (ops i915_fence_ops [i915])
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: use msi interrupt mode
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: hda codecs found, mask 4
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: NHLT device BT(0) detected, ssp_mask 0x4
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: BT link detected in NHLT tables: 0x4
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: DMICs detected in NHLT tables: 0
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware paths/files for ipc type 0:
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3:  Firmware file:     intel/sof/sof-tgl.ri
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3:  Topology file:     intel/sof-tplg/sof-tgl-rt711-rt1316-rt714.tplg
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:1
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:1
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: loading topology: intel/sof-tplg/sof-tgl-rt711-rt1316-rt714.tplg
kernel: sof-audio-pci-intel-tgl 0000:00:1f.3: Topology: ABI 3:22:1 Kernel ABI 3:23:1
kernel: sof_sdw sof_sdw: ASoC: Parent card not yet available, widget card binding deferred
kernel: sof_sdw sof_sdw: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 3
kernel: input: sof-soundwire Headset Jack as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card1/input25
kernel: input: sof-soundwire HDMI/DP,pcm=5 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card1/input26
kernel: input: sof-soundwire HDMI/DP,pcm=6 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card1/input27
kernel: input: sof-soundwire HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card1/input28

```

Happy to help with more logs and testing!

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/800
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
