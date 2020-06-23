Return-Path: <SRS0=bSXK=AE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D32C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:33:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A502E20724
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pPmVrkEt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="zqgoTMmB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IEby4soo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A502E20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 386F61748;
	Tue, 23 Jun 2020 11:32:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 386F61748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592904827;
	bh=wfqMkta+IQg7ST3Eq7tAM2/UTCEYEYqSZ2eUlgaP3c8=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pPmVrkEtY/KRKbDbDFUEB7Me6dIXwaWjfn4zPWDezJ0j4xwUQ7MGcjg2stnH5jFy0
	 52vWzo+YEzgvG12SzOYNoEBGNT1n6VhT7bIytD/ilAwhr4BkG8nF92nAAqYAtiL32w
	 CutZCAR2XkW6LgT/+Q9vXdOLQRwEovCNuGCSnfCA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B22CAF80218;
	Tue, 23 Jun 2020 11:32:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E713BF80234; Tue, 23 Jun 2020 11:32:54 +0200 (CEST)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E199F8012F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 11:32:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E199F8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="zqgoTMmB"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="IEby4soo"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id 6BE8BA6C;
 Tue, 23 Jun 2020 05:32:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 23 Jun 2020 05:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=fm1; bh=a9cM6JbyiFJfGQM3YkoyDP7bPiSv69GBZHa67n4oQOQ=; b=zqgoT
 MmBEZ4Wxp6dZcVOVwn8XzyaTOJLS60Xj63nncI8A4YqFnu06l+bkET1jf31Vlr4h
 mvdhc2RTAVqyyMDY4pnC16PqVnpyh60iCH64/dAbLvr0EkHL7nMI3LOd7ny0/V7u
 WeDx8A9CNVH9NQ288usMM7bCJLijjb6BEt+y0nRhSxOpgmHsO2YgL4ovEdfDqXKd
 F3+dk+HkmDkdtc+3bbSpzG4Gu5Wlhz5ddZ3JzeCesdukxci/pUrZmxSawNo6pZWp
 R+0kcPtErF8N9C4SAYmn3pUQE3bg55PCxxOpyFIE0VQqr0s6ltBUhfEDh1BhdQwt
 xtHu/mvqs+NCtaB/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:message-id
 :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; bh=a9cM6JbyiFJfGQM3YkoyDP7bPiSv6
 9GBZHa67n4oQOQ=; b=IEby4sootwqwKuAFsSGGCaZA41uoWsVOWWxpavboo7Z56
 SuYeM5o4/sUsNlRWEIWOT3pzstPzjS+ihY+iG1GyK4Mesi826TWA+46WeRHZ60gN
 cnSXpnAjdxW5Ht3WmJNBW+loP+zt1mP1YTDDDB0Yjt2bShz5vlvnhqoWBxh3/29p
 ZYu+dNI4kYaGqZoLArIdetOfuNFwQnPj86TH1T745PEbQXeTokxR+KMZK/CTNSWI
 1LNqgI3SPqgj0g+phcl4O7ohWnPmpwR+05tbS/YvhFvneX6/UOBVlQ71UUccIi3J
 aQHTQsB3VsV92iamFwxgDiwtQrlk6HzPvO/FDGs+A==
X-ME-Sender: <xms:O8zxXtjxjUmm76gSZnR-PLS83CaF90hhXbtsYWfq_zlTvkvTORcViQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudekgedgudekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
 cujfgurhepfffhvffukfggtggusehttdertddttddvnecuhfhrohhmpefvrghkrghshhhi
 ucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqe
 enucggtffrrghtthgvrhhnpedulefgudfhfedtheejuefgveelleejheejgfegleefleeu
 veehtdetjeeviefftdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhthhhusg
 drihhopdgrlhhsrgdqphhrohhjvggtthdrohhrghdprhgvrgguthhhvgguohgtshdrihho
 pdhgnhhomhgvrdhorhhgpdhfrhgvvgguvghskhhtohhprdhorhhgpdhpohhrthgruhguih
 hordgtohhmpdhlihgsshgulhdrohhrghenucfkphepudektddrvdefhedrfedrheegnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkh
 grshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:O8zxXiAlzmNEFYAjx7buUhiR42ufc1dNRQVyARyGEnFFa2358NW0Hg>
 <xmx:O8zxXtHmAKUUB7Grg6tKTFU-IgYNI6qU6f-_55MlKqskyCTyCF5r1A>
 <xmx:O8zxXiR5UVysoFqGU8CtuvnPMIeqRXobwnO2tIkhlyf47kLP0WkAyg>
 <xmx:PMzxXvvbBZSdkCD326BELhVjCiAFvrOGMsJUCQERFiCce0ctjcQzkw>
