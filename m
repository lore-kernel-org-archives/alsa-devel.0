Return-Path: <SRS0=Lvkp=D6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C99C388F9
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:46:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340C924182
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PX63rIB1";
	dkim=pass (1024-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b="eqnLhk/R";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EvVPuBNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340C924182
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F397017EB;
	Fri, 23 Oct 2020 10:45:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F397017EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603442759;
	bh=B/kFCiDOB7YoYwaC+40aNTXdynI7Wd3pIW3dJheWALE=;
	h=In-Reply-To:References:Date:From:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PX63rIB1yqK8flEdaO6rHjPpBX7rs3DErbWIF3tY0ln5UbBRrr0S5s1cEOTajsOCk
	 yhNoWE5f5ezZwPzwZJlIGL9Jidfyw66nbDfac0ZdldJzwz53ajPJfMyAF9ZrZL6T2Q
	 FYYIhNmZZInQH5dIsSrYKXFoILseLs51QE/5mbBg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F125F80253;
	Fri, 23 Oct 2020 10:45:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8724FF8025A; Fri, 23 Oct 2020 10:45:06 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 662E1F80247
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2020 10:45:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 662E1F80247
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net
 header.b="eqnLhk/R"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="EvVPuBNi"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 7CBE25C0150
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2020 04:45:01 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Fri, 23 Oct 2020 04:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 arunraghavan.net; h=mime-version:message-id:in-reply-to
 :references:date:from:to:subject:content-type; s=mesmtp; bh=5Fao
 fCvW3YsL/KADdh8wtEsakIw8usGrb6un8wzmFSo=; b=eqnLhk/RhQQai/yF/Yfa
 c5P3hbcYtbTJNns7E4eG13vgt6x92ZSQIa+DW0lyViHq4NHYjQDMzZSa2t/t1D4G
 UzBHL25lTr7LIk4G7igftMPPMOSdO+PBdyMo7yFRcTBgCMV+/ewqmjJ9f0MymPne
 lK3ukGz9C0+rw/TdQggXlZs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5FaofC
 vW3YsL/KADdh8wtEsakIw8usGrb6un8wzmFSo=; b=EvVPuBNilw4M4FcX/Cc/s5
 gPgDDE7nvxYDHEnPwoPeRwjGs7bJDEhuDZlctBKIlx6v5Nq7WrD+4BMtIYDNjgXc
 XjSPlHfkmKVKJNmE/eKvXdiiULCetmKiD08u2iv22FVkxhtwIm1D5NBt7RLpyB2Y
 mBQPyGS7U4fP1VakhubezuZ+5wx6YJBw+xbhJlV2Efj0NMocSzhvch3McpIYEito
 8dgwWXt6u8pG2Q3X8mTQ6wkXASQDkW5KPt5uOD2gwSxRLaDc+EUScW9/m8ZPXvNN
 6SSycCPg2oU3+pJHdqKcU4sO/1OpKgzNGGQvfQ2KzLrdsu6MAesRCrXbmrc+Wnnw
 ==
X-ME-Sender: <xms:DJiSX3ZAaelZEG2NPAO2iA39cxUUcuVqqTbW3cbRXLBLQq2BrEoLQw>
 <xme:DJiSX2aSePpSfkA1G3m9mcFmjJe9H1Bz3GgM4evo-2Fgcr2sKFOd-mYE7dtzAMCRA
 ba8AMJ3ICR2ZbF10g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkedtgddtiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesthdtre
 dtreertdenucfhrhhomhepfdetrhhunhcutfgrghhhrghvrghnfdcuoegrrhhunhesrghr
 uhhnrhgrghhhrghvrghnrdhnvghtqeenucggtffrrghtthgvrhhnpefhgfdtvddvveelte
 ffffejgeelfeegheeuvdeviefhvdeuhfduhfeitdehuefffeenucffohhmrghinheprghl
 shgrqdhprhhojhgvtghtrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomheprghruhhnsegrrhhunhhrrghghhgrvhgrnhdrnhgvth
X-ME-Proxy: <xmx:DJiSX59RRlqsNcYMoEV4cx8DO7WSmhJhaad9yEM-iwSA-OYwUsofDw>
 <xmx:DJiSX9oGvQIVRm3dHruZqO7qEbRQZcp3oenrqDnGOd1PLCUl9LFaVA>
 <xmx:DJiSXyqL35fnemS7klyIcD0fIoeISQ-PA3FBCP8O4uxFwDXKIVNL2Q>
 <xmx:DZiSX_0D-ZxQgkK6FDBCWpahM8QL1uCKmXe0bM1846R__tOBtA3x4A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 263FD660069; Fri, 23 Oct 2020 04:44:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-529-g69105b1-fm-20201021.003-g69105b13
Mime-Version: 1.0
Message-Id: <1187b404-ee9f-47ae-90f6-032fb4a23849@www.fastmail.com>
In-Reply-To: <5ba74317-1cc0-80ae-44d9-e9f24c065968@perex.cz>
References: <CAA+gEba8Q+KgZbao+ur2roSpxbwRAQcshbfR6ZQCAr6cXLq4JA@mail.gmail.com>
 <5ba74317-1cc0-80ae-44d9-e9f24c065968@perex.cz>
Date: Fri, 23 Oct 2020 04:42:40 -0400
From: "Arun Raghavan" <arun@arunraghavan.net>
To: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel mailing list / gmail] Re: Excessive bounces
Content-Type: text/plain
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

On Thu, 22 Oct 2020, at 4:03 AM, Jaroslav Kysela wrote:
[...]
> Unfortunately, I cannot do much here. I can assist to fix the issues, but I
> need to know, what I can improve. I suggest to use another e-mail service. It
> seems that google does not care about users now. Or you should ask them what's
> exactly wrong.
> 
> The current postmaster.google.com stats for alsa-project.org:
> 
> User reported spam rate - 0%
> DKIM, DMARC, SFP success rate - all 100%
> Encryption - 100%
> IP reputation - bad
> Delivery errors - 40% - 100%

FWIW, GMail's handling of mailing lists is horrendous enough that I dropped it for more or less all mailing lists. I saw lots of legitimate emails from alsa-devel and gstreamer-devel go to spam.

-- Arun
