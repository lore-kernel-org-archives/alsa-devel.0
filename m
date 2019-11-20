Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC5DC432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:52:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93096206CC
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Xu6M6+Yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93096206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92DD5173F;
	Wed, 20 Nov 2019 18:51:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92DD5173F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574272358;
	bh=EDuPcEQJSCZfwQYZ3HV5Glfn5PjqOTSjaXSUgodQIMY=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xu6M6+YugF0U1HlBMHckstTX2PIyl/OYSWocbe2kSCNPJpOUnGOZqyXjq1dAsrRHL
	 Td06Nsk/u7EDrsb9qnz6zCBx0DTvqG/3L9uQ+9Syh9erGpvL60SwMCaSuIfM0HbR+f
	 UQJzJMDcg3NdkeFnoYHjpWLZHZR8Rk8ihjMwcrOc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 789E5F8014A;
	Wed, 20 Nov 2019 18:50:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E002F800C1; Wed, 20 Nov 2019 18:50:52 +0100 (CET)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E12E5F800C1
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 18:50:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E12E5F800C1
IronPort-SDR: 75g6dyQHIDxbR8g13CMjnd6U8GtOgQzsAPGMkW8Ox+13qvoqxYl6R1VjR7kRWGdmN1kt82/kzk
 1MLldNlKwNmfYA4ULETRKB3cvJdANI0qXphJVv4eUQsmYwkvHBMq+hVxZ+49WLIF79Nk6O0Ppl
 nh3rdQ5Hh5yYd+QLYijfzYQ3s3k329VTUroBIfNOQBHX7cC0XVVJ966JWMFhADl8kLwkf1zI/a
 lt/d+LyVE/+sNe0RVW4bPJrdsDjpltLvtbrHlyr5QWSSaoOjpk87LIcFPH+h0N939GjRIvXKnf
 I7s=
X-IronPort-AV: E=Sophos;i="5.69,222,1571731200"; d="scan'208";a="43362984"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa3.mentor.iphmx.com with ESMTP; 20 Nov 2019 09:50:48 -0800
IronPort-SDR: qKUm6jxbPObVT9NCkSbPHyK0doNKfHXiPrtKIfFJrofr8o/eIDmDM/hgMve1PbXImAviiOb0yD
 ZZI9B0lSa/3cSDauxLv8Ph072jGC2SeMWlgHEK6p21bVxtyg9YhH6jtYAr3cly3vaqeTKxm7h0
 JJFwPcjgPipN9yfZPix4X+LmCc0GcZ60sDRT6L/ux7jsxGYUYygOD10qA0eHRju84jBQcsUlsF
 RPRuR4ad2AWZT+rTCSoSkzJnlV+p8S7kMJwSACgVUDrgkqbOmUwTPU7d27r6RfNHWbhosbnqae
 wsU=
From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
To: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timo Wischer
 <twischer@de.adit-jv.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>
Date: Wed, 20 Nov 2019 11:49:49 -0600
Message-ID: <20191120174955.6410-2-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120174955.6410-1-andrew_gabbasov@mentor.com>
References: <20191120174955.6410-1-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Subject: [alsa-devel] [PATCH v5 1/7] ALSA: aloop: Describe units of variables
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

From: Timo Wischer <twischer@de.adit-jv.com>

Describe the unit of the variables used to calculate the hw pointer
depending on jiffies ticks.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 54f8b17476a1..573b06cf7cf5 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -102,8 +102,10 @@ struct loopback_pcm {
 	/* flags */
 	unsigned int period_update_pending :1;
 	/* timer stuff */
-	unsigned int irq_pos;		/* fractional IRQ position */
-	unsigned int period_size_frac;
+	unsigned int irq_pos;		/* fractional IRQ position in jiffies
+					 * ticks
+					 */
+	unsigned int period_size_frac;	/* period size in jiffies ticks */
 	unsigned int last_drift;
 	unsigned long last_jiffies;
 	struct timer_list timer;
-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
