Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834ADC43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 01:23:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073D2206DB
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 01:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PcCOWgfe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ImZdu7iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073D2206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5544D83E;
	Mon, 30 Mar 2020 03:22:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5544D83E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585531412;
	bh=a16LLyLLynI/MkO16VZJJpzx3hpFPTgBQC6bIhCFrL8=;
	h=From:To:In-Reply-To:Subject:Date:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PcCOWgfeL2v1HYAclA2xeMESpo2zS3uCiPZ5Ko6HatJ7KRYtiyNkhtqWjiIjlPSuW
	 GOekUkzVqVTKKYFKj5ui9FRDk9N3m9kVs+BjWhjF/PjPQyLOYEAXTvO8ljuTUX3Ci/
	 Ss91FoLQKnkBI2hDWT8NcN6gz8PP709ibKc1BobQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB983F8010C;
	Mon, 30 Mar 2020 03:22:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9EDE1F80148; Mon, 30 Mar 2020 03:22:38 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2366F8010C
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 03:22:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2366F8010C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com
 header.b="ImZdu7iz"
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20200330012227epoutp011b58816dafe5cb55072d64f83da45167~A8FwcDeSC0967109671epoutp01U
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 01:22:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20200330012227epoutp011b58816dafe5cb55072d64f83da45167~A8FwcDeSC0967109671epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1585531347;
 bh=UwqZkCFltakBCqZtWoAlZ+0pCHwHVGC0BKSi3cHXWds=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=ImZdu7izMRX0UqKMrnW8o6HCsaGbbnl1vXcU3DHLFQrMhb7+X93mPv96c9V2XzNws
 D5jrJuXtNRnaXJqHhlttRJm84ON2P4vu91nKP5OSU5n5LjyXXPWOYfUM0STTFadVLa
 sIUc63i08SLrsMHxZVUCBhOwteS0jSzMuEofLkCQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20200330012227epcas2p4af8bcc2ccb50eea5a0df90cc5a024bee~A8FwPd9tK0249302493epcas2p40;
 Mon, 30 Mar 2020 01:22:27 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.191]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 48rF7P4PV3zMqYm1; Mon, 30 Mar
 2020 01:22:25 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 24.24.04024.FC9418E5; Mon, 30 Mar 2020 10:22:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20200330012222epcas2p37827751840f832a4ef042a995291c332~A8FrsazwQ1430014300epcas2p3z;
 Mon, 30 Mar 2020 01:22:22 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200330012222epsmtrp2e429bb0cc4e0a0849a81c5d89a842e81~A8Frrw1m-0174101741epsmtrp20;
 Mon, 30 Mar 2020 01:22:22 +0000 (GMT)
