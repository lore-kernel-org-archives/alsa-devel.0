From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH] ASoC: tlv320aic23 fix rate selection
Date: Tue, 17 Nov 2009 13:51:01 -0700
Message-ID: <1258491061-11633-1-git-send-email-troy.kisky@boundarydevices.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C9109@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-05.inet.qwest.net (mpls-qmqp-05.inet.qwest.net
	[63.231.195.116])
	by alsa0.perex.cz (Postfix) with ESMTP id D88BF24562
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 21:51:14 +0100 (CET)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C9109@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: anuj.aggarwal@ti.com, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Fix the ordering of sr_valid_mask array.
The lower bit of the index represents USB
not bosr.

Reported-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/codecs/tlv320aic23.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 0b8dcb5..6b24d8b 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -265,8 +265,8 @@ static const int bosr_usb_divisor_table[] = {
 #define UPPER_GROUP ((1<<8) | (1<<9) | (1<<10) | (1<<11)        | (1<<15))
 static const unsigned short sr_valid_mask[] = {
 	LOWER_GROUP|UPPER_GROUP,	/* Normal, bosr - 0*/
-	LOWER_GROUP|UPPER_GROUP,	/* Normal, bosr - 1*/
 	LOWER_GROUP,			/* Usb, bosr - 0*/
+	LOWER_GROUP|UPPER_GROUP,	/* Normal, bosr - 1*/
 	UPPER_GROUP,			/* Usb, bosr - 1*/
 };
 /*
-- 
1.5.6.3
