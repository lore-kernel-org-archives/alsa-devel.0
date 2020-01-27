Return-Path: <SRS0=qqgH=3Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E62C32771
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 03:39:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B751620720
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 03:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TOuoIYj/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tcKVr8Fh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B751620720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 022991670;
	Mon, 27 Jan 2020 04:38:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 022991670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580096383;
	bh=ptzHLuwHat5cpxynKk/sS0qESCrCq1X8ZXvG3ws3LgM=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TOuoIYj/wrkPOI9JkZLRXpGSEZHq4XttGAhhTzTTP8BS1TRnCuNKdSS0r1V35nxJN
	 P8SgXldKJgL6Nl+8vxWotyevQqgrNjo0e/Ufd01fu48ID4Em5gxBfiaDq0hg8bCRzS
	 lATTffkARZgFqiImEilhvTSNEosNoWZe72Lk1Ovc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72C1BF800C8;
	Mon, 27 Jan 2020 04:38:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BEB8BF8021E; Mon, 27 Jan 2020 04:38:49 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51650F800C8
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2020 04:38:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51650F800C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="tcKVr8Fh"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 4C82B41C
 for <alsa-devel@alsa-project.org>; Sun, 26 Jan 2020 22:38:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Sun, 26 Jan 2020 22:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xyUbOr
 MBrHqeUt/+bCE1wE6Agf4JbuHdM2UV0h4j1dE=; b=tcKVr8FhHMJATiGYJnLniC
 RRJKNP8k5wwnGgUXDn/0zL8CkTVZmKcfsn/kh4NIC8h4grAFEfnb1MMoozlm/lUE
 7odlmgmyua/Aw8tL/Z0FXFW1HFm2PlIRKpoazYXQM+nUi5nX0JhGkvcoBnh8lwev
 bS5cw27IpZLsontQ6PvdYx4/FvtEV5f+sXg5cGpw4u16glbD8D44T9gYncMRcWb9
 iiZsSP2Pl5vywd9dFvbEo4GSpSvkXhl1duJiquFams0bxb5yq2TFcxMu7GIKEPH6
 SR/7argMWy+XV8CX/+yRN/wd4jOqns/bW5GvxQOM7F+tjmnYd3+lvTY2l7G8+9Jw
 ==
X-ME-Sender: <xms:NVsuXh1y0I5ujg8AYCYS55-9Zhq2bAhI4RRY1SYLHK9Yt46ZNRApsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfedugdeiudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecuogfvvgigthfqnhhlhidqqdetfeejfedqtdegucdlhe
 dtmdenucfjughrpefkuffhvffftggfggfgsehtjeertddtreejnecuhfhrohhmpefvrghn
 uhcumfgrshhkihhnvghnuceothgrnhhukhesihhkihdrfhhiqeenucffohhmrghinhepph
 grthhrvghonhdrtghomhdplhhisggvrhgrphgrhidrtghomhenucfkphepudeliedrvdeg
 gedrudeluddruddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehtrghnuhhksehikhhirdhfih
X-ME-Proxy: <xmx:NVsuXkPTpMZWMbRvwCyn1pbgTl34Y6jKyvdngS-Wxi_DyHebygCKOw>
 <xmx:NVsuXttxCq6Ycx99Teh0H62KTCBO_-hSQS-BkiEZEtKvK2SDLQ71Bg>
 <xmx:NVsuXoLX_e-J03B1ypiX7si6ppFZgSS74qGJTJEvqb2-Hxp-AoMwbA>
 <xmx:NVsuXkXDRw1rD7ZNM3Z59ycoVJHCHGtoujL4Q06j6HdeXkXHQkGuqA>
Received: from laptop (unknown [196.244.191.114])
 by mail.messagingengine.com (Postfix) with ESMTPA id 152CE3280059
 for <alsa-devel@alsa-project.org>; Sun, 26 Jan 2020 22:38:28 -0500 (EST)
Message-ID: <1b39817bef4a6531d303c171aea1c757046cb4d8.camel@iki.fi>
From: Tanu Kaskinen <tanuk@iki.fi>
To: alsa-devel <alsa-devel@alsa-project.org>
Date: Mon, 27 Jan 2020 05:38:25 +0200
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Subject: [alsa-devel] UCM file lookup logic
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi all,

I was looking at the UCM files, and most paths have the following
structure:

    <cardname>/<cardname>.conf

I noticed that the "HDA Intel PCH" configuration uses some other
scheme:

    HDA Intel PCH/HDAudio-DualCodecs.conf
    HDA Intel PCH/HDAudio-Gigabyte-ALC1220DualCodecs.conf
    HDA Intel PCH/HDAudio-Lenovo-DualCodecs.conf

How are the directory and file names determined? If I write
configuration for some random sound card that I don't have myself,
where do I find the various identifiers in the alsa-info output? I
don't even really know for sure what the <cardname> in the first
example is, I've been assuming it's the name that appears in the square
brackets in /proc/asound/cards.

I think the lookup logic should be explained in the ucm2/README.md
file. I can write a patch if someone expains the logic to me, but
probably it's easier if you just write the patch yourself.

-- 
Tanu

https://www.patreon.com/tanuk
https://liberapay.com/tanuk

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
