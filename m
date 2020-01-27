Return-Path: <SRS0=qqgH=3Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF58C2D0DB
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:31:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F346924681
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dGIcVBHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F346924681
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55CEF1657;
	Mon, 27 Jan 2020 20:30:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55CEF1657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580153476;
	bh=G2RLY0hgy5R75wa7jm0ZnhfniN9tDA6Dp2bPYW/+xH0=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dGIcVBHTPhdDbLaEATfh6a206F31SY2SOGQ1Za+TeTgtPcOza5A/ongA/u2Ud63Bu
	 Q116/6nWZyV8RGBwHpLUvBEgm0/ksMn3veCrdqmsCa/KRX/yxEjb3Q01LMHZ6oH3qY
	 luqjTBghXnb3ohCAUZ0VJ5rmeZ06tq5L+kE4eUNY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DAB6F80259;
	Mon, 27 Jan 2020 20:28:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C075FF80254; Mon, 27 Jan 2020 20:28:44 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C326F80218
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2020 20:28:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C326F80218
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 33AAFB133;
 Mon, 27 Jan 2020 19:28:38 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Mon, 27 Jan 2020 20:28:28 +0100
Message-Id: <20200127192831.14057-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200127192831.14057-1-tiwai@suse.de>
References: <20200127192831.14057-1-tiwai@suse.de>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 1/4] ASoC: rt1308-sdw: Add __maybe_unused to PM
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
YWxsYmFja3M6CiAgc291bmQvc29jL2NvZGVjcy9ydDEzMDgtc2R3LmM6NjkwOjEyOiB3YXJuaW5n
OiDigJhydDEzMDhfZGV2X3Jlc3VtZeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQt
ZnVuY3Rpb25dCiAgc291bmQvc29jL2NvZGVjcy9ydDEzMDgtc2R3LmM6Njc2OjEyOiB3YXJuaW5n
OiDigJhydDEzMDhfZGV2X3N1c3BlbmTigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2Vk
LWZ1bmN0aW9uXQoKRml4ZXM6IGE4N2E2NjUzYTI4YyAoIkFTb0M6IHJ0MTMwOC1zZHc6IGFkZCBy
dDEzMDggU2RXIGFtcGxpZmllciBkcml2ZXIiKQpTaWduZWQtb2ZmLWJ5OiBUYWthc2hpIEl3YWkg
PHRpd2FpQHN1c2UuZGU+Ci0tLQogc291bmQvc29jL2NvZGVjcy9ydDEzMDgtc2R3LmMgfCA0ICsr
LS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9ydDEzMDgtc2R3LmMgYi9zb3VuZC9zb2MvY29kZWNz
L3J0MTMwOC1zZHcuYwppbmRleCA4YTAzZGJmZTc5MDYuLmQ5MzBmNjBjYjc5NyAxMDA2NDQKLS0t
IGEvc291bmQvc29jL2NvZGVjcy9ydDEzMDgtc2R3LmMKKysrIGIvc291bmQvc29jL2NvZGVjcy9y
dDEzMDgtc2R3LmMKQEAgLTY3Myw3ICs2NzMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNkd19k
ZXZpY2VfaWQgcnQxMzA4X2lkW10gPSB7CiB9OwogTU9EVUxFX0RFVklDRV9UQUJMRShzZHcsIHJ0
MTMwOF9pZCk7CiAKLXN0YXRpYyBpbnQgcnQxMzA4X2Rldl9zdXNwZW5kKHN0cnVjdCBkZXZpY2Ug
KmRldikKK3N0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgcnQxMzA4X2Rldl9zdXNwZW5kKHN0cnVj
dCBkZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3QgcnQxMzA4X3Nkd19wcml2ICpydDEzMDggPSBkZXZf
Z2V0X2RydmRhdGEoZGV2KTsKIApAQCAtNjg3LDcgKzY4Nyw3IEBAIHN0YXRpYyBpbnQgcnQxMzA4
X2Rldl9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikKIAogI2RlZmluZSBSVDEzMDhfUFJPQkVf
VElNRU9VVCAyMDAwCiAKLXN0YXRpYyBpbnQgcnQxMzA4X2Rldl9yZXN1bWUoc3RydWN0IGRldmlj
ZSAqZGV2KQorc3RhdGljIGludCBfX21heWJlX3VudXNlZCBydDEzMDhfZGV2X3Jlc3VtZShzdHJ1
Y3QgZGV2aWNlICpkZXYpCiB7CiAJc3RydWN0IHNkd19zbGF2ZSAqc2xhdmUgPSBkZXZfdG9fc2R3
X2RldihkZXYpOwogCXN0cnVjdCBydDEzMDhfc2R3X3ByaXYgKnJ0MTMwOCA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOwotLSAKMi4xNi40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
