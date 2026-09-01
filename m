Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38120C79F82
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:38:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59C2B602F6;
	Tue,  8 Sep 2026 20:38:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59C2B602F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788892710;
	bh=qCQ0h5Ddhjtncew0Baus2sGPynVRaDfuMWG+ruVMyYw=;
	h=Date:Subject:From:To:Reply-To:List-Id:List-Archive:List-Help:
	 List-Owner:List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ACx+dxRem0HgxBx6IrODvxXoHnp4W1Pubbtrn0+o/Efo9A0Gg+ikQrwc24rtj37f/
	 kAYG1bQfN3HUjRJLn1DTbu/I6XpWoRwQcrbDiSvJNQ3jgV4fKx5dZeTDh8xMVpuEyz
	 7FiB102u5JoeWSDQq1W15Cgx9y44mL8sGHWBmq4w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73B9DF8077D; Tue,  8 Sep 2026 20:35:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E5028F8076B;
	Tue,  8 Sep 2026 20:35:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CDE31F80548; Wed,  2 Sep 2026 01:23:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788305008;
	b=n8RIMz0Tm0QXhnXG9F2rQo/GOZ8ohtxDVDPOyCxesol7kZzYp2dAJckLzw1u1ubpQZ8Y
	 kZojXCBcsD4KzN0qyLuKRBcm7OwlcMGmu46VL5wIhjyGsiud3EgedbJ79etoixp4ACrKC
	 3pbvmIdSkWpKOf7fWe4rw3yOFYOS0GrPVqbpoCsui200W3X91hInDUILwDdZn58xYLwxe
	 53ZnbujhgB5DlAAXyFLr23JCzAt/dOl5Dbzal5J+yV3VoXeka36EtY6zmMfm0ycUpdA1v
	 tS0P3mv3kZG33FLWGvGpY/yHnXxiRqac522sIHAofW7mYmMKbDr0BqsNO9WNfKCCPBQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788305008;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:From:To;
	bh=ekrDnJ6bNjw3pXwGTevmXAy1eXk2MAQgFFVxpOS+Vyw=;
	b=lEyY58gem9Y7thL5l567LH3/REESuDJ1qruJrBvtYO8pxeyDeQdu1cYP//pvUn75Zyz7
	 6zyWgoQPeLJyj2qh5In/znkn6eYyMX5Kg/hyWaBFCeVtp/jJwi+TUwcHoAdw15xHbi1UC
	 QyhUO3IKL1IA03cCT1Oo4qcxCQdXfFMWw8MPXZxjlb65O1A08O5D6bStqVeaiRwjlylMM
	 ef87vnhK34U+mc+x+0Pruwa8Jv266tPnTw+K8vc/nrWZITwggiad1njgo/3w3oO5LIDhf
	 IgFNDeoDVsPUO7wheSvVmre1yGpLhjZEMLt9/Grivf2vd5XBxlNwtOGe5P+ZMf0hg/A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=lucasfuentes-com.20251104.gappssmtp.com
 header.i=@lucasfuentes-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=yyxNHB5M;
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E768AF8014B
	for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2026 01:23:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E768AF8014B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=lucasfuentes-com.20251104.gappssmtp.com
 header.i=@lucasfuentes-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=yyxNHB5M
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-66ce4a63e17so526076d50.3
        for <alsa-devel@alsa-project.org>;
 Tue, 01 Sep 2026 16:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucasfuentes-com.20251104.gappssmtp.com; s=20251104; t=1788305005;
 x=1788909805; darn=alsa-project.org;
        h=reply-to:to:from:subject:mime-version:content-type:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ekrDnJ6bNjw3pXwGTevmXAy1eXk2MAQgFFVxpOS+Vyw=;
        b=yyxNHB5MNarxDlJceTjCeyx+xkHPEAXFEDAkFkpB8mDpDTxhnJVsJaybVTYO9l+XFk
         bkR2BJbEBgJOO+jvJc7AySW6vSliweW/WmwQMEgkmTsqTJMXK0o74Xy5Gra2hi+H9efI
         ZeDMTmhvGR48c8A3zGppbYfd6dQ4NbLwwPctb9etB3s4tJDTRsF89XRJoqaYHpHhWLIv
         p3Qoy/HqZZ7duRrPpS5lFnihyuoJnwTal/65QIZrdUbpVmhryxg3oRKG1j07soElxZXg
         zIGdl+solRKzcWq2VJsYR9M4pIkDSjEbEimtGoyuUqpfV94uh6+Svgh+xam6ca3a7l9n
         x4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788305005; x=1788909805;
        h=reply-to:to:from:subject:mime-version:content-type:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ekrDnJ6bNjw3pXwGTevmXAy1eXk2MAQgFFVxpOS+Vyw=;
        b=lIaLl3Ty/+NeQKQauesi25jVH4rXX5dYAn/uaxhYhNqjboQZaLfZWtya/iK7X8YGIZ
         Q4+RoEMtXaEUc7NOmWhp/5V5/HNbLA+s/eQ9CGEwn5/3so+tiyhXAmE2pBhQHZM4ZEy3
         h+O4sznVczRllymvZeKz49L7dCvQEdYF7m9ZlydsffXtKQ67LDt37TksVyaf1Iws9X19
         yl4SSy4oa677gNTr1znhM1GFT+l3pY4gW9Gz9D0VyLm3MVE1gsvq/JRRB60AfSMCaJtj
         wyY4KohAU3+yuYsxgrWJYON+YrYohPFLodJx1Hc6OGxjRPUGEtTGHffaExE3d7v91JUF
         Bmdw==
