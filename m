Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AB6C433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Oct 2022 14:48:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B36361660;
	Tue,  4 Oct 2022 16:47:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B36361660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664894913;
	bh=dvtSCMOLUBksWIAbsPCAI+SownkArkMbwrdXw4+/Xcs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ac8HQ8zVox8KcdDyw1a0tGsy/SwN4HqEzwRAte6aGwRwQgzOgxTkYQR/cxow0bkd8
	 cHnlueUPWZHCT/5B6z27do2Me2y3oyg1GbPXVoP4R6LLIEt/D08yFfb3JaD973iiZg
	 5oO/t0Azq6Z0GFsfNO8L3dyntUihaBrTtLpPFfbM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4020DF80162;
	Tue,  4 Oct 2022 16:47:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4723DF801EC; Tue,  4 Oct 2022 16:47:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C6CD0F8012A
 for <alsa-devel@alsa-project.org>; Tue,  4 Oct 2022 16:47:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6CD0F8012A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1664894857067253113-webhooks-bot@alsa-project.org>
References: <1664894857067253113-webhooks-bot@alsa-project.org>
Subject: tgl dmic volume too low
Message-Id: <20221004144742.4723DF801EC@alsa1.perex.cz>
Date: Tue,  4 Oct 2022 16:47:42 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #224 was opened from yuvalk:

x1carbon gen 9 (tiger lake)
all capture devices at max volume (mic boost, capture, dmic0 front, dmic0 rear, dmic1 2nd front, dmic1 2nd rear, PGA2.0 2 M)
still reads from mic is ~5-7% (as can be seen in `arecord -vv --format=dat /dev/null` )

device is using sof-audio-pci-intel-tgl:
```
$ sudo lspci -vvv -s 00:1f.3
00:1f.3 Audio device: Intel Corporation Tiger Lake-LP Smart Sound Technology Audio Controller (rev 20) (prog-if 80)
	Subsystem: Lenovo Device 22d5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	Interrupt: pin A routed to IRQ 185
	IOMMU group: 13
	Region 0: Memory at 603d1c8000 (64-bit, non-prefetchable) [size=16K]
	Region 4: Memory at 603d000000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] Vendor Specific Information: Len=14 <?>
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00998  Data: 0000
	Kernel driver in use: sof-audio-pci-intel-tgl
	Kernel modules: snd_hda_intel, snd_sof_pci_intel_tgl

```

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/224
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
