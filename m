Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212B4CC6B30
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:04:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB5DB6020D;
	Thu, 15 Oct 2026 02:04:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB5DB6020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792022653;
	bh=ZqD6AkmEfndrNGoLuyoQAVJU/spQaYSH67HCIMYM9fw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fNHEEZs87MsPefVQS1JbtylmQCWgLJhvm/88qrU09IWHiahODqV52OUkGSUpkz8f7
	 93DucCN6OFKA5wYEOQsAOu/2YdbCFCszfShzMI3sy18DV7CFnelDVFYgbqkoH+xtYg
	 ieVllUQJIJxfSKG7RyviJPvM//EoDmVvoQ7QzqsM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A8D8F805FF; Thu, 15 Oct 2026 02:03:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D0A58F805F4;
	Thu, 15 Oct 2026 02:03:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D3F6F804CF; Thu, 15 Oct 2026 02:03:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792022612;
	b=E3poUjnBwND2Z4H9Cit0B0WbTy8j2f3/CS44ioE1ZhpQYaoQdc82fDWv+I+5v9/K5vUH
	 rUHWYIQ4w2TjrYEO9MI4sP3yq2XZWKY6teXw6uKRQ6l6qGOAwe1tr4HLEGVho911nzUqV
	 q+iY514IfIowaGMjYwf0Sx7Vz8FQTyWFj++8xhv5GNY371hd197SNmgMTrSYME7YlwXeG
	 MLTOkRrZ/4ETfWDrCdfV6rzysmJe3EUvlIlFSDBXsbV52l50hMP1Sy0DiF3HLEyIL6CWy
	 ALqGzDjx3F0ysy8Zh4CrDlFIWOxqJa9MN2ImLj4Ef3A8XnXm5xbiIwl8G8lmbJtQepA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792022612;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=ZqD6AkmEfndrNGoLuyoQAVJU/spQaYSH67HCIMYM9fw=;
	b=nzKIrCBlqDAIME/+zyzpd925igrOOMwyQpqT2scc1vj/JB0AuSwwjzEApByvI4rZ4eGE
	 KCRRl6xgoX5pTCmwVqeWQ6ZrwR2oF5dxF+E99zj8bsmdA2Id7cBmBdR+Rm2JYnEOy0AW1
	 yDBOOXM/7lu3GQytaypHTnSTNSP85Zw8OkkqR7YBuu1nTED7S36GJXZTPZB+gWUv7U/Pt
	 j7+/l5i/aJ6/zc0rNluHRQ8pUC8rSzHBlGqBaGQQELbeOK/ReH/zOu2HhRyKosU8l+vmv
	 ezjDo3ymc3hG5CXfGsF2JdiTl/qILOacK6lA3cEB7WO1X+QoTaIJ73VY+wBxeJw0Akw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F967F800BD
	for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2026 02:03:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F967F800BD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18de8b12015dca00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/881@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/881@alsa-project.org>
Subject: ucm2: Qualcomm: add Lenovo ThinkPad T14s Gen 7 (Mahua)
Date: Thu, 15 Oct 2026 02:03:33 +0200 (CEST)
Message-ID-Hash: SI3NPLYWGYN6RE4L3FWNISXKNHFFN3RK
X-Message-ID-Hash: SI3NPLYWGYN6RE4L3FWNISXKNHFFN3RK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SI3NPLYWGYN6RE4L3FWNISXKNHFFN3RK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #881 was opened from lmacken:

Snapdragon X2 Elite laptop (Mahua) with two WSA8845 speakers on SoundWire and
two DMICs on the VA macro; no WCD codec (the headset jack is on USB-C). The
card is the "glymur" driver with the board's AudioReach topology
(linux-msm/audioreach-topology#84), which is the Zenbook A14 graph,
so this dispatches from the DMI product family in glymur.conf and reuses the
two-speaker WSA snippets.

DMI: board_vendor=LENOVO, product_family="ThinkPad T14s Gen 7",
board_name=22A7000VUS. The capture PCM offers S16_LE only on this kernel
(arecord reports S32_LE unavailable), so no Format is set for the Mic.

Tested with the Lenovo ADSP firmware: speaker playback and DMIC capture work
through PipeWire (Speaker and Mic devices, volume via the remapped
"Speakers Volume" control). ucm-validator2 `make configs` passes.

alsa-info.sh output attached: alsa-info-Lenovo-ThinkPad-T14s-Gen-7.txt

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/881
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/881.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
