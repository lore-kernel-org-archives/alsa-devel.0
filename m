Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4AACD98F2
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:32:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53C32601FF;
	Tue, 23 Jun 2026 13:32:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53C32601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782214370;
	bh=Z8vpsO4qHXIKWC9tFeUjph/orPHMe2JTCIPTVqYVp7M=;
	h=From:To:Subject:Date:References:List-Id:List-Archive:List-Help:
	 List-Owner:List-Post:List-Subscribe:List-Unsubscribe:From;
	b=TPePoymaRrTokpMM3rdxyeDRRuu1RsU6nxVZC9WBJt/uRVRKqbABWguWc6t26O2wp
	 4ko2GIZJC141DcHHIXpaAWyv7ZsdnsTFS7iUIoqfKBC6Nxao6rFO6h9jzjEJH92I5l
	 KXCcHUyREyN4DEWMznIFt0qIHQLa63SzB2tqe59o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 20982F805F9; Tue, 23 Jun 2026 13:32:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D0C31F805FC;
	Tue, 23 Jun 2026 13:32:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0AEB0F80579; Tue, 23 Jun 2026 13:32:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=203.254.224.33
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782214327;
	b=aoSGdXZpE2cxvaFzZ2upuYymkDVTg3tq/ZOJ5qt0Rx7j4RqZuoUJWHWqV3zMRW9Xvkf+
	 WReVoDwQxubwOXxbSJlGJ3xZwzOthJGFM7LKgQWmi2jT0GIBCVCPttyk5xqxobwYLp9CF
	 WCZqyRwTIKA3TJaV8Mxhi4muqFN7senCMpxs3nKKgAE/7mQJKbRTnGhVl6tN4Q12FptEL
	 WPpXQX5d8p10oZr8FHqjlOM2DLKG5ztDSSEye6TH0JmhdWk8Sk3fndA0qpdps+CQiDS7o
	 KJeGQjOSOkQE2F8Ql84oYXFjGuWhMuHHZk1jFUGXqx55fAjIhiTfkvQyHMFLYC6Fx2w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782214327;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Z8vpsO4qHXIKWC9tFeUjph/orPHMe2JTCIPTVqYVp7M=;
	b=p5wNDE02LLVUUPFJdmVhuzX+cdhWd5fJqN7EutLOdWTt+VsDFWSsO/TezVM6V86gB6Rj
	 JCekbU8dSB6aGfZE5DJ200uhuNvgqbkCTGl8mpoASnR/gYxX9JK+1Fj/mmn/Pe043K+IL
	 LPqio8NazTZh3mMWIlAw6Cem0oksXc/lPl/Z+hvvS14x8yfm1Ol1avvuF2TboCoCf64/t
	 mbKp9/xHilj9lXqPrz3SNsThPMDeob4NaYPQv338ny0bdsl5Gad/cDQkWANqU4debbF62
	 bQde1X47nY8RQnbf8ZKQrbqsCdy6/Tr+M/0byOWVc22zRBOE/vKN3CaIwD7geJelpLA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256
 header.s=mail20170921 header.b="K99V/FLM";
	arc=none smtp.remote-ip=203.254.224.33
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E88D3F8045D
	for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2026 13:32:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E88D3F8045D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256
 header.s=mail20170921 header.b=K99V/FLM
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20260623113159epoutp039b988bacb19bd80d2dc097589565f9b5~7snsRadub0896108961epoutp03g
	for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2026 11:31:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20260623113159epoutp039b988bacb19bd80d2dc097589565f9b5~7snsRadub0896108961epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782214319;
	bh=JEYi2D1GLvPf4odr9/dzVmsd6aC0R8e0ueT/xRCCMu4=;
	h=From:To:Subject:Date:References:From;
	b=K99V/FLMBhF+9COXooGqWIIs5x7v3g7wIE/AbNq7lrIj7puFGQzPg86dIVPUP/k2u
	 XqoHVA1vkVXV+2YQO0w1khLwwlsM7/P5aMLrkHjZcXmBIVctN3wAh7hxUCukKHIhGU
	 sfJAlEUBpo5kPnYjqjMPXCb7tWddatYNt3xYGpmQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20260623113158epcas2p4060b5a446fd19cf7edf6125e3cae2bfd~7snr5P08F1615516155epcas2p4P;
	Tue, 23 Jun 2026 11:31:58 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.207]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4gl2wG2Tcbz6B9m8; Tue, 23 Jun
	2026 11:31:58 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20260623113157epcas2p24944f3b44efb5b5c771d502148ad8e23~7snq8GUtB1314613146epcas2p2Y;
	Tue, 23 Jun 2026 11:31:57 +0000 (GMT)
