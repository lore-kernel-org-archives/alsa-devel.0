Return-Path: <SRS0=H50z=GA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EB2C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 12:19:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B151920867
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 12:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B151920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 423361706;
	Mon, 28 Dec 2020 13:18:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 423361706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609157945;
	bh=PwRLMvJHAUwCjlDQgTiSqtXT16/6gII85ctLNdFXxFI=;
	h=From:To:In-Reply-To:Subject:Date:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i5prUl1EMhZXBjeduKzlnYG4EeWDRPxZL5vzHzX/PKsiDp6UsPuVCXMJ5avsogXFN
	 9LeJKSuSJDjHMqo22+enDDLHqAMHko+lfbi8UVyjX3uNudrRbC3eQUdW9jKQg/2RQu
	 W5pE8AQZ6v9s2k9zMpCjhn2qZ0e0r3gQbh02VHyg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA86AF801ED;
	Mon, 28 Dec 2020 13:18:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8FC0DF801F5; Mon, 28 Dec 2020 13:18:13 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C14FCF80169
 for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2020 13:18:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C14FCF80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com
 header.b="bvGVnxnh"
Received: from epcas3p3.samsung.com (unknown [182.195.41.21])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20201228121801epoutp0221b1eabd678f2280d4c86380a03423ec~U4JFfl1YW0301703017epoutp02s
 for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2020 12:18:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20201228121801epoutp0221b1eabd678f2280d4c86380a03423ec~U4JFfl1YW0301703017epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1609157881;
 bh=6mjmvTKYi5n8uE/b9GzEfeO2rilVfByLM24p6DFxT5w=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=bvGVnxnhDbTIUUilD+PyTtzSAkWsKrfaUjT2x5ohL7oEvu/igeuBJLP3E8AomEywN
 9b36kn45/s4OZx0y24fmort4FqnOAUlCNCDl1LdLb9vc04EaLpq5ImdsMdUHpm9Rhz
 66pNWMsCbTwzpQr3zxXh9aOn9TzRG+ZoEBC311oY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas3p4.samsung.com (KnoxPortal) with ESMTP id
 20201228121801epcas3p435241b53c07e16da7f15708e0a71bda4~U4JFJYK9L3178131781epcas3p4w;
 Mon, 28 Dec 2020 12:18:01 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp2.localdomain
 (Postfix) with ESMTP id 4D4Gls3Bxzz4x9Pp; Mon, 28 Dec 2020 12:18:01 +0000
 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20201228112316epcas2p3b726099ef37e66e63d1134923e791906~U3ZSGrHNk0616906169epcas2p3E;
 Mon, 28 Dec 2020 11:23:16 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20201228112316epsmtrp1d50851a318a5ebfdf81d66d7062ab31a~U3ZSFwVJW1792317923epsmtrp13;
 Mon, 28 Dec 2020 11:23:16 +0000 (GMT)