X-Gm-Message-State: AFuF++mexNMuQ5sa6rFfOjQDAyb17sJOZc5KyGeUfNhH6KC2jWczp0wc
	DyiGRLnck40S7Hnjo2wdDNHHvsKi5Hy8YePSnXYs8vtU7/cZPHRDkNt7izOJiN7yZgb8vv7jcHT
	AjHqckRU=
X-Gm-Gg: AYBFou2MYGbQYUlpWx9uI3xQpIeA5ZpncfrOyVhsViLZdqfgGvtCgNa04dqtcTFIC0f
	xnMxptrbmgTJgAIa859JGIufRDsnFAYHmE1v7rVhJuZR0jVtc4FUI2Sl9uZ3q0iRc7p36nzoFjs
	2N/a6/noz3MmM7LaX5kmeM1pWO7505+cO9ixHH2EGOzp0NNWC02GoXWE+ok3hDFdo5A1AjHBXsJ
	GBrYXcBBh5fx43dgJNvEAJZRxNrKAx3PaB9pz5tDisocDcBlrNaHbRQHH4V7cG3bgItmxxYY33D
	JaHivG8V1m64f2vIuCSzzlGFGe1HSNcNn3Oodr7TRdC10o3qpi9of1yp2xQhdvESF/svhKdT7lN
	CjO3tukwTD74kq2ZdpbojGfZCZfadHsW7OWUXfhabX0BH3KPc0i2EakViKVAAfyBqPKCRtDsOxQ
	REhZJ1ORz30KJJGCvdeIziMLCPIdNvyS9+sZTdW4nqpz3HBMplG3dnqcXF0zheie27ANjyk3Wsj
	kUIxu6YBEk=
X-Received: by 2002:a53:d946:0:b0:66b:245f:bc5c with SMTP id
 956f58d0204a3-66f9bbb0365mr173430d50.24.1788305004425;
        Tue, 01 Sep 2026 16:23:24 -0700 (PDT)
Received: from [192.168.0.251] ([2800:810:44b:3d9:5cc5:7d84:44c2:6137])
        by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66f9867035dsm668235d50.15.2026.09.01.16.23.23
        for <alsa-devel@alsa-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 16:23:23 -0700 (PDT)
Message-ID: <6a975e6b.a76636fb.19c40f.05bb@mx.google.com>
Date: Tue, 01 Sep 2026 16:23:23 -0700 (PDT)
MIME-Version: 1.0
Subject: [BUG] snd-usb-audio: distorted/"robotic" playback on NUX NAI-24
 (3703:2000) - audio frame split across isochronous packet boundary
From: Lucas Fuentes <contacto@lucasfuentes.com>
To: alsa-devel@alsa-project.org
X-MailFrom: contacto@lucasfuentes.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: QE236GGF5GRP5R2AIKPZ3563MI7FVYYE
X-Message-ID-Hash: QE236GGF5GRP5R2AIKPZ3563MI7FVYYE
X-Mailman-Approved-At: Tue, 08 Sep 2026 18:35:12 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
Reply-To: contacto@lucasfuentes.com
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QE236GGF5GRP5R2AIKPZ3563MI7FVYYE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

