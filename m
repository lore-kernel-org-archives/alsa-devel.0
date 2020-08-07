Return-Path: <SRS0=pDBX=BR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E345BC433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Aug 2020 05:20:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720442075A
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Aug 2020 05:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Mpz2wjeF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="IjODR5Qi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WjyI+lfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720442075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C903E3E;
	Fri,  7 Aug 2020 07:19:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C903E3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596777600;
	bh=FwyK/3mmrQDz8dFH9XspZFB5f8sJKDlPcvEFyfsQQiU=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Mpz2wjeF9fN3l9m0PrOGf5zF8DS2ovQ3iMx+RyeAUpVWEZPN8DR4hQELR4rtxhXXd
	 lw80cM02JcEszR4dbMOm9TnrBxKLSlqyXrMk4t41eD3k7SsUDuFAhXQELyMjTh70gU
	 RqJOhDTFmWKteFhm6TatIUtgV6rQoUtHUi4ZGr3I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40971F8020B;
	Fri,  7 Aug 2020 07:19:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02363F80218; Fri,  7 Aug 2020 07:19:07 +0200 (CEST)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 459DFF801F7
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2020 07:19:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 459DFF801F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="IjODR5Qi"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="WjyI+lfO"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id 0E6D0F49;
 Fri,  7 Aug 2020 01:18:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 07 Aug 2020 01:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=fm2; bh=FwyK/3mmrQDz8dFH9XspZFB5f8sJKDlPcvEFyfsQQiU=; b=IjODR
 5QiwlfVdQBF5INshDXPrcVqWuNdECoE3+eDABk7jU2PN65MTGCiElPm76DOS4S7Q
 vdjruBOafDpipEGlV5EtGPtXniMk+/j1lsi+HnrTSZ1XQ8K+6zr4xctJqYeRwGDv
 TUMWa39h+GBbMWAlnDWAqLS90F7siTXpy4k8vMyDyN/22CboQhHMr6jknH1KAmL8
 qaWehhKlWKiBcwa/x2SUUlIHsvND7SwMjMvtL7/QBx4F/04pl0E+V4+aONbIp277
 UJdxnJmmoVVRdgBeDUe8GxZIK+nJ3UIWf06E/91dcXgw7DPFnrHVTaGXdGrGSx4V
 Gln3t+0qVegCIzJdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:message-id
 :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; bh=FwyK/3mmrQDz8dFH9XspZFB5f8sJK
 DlPcvEFyfsQQiU=; b=WjyI+lfO6/FOdvM40dD8HU9hgaNpE503oU/k9fq+xpPE5
 DB8e+Rt2tZHCcPLVHdNACUUvsjYUfQBaw9IHuDdJHlu9U6FtGanHgulZN0T/+0QG
 suO521pYBSWc0gXofEKE6OLNMeFnaPNPdkzk6W6PzMlqPLQxSyi1MDRfxRuPAXD9
 cT9z/xmm97wB1b3AjtENgq3puKFHrpVcLgEB+daXe+0gU353NX2qV7tuWK1s4uRJ
 CTWoiEVxHVi9phgxhSSP6FGu34I+mP94MI87H/J3A1gOXmlKNjI2JApwmx6p5k2g
 TUNalic9rZWqXQ+5dutByF6MGalKMb2Kp1yHWE2WQ==
X-ME-Sender: <xms:QOQsX0x3qa5fOQAfP4G0t5x0a9gIEtViwvQPN7v08YeXV3jWMiqmZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdeliecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehttdertddttd
 dvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
 sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedugeehgfdttedtud
 fhudegveeufefghfegveekieffudekudfggfegtefgffelffenucffohhmrghinhepghhi
 thhhuhgsrdgtohhmnecukfhppedukedtrddvfeehrdefrdehgeenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghk
 rghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:QOQsX4QvXMlf9SKiDt5cjVqGiM6qbY2Fh6msbPbMBvfi3NrMGusKLQ>
 <xmx:QOQsX2UrAcxy_PrJRAsmZV9Fk2u2s6j8Sf3PfEH9mnUUWLNteDJPeQ>
 <xmx:QOQsXyike8XpB3CX4x_6C3Lot0w36SwaRTOOGixN9ekACiuHuEnW5A>
 <xmx:QeQsX99OPYAF2w-P3hLl-HwM6UXp1MOi7z_32JvTqMrTOFqiBtNazA>
Received: from workstation (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id D49FA306005F;
 Fri,  7 Aug 2020 01:18:55 -0400 (EDT)
Date: Fri, 7 Aug 2020 14:18:53 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: request for missing access permission to libhinawa repository
Message-ID: <20200807051853.GA453546@workstation>
Mail-Followup-To: tiwai@suse.de, alsa-devel@alsa-project.org,
	perex@perex.cz
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

Hi Iwai-san,

As Jaroslav is absent so long[1] (summer vacation?), I would like you to
arrange some team/repository settings for libhinawa.

I lost my write permission to libhinawa repository[2] since Jaroslav's
arrangement for github team. You are an owner of 'alsa-project' team in
github.com, and I guess you have enough permission to configure below items:

1. setting enough permission for my account to libhinawa repository
2. add libhinawa repository to 'GObject Introspection' team[2]

Would I request you the above?

[1] https://github.com/orgs/alsa-project/teams/gobject-introspection/discussions/1
[2] https://github.com/alsa-project/libhinawa
[3] https://github.com/orgs/alsa-project/teams/gobject-introspection/repositories


Thanks in advance

Takashi Sakamoto