X-AuditID: b6c32a2a-755ff70000002229-bd-5fe9c02499ed
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 BD.47.08745.420C9EF5; Mon, 28 Dec 2020 20:23:16 +0900 (KST)
Received: from KORDO025540 (unknown [12.36.182.130]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20201228112316epsmtip2c3e88bb678477b413065205f9bcf1fd1~U3ZR3vCkt1446414464epsmtip2i;
 Mon, 28 Dec 2020 11:23:16 +0000 (GMT)
From: "Gyeongtaek Lee" <gt82.lee@samsung.com>
To: "'Kuninori Morimoto'" <kuninori.morimoto.gx@renesas.com>,
 <broonie@kernel.org>, <cpgs@samsung.com>
In-Reply-To: 
Subject: [PATCH v3 1/1] ASoC: dpcm: acquire dpcm_lock in dpcm_do_trigger()
Date: Mon, 28 Dec 2020 20:23:16 +0900
Message-ID: <1891546521.01609157881415.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdbJUefzWBsBwqKdQFqEbWIOCt4/TAIohdnAAsXlGqA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvK7KgZfxBm3ndC2uXDzEZDH14RM2
 i5eHNC3u/jC3mLGtm8Wi8d4ENovVV7cwWbw6vIvR4tuVDiaLX/+fMVkcvbiYyaLhbjO7xcvN
 b5gsjjROYXLg89jwuYnNY+esu+wem1Z1snnMOxno8e3MRBaPvi2rGD02n64OYI/isklJzcks
 Sy3St0vgyjj16SpbwQOjikMX7rM2MP7X6GLk5JAQMJGYdPU4SxcjF4eQwA5Gie2ndjBBJCQk
 Psw/ww5hC0vcbznCClH0nFFi5d0bjCAJNgFdiS/37jCD2CICWRIv/99lBiliFnjHJDFxzUcW
 kISQAI/Eqw37gRo4ODgFeCUm/LMGCQsLeEk8fPyHDcRmEVCVWP2lFczmFbCU+P/5CiOELShx
 cuYTFpBWZgE9ibaNYGFmAXmJ7W/nMEPcpiDx8+kyVogTrCS2H3rPAlEjIjG7s415AqPwLCST
 ZiFMmoVk0iwkHQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgTHp5bWDsY9qz7o
 HWJk4mA8xCjBwawkwvuJ5Xm8EG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NT
 C1KLYLJMHJxSDUwMb174pzFLT1N8OOWPxJT1Fw8+fun4QG9B6OMbHQ9fHGBxX2kme2k+p/ya
 FL0V08LesKpt3rFx/7Mvu926iv3abOLWTzjod+4xV1flyWf5PPM33K0sZv1QKRff724RLz3X
 Km6e+uQUyzXL4lTmbjZ+ryq8vrU2dpqyyjFzvsU/+7btv+XAfCrikc7zV1H/7S/+//EveL6I
 Hd9tX/H47i+nD2TK16085zTH7ZDDnzV8j2+rKnSuWJJ+WVZ9g4Sa6vP3hSraB/XVE2TWTRb4
 fmWugTU/X2Lwukvlws/e81zInmDA4+K2a1p5zv7FbP8KZWTF315seNh8+U6p1aNlmw5cu3zz
 tU9Ljl/+UafFjP2RSizFGYmGWsxFxYkA88YQxD4DAAA=
X-CMS-MailID: 20201228112316epcas2p3b726099ef37e66e63d1134923e791906
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20201228112316epcas2p3b726099ef37e66e63d1134923e791906
References: <CGME20201228112316epcas2p3b726099ef37e66e63d1134923e791906@epcas2p3.samsung.com>
Cc: alsa-devel@alsa-project.org, khw0178.kim@samsung.com, 'Takashi
 Iwai' <tiwai@suse.de>, lgirdwood@gmail.com,
 'Pierre-Louis Bossart' <pierre-louis.bossart@linux.intel.com>,
 kimty@samsung.com, donggyun.ko@samsung.com, hmseo@samsung.com,
 cpgs@samsung.com, s47.kang@samsung.com, pilsun.jang@samsung.com,
 tkjung@samsung.com
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

If stop by underrun and DPCM BE disconnection is run simultaneously,
data abort can be occurred by the sequence below.

CPU0					CPU1
dpcm_be_dai_trigger():			dpcm_be_disconnect():

for_each_dpcm_be(fe, stream, dpcm) {

					spin_lock_irqsave(&fe->card->dpcm_lock, flags);
					list_del(&dpcm->list_be);
					list_del(&dpcm->list_fe);
					spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
					kfree(dpcm);

struct snd_soc_pcm_runtime *be = dpcm->be; <-- Accessing freed memory

To prevent this situation, dpcm_lock should be acquired during
iteration of dpcm list in dpcm_be_dai_trigger().

Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
Cc: stable@vger.kernel.org
---
 sound/soc/soc-pcm.c | 62 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index dcab9527ba3d..7c5d950a8628 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2073,6 +2073,9 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
+		struct snd_soc_pcm_runtime *be, int stream);
+
 static int dpcm_do_trigger(struct snd_soc_dpcm *dpcm,
 		struct snd_pcm_substream *substream, int cmd)
 {
@@ -2092,8 +2095,10 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			       int cmd)
 {
 	struct snd_soc_dpcm *dpcm;
+	unsigned long flags;
 	int ret = 0;
 
+	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_be(fe, stream, dpcm) {
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
@@ -2113,7 +2118,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 
 			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
 			if (ret)
-				return ret;
+				break;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
@@ -2123,7 +2128,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 
 			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
 			if (ret)
-				return ret;
+				break;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
@@ -2133,7 +2138,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 
 			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
 			if (ret)
-				return ret;
+				break;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
@@ -2142,12 +2147,12 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				continue;
 
-			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+			if (!dpcm_can_be_free_stop(fe, be, stream))
 				continue;
 
 			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
 			if (ret)
-				return ret;
+				break;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
 			break;
@@ -2155,12 +2160,12 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
 				continue;
 
-			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+			if (!dpcm_can_be_free_stop(fe, be, stream))
 				continue;
 
 			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
 			if (ret)
-				return ret;
+				break;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_SUSPEND;
 			break;
@@ -2168,17 +2173,20 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
 				continue;
 
-			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+			if (!dpcm_can_be_free_stop(fe, be, stream))
 				continue;
 
 			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
 			if (ret)
-				return ret;
+				break;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
 			break;
 		}
+		if (ret)
+			break;
 	}
+	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 	return ret;
 }
@@ -2916,10 +2924,9 @@ static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
 	struct snd_soc_dpcm *dpcm;
 	int state;
 	int ret = 1;
-	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+	lockdep_assert_held(&fe->card->dpcm_lock);
 	for_each_dpcm_fe(be, stream, dpcm) {
 
 		if (dpcm->fe == fe)
@@ -2933,17 +2940,12 @@ static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
 			}
 		}
 	}
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 	/* it's safe to do this BE DAI */
 	return ret;
 }
 
-/*
- * We can only hw_free, stop, pause or suspend a BE DAI if any of it's FE
- * are not running, paused or suspended for the specified stream direction.
- */
-int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
+static int dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream)
 {
 	const enum snd_soc_dpcm_state state[] = {
@@ -2954,6 +2956,23 @@ int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 
 	return snd_soc_dpcm_check_state(fe, be, stream, state, ARRAY_SIZE(state));
 }
+
+/*
+ * We can only hw_free, stop, pause or suspend a BE DAI if any of it's FE
+ * are not running, paused or suspended for the specified stream direction.
+ */
+int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
+		struct snd_soc_pcm_runtime *be, int stream)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+	ret =  dpcm_can_be_free_stop(fe, be, stream);
+	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_free_stop);
 
 /*
@@ -2963,6 +2982,9 @@ EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_free_stop);
 int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream)
 {
+	unsigned long flags;
+	int ret;
+
 	const enum snd_soc_dpcm_state state[] = {
 		SND_SOC_DPCM_STATE_START,
 		SND_SOC_DPCM_STATE_PAUSED,
@@ -2970,6 +2992,10 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 		SND_SOC_DPCM_STATE_PREPARE,
 	};
 
-	return snd_soc_dpcm_check_state(fe, be, stream, state, ARRAY_SIZE(state));
+	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+	ret = snd_soc_dpcm_check_state(fe, be, stream, state, ARRAY_SIZE(state));
+	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_params);
-- 
2.21.0



