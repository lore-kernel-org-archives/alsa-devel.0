Return-Path: <SRS0=qqgH=3Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D0AC2D0DB
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:31:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7ED62467E
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JgTo8E3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7ED62467E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0AC93836;
	Mon, 27 Jan 2020 20:31:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0AC93836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580153516;
	bh=h5v6QfXdE2HCPjE5V/jciJDjjiHjuTWuLuddxNzvuxM=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JgTo8E3SHtCaYqrT429ihJnoZF8d7nI0xa15FUHMMYgWPS+y1zYhOSKMhxfFskSS6
	 kClDY3vcWzAb1hCLAdDYI+okuWTl9iEEdHE4Dthn3vVKWe90pJsDZ4LpfZJz8hJotk
	 ef/UcJKvNFmI36noXDulCq7w5ZCaQGq2SsAiK00w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74BACF80276;
	Mon, 27 Jan 2020 20:28:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE1F2F80253; Mon, 27 Jan 2020 20:28:44 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3445BF800C8
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2020 20:28:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3445BF800C8
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 43175B19B;
 Mon, 27 Jan 2020 19:28:38 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Mon, 27 Jan 2020 20:28:29 +0100
Message-Id: <20200127192831.14057-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200127192831.14057-1-tiwai@suse.de>
References: <20200127192831.14057-1-tiwai@suse.de>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 2/4] ASoC: rt700: Add __maybe_unused to PM
	callbacks
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

Rml4IHRoZSBjb21waWxlIHdhcm5pbmdzIGJ5IGFkZGluZyBfX21heWJlX3VudXNlZCB0byBQTSBj
YWxsYmFja3M6CiAgc291bmQvc29jL2NvZGVjcy9ydDcwMC1zZHcuYzo1MDM6MTI6IHdhcm5pbmc6
IOKAmHJ0NzAwX2Rldl9yZXN1bWXigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWZ1
bmN0aW9uXQogIHNvdW5kL3NvYy9jb2RlY3MvcnQ3MDAtc2R3LmM6NDg5OjEyOiB3YXJuaW5nOiDi
gJhydDcwMF9kZXZfc3VzcGVuZOKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVu
Y3Rpb25dCgpGaXhlczogN2QyYTVmOWFlNDFlICgiQVNvQzogcnQ3MDA6IGFkZCBydDcwMCBjb2Rl
YyBkcml2ZXIiKQpTaWduZWQtb2ZmLWJ5OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+Ci0t
LQogc291bmQvc29jL2NvZGVjcy9ydDcwMC1zZHcuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mv
Y29kZWNzL3J0NzAwLXNkdy5jIGIvc291bmQvc29jL2NvZGVjcy9ydDcwMC1zZHcuYwppbmRleCBh
NGI5NTQyNTg4NmYuLmQ0ZTBmOTUzYmNjZSAxMDA2NDQKLS0tIGEvc291bmQvc29jL2NvZGVjcy9y
dDcwMC1zZHcuYworKysgYi9zb3VuZC9zb2MvY29kZWNzL3J0NzAwLXNkdy5jCkBAIC00ODYsNyAr
NDg2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzZHdfZGV2aWNlX2lkIHJ0NzAwX2lkW10gPSB7
CiB9OwogTU9EVUxFX0RFVklDRV9UQUJMRShzZHcsIHJ0NzAwX2lkKTsKIAotc3RhdGljIGludCBy
dDcwMF9kZXZfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpCitzdGF0aWMgaW50IF9fbWF5YmVf
dW51c2VkIHJ0NzAwX2Rldl9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3Qg
cnQ3MDBfcHJpdiAqcnQ3MDAgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKIApAQCAtNTAwLDcgKzUw
MCw3IEBAIHN0YXRpYyBpbnQgcnQ3MDBfZGV2X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQog
CiAjZGVmaW5lIFJUNzAwX1BST0JFX1RJTUVPVVQgMjAwMAogCi1zdGF0aWMgaW50IHJ0NzAwX2Rl
dl9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQorc3RhdGljIGludCBfX21heWJlX3VudXNlZCBy
dDcwMF9kZXZfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3Qgc2R3X3NsYXZl
ICpzbGF2ZSA9IGRldl90b19zZHdfZGV2KGRldik7CiAJc3RydWN0IHJ0NzAwX3ByaXYgKnJ0NzAw
ID0gZGV2X2dldF9kcnZkYXRhKGRldik7Ci0tIAoyLjE2LjQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
