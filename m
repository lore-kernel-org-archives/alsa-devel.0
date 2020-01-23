Return-Path: <SRS0=ePgV=3M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC0FC2D0DB
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:35:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC96921D7D
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VDo2hDof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC96921D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tarent.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39C6F169E;
	Thu, 23 Jan 2020 21:34:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39C6F169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579811737;
	bh=WTdfiP7+9LyKrCnOQQ1640TKkcHAR1jE6UjXpU8BjsI=;
	h=In-Reply-To:References:To:From:Date:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VDo2hDofW1Q5t0e5oP1KRfMPUZhCOIvVsGG421PQmDxvavDr6p36Febey8CoBmjOz
	 F9v6/KDhToRHkUfZCM9dy2kXgpv9gLTNCccaHBGuwOIFVs3zF3vso8xu88+CP+J5F/
	 V9c8KUBF6aHD62ZPhfQP2rvMMJtmaHkw7y4X8Ngs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4FCCF80272;
	Thu, 23 Jan 2020 21:33:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6FF54F800BA; Thu, 23 Jan 2020 21:33:13 +0100 (CET)
Received: from herc.mirbsd.org (herc.mirbsd.org
 [IPv6:2001:470:1f15:10c:202:b3ff:feb7:54e8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C7ABF800BA
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2020 21:33:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C7ABF800BA
Received: from herc.mirbsd.org (tg@localhost [IPv6:::1])
 by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 00NKWWeX016306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Thu, 23 Jan 2020 20:32:34 GMT
Received: (from tg@localhost)
 by herc.mirbsd.org (8.14.9/8.14.5/Submit) id 00NKWWwd018015;
 Thu, 23 Jan 2020 20:32:32 GMT
Message-Id: <202001232032.00NKWWwd018015@herc.mirbsd.org>
X-Authentication-Warning: herc.mirbsd.org: tg set sender to t.glaser@tarent.de
 using -f
In-Reply-To: <alpine.DEB.2.22.394.2001232123580.6327@tglase-nb.lan.tarent.de>
References: <alpine.DEB.2.22.394.2001232123580.6327@tglase-nb.lan.tarent.de>
 <alpine.DEB.2.21.1911202147000.2011@tglase.lan.tarent.de>
 <s5hzhgpsl7b.wl-tiwai@suse.de>
 <alpine.DEB.2.21.1911211536340.23653@tglase-nb.lan.tarent.de>
 <s5hmuco3unv.wl-tiwai@suse.de>
 <157133531799.6063.9249463816269134459.reportbug@tglase.lan.tarent.de>
To: alsa-devel@alsa-project.org
MIME-Version: 1.0
From: mirabilos <t.glaser@tarent.de>
Date: Thu, 23 Jan 2020 21:21:21 +0100
MIME-Version: 1.0
X-MIME-Autoconverted: from 8bit to quoted-printable by herc.mirbsd.org id
 00NKWWwd018015
Cc: 870396@bugs.debian.org
Subject: [alsa-devel] [PATCH 3/3] test: explicitly cast time types to types
 printf can handle
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

QWxzbyAoYXMgcmVxdWVzdGVkIGJ5IFRha2FzaGkgSXdhaSksIGNvbnZlcnQgdGltZWRpZmYoKSB0
byB0aW1lX3QsCmFzIGl04oCZcyB0aGUgcHJvcGVyIHJldHVybiB0eXBlLgoKU2lnbmVkLW9mZi1i
eTogbWlyYWJpbG9zIDx0Z0BkZWJpYW4ub3JnPgotLS0KIHRlc3QvbGF0ZW5jeS5jICAgICB8IDEw
ICsrKysrLS0tLS0KIHRlc3QvcXVldWVfdGltZXIuYyB8IDEwICsrKysrLS0tLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
dGVzdC9sYXRlbmN5LmMgYi90ZXN0L2xhdGVuY3kuYwppbmRleCAyOThiYWI4YS4uY2YzOWQzMTkg
MTAwNjQ0Ci0tLSBhL3Rlc3QvbGF0ZW5jeS5jCisrKyBiL3Rlc3QvbGF0ZW5jeS5jCkBAIC0zMjUs
NyArMzI1LDcgQEAgdm9pZCBzZXRzY2hlZHVsZXIodm9pZCkKIAlwcmludGYoIiEhIVNjaGVkdWxl
ciBzZXQgdG8gUm91bmQgUm9iaW4gd2l0aCBwcmlvcml0eSAlaSBGQUlMRUQhISFcbiIsIHNjaGVk
X3BhcmFtLnNjaGVkX3ByaW9yaXR5KTsKIH0KIAotbG9uZyB0aW1lZGlmZihzbmRfdGltZXN0YW1w
X3QgdDEsIHNuZF90aW1lc3RhbXBfdCB0MikKK3RpbWVfdCB0aW1lZGlmZihzbmRfdGltZXN0YW1w
X3QgdDEsIHNuZF90aW1lc3RhbXBfdCB0MikKIHsKIAlzaWduZWQgbG9uZyBsOwogCkBAIC02ODMs
MTIgKzY4MywxMiBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCQlzbmRfcGNt
X25vbmJsb2NrKHBoYW5kbGUsICFibG9jayA/IDEgOiAwKTsKIAkJaWYgKG9rKSB7CiAjaWYgMQot
CQkJcHJpbnRmKCJQbGF5YmFjayB0aW1lID0gJWxpLiVpLCBSZWNvcmQgdGltZSA9ICVsaS4laSwg
ZGlmZiA9ICVsaVxuIiwKLQkJCSAgICAgICBwX3RzdGFtcC50dl9zZWMsCisJCQlwcmludGYoIlBs
YXliYWNrIHRpbWUgPSAlbGxpLiVpLCBSZWNvcmQgdGltZSA9ICVsbGkuJWksIGRpZmYgPSAlbGxp
XG4iLAorCQkJICAgICAgIChsb25nIGxvbmcpcF90c3RhbXAudHZfc2VjLAogCQkJICAgICAgIChp
bnQpcF90c3RhbXAudHZfdXNlYywKLQkJCSAgICAgICBjX3RzdGFtcC50dl9zZWMsCisJCQkgICAg
ICAgKGxvbmcgbG9uZyljX3RzdGFtcC50dl9zZWMsCiAJCQkgICAgICAgKGludCljX3RzdGFtcC50
dl91c2VjLAotCQkJICAgICAgIHRpbWVkaWZmKHBfdHN0YW1wLCBjX3RzdGFtcCkpOworCQkJICAg
ICAgIChsb25nIGxvbmcpdGltZWRpZmYocF90c3RhbXAsIGNfdHN0YW1wKSk7CiAjZW5kaWYKIAkJ
CWJyZWFrOwogCQl9CmRpZmYgLS1naXQgYS90ZXN0L3F1ZXVlX3RpbWVyLmMgYi90ZXN0L3F1ZXVl
X3RpbWVyLmMKaW5kZXggYzRmZmIxOTIuLmM1Y2U1ODY2IDEwMDY0NAotLS0gYS90ZXN0L3F1ZXVl
X3RpbWVyLmMKKysrIGIvdGVzdC9xdWV1ZV90aW1lci5jCkBAIC05OSwxMSArOTksMTEgQEAgbWFp
bihpbnQgYXJnYyBBVFRSSUJVVEVfVU5VU0VELCBjaGFyICoqYXJndiBBVFRSSUJVVEVfVU5VU0VE
KQogCW5vcm1hbGl6ZSgmZGlmZmRpZmYpOwogCXByZXZkaWZmID0gZGlmZjsKIAotCWZwcmludGYo
c3RkZXJyLCAiIHJlYWwgdGltZTogJTEybGQgc2VjICU4bGQgdXNlY1xucXVldWUgdGltZTogJTEy
bGQgc2VjICU4bGQgdXNlY1xuICAgICAgZGlmZjogJTEybGQgc2VjICU4bGQgdXNlY1xuICBkaWZm
ZGlmZjogJTEybGQgc2VjICU4bGQgdXNlY1xuIiwKLQkJdHYudHZfc2VjLCB0di50dl91c2VjLAot
CQkobG9uZylydGltZS0+dHZfc2VjLCAobG9uZylydGltZS0+dHZfbnNlYyAvIDEwMDAsCi0JCWRp
ZmYudHZfc2VjLCBkaWZmLnR2X3VzZWMsCi0JCShsb25nKWRpZmZkaWZmLnR2X3NlYywgKGxvbmcp
ZGlmZmRpZmYudHZfdXNlYyk7CisJZnByaW50ZihzdGRlcnIsICIgcmVhbCB0aW1lOiAlMTJsbGQg
c2VjICU4bGQgdXNlY1xucXVldWUgdGltZTogJTEybGxkIHNlYyAlOGxkIHVzZWNcbiAgICAgIGRp
ZmY6ICUxMmxsZCBzZWMgJThsZCB1c2VjXG4gIGRpZmZkaWZmOiAlMTJsbGQgc2VjICU4bGQgdXNl
Y1xuIiwKKwkJKGxvbmcgbG9uZyl0di50dl9zZWMsIChsb25nKXR2LnR2X3VzZWMsCisJCShsb25n
IGxvbmcpcnRpbWUtPnR2X3NlYywgKGxvbmcpcnRpbWUtPnR2X25zZWMgLyAxMDAwLAorCQkobG9u
ZyBsb25nKWRpZmYudHZfc2VjLCAobG9uZylkaWZmLnR2X3VzZWMsCisJCShsb25nIGxvbmcpZGlm
ZmRpZmYudHZfc2VjLCAobG9uZylkaWZmZGlmZi50dl91c2VjKTsKIAogCWlmIChkaWZmZGlmZi50
dl91c2VjID4gIDUwMDAgfHwKIAkgICAgZGlmZmRpZmYudHZfdXNlYyA8IC01MDAwKSB7Ci0tIAoy
LjI1LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
