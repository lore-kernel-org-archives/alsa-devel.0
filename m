Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5F8C35242
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:22:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 759A120842
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ch4Nepx3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Geu0/VC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759A120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 850DF82C;
	Tue, 11 Feb 2020 21:03:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 850DF82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581451457;
	bh=Zbfjn5YO2jzZOdAaTTo3rz0VWJJCdb+g6DGz1ly6AZ8=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ch4Nepx31gAubR9tUyiHXkClshvtPdu4VcPL5vjvE40rcQj3wI/tlrNj51Vie0V/F
	 L+mHxS/xEjU96PQNWdS8GcMH0vcuH9UTQneNYnR+x3453/q+Gq8c4K0i0OG3WSat6u
	 EEhXEWXYfAZYdkED7XlLcdRY2drOtUVBVQl/0/5o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A0C8F8013E;
	Tue, 11 Feb 2020 21:03:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8A45F80145; Tue, 11 Feb 2020 21:03:24 +0100 (CET)
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com
 [192.185.50.185])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48DB4F8013D
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 21:03:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48DB4F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com
 header.b="Geu0/VC1"
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
 by gateway23.websitewelcome.com (Postfix) with ESMTP id 58D77CDC
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 14:03:16 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id 1bkZjHX4vXVkQ1bkajfs41; Tue, 11 Feb 2020 14:03:16 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
 Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QizRvNIXF5DCCYH7u737lg5G394CbFtXby/EhqCQDuw=; b=Geu0/VC1a9bUnDK6UTB9KqkiDb
 00iQRld7kRim+DS53Mfew6B4tfD75rs5d7hV33SuZJUKAlBhhtA5v19dV0b5rK/hoF9iFJ5Yy6v/D
 Rty6bJrYNpI1JA/ph9yYQ3TAJeCDi+4WLy2Dy67gi0cJiXngA7QhZkyikdbM2IirBJVbCNDV99TdY
 Uuw8dhb4u7Kcfu1c3veFSLBtQwJDRE9SNefXYznkTWyDajHwpEgjC2gQjKhXA5vPgHic5SmaowxEb
 7WrO7VW5d44awiisOW/SPTSncQGo0MSx5YC7s7aT22F3DjPZGZ8FsdpaksTXeZEbRZAXfbp3x3Fu5
 TIdLIjwA==;
Received: from [200.68.140.36] (port=25245 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.92)
 (envelope-from <gustavo@embeddedor.com>)
 id 1j1bkY-001WQz-Cy; Tue, 11 Feb 2020 14:03:14 -0600
Date: Tue, 11 Feb 2020 14:05:49 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Message-ID: <20200211200549.GA12072@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - alsa-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.68.140.36
X-Source-L: No
X-Exim-ID: 1j1bkY-001WQz-Cy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:25245
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [alsa-devel] [PATCH] ASoC: wm0010: Replace zero-length array with
 flexible-array member
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

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertenly introduced[3] to the codebase from now on.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/wm0010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index abd2defe7530..d7a882a6adf2 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -46,7 +46,7 @@ struct dfw_binrec {
 	u8 command;
 	u32 length:24;
 	u32 address;
-	uint8_t data[0];
+	uint8_t data[];
 } __packed;
 
 struct dfw_inforec {
-- 
2.25.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