X-AuditID: b6c32a48-5a9ff70000000fb8-aa-5e8149cf1c80
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 7C.6D.04158.DC9418E5; Mon, 30 Mar 2020 10:22:22 +0900 (KST)
Received: from KORDO025540 (unknown [12.36.182.130]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20200330012221epsmtip148b06935fb5cb59da3ed4832608bb3ff~A8FrhJy8h1707317073epsmtip1W;
 Mon, 30 Mar 2020 01:22:21 +0000 (GMT)
From: =?ks_c_5601-1987?B?wMyw5sXD?= <gt82.lee@samsung.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>
In-Reply-To: <000101d6034a$fe37c7a0$faa756e0$@samsung.com>
Subject: RE: [PATCH 1/1] ASoC: soc-compress: lock pcm_mutex to resolve
 lockdep error
Date: Mon, 30 Mar 2020 10:22:21 +0900
Message-ID: <000f01d60631$a96b8b50$fc42a1f0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKAEW77uMNfXLuQv8YtyLDZ4ovWLQHghbSfpv0twdA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmd3d3vT4m1/noIGrz9iJD3WZbU1wUSi2KkgrJCPXmLtPci90Z
 1V8rdTgtU0rCZRZkRVrkY0wrhJqipT2UjEjqD0nDkiJLe8iMNu+C/fedc77vd853focUiBuJ
 eLLMaGUtRkZPE2G4e2CjMvXlrtOF0iY7qCbGPZiqaWqaUP2cqMFUnb/uom24pvPHGUJz3/k+
 RNPd7iA091yv8Tz8sD67lGW0rEXCGktM2jKjTk3vPlCUU6RQSmWpskzVFlpiZAysms7dk5e6
 o0zv60lLjjP6Cl8qj+E4On1rtsVUYWUlpSbOqqZZs1ZvlsnMaRxj4CqMurQSkyFLJpXKFT5m
 sb509MlV3OyhTlS6hjAbckTWIpIEajOcnUusRWGkmOpD0ONtQHzwHcE5l0vABz8R1M2PCWtR
 6IqiudVO8IV+BJU3B3E++IRgzNuO/O8SVBacraP9ghhqOywO2XA/FlDJ8MHbsoJDfZTmcX8H
 koym8mG+utifxql1cMVdhfxYRGWCff4axuMoeNo8HXhGDm0dVzEer4beLy0CfjYJ/Jm5KeTb
 ZoHt4XUBz4mByw77ihmgnhEw2jKH84JcmP99D+NxNHwedoXwOB5+fO0neEElgq/PvYHCRQSO
 OjGPM8B1ZQTj97gGBicDw0VCzcByCJ8WQY09wKaha+RvgA3Q2hnSgGhnkDNnkDNnkDNnkINr
 CG9HcayZM+hYTm7eHPzX3WjlHFM0fejRiz0eRJGIjhB967UVioXMce6kwYOAFNAxImKfLyXS
 MidPsRZTkaVCz3IepPBtvlEQH1ti8h230VokU8iVSmmmQqVQylX0KlF3+NsjYkrHWNlyljWz
 lv86jAyNt6GuVzV70+s9muERR9tO1PqgfnnVpfCFnIQL1XnetbEzzjU7r+dby/ePaNXJBWrh
 x4gbHbO5iz3Ttw9NnnfpUJXbjSXYMtXp70ajGzYc/Vvc4Y5rnhJlREjYpW1xiWOtSer1C9/C
 ozbd/VDwuHhsX6pmNklYID84dEedPDD85tbSMRrnShlZisDCMf8AEu6Ob6QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnO45z8Y4g7nHGS2uXDzEZDH14RM2
 i29XOpgsNnxfy+jA4rHhcxObx85Zd9k9Nq3qZPNYv+UqSwBLFJdNSmpOZllqkb5dAlfG6RPz
 WQoOCVQ0bznG1MDYydfFyMkhIWAiMXNeG1sXIxeHkMBuRol3F7axQSQkJD7MP8MOYQtL3G85
 wgpR9JxR4v3aX0BFHBxsAlYSPd1KIDUiAq4S9/c2gNUzCyhKPP4zhwWivptRYvbJ5UwgCU6g
 +pkXtzCD2MICIRK9a36CLWMRUJWYu62FEcTmFbCUaPu4gAnCFpQ4OfMJC8RQE4nGw91QtrzE
 9rdzmCGOU5D4+XQZK8QRVhINuxczQ9SISMzubGOewCg8C8moWUhGzUIyahaSlgWMLKsYJVML
 inPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYIjRUtrB+OJE/GHGAU4GJV4eD9sb4gTYk0sK67M
 PcQowcGsJMLL5g8U4k1JrKxKLcqPLyrNSS0+xCjNwaIkziuffyxSSCA9sSQ1OzW1ILUIJsvE
 wSnVwLhCsmXKt9OnF17O2rS21Wv+pfkN7Kq71GyeJax2yt/84K9p8npTZqGPZ7t/HL/fZdoV
 cm/tp/le9ovNtQ+WvjjipH3vq2qY7JJAZbXdJqLMKhxCjN1vjLfvlf2xOEvg5qMNxb8XyET5
 zYlNWrDFzIchr5ar9Egym/C2dYn6h4RNe6Ija8/2zFNiKc5INNRiLipOBACgOPDPkAIAAA==
X-CMS-MailID: 20200330012222epcas2p37827751840f832a4ef042a995291c332
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200326084608epcas2p32239121f201613573e7dd86c3172a29f
References: <CGME20200326084608epcas2p32239121f201613573e7dd86c3172a29f@epcas2p3.samsung.com>
 <000101d6034a$fe37c7a0$faa756e0$@samsung.com>
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

On Thu, 26 Mar 2020 17:46:07 +0900,
Gyeongtaek Lee wrote:
>Hi,
>
>I'd like to send a patch to fix a problem in soc-compress with DPCM.
>soc_compr_open_fe() and soc_compr_free_fe() call snd_soc_runtime_activate()
>and snd_soc_runtime_deactivate() but don't lock card->pcm_mutex.
>It can cause lockdep error, because snd_soc_runtime_activate/deactivate()
>checks whether pcm_mutex is held using lockdep_assert_held().
>I'd like to send a patch which adds mutex_lock/unlock()
>before and after of the snd_soc_runtime_activate/deactivate() call.
>If there is anything should be changed in my patch or email,
>please let me know it.
>I'll really appreciate it.
>
>Gyeongtaek Lee (1):
>  ASoC: soc-compress: lock pcm_mutex to resolve lockdep error
>
> sound/soc/soc-compress.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>
>base-commit: 76ccd234269bd05debdbc12c96eafe62dd9a6180
>---
>
>snd_soc_runtime_activate() and snd_soc_runtime_deactivate()
>require pcm_mutex lock.
>
>Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
>---
> sound/soc/soc-compress.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
>index 392a1c5b15d3..42d416ac7e9b 100644
>--- a/sound/soc/soc-compress.c
>+++ b/sound/soc/soc-compress.c
>@@ -207,7 +207,9 @@ static int soc_compr_open_fe(struct snd_compr_stream
*cstream)
> 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_OPEN;
> 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
> 
>+	mutex_lock_nested(&fe->pcm_mutex, fe->pcm_subclass);
> 	snd_soc_runtime_activate(fe, stream);
>+	mutex_unlock(&fe->pcm_mutex);
> 
> 	mutex_unlock(&fe->card->mutex);
> 
>@@ -285,7 +287,9 @@ static int soc_compr_free_fe(struct snd_compr_stream
*cstream)
> 	else
> 		stream = SNDRV_PCM_STREAM_CAPTURE;
> 
>+	mutex_lock_nested(&fe->pcm_mutex, fe->pcm_subclass);
> 	snd_soc_runtime_deactivate(fe, stream);
>+	mutex_unlock(&fe->pcm_mutex);
> 
> 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
> 
>-- 
>2.21.0
>
Hi,

Resending patch with removing tab expansion.

Lee

