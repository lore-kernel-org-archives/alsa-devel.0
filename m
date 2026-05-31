Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2721ACD6E52
	for <alsa-devel@archiver.kernel.org>; Sun, 31 May 2026 20:49:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EBC8601D1;
	Sun, 31 May 2026 22:49:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EBC8601D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780260572;
	bh=A/3Ndw/QNFZQki1U23VUVmD30t5e7rQNDVkmvPlwrHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=opVIsIFwKTaDsMoim29I0viFys0CxO3Qdfm1aGVsFtHK4hJ7ZmTRezVZfifGZT/l0
	 55/NKhGCp29LyuheBkc15qKZ8DzsG8KITrVkxjVgocFFKRtpdtj8Y9406jP5A7OBtK
	 d72yovKtoM/a5SMIYLmdyE14MZgWy/6i9wB34ZT8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B0ABAF805E6; Sun, 31 May 2026 22:48:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 62F77F805E6;
	Sun, 31 May 2026 22:48:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B091DF805B0; Sun, 31 May 2026 22:48:47 +0200 (CEST)
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
 [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9EAA8F80075
	for <alsa-devel@alsa-project.org>; Sun, 31 May 2026 22:48:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9EAA8F80075
Received: from h08.hostsharing.net (h08.hostsharing.net
 [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 91D1DC07;
	Sun, 31 May 2026 22:48:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4E93E601807C; Sun, 31 May 2026 22:48:44 +0200 (CEST)
Date: Sun, 31 May 2026 22:48:44 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Filippe Duke <fduke@greennet.ua>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"superm1@kernel.org" <superm1@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"tiwai@suse.com" <tiwai@suse.com>
Subject: Re: [REGRESSION][BISECTED] HDA controller MMIO unreadable on Intel
 5-series PCH (Ibex Peak) since v6.16
Message-ID: <ahyerEqlBdIbQN9u@wunner.de>
References: <5e54aea4a97f1cbbe866d9d8f3f25f9f2958e1c9.camel@greennet.ua>
 <cf379972-6b2d-42e5-9660-32d031516862@kernel.org>
 <e05ab19cf41224661325a8acb5f10d31a1d8fbf0.camel@greennet.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e05ab19cf41224661325a8acb5f10d31a1d8fbf0.camel@greennet.ua>
Message-ID-Hash: MVECL2EL32RDIGCVBKK4LKVBPWFWSLOS
X-Message-ID-Hash: MVECL2EL32RDIGCVBKK4LKVBPWFWSLOS
X-MailFrom: lukas@wunner.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MVECL2EL32RDIGCVBKK4LKVBPWFWSLOS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, May 31, 2026 at 07:49:59PM +0000, Filippe Duke wrote:
> 00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset High Definition Audio (rev 05) (prog-if 00 [HDA compatible])
> 	Subsystem: Acer Incorporated [ALI] Device 0357
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupts: pin B disabled, MSI(X) routed to IRQ 34
> 	Region 0: Memory at cc100000 (64-bit, non-prefetchable) [size=16K]
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000

MSI is enabled but address is zeroed.  Please provide "sudo lspci -vvv"
output of a working kernel so that we can see whether there's no MSI
address configured there either.

Thanks,

Lukas
