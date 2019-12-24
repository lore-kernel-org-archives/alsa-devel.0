Return-Path: <SRS0=G//A=2O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E22C2D0CF
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Dec 2019 10:14:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67F620643
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Dec 2019 10:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="isdBnXm2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="h33VJL+y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kjqgelFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67F620643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B5E11699;
	Tue, 24 Dec 2019 11:13:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B5E11699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577182477;
	bh=sJvgUIQivik302Y+o1Q33+BXp/NMPVvi2PQIFmKHwXA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=isdBnXm26NhyJQCoVgyyPGogzqYh1p5L75ibVlPZFSBid0RKCiUBJfHV5LkJ3Ab+l
	 uEM04XH8/8VTXwX7KtaLCxIAKc+zPLl08riZL9diWEeTvO7OFi6AvxSXjHv/YWLsFW
	 AlgObz09vTnrq3gaGvPJelk7DK89VSZFBWSs9VMU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 937B1F80136;
	Tue, 24 Dec 2019 11:13:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 323F2F80138; Tue, 24 Dec 2019 11:13:45 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B87DAF800E3
 for <alsa-devel@alsa-project.org>; Tue, 24 Dec 2019 11:13:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B87DAF800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="h33VJL+y"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="kjqgelFe"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 9820121F18;
 Tue, 24 Dec 2019 05:13:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Tue, 24 Dec 2019 05:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=FYJOBx3/mVPOovdcMeWhsGuhu/C
 grbycCqjG97k9olw=; b=h33VJL+yKBnUoL8ZbZlEHy6BvvmbvDGyU6BOP8xRghJ
 dz5pvdxI3W/hxW9eG/uPaz1y5Y5UuBvdxVuyq9Vqoer6wL8gAf0OY7Xjncpk6n8y
 ZkcU2O0c4wA1KF1FTKg0FIpKJebRlXbFPjLYIEP+1kjugxVuBILqoLk/Lzm+EnwZ
 n+nn6lgbC6nHValo/L2Bzjhxs5fRd7P6/k9rp78B3LBWxtCbpMXnGptc3TrR2Z7f
 LXHa5GaQGmd8da1+Fc0TZv7GtQwz/voBqRA8WwqtVxh/89yxnBeXK2t9iFB2SjAQ
 HTqJRsU18fkH2qWMIj/ElnVorAkIKM8mAtDODtRoQEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FYJOBx
 3/mVPOovdcMeWhsGuhu/CgrbycCqjG97k9olw=; b=kjqgelFeKHak6JdLf9aCNe
 MHRMgsaPyzkhMNA2EhPVaLv1kfAePKYcZXQZCDGFP6mRc7dYP0cZ1y+ip4KxCm+E
 JyUz4+JqGZMWn4V8aRIo6mdpBEEypbjwLuWgT83hn3LFxwoUXIhcTeeCZlAwx+bU
 azBUiM/LKeRpg48Xim0UZ67ZZo8av3uZIOTD9NJzRuFeOR0zR6kcvy7zQXC6mZ6H
 zR5gt4+MfDBaYz5xkTfoz6ZSb0drxqnMEEJQd8hU5PMhulgjetNCSbwUPaHvlLml
 34shZz4nL8qR/WdazMbKCd87Z+kVZ2kOPVHWrXHvpJs88lihqNiP3dEoDBhpCpnw
 ==
X-ME-Sender: <xms:0-QBXhQyFC_pZC8I6_zV8aVhNnl5fUHABETSEvoB8zopW1X4ovekjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddvvddgtdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfgrkhgr
 shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
 hjpheqnecuffhomhgrihhnpehgnhhurdhorhhgnecukfhppedugedrfedrjeehrddukedu
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttg
 hhihdrjhhpnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:0-QBXj8gxOQiwpVkM30CjhnTkJPxFRUZdq0TBA6UNuUNnt-XX_ZuFg>
 <xmx:0-QBXrGHe5Xocx3F8Bx6LlGnru09xFF9BZG01MM1KOLsHk1KSt5dBg>
 <xmx:0-QBXuzOFUZK_wUkCSUG36Xyjj3p7Pi25YWVqxibBd_ZwkjFBShpTw>
 <xmx:0-QBXvdAbk24P1yh8mCHwnXxr8Gv4_Zg9qJafPri0ccHYXoZeR9LoA>
Received: from workstation (ae075181.dynamic.ppp.asahi-net.or.jp [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id 59B023060802;
 Tue, 24 Dec 2019 05:13:38 -0500 (EST)
Date: Tue, 24 Dec 2019 19:13:35 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Rosen Penev <rosenp@gmail.com>
Message-ID: <20191224101335.GB28396@workstation>
Mail-Followup-To: Rosen Penev <rosenp@gmail.com>, alsa-devel@alsa-project.org
References: <20191222025458.745140-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191222025458.745140-1-rosenp@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH] xfer-opitons: Fix -Wformat=2 warnings
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

On Sat, Dec 21, 2019 at 06:54:58PM -0800, Rosen Penev wrote:
> Allows the compiler to check types.
> 
> format string functions expect constant expressions, not constant
> variables.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  axfer/xfer-options.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Reviewd-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

According to reference manual of GCC[1], '-Wformat=2' is a easy helper to
enable below options:
 * -Wformat
 * -Wformat-nonliteral
 * -Wformat-security
 * -Wformat-y2k

Your fix suppresses the warning from '-Wformat-nonliteral'. I'd like
maintainers to revise the title of patch.

[1] https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html


Regards

Takashi Sakamoto
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
