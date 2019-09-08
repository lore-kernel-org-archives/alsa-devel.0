Return-Path: <SRS0=DUcU=XG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7D9C5ACAE
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:17:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCBB206A5
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Qc4c4i6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCBB206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=juszkiewicz.com.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DBF316C6;
	Wed, 11 Sep 2019 17:16:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DBF316C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568215026;
	bh=rrQDrfJ8FSE6UNvDq35pWICkOK4fiMiyv8Sq2+evL7U=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qc4c4i6HWGB/hUme7OayYJGvlLYQ9a6f86nrlp3qVyE3zyMwpG+9CKeJip82PE09Y
	 nNIZ1TB/rbjJRSSWiBIGKZsqpajTID9onY7ElHsFPM/Q0PC/jNGzwkOnwxZbIYvvmR
	 O0CAik6oCnjbIPW6R1TrX2zDs+dvFka23/TbXbgo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D07B8F8031A;
	Wed, 11 Sep 2019 17:16:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7745FF80368; Sun,  8 Sep 2019 18:16:16 +0200 (CEST)
Received: from malenstwo.juszkiewicz.com.pl (malenstwo.juszkiewicz.com.pl
 [37.187.99.30])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37247F800C1
 for <alsa-devel@alsa-project.org>; Sun,  8 Sep 2019 18:16:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37247F800C1
Received: from localhost (localhost [127.0.0.1])
 by malenstwo.juszkiewicz.com.pl (Postfix) with ESMTP id A759BC06AD;
 Sun,  8 Sep 2019 18:16:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at juszkiewicz.com.pl
Received: from malenstwo.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (mail.juszkiewicz.com.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SqudHF1ds49x; Sun,  8 Sep 2019 18:16:08 +0200 (CEST)
Received: from puchatek.local (89-67-26-161.dynamic.chello.pl [89.67.26.161])
 by malenstwo.juszkiewicz.com.pl (Postfix) with ESMTPSA id 721C9C0561; 
 Sun,  8 Sep 2019 18:16:08 +0200 (CEST)
To: Jaroslav Kysela <jkysela@redhat.com>
References: <15679391594432724-alsa-devel@perex.cz>
From: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Message-ID: <fbd36c4d-8fc1-4898-497f-3f5935d65cfb@juszkiewicz.com.pl>
Date: Sun, 8 Sep 2019 18:16:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <15679391594432724-alsa-devel@perex.cz>
Content-Language: en-GB
X-Mailman-Approved-At: Wed, 11 Sep 2019 17:16:14 +0200
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Licence change for your alsa-lib UCM commits
 (Marcin Juszkiewicz: 5 total)
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

VyBkbml1IDA4LjA5LjIwMTkgb8KgMTI6MzksIEphcm9zbGF2IEt5c2VsYSBwaXN6ZToKPiBBcyBk
aXNjdXNzZWQsIHdlIHdvdWxkIGxpa2UgdG8gbW92ZSB0aGUgVUNNIGNvbmZpZ3VyYXRpb24gZmls
ZXMgZnJvbSB0aGUKPiBhbHNhLWxpYiByZXBvc2l0b3J5IHRvIG5ldyBhbHNhLXVjbS1jb25mIHJl
cG9zaXRvcnkgd2l0aCB0aGUgbGljZW5jZSBjaGFuZ2UKPiBmcm9tIExHUEwtMi4xIHRvIEJTRC0z
LUNsYXVzZS4KPiAKPiBJIHdvdWxkIGxpa2UgdG8gY2hlY2ssIGlmIHlvdSBhZ3JlZSB3aXRoIHRo
aXMgbGljZW5jZSBjaGFuZ2UuIFBsZWFzZSwgYW5zd2VyCj4gdG8gdGhpcyBlLW1haWwgYW5kIHdy
aXRlIHlvdXIgYWdyZWVtZW50IC8gZGlzYWdyZWVtZW50IChrZWVwIENDIHRvCj4gdGhlIGFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0IGZvciB0aGUgYXJjaGl2aW5nIHB1cnBvc2VzKS4KCkkgYW0gZmlu
ZSB3aXRoIGxpY2Vuc2UgY2hhbmdlLgoKPiBSZWZlcmVuY2U6ICBodHRwczovL21haWxtYW4uYWxz
YS1wcm9qZWN0Lm9yZy9waXBlcm1haWwvYWxzYS1kZXZlbC8yMDE5LUp1bHkvMTUzMjU3Lmh0bWwK
PiAKPiBMaXN0IG9mIHlvdXIgY29tbWl0KHMpOgo+IAo+ICAgZjA3YzE0YjA4MjgwZmI0NjFiN2Yw
NzBkNTVhNjI1ZTFmNWU4OGExZQo+ICAgICBjb25mL3VjbTogREFJU1ktSTJTOiBhZGQgU2Ftc3Vu
ZyBBUk0gQ2hyb21lYm9vayBVQ00gY29uZmlnIGZyb20gQ2hyb21lT1MKPiAgIDViMDE5ZWEzMTBl
NmE1ZDZmZjg5MzNiY2JjYTFmM2YzNDcxYmUzM2IKPiAgICAgY29uZi91Y206IFBhbmRhQm9hcmQ6
IGFkZCBVQ00gY29uZmlnIGZyb20gVWJ1bnR1Cj4gICA5ZDBmOTNhZjBiMzViZmRjYmQzZDc1OGQ5
ODcxNTUwOGI2OWQ2MDA4Cj4gICAgIGNvbmYvdWNtOiBQYW5kYUJvYXJkRVM6IGFkZCBVQ00gY29u
ZmlnIGZyb20gVWJ1bnR1Cj4gICA3ZGIyNDdiZTExMzgxYmVmNmUzOGE0MWYxZDUxZmE3OGE5OTM1
MGI1Cj4gICAgIGNvbmYvdWNtOiBTRFA0NDMwOiBhZGQgVUNNIGNvbmZpZyBmcm9tIFVidW50dQo+
ICAgNTJkZTkxMDg2OGY1NmVlN2U2YjA3YTFhMmFkNmE1NDkxM2Y3NDVkMAo+ICAgICBjb25mL3Vj
bTogdGVncmFhbGM1NjMyOiBhZGQgVUNNIGNvbmZpZyBmcm9tIFVidW50dQo+IAo+IC0tLQo+IEph
cm9zbGF2IEt5c2VsYSA8cGVyZXhAcGVyZXguY3o+Cj4gTGludXggU291bmQgTWFpbnRhaW5lcjsg
QUxTQSBQcm9qZWN0OyBSZWQgSGF0LCBJbmMuCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