Received: from KORDO035882 (unknown [12.80.201.209]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20260623113157epsmtip16d0a1dc575e84a11958b14c8a856512b~7snq6UON53180131801epsmtip1H;
	Tue, 23 Jun 2026 11:31:57 +0000 (GMT)
From: "Shinhyung Kang" <s47.kang@samsung.com>
To: <alsa-devel@alsa-project.org>, <broonie@kernel.org>, <tiwai@suse.de>
Subject: [PATCH v2] ASoC: soc-compress: fix UAF in soc_compr_trigger_fe()
Date: Tue, 23 Jun 2026 20:31:57 +0900
Message-ID: <086101dd0303$e6702f80$b3508e80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ad0DA3LfEeu35P4eTXGqOpuiwDSk6A==
Content-Language: ko
X-CMS-MailID: 20260623113157epcas2p24944f3b44efb5b5c771d502148ad8e23
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260623113157epcas2p24944f3b44efb5b5c771d502148ad8e23
References: 
 <CGME20260623113157epcas2p24944f3b44efb5b5c771d502148ad8e23@epcas2p2.samsung.com>
Message-ID-Hash: 26QNS2RLSAD4T5JRKC422H73HKAM3UXI
X-Message-ID-Hash: 26QNS2RLSAD4T5JRKC422H73HKAM3UXI
X-MailFrom: s47.kang@samsung.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/26QNS2RLSAD4T5JRKC422H73HKAM3UXI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The DPCM compress trigger path traverses the FE's BE client list in
dpcm_be_dai_trigger() without holding card->pcm_mutex, while
dpcm_be_disconnect() can concurrently remove and free entries from
that same list under pcm_mutex protection.

This causes a use-after-free when for_each_dpcm_be() advances to the
next list node after releasing a BE's stream lock between iterations,
and the snd_soc_dpcm entry has already been kfree()'d by a concurrent
dpcm_be_disconnect() call.

Crash signature observed:
 Unable to handle kernel paging request at virtual address dead0000000000e8
 Call trace:
  dpcm_be_dai_trigger+0x90/0x3f0
  soc_compr_trigger_fe+0xa8/0x144
  snd_compr_ioctl+0xc98/0x2010

Race condition timeline:
Thread A(soc_compr_trigger_fe):
 snd_soc_card_mutex_lock()        <- holds card->mutex only
   dpcm_be_dai_trigger()
    for_each_dpcm_be(fe, stream, dpcm) {
	  snd_pcm_stream_lock_irqsave_nested(be_substream);
	  ...
	  snd_pcm_stream_unlock_irqrestore(be_substream);
	  /* WINDOW: next iteration reads dpcm->list_be.next */
	}

Thread B(snd_soc_dpcm_runtime_update via DAPM):
 snd_soc_dpcm_mutex_lock()        <- holds card->pcm_mutex
  dpcm_be_disconnect()
	snd_pcm_stream_lock_irq(fe_substream);
	list_del(&dpcm->list_be);      <- removes from list
	snd_pcm_stream_unlock_irq();
	kfree(dpcm);                   <- frees the struct

The PCM trigger path (dpcm_fe_dai_trigger) is protected against this
race by checking runtime_update and deferring to trigger_pending when
a concurrent update is in progress. The compress trigger path
(soc_compr_trigger_fe) lacks this deferred-trigger mechanism, so the
only correct fix is to hold pcm_mutex for the duration of the BE list
traversal, as is done in all other compress FE operations such as
soc_compr_open_fe() and soc_compr_set_params().

Signed-off-by: Shinhyung Kang <s47.kang@samsung.com>

---
Changes in v2:
   - Reworded commit message for clarity.
   - Resend due to mail client corruption in v1.
   - No functional changes.

  Link to v1:
https://lore.kernel.org/alsa-devel/000e01dcf3ef$15d69530$4183bf90$@samsung.c
om
---
 sound/soc/soc-compress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index b8402802ae78..615ce7a0e8d9 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -285,6 +285,7 @@ static int soc_compr_trigger_fe(struct snd_compr_stream
*cstream, int cmd)
 		return snd_soc_component_compr_trigger(cstream, cmd);
 
 	snd_soc_card_mutex_lock(fe->card);
+	snd_soc_dpcm_mutex_lock(fe);
 
 	ret = snd_soc_dai_compr_trigger(cpu_dai, cstream, cmd);
 	if (ret < 0)
@@ -315,6 +316,7 @@ static int soc_compr_trigger_fe(struct snd_compr_stream
*cstream, int cmd)
 
 out:
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
+	snd_soc_dpcm_mutex_unlock(fe);
 	snd_soc_card_mutex_unlock(fe->card);
 	return ret;
 }
-- 
2.21.0

