Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ED1CA9EA0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:34:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F70D214AF
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nEBfElKI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MUki5QF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F70D214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E7081AE2;
	Mon, 28 Oct 2019 08:33:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E7081AE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572248050;
	bh=hWHZmJVa2GJ+T63cjFSf8GzCUoqun93lDs6zPwywLxE=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nEBfElKImEeVOSR7Cb3aa8mtcObJqMQcHEiV3q2rytZuDYc9V+tUvmmUhKoSktKkc
	 KYWsxiILgLsJqvaagkv6XcbY0O1UpkswU3t5NLZ45W+r0gHEBxkTY4PXVZRvZEL+Qi
	 1p+BaLv6e0YTRExR51RhH2ZQZRY/FX9vxYXnL8ho=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 991F0F802BD;
	Mon, 28 Oct 2019 08:33:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C525EF8036F; Fri, 25 Oct 2019 07:14:13 +0200 (CEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF1BDF802A0
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2019 07:14:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF1BDF802A0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="MUki5QF2"
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46zsj62wkXz9sPh; Fri, 25 Oct 2019 16:14:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1571980442;
 bh=XUnk/aDzI0RoSsU6UPnlmFhYiY8BJtc3RoeNDTw86bM=;
 h=From:To:Cc:Subject:Date:From;
 b=MUki5QF2/NzyA9s6I4tsE0/RhIMRunvvcWUI/eur+Y3/IFtPPa5GAwPuoJQsX84HS
 mnIMlmHusHuUlAZMruibKVWTPQOQ+ej3SD/XamhJyeeWhKmSSM6Uj2JdFYm39w3olA
 xzqHC06myjj6dleKseudkjfXnyAYyneGY+QlR9yrvnQt31J4OKDyt0F620cncHR41v
 i2Y3cI3Ytx1xdjYQ4rDviFhu94UY5i0kwXliphOuklCXrKvmpIjNEoeXmbCjVtc1Em
 F7yArYWGpmOjSVnXff5xvKf/of+78I4EUxYdXTpFBgOSOIBK3CKrCkyO8Tdr+jLgGX
 Bykg0EcXt+WCA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: alsa-devel@alsa-project.org
Date: Fri, 25 Oct 2019 16:13:53 +1100
Message-Id: <20191025051353.2878-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 28 Oct 2019 08:33:18 +0100
Cc: linuxppc-dev@ozlabs.org, broonie@kernel.org,
 kuninori.morimoto.gx@renesas.com
Subject: [alsa-devel] [PATCH] ASoC: fsl: fsl_dma: fix build failure
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Q29tbWl0IDRhYzg1ZGU5OTc3ZSAoIkFTb0M6IGZzbDogZnNsX2RtYTogcmVtb3ZlIHNuZF9wY21f
b3BzIikgcmVtb3ZlZApmc2xfZG1hX29wcyBidXQgbGVmdCBhIHVzYWdlLCBsZWFkaW5nIHRvIGEg
YnVpbGQgZXJyb3IgZm9yIHNvbWUKY29uZmlncywgZWcuIG1wYzg1eHhfZGVmY29uZmlnOgoKICBz
b3VuZC9zb2MvZnNsL2ZzbF9kbWEuYzogSW4gZnVuY3Rpb24g4oCYZnNsX3NvY19kbWFfcHJvYmXi
gJk6CiAgc291bmQvc29jL2ZzbC9mc2xfZG1hLmM6OTA1OjE4OiBlcnJvcjog4oCYZnNsX2RtYV9v
cHPigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCiAgICBkbWEtPmRh
aS5vcHMgPSAmZnNsX2RtYV9vcHM7CiAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn4KClJl
bW92ZSB0aGUgdXNhZ2UgdG8gZml4IHRoZSBidWlsZC4KCkZpeGVzOiA0YWM4NWRlOTk3N2UgKCJB
U29DOiBmc2w6IGZzbF9kbWE6IHJlbW92ZSBzbmRfcGNtX29wcyIpClNpZ25lZC1vZmYtYnk6IE1p
Y2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxlcm1hbi5pZC5hdT4KLS0tCiBzb3VuZC9zb2MvZnNsL2Zz
bF9kbWEuYyB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKClRoaXMgYnJlYWth
Z2UgaXMgb25seSBpbiBsaW51eC1uZXh0LgoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9mc2wvZnNs
X2RtYS5jIGIvc291bmQvc29jL2ZzbC9mc2xfZG1hLmMKaW5kZXggYTA5MjcyNjUxMGQ0Li4yODY4
YzRmOTdjYjIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9mc2wvZnNsX2RtYS5jCisrKyBiL3NvdW5k
L3NvYy9mc2wvZnNsX2RtYS5jCkBAIC05MDEsNyArOTAxLDYgQEAgc3RhdGljIGludCBmc2xfc29j
X2RtYV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCX0KIAogCWRtYS0+ZGFp
Lm5hbWUgPSBEUlZfTkFNRTsKLQlkbWEtPmRhaS5vcHMgPSAmZnNsX2RtYV9vcHM7CiAJZG1hLT5k
YWkub3BlbiA9IGZzbF9kbWFfb3BlbjsKIAlkbWEtPmRhaS5jbG9zZSA9IGZzbF9kbWFfY2xvc2U7
CiAJZG1hLT5kYWkuaW9jdGwgPSBzbmRfc29jX3BjbV9saWJfaW9jdGw7Ci0tIAoyLjIxLjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