Received: from workstation (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id 23DDE30674A7;
 Tue, 23 Jun 2020 05:32:41 -0400 (EDT)
Date: Tue, 23 Jun 2020 18:32:39 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: alsa-devel@alsa-project.org
Subject: Announcement for alsa-gobject v0.1.0 release
Message-ID: <20200623093239.GA68404@workstation>
Mail-Followup-To: alsa-devel@alsa-project.org, perex@perex.cz,
	tiwai@suse.de
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

This is an announcement for the first official release of alsa-gobject
project, addressed in Audio Mini Conference 2018[1]. The release is
available in below URL.

 * https://github.com/alsa-project/alsa-gobject/releases/tag/v0.1.0

The release includes below libraries to operate corresponding character
devices of Linux Sound subsystem (=Advanced Linux Sound Architecture,
a.k.a ALSA)[2]:

 * libalsactl0
 * libalsatimer0
 * libalsaseq0
 * libalsahwdep0
 * libalsarawmidi0

The libraries are also compatible with gobject-introspection (g-i)[3] to
produce gir files:

 * ALSACtl-0.0
 * ALSATimer-0.0
 * ALSASeq-0.0
 * ALSAHwdep-0.0
 * ALSARawmidi-0.0

Any language binding for g-i can handle the gir files to use the the
libraries. For example, PyGObject[4] is available as dynamic g-i loader in
Python 3 runtime, and some Python 3 sample scripts are available in
`samples` directory.

 * https://github.com/alsa-project/alsa-gobject/tree/master/samples

Rust FFI/Safe API crates are provided in alsa-gobject-rs, automatically
generated by gtk-rs/gir[5]. Its README includes code snippet.

 * https://github.com/alsa-project/alsa-gobject-rs

Documentation is available in below URLs. They're auto-generated by
gtk-doc[6] with function annotations:

 * https://alsa-project.github.io/alsa-gobject-docs/

As a design note, the libraries provide API to execute system calls directly
to ALSA core implementation in kernel land. The libraries produce minimal set
of API, and delegate enhanced features to application side. They perform like
'glue' code between application and in-kernel functionalities. This makes it
easy to write test code for the in-kernel functionalities as well as to write 
ehhanced features by each language.

The libraries have no dependency on alsa-lib[7]. The alsa-lib includes own
software features such as configuration space with plug-in system. Although
the plug-in system is useful to add sample operating feature into PCM
interface, it's not necessarily useful for the other interfaces. Furthermore
it's better design to implement enhanced software features in user library and
user application side, instead of common library side. For the above points,
alsa-gobject produces languag bindings different from the existent ones[8][9].

In the release, PCM interface is not supported yet because the 'glue' is
already provided by the other projects; GStreamer[10], PortAudio[11], SDL[12],
and so on. They mostly satisfy the demand, therefore the support is judged not
to be so urgent. It's planned to support PCM interfaces in future release as
'ALSAPcm-0.0'.

Compress-Offload interface is not supported as well because it's difficult to
buy free test device in market as of 2020.

[1] https://www.alsa-project.org/wiki/Miniconf_2018#GObject_introspection
[2] http://www.alsa-project.org/
[3] https://gi.readthedocs.io/
[4] https://pygobject.readthedocs.io/
[5] https://github.com/gtk-rs/gir
[6] https://developer.gnome.org/gtk-doc-manual/
[7] https://git.alsa-project.org/?p=alsa-lib.git;a=summary
[8] https://git.alsa-project.org/?p=alsa-python.git;a=summary
[9] https://github.com/diwic/alsa-rs/
[10] https://gstreamer.freedesktop.org/bindings/
[11] http://www.portaudio.com/
[12] https://www.libsdl.org/languages.php

Regards


Takashi Sakamoto