U3VtbWFyeQotLS0tLS0tCgpQbGF5YmFjayB0aHJvdWdoIHRoZSBOVVggTkFJLTI0IFVTQiBhdWRp
byBpbnRlcmZhY2UgKGlkVmVuZG9yIDB4MzcwMywKaWRQcm9kdWN0IDB4MjAwMCkgaXMgY29uc2lz
dGVudGx5IGRpc3RvcnRlZCAoInJvYm90aWMiL21ldGFsbGljLCBhcyBpZgpjaGFubmVscyB3ZXJl
IHNsaXBwaW5nIG91dCBvZiBwaGFzZSB3aXRoIGVhY2ggb3RoZXIpIG9uIExpbnV4LCBhdCB0aGUg
cmF3CkFMU0EgbGV2ZWwgKGJ5cGFzc2luZyBQaXBlV2lyZSBlbnRpcmVseSkuIFRoZSBzYW1lIGRl
dmljZSwgc2FtZSBmaXJtd2FyZSwKc2FtZSBjYWJsZSwgc2FtZSBQQyB3b3JrcyBjb3JyZWN0bHkg
b24gV2luZG93cywgYW5kIHRoZSBtYWNoaW5lJ3Mgb25ib2FyZAphdWRpbyBvdXRwdXQgd29ya3Mg
Y29ycmVjdGx5IHVuZGVyIHRoZSBzYW1lIExpbnV4IGluc3RhbGwgLSBpc29sYXRpbmcgdGhlCnBy
b2JsZW0gdG8gaG93IHNuZC11c2ItYXVkaW8gZHJpdmVzIHRoaXMgc3BlY2lmaWMgZGV2aWNlLgoK
QSB1c2Jtb24gY2FwdHVyZSBkdXJpbmcgYSBzcGVha2VyLXRlc3Qgc2luZSB0b25lIHNob3dzIHRo
ZSBkcml2ZXIKc3VibWl0dGluZyBpc29jaHJvbm91cyBPVVQgcGFja2V0cyBvZiAxMDAgYW5kIDEx
NiBieXRlcy4gQXQgNDgga0h6IG92ZXIgYQpoaWdoLXNwZWVkIGVuZHBvaW50ICg4MDAwIG1pY3Jv
ZnJhbWVzL3NlYyksIDQ4MDAwIC8gODAwMCA9IDYgZXhhY3RseSwgc28KZXZlcnkgcGFja2V0IHNo
b3VsZCBiZSBhIGNsZWFuIG11bHRpcGxlIG9mIHRoZSAxNi1ieXRlIGF1ZGlvIGZyYW1lICg0CmNo
YW5uZWxzIHggNCBieXRlcy9zYW1wbGUpOiA5NiwgMTEyLCAxMjggYnl0ZXMsIGV0Yy4sIHBvc3Np
Ymx5IHdpdGgKb2NjYXNpb25hbCArLy0xLWZyYW1lIGppdHRlciBmcm9tIHJlYWwgZGV2aWNlIGNs
b2NrIGRyaWZ0LiBJbnN0ZWFkLCBldmVyeQpvYnNlcnZlZCBwYWNrZXQgY2FycmllcyBleGFjdGx5
IDQgZXh0cmEgYnl0ZXMgKDEwMCA9IDk2ICsgNCwgMTE2ID0gMTEyICsgNCkKLSBvbmUgbG9uZSBj
aGFubmVsIHNhbXBsZSBiZXlvbmQgdGhlIGxhc3QgY29tcGxldGUgNC1jaGFubmVsIGZyYW1lLiBU
aGF0Cm1lYW5zIGEgc2luZ2xlIGF1ZGlvIGZyYW1lIGlzIGJlaW5nIHNwbGl0IGFjcm9zcyB0d28g
aXNvY2hyb25vdXMgcGFja2V0cyBvbgpldmVyeSB0cmFuc2l0aW9uLCB3aGljaCB3b3VsZCBtaXNh
bGlnbiBjaGFubmVsLXRvLXRpbWUtc2xvdCBtYXBwaW5nCnByb2dyZXNzaXZlbHkgYXMgdGhlIHN0
cmVhbSBwbGF5cyAtIGNvbnNpc3RlbnQgd2l0aCB0aGUgZGlzdG9ydGVkLyJyb2JvdGljIgpzb3Vu
ZCByZXBvcnRlZC4KCkVudmlyb25tZW50Ci0tLS0tLS0tLS0tCgotIEtlcm5lbDogNy4xLjgtYXJj
aDEtMyAoQXJjaCBMaW51eCAvIE9tYXJjaHkpCi0gc3lzdGVtZDogMjYxLjItMS1hcmNoCi0gQXVk
aW8gc3RhY2s6IFBpcGVXaXJlIDEuNi44ICsgV2lyZVBsdW1iZXIgKGJ1ZyByZXByb2R1Y2VzIHdp
dGggdGhlc2UKICBzdG9wcGVkLCBkaXJlY3RseSBhZ2FpbnN0IGh3OjAsMCB2aWEgc3BlYWtlci10
ZXN0L2FwbGF5LCBzbyB0aGlzIGlzIG5vdCBhCiAgUGlwZVdpcmUvV2lyZVBsdW1iZXIgaXNzdWUp
Ci0gRGV2aWNlOiBOVVggTkFJLTI0IFVTQiBhdWRpbyBpbnRlcmZhY2UKICAtIGlkVmVuZG9yIDB4
MzcwMywgaWRQcm9kdWN0IDB4MjAwMCwgYmNkRGV2aWNlIDEuMDEKICAtIFVTQiBBdWRpbyBDbGFz
cyAyLjAsIEhpZ2ggU3BlZWQgKDQ4MCBNYnBzKQogIC0gUGxheWJhY2s6IEludGVyZmFjZSAyLCBB
bHRzZXQgMSAtIDQgY2hhbm5lbHMsIFBDTSwgRm9ybWF0IFR5cGUgSSwKICAgIGJTdWJzbG90U2l6
ZSA0LCBiQml0UmVzb2x1dGlvbiAzMgogIC0gUGxheWJhY2sgZGF0YSBlbmRwb2ludDogMHgwMSBP
VVQsIElzb2Nocm9ub3VzLCBBc3luY2hyb25vdXMsCiAgICB3TWF4UGFja2V0U2l6ZSAweDAxOTAg
KDQwMCBieXRlcyksIGJJbnRlcnZhbCAxCiAgLSBGZWVkYmFjayBlbmRwb2ludDogMHg4MSBJTiwg
SXNvY2hyb25vdXMsIFVzYWdlPUZlZWRiYWNrLAogICAgd01heFBhY2tldFNpemUgMHgwMDA0ICg0
IGJ5dGVzKSwgYkludGVydmFsIDQgKDEgbXMpLCBmb3JtYXQgMTYuMTYgKHBlcgogICAgL3Byb2Mv
YXNvdW5kL2NhcmQwL3N0cmVhbTApCgpTdGVwcyB0byByZXByb2R1Y2UKLS0tLS0tLS0tLS0tLS0t
LS0tLQoKICAgIHN5c3RlbWN0bCAtLXVzZXIgc3RvcCBwaXBld2lyZS5zb2NrZXQgcGlwZXdpcmUt
cHVsc2Uuc29ja2V0IHBpcGV3aXJlIHdpcmVwbHVtYmVyIHBpcGV3aXJlLXB1bHNlCiAgICBzcGVh
a2VyLXRlc3QgLUQgaHc6MCwwIC1jIDQgLUYgUzMyX0xFIC1yIDQ4MDAwIC10IHNpbmUgLWYgNDQw
CgpMaXN0ZW5pbmcgb24gdGhlIGludGVyZmFjZSdzIG1haW4gb3V0cyAoY2hhbm5lbHMgMS8yKTog
dGhlIHRvbmUgaXMKZGlzdG9ydGVkLyJyb2JvdGljIiBpbnN0ZWFkIG9mIGEgY2xlYW4gc2luZSB3
YXZlLgoKV2hhdCBoYXMgYmVlbiBydWxlZCBvdXQKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgot
IE5vdCBQaXBlV2lyZS9XaXJlUGx1bWJlciBjb25maWc6IHJlcHJvZHVjZXMgaWRlbnRpY2FsbHkg
YWdhaW5zdCByYXcgQUxTQQogIGh3OjAsMCwgUGlwZVdpcmUgZnVsbHkgc3RvcHBlZC4KLSBOb3Qg
eHJ1bnMvdW5kZXJydW5zOiBubyB4cnVuIG1lc3NhZ2VzIGluIGpvdXJuYWxjdGwgLS11c2VyIC11
IHBpcGV3aXJlCiAgZHVyaW5nIHBsYXliYWNrOyBwdy1tZXRhZGF0YSBjbG9jayBzZXR0aW5ncyBt
YXRjaCB0aGUgZGV2aWNlJ3MgbmVnb3RpYXRlZAogIHJhdGUgKGNsb2NrLnJhdGUgNDgwMDAsIGRl
dmljZSAiTW9tZW50YXJ5IGZyZXEiIDQ4MDAwIEh6KS4KLSBOb3QgVVNCIGF1dG9zdXNwZW5kOiAv
c3lzL2J1cy91c2IvZGV2aWNlcy8xLTMvcG93ZXIvY29udHJvbCBpcyAib24iCiAgKGF1dG9zdXNw
ZW5kIGRpc2FibGVkKS4KLSBOb3QgdGhlIEFMU0EgYWxzYS1jYXJkLXByb2ZpbGUgIlN1cnJvdW5k
IDQuMCIgY2hhbm5lbC1tYXAgdXBtaXg6CiAgc3dpdGNoaW5nIHRoZSBjYXJkIHByb2ZpbGUgdG8g
cHJvLWF1ZGlvIChyYXcgQVVYIGNoYW5uZWxzLCBubyBzdXJyb3VuZAogIG1hcHBpbmcpIG1ha2Vz
IG5vIGRpZmZlcmVuY2UuCi0gTm90IGZpcm13YXJlL2hhcmR3YXJlOiBpZGVudGljYWwgZGV2aWNl
IGFuZCBmaXJtd2FyZSB3b3JrIGNvcnJlY3RseSBvbgogIFdpbmRvd3Mgb24gdGhlIHNhbWUgbWFj
aGluZSwgYW5kIHRoZSBtYWNoaW5lJ3Mgb25ib2FyZCBhdWRpbyAoc2VwYXJhdGUKICBIREEgY29k
ZWMpIHBsYXlzIGNsZWFubHkgdW5kZXIgdGhlIHNhbWUgTGludXggaW5zdGFsbC4KLSBOb3QgZml4
ZWQgYnkga25vd24gc25kX3VzYl9hdWRpbyBtb2R1bGUgcXVpcmtzIHRyaWVkIHNvIGZhcjoKICAt
IGltcGxpY2l0X2ZiPTEgbG93bGF0ZW5jeT0wCiAgLSBxdWlya19mbGFncz0zNzAzOjIwMDA6MHg0
IChRVUlSS19GTEFHX0FMSUdOX1RSQU5TRkVSKQogIC0gcXVpcmtfZmxhZ3M9MzcwMzoyMDAwOjB4
MjAwMEMgKFFVSVJLX0ZMQUdfQUxJR05fVFJBTlNGRVIgfAogICAgUVVJUktfRkxBR19UWF9MRU5H
VEggfCBRVUlSS19GTEFHX0dFTkVSSUNfSU1QTElDSVRfRkIpCgp1c2Jtb24gZXZpZGVuY2UKLS0t
LS0tLS0tLS0tLS0tLQoKQ2FwdHVyZWQgdmlhOgoKICAgIHN1ZG8gbW9kcHJvYmUgdXNibW9uCiAg
ICBzdWRvIGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy91c2IvdXNibW9uLzF1ID4gbmFpMjRfdXNibW9u
LmxvZwoKUGxheWJhY2sgZW5kcG9pbnQgKFpvOjE6MDAyOjEpLCBzdGVhZHkgc3RhdGUsIHNob3dp
bmcgMTE2LWJ5dGUgcGFja2V0cwp1bmlmb3JtbHkgaW4gb25lIFVSQiBhbmQgYSAxMDAvMTE2IG1p
eCBpbiBhbm90aGVyICg1IG9mIDggaXNvIGRlc2NyaXB0b3JzCnNob3duIHBlciBsaW5lOyB1c2Jt
b24gdHJ1bmNhdGVzIHRoZSBkaXNwbGF5IGxpc3QgYnV0IHRoZSB0b3RhbCBsZW5ndGgKZmllbGQg
Y29uZmlybXMgdGhlIHN1bSBmb3IgYWxsIDgpOgoKICAgIGZmZmY4YjgzMjRiYTZlMDAgNTk5NzMx
MTM5IFMgWm86MTowMDI6MSAtMTE1OjE6NTM2MCA4IC0xODowOjEwMCAtMTg6MTAwOjExNiAtMTg6
MjE2OjExNiAtMTg6MzMyOjExNiAtMTg6NDQ4OjExNiA5MTIgPSA2MDAwMDAwMCA4MGYxODk2NCAu
Li4KICAgIGZmZmY4YjgzMGZlYTljMDAgNTk5NzMzMTQ0IFMgWm86MTowMDI6MSAtMTE1OjE6NTM3
NiA4IC0xODowOjExNiAtMTg6MTE2OjExNiAtMTg6MjMyOjExNiAtMTg6MzQ4OjExNiAtMTg6NDY0
OjExNiA5MjggPSA3MDAwMDAwMCAwMGI2NTk2MyAuLi4KCi0gOTEyIC8gOCA9IDExNCBieXRlcy9w
YWNrZXQgYXZlcmFnZSAobWl4ZWQgMTAwICsgMTE2IHggNykKLSA5MjggLyA4ID0gMTE2IGJ5dGVz
L3BhY2tldCAoYWxsIGVpZ2h0IHBhY2tldHMgMTE2IGJ5dGVzKQoKTmVpdGhlciAxMDAgbm9yIDEx
NiBpcyBhIG11bHRpcGxlIG9mIDE2ICh0aGUgNC1jaGFubmVsIHggMzItYml0IGZyYW1lCnNpemUp
LiBFeHBlY3RlZCBjbGVhbiB2YWx1ZXMgd291bGQgYmUgOTYgb3IgMTEyLgoKRmVlZGJhY2sgZW5k
cG9pbnQgKFppOjE6MDAyOjEpLCBwb2xsZWQgZXZlcnkgfjEgbXMsIGNvbnNpc3RlbnRseSByZXR1
cm5pbmcKdGhlIHNhbWUgNC1ieXRlIHZhbHVlOgoKICAgIGZmZmY4YjgyNjJkNzM1MDAgNTk5NzMw
MjYxIEMgWmk6MTowMDI6MSAwOjg6NTM2MDowIDEgMDowOjQgNCA9IDQ4ZWMwNjAwCiAgICBmZmZm
OGI4MjY1Zjc5OTAwIDU5OTczMTI1OSBDIFppOjE6MDAyOjEgMDo4OjUzNjg6MCAxIDA6MDo0IDQg
PSA0OGVjMDYwMAoKU3VzcGVjdGVkIHJvb3QgY2F1c2UKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoK
VGhlIHBhY2tldC1zaXplIGFyaXRobWV0aWMgdXNlZCBieSBzbmQtdXNiLWF1ZGlvIGZvciB0aGlz
IHN0cmVhbSAoNApjaGFubmVscywgMzItYml0IHN1YnNsb3QsIDQ4IGtIeiwgYXN5bmMgKyBleHBs
aWNpdCBmZWVkYmFjaykgYXBwZWFycyB0byBiZQpvZmYgYnkgZXhhY3RseSBvbmUgc3Vic2xvdCAo
NCBieXRlcykgcGVyIHBhY2tldCBib3VuZGFyeSwgc3BsaXR0aW5nIGEKNC1jaGFubmVsIGF1ZGlv
IGZyYW1lIGFjcm9zcyB0d28gaXNvY2hyb25vdXMgcGFja2V0cyBpbnN0ZWFkIG9mIGtlZXBpbmcK
ZnJhbWVzIGludGFjdC4gVGhpcyB3b3VsZCBjYXVzZSBhIHNsb3csIGNvbnRpbnVvdXMgY2hhbm5l
bC10by10aW1lLXNsb3QKZHJpZnQsIHdoaWNoIGlzIGNvbnNpc3RlbnQgd2l0aCB0aGUgInJvYm90
aWMiL21ldGFsbGljIGRpc3RvcnRpb24gcmVwb3J0ZWQKKGFzIG9wcG9zZWQgdG8gY2xpY2tzL2Ry
b3BvdXRzLCB3aGljaCB3b3VsZCBwb2ludCB0byBwbGFpbiB4cnVucykuCgpIYXBweSB0byBwcm92
aWRlIHRoZSBmdWxsIGxzdXNiIC12IGR1bXAsIGEgbG9uZ2VyIHVzYm1vbiBjYXB0dXJlLCBvciB0
ZXN0CmZ1cnRoZXIga2VybmVsIHBhdGNoZXMvcXVpcmsgY29tYmluYXRpb25zIGFnYWluc3QgdGhl
IGhhcmR3YXJlIC0gSSBoYXZlIHRoZQpkZXZpY2UgaW4gaGFuZC4KClJlZ2FyZHMsCkx1Y2FzCg==
