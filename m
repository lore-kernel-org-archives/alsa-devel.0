Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A52AC34022
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 03:12:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0517420836
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 03:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LFMHuk1V";
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="FR9PW3tw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xfafgPj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0517420836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A17482A;
	Tue, 18 Feb 2020 04:11:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A17482A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581995524;
	bh=l650z/IPSx/vrozLWgpwth/7S6Xcwo6rM2VDgGDOF2Y=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LFMHuk1VXyu0mVESBRrsgsAQCVph5G6x0I6tsOnzcSOWNWZ87tkGcZTdSZQTQ0Bj4
	 FZiEL4Cj/NJTYBOhaaAHV9xq5ocseoL2Vq+TUPxgcIEUyRhBIeOJJ7FlBoK22UZjLU
	 opxjxAqQB9WuWFoSuO0CGro1Aw/wtBDYrA9UeI4s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2035F80145;
	Tue, 18 Feb 2020 04:11:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26918F80148; Tue, 18 Feb 2020 04:11:12 +0100 (CET)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F7A7F80135
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 04:11:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F7A7F80135
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="FR9PW3tw"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="xfafgPj3"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 0386C21448;
 Mon, 17 Feb 2020 22:11:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Mon, 17 Feb 2020 22:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=fm3; bh=l650z/IPSx/vrozLWgpwth/7S6Xcwo6rM2VDgGDOF2Y=; b=FR9PW
 3twZkbFeEUEl1wv9btW9SmpH0/mrlzL8YQM6E7GhoVYbHaVQ1+6p/qNRZ4W1TcKV
 EZR9+bho7s2POvv2OGf6wTRdne8cvDx3DZ9tOAsbHF0fY6qdC5GLH5nWZkMJzFox
 gUGR4SiF58DKW2140f3NO21s3y1j3MyCAMLEa+p+eDQaesPZqPKNXQ/8AOPhxFlV
 1lN4WTrqcmwkilF0ki+DgEq2WXepd1ao1OT0QMFQBe+bBiF6fMQT9ZqRDEFeakTA
 +QjWSdTP9j8Tb08t0GeuoyQwsJYcCOyCpwkgITnm7/N8Q3WLrYWyj7oewLZzOMCt
 7WxwQuc0+i84E7Umg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:message-id
 :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; bh=l650z/IPSx/vrozLWgpwth/7S6Xcw
 o6rM2VDgGDOF2Y=; b=xfafgPj3Dm7pVWG3GNA+G5GRoQMOUdhYCEV7rVC8exSB4
 ATwRfkIoTzu97JMQv+jgW3Ut+8quW0gPTJC4Z2bp/MmolkaiCVF7K1uSF08ReXpD
 VEe3Fry54FvZ1uLLf3Zft1dgoRsXndV4t+MvAAGSCqqwsjdDUnLW2mss6BlbmiVt
 /8cEFcuxfzL6PaRpPD5tPsi+5l7oYYz9lpy7jZhK7nYpEnqIU83w/hTrSyqujBTt
 K0csO6N9w5kLVHuLFeTlnsbmN45iwsUFixFIrPjY85MR/bxMKg81Neo8OJCCSazi
 E2Z241my+UaTgBXkoqgARU0CU7iLynCxNNkcMiTbQ==
X-ME-Sender: <xms:yVVLXh8t0foz238wsscQmsRGzWgJZex-0OusACzwiW4eeeNLFQv1Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeejgdehgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggufgesthdtredttd
 ervdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuffhomhgrihhnpehgihhthhhusgdrtghomh
 enucfkphepudegrdefrdejgedrudeikeenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
 hp
X-ME-Proxy: <xmx:yVVLXm-Vzum1Apj_EIAQuMNr5YHwVM12mc4mAd0XQ2ZtQmABmck7zQ>
 <xmx:yVVLXgz_VNKFbWZLlSKt5_G2L6DzsMccjBNNfL1Vj20aqc8W7WTuVQ>
 <xmx:yVVLXu644sLf_O0wyD6bpP_euBUJbuhpGQv3eaYY3FfuTCSdo8WwAA>
 <xmx:yVVLXgagoS_k-U7ZOuuuVrFIkl9IgVyOTm-AG2GGxRvB0iafIX-bEg>
Received: from workstation (ae074168.dynamic.ppp.asahi-net.or.jp [14.3.74.168])
 by mail.messagingengine.com (Postfix) with ESMTPA id A06BD328005D;
 Mon, 17 Feb 2020 22:11:04 -0500 (EST)
Date: Tue, 18 Feb 2020 12:11:02 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: alsa-devel@alsa-project.org
Subject: Questions about event implementation in ALSA Sequencer
Message-ID: <20200218031101.GA12168@workstation>
Mail-Followup-To: alsa-devel@alsa-project.org, tiwai@suse.de
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de
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

Hi,

I'm working for alsa-gobject[1] so that it supports API for ALSA Sequencer.
At present I've mostly done it just with direct dispatch support[2] (thus
transmission via queue is for my later work). Then I have some questions
about the design of event in ALSA Sequencer. I'd like to ask for some advices
(mainly Iwai-san, perhaps).

1. use case of SNDRV_SEQ_EVENT_LENGTH_VARUSR in 'struct snd_seq_event'

In my understanding, the flag is used for a case that sender transmits the
value of pointer itself and its length to the receiver in the shape of
'struct snd_seq_ev_ext'. I assume that two use cases. If the sender and
receiver are in the same process, the event is a request for the receiver to
operate data in the same VMA. If the sender and receiver are in different
processes, the event is a request for pointer-based calculation between the
peer.

If the above understanding is correct, it's hard to represent this type of
event for g-i interface because g-i is the object-based framework. Any raw
pointer without explicit type is hard to be exposed to g-i applications as
long as I know, and it's going to be unsupported, perhaps.


2. event data type corresponding to event type

Some event types are expected to specific data type; e.g. SNDRV_SEQ_EVENT_NOTE
is for 'struct snd_seq_ev_note' and SNDRV_SEQ_EVENT_CONTROLLER is for
'struct snd_seq_ev_ctrl'. However there're some types for any data type; e.g.
SNDRV_SEQ_EVENT_ECHO or SNDRV_SEQ_EVENT_USR0. For the kind of types, the
event structure has no information about which data type should be used and
user applications voluntarily decide the data type. Therefore the sender
and receiver should share a kind of protocol in advance.

This means that userspace applications require API to select data type
independent of event type itself.


3. quote event and specific event types.

Two event types are reserved for 'struct snd_seq_ev_quote'; i.e.
SNDRV_SEQ_EVENT_KERNEL_ERROR and SNDRV_SEQ_EVENT_KERNEL_QUOTE(obsoleted?).
However, the quote structure is exposed to userspace itself. Furthermore,
as of v5.5 kernel, there's no in-kernel code to check the quote data
from/to user client.

Is it better to produce API so that userspace application can transfer
the quote event?

[1] https://github.com/alsa-project/alsa-gobject
[2] https://github.com/takaswie/alsa-gobject/tree/topic/seq

Regards


Takashi Sakamoto
