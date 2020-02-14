Return-Path: <SRS0=Q+Fc=4C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1E4C2BA83
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:14:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A61A246C0
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="E8H+hHoJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsgzfMGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A61A246C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B824F166C;
	Fri, 14 Feb 2020 17:13:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B824F166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581696855;
	bh=cBIHMNe4Yfufalcje8h0rEccB0qEiFzrIO0HCxE9npQ=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E8H+hHoJKF7KlrWTpLAHfC785Upz4wpqgWyC4VRZiLrkqqhtdSaSGSQbrWBUCXgS7
	 mcl2HxWYrU38a8qYxG4g+Z2som4suNVkhWirxEfYLhVkrN28kjIeYdsX96FuUs/BML
	 ZkiNgGEIf6aUPulyB+DlFJXuZ6SKmGnC1KtyhpcQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5343FF802E9;
	Fri, 14 Feb 2020 17:08:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51EF1F802EA; Fri, 14 Feb 2020 17:08:23 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F854F80264
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 17:08:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F854F80264
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bsgzfMGX"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 304F82067D;
 Fri, 14 Feb 2020 16:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581696498;
 bh=cBFPbr8CVvdMgTjBagQOmxmbeGJeF3llcrP0PGr67TY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bsgzfMGXdhlu7y3udEwlJpOfbWdeo9Mm/nDyPDl1x1sIn7Q6TA45r+nRiHBG3PkRN
 QrxEWtLGf5V2wG/tVebtb5CShYrnxJGiiG5Odxs8H+h8nO0SfDB2g+W4Jm/cCiCrVI
 +hpGo6kGYUrnbHUjXE5Ee6IaadAjHx8Ip9XCvSd8=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Fri, 14 Feb 2020 10:59:13 -0500
Message-Id: <20200214160149.11681-303-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [alsa-devel] [PATCH AUTOSEL 5.4 303/459] ASoC: SOF: Intel: hda-dai:
	fix compilation warning in pcm_prepare
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

RnJvbTogUGllcnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4Lmlu
dGVsLmNvbT4KClsgVXBzdHJlYW0gY29tbWl0IGQ4NzM5OTcxOTJkZGNhY2I1MzMzNTc1NTAyYmUy
ZjkxZWE0YjQ3YjggXQoKRml4IEdDQyB3YXJuaW5nIHdpdGggVz0xLCBwcmV2aW91cyBjbGVhbnVw
IGRpZCBub3QgcmVtb3ZlIHVubmVjZXNzYXJ5CnZhcmlhYmxlLgoKc291bmQvc29jL3NvZi9pbnRl
bC9oZGEtZGFpLmM6IEluIGZ1bmN0aW9uIOKAmGhkYV9saW5rX3BjbV9wcmVwYXJl4oCZOgoKc291
bmQvc29jL3NvZi9pbnRlbC9oZGEtZGFpLmM6MjY1OjMxOiB3YXJuaW5nOiB2YXJpYWJsZSDigJho
ZGFfc3RyZWFt4oCZCnNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVd
CiAgMjY1IHwgIHN0cnVjdCBzb2ZfaW50ZWxfaGRhX3N0cmVhbSAqaGRhX3N0cmVhbTsKICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+CgpGaXhlczogYTNlYmNj
YjUyZWZkZiAoIkFTb0M6IFNPRjogSW50ZWw6IGhkYTogcmVzZXQgbGluayBETUEgc3RhdGUgaW4g
cHJlcGFyZSIpCkNjOiBLYWkgVmVobWFuZW4gPGthaS52ZWhtYW5lbkBsaW51eC5pbnRlbC5jb20+
ClNpZ25lZC1vZmYtYnk6IFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IDxwaWVycmUtbG91aXMuYm9zc2Fy
dEBsaW51eC5pbnRlbC5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMDAx
MTMyMDU2MjAuMjcyODUtMS1waWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5jb20KU2ln
bmVkLW9mZi1ieTogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5
OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+Ci0tLQogc291bmQvc29jL3NvZi9pbnRl
bC9oZGEtZGFpLmMgfCAzIC0tLQogMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvc291bmQvc29jL3NvZi9pbnRlbC9oZGEtZGFpLmMgYi9zb3VuZC9zb2Mvc29mL2lu
dGVsL2hkYS1kYWkuYwppbmRleCA4OTZkMjE5ODRiNzM1Li4xOTIzYjBjMzZiY2VmIDEwMDY0NAot
LS0gYS9zb3VuZC9zb2Mvc29mL2ludGVsL2hkYS1kYWkuYworKysgYi9zb3VuZC9zb2Mvc29mL2lu
dGVsL2hkYS1kYWkuYwpAQCAtMjYxLDE0ICsyNjEsMTEgQEAgc3RhdGljIGludCBoZGFfbGlua19w
Y21fcHJlcGFyZShzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwKIHsKIAlzdHJ1
Y3QgaGRhY19leHRfc3RyZWFtICpsaW5rX2RldiA9CiAJCQkJc25kX3NvY19kYWlfZ2V0X2RtYV9k
YXRhKGRhaSwgc3Vic3RyZWFtKTsKLQlzdHJ1Y3Qgc29mX2ludGVsX2hkYV9zdHJlYW0gKmhkYV9z
dHJlYW07CiAJc3RydWN0IHNuZF9zb2ZfZGV2ICpzZGV2ID0KIAkJCQlzbmRfc29jX2NvbXBvbmVu
dF9nZXRfZHJ2ZGF0YShkYWktPmNvbXBvbmVudCk7CiAJc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRp
bWUgKnJ0ZCA9IHNuZF9wY21fc3Vic3RyZWFtX2NoaXAoc3Vic3RyZWFtKTsKIAlpbnQgc3RyZWFt
ID0gc3Vic3RyZWFtLT5zdHJlYW07CiAKLQloZGFfc3RyZWFtID0gaHN0cmVhbV90b19zb2ZfaGRh
X3N0cmVhbShsaW5rX2Rldik7Ci0KIAlpZiAobGlua19kZXYtPmxpbmtfcHJlcGFyZWQpCiAJCXJl
dHVybiAwOwogCi0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
