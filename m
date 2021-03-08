Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AB6C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 12:59:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69FF46518F
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 12:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FF46518F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1562817AA;
	Mon,  8 Mar 2021 13:58:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1562817AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615208370;
	bh=Aj/RmNB9bg1JwHjFQDvNCNmh4qssBi1OKACGeEpiJRQ=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J0DycEXexQMYaN2AqgKGX9896H4OJ5lGLdlGkw8uoCyVsLvVB8T/wN+zxShBPGkhC
	 7GpFSomVe3SCl32lLaGe16pJmJPKDj4IZeZKPJ0DSb8wg2TZ8RAnWDF137cOsrvLcA
	 g3e27U2HtBwQ35Tr17UQsNf+/iJV6+aZNyAlDH4s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F337F8016C;
	Mon,  8 Mar 2021 13:58:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA3FFF801D8; Mon,  8 Mar 2021 13:58:37 +0100 (CET)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01C3CF800D0
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 13:58:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01C3CF800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="HntoVDIu"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="MdFdBpqo"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id B2DA8265A;
 Mon,  8 Mar 2021 07:58:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 08 Mar 2021 07:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=fm1; bh=Aj/RmNB9bg1JwHjFQDvNCNmh4qssBi1OKACGeEpiJRQ=; b=HntoV
 DIuiHH8tKqaynp1Q55yipZC60XMusF3Wm+KS22N/kVb4CSYOEpKcoH70/ZLVJl5t
 VBjfhWYIOgLoVGjLXJJj+DUHaK1Zbe22x3RfgDmCM/WA1k17+XW8SrgxzHmtRTcz
 nXyQikBtlT0U+rN/Rz/PsK/4QED7B0nQlD71s17PI4T3bgueu54ObF/zjayW8oUi
 KEBSo5p0WKlSjbveYjQr4VzsuwMku/E4lkmIJakyleM9TFk8bnJTna0rEoUKHpXg
 m7qZVs92vsUuJcJIHHwi+P3t0srdHsFTCnlzfKWukpSFSLabo2a4+aWzEL7SzJLp
 EBuel/cVyOCr8XuVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:message-id
 :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; bh=Aj/RmNB9bg1JwHjFQDvNCNmh4qssB
 i1OKACGeEpiJRQ=; b=MdFdBpqo5ppiJKOiwAGqr2ty8HpyHFUhlkC+kMRLjbXA7
 D9IA6MrmRypSDu1x1/rkgT0CO7Bc9pWylFcnEOrKp8ZEepZRfS8sj2TVuqoCSE2g
 R5gAsQrm+mXTg9++Xh+cRwBqhwqMNkMLxEx5JYD577hlN5fl9Z5FJlDoXo2Q7bJw
 Gb8OsBciRzLehTvPB3SzInJgmD1tYzRwydxuLlPMNniCX4N4xw2uFC9KFVXdXVZ2
 09LhjjS6mUq7mqf1IpG+MNq4lQ11RS3lpb1SFvzKNBSZVoWJRkxo/KnX5iq9XhZf
 hurIohxYjQumxD0XyrYWOog14ApdPfH0qgx4tJ2/w==
X-ME-Sender: <xms:bB9GYI8YmT-u9bbxxQGT5Ap59jZwX-jFMSmDqBks0G2fo5lNJn20yw>
 <xme:bB9GYAsLCo6LBy89NRYBEY3xaHnl5d6Fuz01pz6kz-mdEHRZuTeTetdIfHBpa23Gx
 p0697fIX6GtlzNHp7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudduvddgfeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtredttd
 dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepudeghefgtdettd
 duhfdugeevueefgffhgeevkeeiffdukedugffggeetgfffleffnecuffhomhgrihhnpehg
 ihhthhhusgdrtghomhenucfkphepudegrdefrdeihedrudejheenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghk
 rghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:bB9GYODtti_zWCk5gr_RKK0JwG4CNNw4LfzpwqfB1zgRoFWj0IJRYg>
 <xmx:bB9GYIf0_XmkyfYsUWMfNTOU2m9tX4vqUr2O77JJQTSnaJiMOzblmA>
 <xmx:bB9GYNMritU4WhvJLzipGmTEOh_qAjiHAhkSasSoARP5y2RiBctYOg>
 <xmx:bR9GYEZ0gmnRotghaUYqnnPgvQBM0VItrSPcpOOvwmlFBc3zld7cNQ>
Received: from workstation (ae065175.dynamic.ppp.asahi-net.or.jp [14.3.65.175])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1251424005D;
 Mon,  8 Mar 2021 07:58:19 -0500 (EST)
Date: Mon, 8 Mar 2021 21:58:17 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: perex@perex.cz
Subject: alsa-lib's new API issue (snd_ctl_elem_id_compare)
Message-ID: <20210308125817.GA212288@workstation>
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

I have some concern about your commit 2cfe6addaef6[1] for alsa-lib,

It adds new library API, 'snd_ctl_elem_id_compare()', to compare a pair of
IDs for control element. In the implementation, the API call returns 0 if
they are the same, else negative or positive numeric value according to
contents of the IDs.

My concerns are:

1. evaluation of numid field is not covered.

This is not preferable since ALSA control core implementation covers two
types of comparison; numid only, and the combination iface, device,
subdevice, name, and index fields. If the API is produced for general use
cases, it should correctly handle the numid-only case, in my opinion.

2. tri-state return value is semantically inconsistent

The ID structure includes three types of values; integer, enumeration, and
string. In my opinion, tri-state return value from them has different meaning
each other. It's better just to return comparison result by boolean value,
in my opinion.

The reason I post this message instead of posting any fix is that the fix
to the API affects to alsa-utils, in which the API is used by a patch you
applied a few days ago[2]. The patch also includes change to 'AM_PATH_ALSA'
declaration in configure.ac with bumped-up version to '1.2.5', and it
disables to rebuild alsa-utils on the latest toolchain. (alsa-lib 1.2.5 is
not released yet.)

I'd like to drop the usage of API from alsa-utils with equivalent
alternative codes in alsa-utils side at first, apart from the new API in
alsa-lib so that alsa-utils can be still build on the latest toolchains to
avoid any confusion in user side. Then I'd fix the issued API carefully
so that it can be used so long as exposed API without any issue.

[1] https://github.com/alsa-project/alsa-lib/commit/2cfe6addaef6a0afa72699ec07a45e7f2fa445ba
[2] https://github.com/alsa-project/alsa-utils/commit/17b4129e6c89d1a96d4d86dabea38389927e3cf4


Regards

Takashi Sakamoto
