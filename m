Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693D6CD6E4C
	for <alsa-devel@archiver.kernel.org>; Sun, 31 May 2026 00:41:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB8A56021A;
	Sun, 31 May 2026 02:41:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB8A56021A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780188092;
	bh=SVKq6zLWnEW+Y4nrMOMBoxyWyLn1HlrbF3hPgOtPOT4=;
	h=Cc:Subject:To:Date:From:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=PckkIqucwhrp95DlaVZ6SvTVJ01tqv10h6fHcl1MmHc7p2BdqzAHDAj/rKhpswTxT
	 h+n6LBEALHw2Y4PuO5OOXLHa+msaejv11Xxj5Vj+yQf9X7uJ3rx6/gv3X5lEdjCD8i
	 S7uAdZQk/BWbwRKao4WWokCLsHXVXdNG0e8s4hbQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2BF6EF800E2; Sun, 31 May 2026 02:40:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EB176F800E2;
	Sun, 31 May 2026 02:40:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 736D3F805B0; Sun, 31 May 2026 02:40:51 +0200 (CEST)
Received: from smtp-outbound8.duck.com (smtp-outbound8.duck.com
 [20.67.223.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 03DC3F80075
	for <alsa-devel@alsa-project.org>; Sun, 31 May 2026 02:40:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03DC3F80075
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=duck.com header.i=@duck.com header.a=rsa-sha256
 header.s=postal-KpyQVw header.b=AETCLhed
Cc: 
Subject: 
 =?UTF-8?Q?CX8200_=2814f1=3A2008=29_no_audio_on_HP_EliteBook_745_G5_=28?=
	=?UTF-8?Q?103c=3A83d5=29_=E2=80=94_BIOS_never_initializes_codec?=
MIME-Version: 1.0
X-Rspamd-Bar: -
X-Rspamd-Report: ARC_ALLOW(-1) DMARC_POLICY_ALLOW(-0.5) R_DKIM_ALLOW(-0.2)
 MIME_BASE64_TEXT(0.1) MIME_GOOD(-0.1) R_SPF_ALLOW(-0.2)
X-Rspamd-Score: -1.9
X-Rspamd-Action: no action
To: alsa-devel@alsa-project.org
Received: by smtp-inbound1.duck.com; Sat, 30 May 2026 20:40:44 -0400
Message-ID: <75BE61E0-2896-4A66-902F-48B1E7D0E433.1@smtp-inbound1.duck.com>
Date: Sat, 30 May 2026 20:40:44 -0400
From: realmlawton@duck.com
Feedback-ID: :isSendReply:isDirect:duckcom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com;
 h=Feedback-ID: From: Date: Message-ID: To: Content-Type: MIME-Version:
 Subject: Cc; q=dns/txt; s=postal-KpyQVw; t=1780188045;
 bh=8KO/Z6QULH1K6MN/lnZtRhHeFjqZ9bdl0fQmbPdrtio=;
 b=AETCLhedwiU5JAHnEYejIwYa6Qctet/YEo9+rRNxHrI3LPYehVKMqE/jWE3361aOhHygLn7G6
 WQXTbUo8aVaZmxS4PCOJQkoyTsXYUOJEGgOGAtaiTfMgAawUx2bf+ZQAk7pEN9LmqPWuwkizzSG
 DAZplWhpVSoHdZOsf2U6ETM=
Message-ID-Hash: 7RVSRRIBDMVZW5FCRHYOAHWTAVZK6XAB
X-Message-ID-Hash: 7RVSRRIBDMVZW5FCRHYOAHWTAVZK6XAB
X-MailFrom: realmlawton@duck.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain;
	charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7RVSRRIBDMVZW5FCRHYOAHWTAVZK6XAB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Ck1hdHRoZXcgTGF3dG9uIGhhcyBzZW50IHlvdSBhbiBlbWFpbCB2aWEgR21haWwgY29uZmlkZW50
aWFsIG1vZGU6CgpbaW1hZ2U6IEdtYWlsIGxvZ29dQ1g4MjAwICgxNGYxOjIwMDgpIG5vIGF1ZGlv
IG9uIEhQIEVsaXRlQm9vayA3NDUgRzUgKDEwM2M6ODNkNSkg4oCUIEJJT1MgbmV2ZXIgaW5pdGlh
bGl6ZXMgY29kZWMgPGh0dHBzOi8vY29uZmlkZW50aWFsLW1haWwuZ29vZ2xlLmNvbS9tc2cvQUx4
czRXNkUwb3dXQ2pqaEdrZ3dQQkkxM0Y4el8xdmhCZnJnRjd3RGN1eUpkTEJlcktmN0FnNFlMOXdI
QTZtbFRraTBRTzdBcDJXYnRZa3JCMUZ6TThTLURrWjJBUW5aUHZjcXR5dWROcUVVNnA4MTNYREgw
b0VHNzRac2VJczdEWTVLYmVGOWNINnZUcEFzSXo2amhSTkZqSVFYZzR1V1ltZHVXOVFKaGpITXli
UThXSmxKNTZvNlE2UjMxN21EPgoKVGhpcyBtZXNzYWdlIHdhcyBzZW50IG9uIE1heSAzMCwgMjAy
NiBhdCA1OjQwOjQx4oCvUE0gUERUCllvdSBjYW4gb3BlbiBpdCBieSBjbGlja2luZyB0aGUgbGlu
ayBiZWxvdy4gVGhpcyBsaW5rIHdpbGwgb25seSB3b3JrIGZvciBhbHNhLWRldmVsX2F0X2Fsc2Et
cHJvamVjdC5vcmdfcmVhbG1sYXd0b25AZHVjay5jb20uCgpWaWV3IHRoZSBlbWFpbCA8aHR0cHM6
Ly9jb25maWRlbnRpYWwtbWFpbC5nb29nbGUuY29tL21zZy9BTHhzNFc2RTBvd1dDampoR2tnd1BC
STEzRjh6XzF2aEJmcmdGN3dEY3V5SmRMQmVyS2Y3QWc0WUw5d0hBNm1sVGtpMFFPN0FwMldidFlr
ckIxRnpNOFMtRGtaMkFRblpQdmNxdHl1ZE5xRVU2cDgxM1hESDBvRUc3NFpzZUlzN0RZNUtiZUY5
Y0g2dlRwQXNJejZqaFJORmpJUVhnNHVXWW1kdVc5UUpoakhNeWJROFdKbEo1Nm82UTZSMzE3bUQ+
CgpHbWFpbCBjb25maWRlbnRpYWwgbW9kZSBnaXZlcyB5b3UgbW9yZSBjb250cm9sIG92ZXIgdGhl
IG1lc3NhZ2VzIHlvdSBzZW5kLiBUaGUgc2VuZGVyIG1heSBoYXZlIGNob3NlbiB0byBzZXQgYW4g
ZXhwaXJhdGlvbiB0aW1lLCBkaXNhYmxlIHByaW50aW5nIG9yIGZvcndhcmRpbmcsIG9yIHRyYWNr
IGFjY2VzcyB0byB0aGlzIG1lc3NhZ2UuIExlYXJuIG1vcmUgPGh0dHBzOi8vc3VwcG9ydC5nb29n
bGUuY29tL21haWwvYW5zd2VyLzc2NzQwNTk+CkdtYWlsOiBFbWFpbCBieSBHb29nbGUKVXNlIGlz
IHN1YmplY3QgdG8gdGhlIEdvb2dsZSBQcml2YWN5IFBvbGljeSA8aHR0cHM6Ly9teWFjY291bnQu
Z29vZ2xlLmNvbS9wcml2YWN5cG9saWN5P2hsPWVuPgpHb29nbGUgTExDLCAxNjAwIEFtcGhpdGhl
YXRyZSBQYXJrd2F5LCBNb3VudGFpbiBWaWV3LCBDQSA5NDA0MywgVVNBCllvdSBoYXZlIHJlY2Vp
dmVkIHRoaXMgbWVzc2FnZSBiZWNhdXNlIHNvbWVvbmUgc2VudCB5b3UgYW4gZW1haWwgdmlhIEdt
YWlsIGNvbmZpZGVudGlhbCBtb2RlLgpbaW1hZ2U6IEdvb2dsZSBsb2dvXQo=
