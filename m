Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F646C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Mar 2022 15:14:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 924D416C7;
	Tue, 22 Mar 2022 16:13:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 924D416C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647962053;
	bh=fPtLeb95MnAJvYrjTDWKhrZcWDaWVGqBMDWswnqr6RU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UhB2eAm77bQa6tafOAJP9sU57KOARSsWriqWGo3DSLOp9wvTlhYreP18CzhShbeUa
	 qFhGJeKVVOcylPr+NNEzfqgyIF9c3o0dgHWmK84MLAlvryLOkxjtG8DgWy/6cUrjHn
	 hlGgXT6plMFm/OzeHRaVBfNcifFI7DwnfnN0Ez64=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BD5DF80548;
	Tue, 22 Mar 2022 16:10:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A690CF8016C; Tue, 22 Mar 2022 08:05:17 +0100 (CET)
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79E33F80116
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2022 08:05:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79E33F80116
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM: 
X-RM-SPAM-FLAG: 00000000
Received: from LAPTOP-39QA2GAC.localdomain (unknown[192.163.20.102])
 by rmsmtp-lg-appmail-10-12088 (RichMail) with SMTP id 2f38623975122ac-7c81b;
 Tue, 22 Mar 2022 15:05:05 +0800 (CST)
X-RM-TRANSID: 2f38623975122ac-7c81b
From: Raphael-Xu <13691752556@139.com>
To: broonie@kernel.org
Subject: [PATCH v3 1/2] Rename tas2764 to tas27xx
Date: Tue, 22 Mar 2022 15:04:37 +0800
Message-Id: <20220322070438.506-1-13691752556@139.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Mar 2022 16:10:02 +0100
Cc: navada@ti.com, alsa-devel@alsa-project.org, shenghao-ding@ti.com,
 raphael-xu@ti.com, Raphael-Xu <13691752556@139.com>
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

Signed-off-by: Raphael-Xu <13691752556@139.com>
---
 sound/soc/codecs/{tas2764.c => tas27xx.c} | 0
 sound/soc/codecs/{tas2764.h => tas27xx.h} | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename sound/soc/codecs/{tas2764.c => tas27xx.c} (100%)
 rename sound/soc/codecs/{tas2764.h => tas27xx.h} (100%)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas27xx.c
similarity index 100%
rename from sound/soc/codecs/tas2764.c
rename to sound/soc/codecs/tas27xx.c
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas27xx.h
similarity index 100%
rename from sound/soc/codecs/tas2764.h
rename to sound/soc/codecs/tas27xx.h
-- 
2.35.1


