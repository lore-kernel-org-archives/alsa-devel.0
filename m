Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFD0C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 07:07:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 849E416DA;
	Tue, 12 Apr 2022 09:06:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 849E416DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649747258;
	bh=0q+IaaUoHpY9M31qHkIJPOSI6zMbZOTod5BoLUgD7rE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KXiak0BpdrX4UgkWT6VDhkFWBgFWC2sW3sGutT3S9Cingn0oJ0wRdgNf1aVmC++o5
	 B+WvX0nbTJ3so+d8zjdE3koOszQcG8J+DfUD2vsZqPgtOYLGFoK1L1E3jTU0uMIFn7
	 EF7wuDD/pWtM33XIcKoNh/YaZpb5JmQJFH5Ulq6E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 179C5F80154;
	Tue, 12 Apr 2022 09:06:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BBB9DF80245; Tue, 12 Apr 2022 09:06:46 +0200 (CEST)
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2DD4F8011C
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 09:06:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2DD4F8011C
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM: 
X-RM-SPAM-FLAG: 00000000
Received: from LAPTOP-39QA2GAC.localdomain (unknown[117.136.33.170])
 by rmsmtp-lg-appmail-23-12026 (RichMail) with SMTP id 2efa625524ed33a-97a11;
 Tue, 12 Apr 2022 15:06:35 +0800 (CST)
X-RM-TRANSID: 2efa625524ed33a-97a11
From: Raphael-Xu <13691752556@139.com>
To: broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v2 1/2] rename tas2764 to tas27xx
Date: Tue, 12 Apr 2022 15:06:20 +0800
Message-Id: <20220412070621.4513-1-13691752556@139.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

rename tas2764.yaml to tas27xx.yaml

Signed-off-by: Raphael-Xu <13691752556@139.com>
---
 .../devicetree/bindings/sound/{tas2764.yaml => tas27xx.yaml}      | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/sound/{tas2764.yaml => tas27xx.yaml} (100%)

diff --git a/Documentation/devicetree/bindings/sound/tas2764.yaml b/Documentation/devicetree/bindings/sound/tas27xx.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/sound/tas2764.yaml
rename to Documentation/devicetree/bindings/sound/tas27xx.yaml
-- 
2.35.1


