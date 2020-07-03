Return-Path: <SRS0=5/d5=AO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319D4C433DF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:50:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD89221532
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bG8iF9aV";
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="UJvkgiIy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cs+uaj9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD89221532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 328AE16A4;
	Fri,  3 Jul 2020 18:49:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 328AE16A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593795039;
	bh=VaZuqzSVOQo1CFbSJdv1voPfjGj4y5CKxBvZQ/BpF0Q=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bG8iF9aVcnhpofjD7sEW3oN+/HrkV9uV0ywqziobPbnhUxhplEH5TOYzB6DxIPKN8
	 rAkt10U/k+EBVrBIMZ9Jm06Rq2BlzCaxdi4cHmrIh1hRJM2VX8ZsyHIr6W5ElQeSXh
	 hrxUGTBPVcp5nT+rVjuQLsMgbyQy6nN5105FPFYE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8C09F800ED;
	Fri,  3 Jul 2020 18:49:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76EC1F80217; Fri,  3 Jul 2020 18:49:46 +0200 (CEST)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DBF52F800E0
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2020 18:49:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBF52F800E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="UJvkgiIy"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="Cs+uaj9m"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id CD5205C0134;
 Fri,  3 Jul 2020 12:49:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 03 Jul 2020 12:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=fm2; bh=VaZuqzSVOQo1CFbSJdv1voPfjGj4y5CKxBvZQ/BpF0Q=; b=UJvkg
 iIyurbC0S7w2IB+0C0oI3hF6vv2c/55n6aXsmMsMqwJO4UfUH1nrsDy0g3wmYWC+
 j0A/bzp2zGIZngSX1CCz5GFKAWRpQyStR6VAo8XEkjIthUx7I3aNBej6tNgsSVws
 uEGrrTn91bzExR15c8s7SYwixnXfo46BqJjOAsBL1TBuClyDtPccsZMePrx8gL76
 2fqEKa5wKDe6D1PlMrc5izeDDpzlT9x19w9XD/u3EJI3c3Nj2oSiHwn9RWI8Tty6
 Vj6xyqxStozN0Av/EPvlirjFASvK0X3xovvkSYl0+/iluvGvQ5GP+paAb/3F5nDa
 inNO7/CCwZtF/7R0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:message-id
 :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; bh=VaZuqzSVOQo1CFbSJdv1voPfjGj4y
 5CKxBvZQ/BpF0Q=; b=Cs+uaj9mAlNsY7MSR6StVEEljUOfv50mf6gQ4oklKShj2
 xi51xk10uQt+79ICZCydZDYa02Dhi2Xak4b1/hSVfvWYVQxHO2+rArRqS/O5ob/x
 Biu7O0KNBI75RC6rdqS8Q/xlsLbhzLKbgUkwUmqMAoHxOyJzKAZwQiDJR5bc55FN
 nwTc5B4zT9AW+p7P7G2OcmGXcu0lJJ89ojSqy+dr6myTlu7UiXoyKt0JBhOUK5/P
 iM8XeaKWmsCm5nsWhtINCnveJZ66QLPr6/A6/W8WWDVrwmk6ZgxXWS47SrVXk6KM
 SXcvnqaekkb+AXu0ydesAl780jAg7HmKGXO5obhzg==
X-ME-Sender: <xms:oWH_XsGljkHs1CFYQv_4xprnxHtnIV2pgVz03VW7qm6vjAuqF0a7ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrtdeigddutdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtredttd
 dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepuedutefhleejle
 egudeklefgkeelgeeuffeuueeuffdttddtgfetuefgheegfeeinecuffhomhgrihhnpegr
 lhhsrgdqphhrohhjvggtthdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppedukedtrd
 dvfeehrdefrdehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
 fhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:oWH_XlUViobQRHMYHkHeUKWrnq2wBDlNMT2QHXszraWbb0TpbyPc3g>
 <xmx:oWH_XmLLsa_CpYz1Wbws5CXLzqDHlxPwdwctIwsCcmH6UOcQJZ6O5Q>
 <xmx:oWH_XuEQqUrpCpOatsf5vOR6NTTltz6rAuAu_4y6G_7LPqxWMWogkA>
 <xmx:oWH_Xqini2yHrzXKIdkUS_D8GOzwdXzgzf4RSftci-LNytVVK0lX3A>
Received: from workstation (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id 797503060062;
 Fri,  3 Jul 2020 12:49:36 -0400 (EDT)
Date: Sat, 4 Jul 2020 01:49:34 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: perex@perex.cz
Subject: Move ownership of snd-firewire-ctl-services repository
Message-ID: <20200703164934.GA49779@workstation>
Mail-Followup-To: perex@perex.cz, alsa-devel@alsa-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: alsa-devel@alsa-project.org
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

Hi Jaroslav,

I'm currently working for the idea of 'ALSA control service in
userspace'[1] for audio and music units on IEEE 1394 bus under my personal
repository[2], and the work mostly done for Digidesign Digi 002/003 family
and Tascam FireWire series[3].

As well as libhinawa and alsa-gobject repositories[4], I'd like to move
ownership of the repository to 'GObject Introspection' team of alsa-project
account, then continue the work. I'd like you to arrange access rights and
so on, again.

Besides, as I tols you in previous message[5], the nested team is not
good in reasons. I strongly request you to leave 'GObject Introspection' team
and drop 'Hinawa' team, again. Would I expect your arrangement for it?

[1] https://mailman.alsa-project.org/pipermail/alsa-devel/2020-June/169141.html
[2] https://github.com/takaswie/snd-firewire-ctl-services/
[3] https://github.com/takaswie/snd-firewire-ctl-services/tree/topic/services-for-dg00x-tascam
[4] https://mailman.alsa-project.org/pipermail/alsa-devel/2020-June/169141.html
[5] https://mailman.alsa-project.org/pipermail/alsa-devel/2020-June/169191.html


Thanks

Takashi Sakamoto
