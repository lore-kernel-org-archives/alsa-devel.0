Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D91C5DF85
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:35:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3651960290;
	Thu, 20 Aug 2026 16:35:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3651960290
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787236538;
	bh=PYOgOGfBVLjKqPPDlxjKosCe/JvoiucAM/Y4K8nmWeY=;
	h=Date:To:From:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=vICpI/o69FLWr17waUsHPxM3/k2mYs83c6Ef/oVzbLhIiluJKNMVlnGDIQtKGIyj9
	 hWsQBl9f/Kbaavh2iWS8LYsttlMMUX/MhyRFnqsOn8pYk3jeJswcaAQ0qFT8ynCTXN
	 fOpEs6zmO1u8gADUalBZHChyU3m4IBkLuSPAYqdg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 546E4F8060D; Thu, 20 Aug 2026 16:34:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BDFC7F80608;
	Thu, 20 Aug 2026 16:34:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D8295F8055C; Tue, 18 Aug 2026 12:00:18 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=185.70.43.166
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787047217;
	b=XcHgGgx3PTovELp6d5wTLMdoS8TAF2x7WAbcG8CPhWodex23UFRK53F9mt2ih1Isrhlg
	 A10lyQ6uJDJyCGbxvBMJJMGeC4V74Q9RKydKI3CUjBvmxmlV29aHYPwiwL138OCwbFquk
	 c5qBR08Y33NRbH+UDl2TDGTAQRb1fpqURgKK5lGkDKD0mrc3u+ushnxVUcXgnwdaJDGJd
	 ye1eHdc7QnAHHoSd6nK85ZyejgSX1rX6EHoNZvKEc9rDRozNj8XA9NMdlsvfI73H4Ao+v
	 2eOaruJgUukp/dS2jtW1lpF4xC92xuNYXMw2AtChjaenfcWqth+EWW0fDhh0o9uZ3YA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787047217;
	h=DKIM-Signature:Date:To:From:Subject:Message-ID:MIME-Version;
	bh=Ztp4JvPL9otP3vAnpd6qPIP5RoYUNSXefFYza5cqpsA=;
	b=h/Zt20FQXJfmhv4w1TTxUaiACeWOq0ChDLwhBrv4lqtw/IozuyR14QDQK+lM88+aEIaI
	 46S2ySCu1MWGCBsEQ9Fn0KUMGvaVQB1Hoy1EwKask5FZogkHUFVmuGLh/+V3WuAmW5sai
	 KfEnBxRK7ellRZ8wMZaVpvVvYfe+VrVzz05YBDl4KvPQQrfNFqQjH+zTyyYKrKLYe9r+D
	 MyMWKE2QJ0k4U/w6paW5AMvLG4/X09fteBEwqB3GAANX0qhrBsV35+a6Ff8bCe53PkzUA
	 0nAWfDiXW1pBmg2eU0rxYJ5s7HxBgGqoUL6L4XxB141aCTZQoq5f1ElRinnjSMfTq0A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=3k2wq6izjbdyppgkqctkhrifne.protonmail header.b=Kolp3fQx;
	arc=none smtp.remote-ip=185.70.43.166
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch
 [185.70.43.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5A4C3F800AC
	for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2026 12:00:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A4C3F800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=3k2wq6izjbdyppgkqctkhrifne.protonmail header.b=Kolp3fQx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3k2wq6izjbdyppgkqctkhrifne.protonmail; t=1787047214; x=1787306414;
	bh=Ztp4JvPL9otP3vAnpd6qPIP5RoYUNSXefFYza5cqpsA=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Kolp3fQxnEg520c5BqO90V+uE0HBbtkgkytGUGr41Pr8cTK8p2KWfwd1bBZ5DeVTv
	 e3A5NTuXqHBrfPIy2+JlwXJnCkt03UhGnBeMW59Gt2fL2ITSinC5gxGovjVMq8kT+V
	 RMWBGXP7mnq2AyB3pQxlc2Dk112j36KLcbazo0ZI3F+NucUA0eaECZOB6+DUuXd6I8
	 5Z8tSczCvTz0g2K9TsJB7Q4xsxC8FkezpsTfcb2v3qVz5UGwTuLaR2ptuV+mFsmnui
	 XdYxriREB3EoUNfgS6h4qlROhj9LNqgDtpZ/2UMaxuDlzLT+Az/Awo/jqNf9fsNC3o
	 G3j/X+4tSh7zA==
Date: Tue, 18 Aug 2026 10:00:10 +0000
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: Swac <swac644@proton.me>
Subject: 
 =?utf-8?Q?[BUG]_tas2781:_V1_CRC_error_on_Lenovo_16IRP8_(83C0)_=E2=80=94_calibration_data_valid,_CRC_field_never_populated?=
Message-ID: 
 <6eBGKHDUJnThj09kdjSKBK9773Pa4XZzsT6YNba7mX73uKQ1UpEDrGf3NdZn-Re-92ilEQD0H7Adh0aeE7g-f3_ZzQfzwd06W8s1BGdg2ik=@proton.me>
Feedback-ID: 97449758:user:proton
X-Pm-Message-ID: c88c6e43eb18a6864b308c3eac2e89cca703b027
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_T9Lpqh7lssyVHQpQPK3n7Kc346T2ClD1tDaKz5eR7c"
X-MailFrom: swac644@proton.me
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: PAEWCEGXDTPDFENGZOXHDTTS2TKCYXZT
X-Message-ID-Hash: PAEWCEGXDTPDFENGZOXHDTTS2TKCYXZT
X-Mailman-Approved-At: Thu, 20 Aug 2026 14:34:49 +0000
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PAEWCEGXDTPDFENGZOXHDTTS2TKCYXZT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--b1=_T9Lpqh7lssyVHQpQPK3n7Kc346T2ClD1tDaKz5eR7c
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGFyZHdhcmU6IExlbm92byBTbGltIFBybyA5aTsgMTZJUlA4IChETUkgODNDMCkKS2VybmVsOiA3
LjEuOC1hcmNoMQpDaGlwOiBUQVMyNzgxLCA0IGRldmljZXMsIGkyYwoKZG1lc2cgKGJlZm9yZSBm
aXgpOgp0YXMyNzgxLWhkYSBpMmMtVElBUzI3ODE6MDA6IHRhczI3ODFfYXBwbHlfY2FsaWI6IFYx
IENSQyBlcnJvcgoKVGhlIENBTElfREFUQSBVRUZJIHZhcmlhYmxlIChHVUlEIDFmNTJkMmExLWJi
M2EtNDU3ZC1iYzA5LTQzYTNmNDMxMGE5MikgY29udGFpbnMgdmFsaWQsIGNvcnJlY3RseS1zdHJ1
Y3R1cmVkIGNhbGlicmF0aW9uIGRhdGEgKDQgZGV2aWNlcyB4IDIwIGJ5dGVzICsgNC1ieXRlIHRp
bWVzdGFtcCksIHVzZWQgc3VjY2Vzc2Z1bGx5IGJ5IHRoZSBXaW5kb3dzIGRyaXZlciBvbiB0aGUg
c2FtZSBoYXJkd2FyZS4gVGhlIENSQyBmaWVsZCBhdCBvZmZzZXQgODQtODcsIGhvd2V2ZXIsIHdh
cyBsZWZ0IGFzIDB4MDAwMDAwMDAgcmF0aGVyIHRoYW4gYmVpbmcgcG9wdWxhdGVkIGJ5IHdoYXRl
dmVyIGZhY3RvcnkgdG9vbCB3cm90ZSB0aGlzIHZhcmlhYmxlLgoKdGFzMjc4MV9hcHBseV9jYWxp
YigpIHRyZWF0cyB0aGlzIHRoZSBzYW1lIGFzIGEgZ2VudWluZSBDUkMgbWlzbWF0Y2ggYW5kIHJl
ZnVzZXMgdG8gYXBwbHkgY2FsaWJyYXRpb24uCgpNYW51YWxseSBjb21wdXRpbmcgY3JjMzIoKSBv
dmVyIGJ5dGVzIDAtODMgYW5kIHdyaXRpbmcgdGhlIHJlc3VsdCAoMHg2NTE5ZjE1ZSkgaW50byB0
aGUgQ1JDIGZpZWxkIHJlc29sdmVzIHRoZSBpc3N1ZSB3aXRoIHplcm8gb3RoZXIgY2hhbmdlcyDi
gJQgZnVsbCBiZWZvcmUvYWZ0ZXIgaGV4IGR1bXBzIGFuZCBkaWZmIGF0dGFjaGVkLCBzaG93aW5n
IGV4YWN0bHkgb25lIDQtYnl0ZSBmaWVsZCBjaGFuZ2VkLgoKZGlmZiBiZWZvcmUudHh0IGFmdGVy
LnR4dAo2YzYKPCAwMDAwMDA1MDogMDAwMCAyMDMwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAw
MDAwIC4uIDAuLi4uLi4uLi4uLi4KLS0tPiAwMDAwMDA1MDogMDAwMCAyMDMwIDAwMDAgMDAwMCA1
ZWYxIDE5NjUgMDAwMCAwMDAwIC4uIDAuLi4uXi4uZS4uLi4KCkFmdGVyIHRoZSBwYXRjaCwgY2Fs
aWJyYXRpb24gYXBwbGllcyBzdWNjZXNzZnVsbHksIGFuZCBzcGVha2VyIG91dHB1dCBxdWFsaXR5
IG5vdyBtYXRjaGVzIFdpbmRvd3MuCgpTdWdnZXN0IGRpc3Rpbmd1aXNoaW5nICJDUkMgZmllbGQg
dW5zZXQgKDB4MDAwMDAwMDApIiBmcm9tIGEgZ2VudWluZSBtaXNtYXRjaCBvbiBwb3B1bGF0ZWQg
ZGF0YSDigJQgdGhlIGZvcm1lciBsb29rcyBsaWtlIGEgZmFjdG9yeSBwcm92aXNpb25pbmcgZ2Fw
IHJhdGhlciB0aGFuIGFjdHVhbCBjb3JydXB0aW9uLCBhbmQgY3VycmVudGx5IGJvdGggYXJlIHRy
ZWF0ZWQgaWRlbnRpY2FsbHkgYXMgZmF0YWwuCgpQbGVhc2UgQ0MgbWUgb24gcmVwbGllczsgSSdt
IG5vdCBzdWJzY3JpYmVkLg==

--b1=_T9Lpqh7lssyVHQpQPK3n7Kc346T2ClD1tDaKz5eR7c
Content-Type: text/plain; name=after.txt
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=after.txt

MDAwMDAwMDA6IDA3MDAgMDAwMCA4MWQ1IDY3MjAgMzM3NyA5OTFmIDI0YWQgYzMxOCAgLi4uLi4u
ZyAzdy4uJC4uLgowMDAwMDAxMDogYzkyOCBjNjAwIDAwMDAgMjAzMCA0NWI2IGI2MjEgYTA5NiA1
ZjFlICAuKC4uLi4gMEUuLiEuLl8uCjAwMDAwMDIwOiAxMTk3IGMzMTkgMTlmMCBiZjAwIDAwMDAg
MjAzMCAxNjhlIDEwMjEgIC4uLi4uLi4uLi4gMC4uLiEKMDAwMDAwMzA6IDliMzggZjgxZSBlYTlj
IDQ0MTkgMGMyYSBjODAwIDAwMDAgMjAzMCAgLjguLi4uRC4uKi4uLi4gMAowMDAwMDA0MDogNDFk
YSBlMzIyIDgyNmUgNTkxZCBjM2I4IGE5MWEgZjg0MSBjMzAwICBBLi4iLm5ZLi4uLi4uQS4uCjAw
MDAwMDUwOiAwMDAwIDIwMzAgMDAwMCAwMDAwIDVlZjEgMTk2NSAwMDAwIDAwMDAgIC4uIDAuLi4u
Xi4uZS4uLi4KMDAwMDAwNjA6IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAw
MCAgLi4uLi4uLi4uLi4uLi4uLgowMDAwMDA3MDogMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAw
MDAgMDAwMCAwMDAwICAuLi4uLi4uLi4uLi4uLi4uCjAwMDAwMDgwOiAwMDAwIDAwMDAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC4uLi4K

--b1=_T9Lpqh7lssyVHQpQPK3n7Kc346T2ClD1tDaKz5eR7c
Content-Type: text/plain; name=before.txt
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=before.txt

MDAwMDAwMDA6IDA3MDAgMDAwMCA4MWQ1IDY3MjAgMzM3NyA5OTFmIDI0YWQgYzMxOCAgLi4uLi4u
ZyAzdy4uJC4uLgowMDAwMDAxMDogYzkyOCBjNjAwIDAwMDAgMjAzMCA0NWI2IGI2MjEgYTA5NiA1
ZjFlICAuKC4uLi4gMEUuLiEuLl8uCjAwMDAwMDIwOiAxMTk3IGMzMTkgMTlmMCBiZjAwIDAwMDAg
MjAzMCAxNjhlIDEwMjEgIC4uLi4uLi4uLi4gMC4uLiEKMDAwMDAwMzA6IDliMzggZjgxZSBlYTlj
IDQ0MTkgMGMyYSBjODAwIDAwMDAgMjAzMCAgLjguLi4uRC4uKi4uLi4gMAowMDAwMDA0MDogNDFk
YSBlMzIyIDgyNmUgNTkxZCBjM2I4IGE5MWEgZjg0MSBjMzAwICBBLi4iLm5ZLi4uLi4uQS4uCjAw
MDAwMDUwOiAwMDAwIDIwMzAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgIC4uIDAuLi4u
Li4uLi4uLi4KMDAwMDAwNjA6IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAw
MCAgLi4uLi4uLi4uLi4uLi4uLgowMDAwMDA3MDogMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAw
MDAgMDAwMCAwMDAwICAuLi4uLi4uLi4uLi4uLi4uCjAwMDAwMDgwOiAwMDAwIDAwMDAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC4uLi4K

--b1=_T9Lpqh7lssyVHQpQPK3n7Kc346T2ClD1tDaKz5eR7c--

