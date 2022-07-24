Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59DECCA473
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jul 2022 06:27:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B66D84C;
	Mon, 25 Jul 2022 08:26:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B66D84C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658730452;
	bh=ZOflmkW4RvkZAjv1dvIJg/i8/vP3xgYrHmirOyfDHd4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Qd1BgQ3u1gB0L+ezw0+uUBeXtq97/MMu1n2KTsUDhqcTlhn8cbWx362YUqgmdXedl
	 6YWBvFjngE/mdSnDxIt7H13jaBGR3s0zKdDtVY9qlQUGpI/sDymEH+U6adAzvh0wtb
	 +n+cx/ehmMfjumdBfq4AsJY9SaWQI9e/8i/+ZM1A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67C7FF804FD;
	Mon, 25 Jul 2022 08:25:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49E1FF8016A; Sun, 24 Jul 2022 09:14:36 +0200 (CEST)
Received: from smtpbg.qq.com (unknown [43.155.67.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42643F8012B
 for <alsa-devel@alsa-project.org>; Sun, 24 Jul 2022 09:14:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42643F8012B
X-QQ-mid: bizesmtp82t1658646861tfpjqeg1
Received: from localhost.localdomain ( [125.70.163.183])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 24 Jul 2022 15:14:20 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: 7jw2iSiCazp69tT+f4E81zq3rVd3a8D7IVyLs5HY8A4DQ/X7/uaB5yXKiVA/v
 KRsmFd0ppSx/eKWTZk2TReA+YL2fM2ubRaX0m1D9vM3g8FGiV9L5hommEhDI+QVaoKwbhC8
 J7jxJQJhOtgP/r4JTeMwFm8mE5jzTvgVniVnRPeE9KNFc/IfyawuWnNmW7aSacIDZur4PJb
 Tl/JIYOJ6yUYhq3cur+hvdFtPi5NmRlJE1f+u89gvvDfVrUIUsnhnvwzIsTSpDXwk4ss9Pj
 R8RFaAarlN/JJCm+S/xgjeaK9hQdktRknl5oxVQN9oK+GXgn3JakkNYCsDTbp1ltHt0RffK
 bmVC/6dsQZ7AnMjvW+A9cWMpQNWOYCJRF/Q2rYKkjrE9Tm2QeY=
X-QQ-GoodBg: 0
From: wangjianli <wangjianli@cdjrlc.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] pci/asihpi: fix repeated words in comments
Date: Sun, 24 Jul 2022 15:14:13 +0800
Message-Id: <20220724071413.10085-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Mailman-Approved-At: Mon, 25 Jul 2022 08:25:50 +0200
Cc: wangjianli <wangjianli@cdjrlc.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 sound/pci/asihpi/hpi6000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/hpi6000.c b/sound/pci/asihpi/hpi6000.c
index aa4d06353126..88d902997b74 100644
--- a/sound/pci/asihpi/hpi6000.c
+++ b/sound/pci/asihpi/hpi6000.c
@@ -388,7 +388,7 @@ void HPI_6000(struct hpi_message *phm, struct hpi_response *phr)
 /* SUBSYSTEM */
 
 /* create an adapter object and initialise it based on resource information
- * passed in in the message
+ * passed in the message
  * NOTE - you cannot use this function AND the FindAdapters function at the
  * same time, the application must use only one of them to get the adapters
  */
-- 
2.36.1

