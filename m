Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29258CA5FA7
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:08:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17F33602AB;
	Tue, 29 Sep 2026 21:08:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17F33602AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708915;
	bh=EKxLXsbkn8QUaU2C0HNczESkVSiMxslDAvUjjLLe/JQ=;
	h=Date:To:From:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=CwxZT3KfmxPm/FaQUci8jUIcekaaY7MJyP19hc/RHWY1KBg4bK1GJwG3RutNW6lZI
	 mqKFwHB8PEYc6k6MP/OOlXhbwaHnQjWxPGzRlYA/1FPQ9SJYqW1CnpKEU8Sji8Bv9m
	 jRm6yg0fPl/FefWX6wxjYnMM4Vz6RGmjVpp/Np+8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A1A7F8061A; Tue, 29 Sep 2026 21:05:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D8282F8061C;
	Tue, 29 Sep 2026 21:05:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59589F8049C; Thu, 24 Sep 2026 11:11:49 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=185.244.194.184
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790241107;
	b=BI2dfkM3ZOGRcsQyuvUvlLL/Ro5fWbppjxyxqYH6gx/rXr9XI1VmtRu/HDCri/SDyHfc
	 aMQW35kXBMmqepeFJC33433RYm2wVdY4iaMaHqOtuSg8LGnImvWmF4LRXzcwrv3kgD+bE
	 tkjwDJJN0+Gfg5/3Y9sTVsZQpHUjA+nZ+O4xVxUcd4NvgrkISuk2lPk6/AkHApFp+R80Y
	 +WLuLscCQUBGe5HUpW3oMBXxcizuYPcTuTi0XSpTHYAIMTUQVVCSgdQGS9fOP0VuH8x/q
	 WfSbvkJIxQwH1EvJ322sEkmwqF163pf1+SuXsHkAxxsPYSd1OTGQkW0Nwnt1bej9C6Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790241107;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:To:From:Subject;
	bh=EKxLXsbkn8QUaU2C0HNczESkVSiMxslDAvUjjLLe/JQ=;
	b=rb33A9XLcE1iVfZgccHg3vdiD24dX5y6CYJXfLgIpekR1Ja1H8Mu4XkSDAqEUbKV0Zef
	 BClXCtwvybVx1leftk6B/PnDHa4b7fWq0TOkGe3HZ992hGfKYluvWmjyacE8SnJK7uIU5
	 eQIxi0PVsgQIl2e7Kdq5Nv2Lr8QtEcQtCEQL9zIqvSZSh2wYzQxvkgT2JLnH5Y9CIsEvA
	 rUK2lvVOFpuE0bbMwGOqE+DvDtgwHP9uea8XCdlGm1arA+UVQQdwzVu2te2RPNcO2Sn9y
	 0da5U6cPt/bPUO2n4y61w0p5OSCAgp4h81ZsTVrkBezqKO+s94EG/wQ4xzALi1JgQeQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=schanzis.de header.i=@schanzis.de header.a=rsa-sha256
 header.s=key2 header.b=izhvZLJX;
	arc=none smtp.remote-ip=185.244.194.184
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [185.244.194.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 697CDF801F5
	for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2026 11:11:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 697CDF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=schanzis.de header.i=@schanzis.de header.a=rsa-sha256
 header.s=key2 header.b=izhvZLJX
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hr7PY4CHHz9Cy9
	for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2026 11:11:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schanzis.de; s=key2;
	t=1790241105; bh=EKxLXsbkn8QUaU2C0HNczESkVSiMxslDAvUjjLLe/JQ=;
	h=Date:To:From:Subject:From;
	b=izhvZLJXqZElx/On0AccIbZ72R205mJcq2YaNZgNWswC7fDY/1RinFDdO9ftOD+QA
	 LO9AqX9LKAH9YYhyqCEefz9ookCGqO8fPG920fAEneytFMIcCCjk1M4RTWaWV5ubwC
	 MiXx6XRY0syhYib76PAnING6VIFz/gnYRvZcMaGww8s8Cx7v10eZXzAUUSjisjh+u5
	 wzpVXh+QFQUJDekOVRLmc5CTnkrS9v5kJmhz7idhj0P1TIZZYeQ8PLMoK6eSgSRePB
	 VsyS0zowXw3C1ZrxP1PgZUWm073zG1q+uGZCf1dWbcAcAEEdHqBMy8oXZz8ZCgw3Hj
	 TefhobSsJJTyw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hr7PY3Vshz7wjF
	for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2026 11:11:45 +0200 (CEST)
Received: from mx2ef9.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hr7PY1y2mz8sb7
	for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2026 11:11:45 +0200 (CEST)
Received: from [IPV6:2a00:fbc:f389:68c9:adda:86b1:f382:3e32] (unknown
 [IPv6:2a00:fbc:f389:68c9:adda:86b1:f382:3e32])
	by mx2ef9.netcup.net (Postfix) with ESMTPSA id D39EF1A35C0
	for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2026 11:11:39 +0200 (CEST)
Authentication-Results: mx2ef9;
        spf=pass (sender IP is 2a00:fbc:f389:68c9:adda:86b1:f382:3e32)
 smtp.mailfrom=wolfgang@schanzis.de
 smtp.helo=[IPV6:2a00:fbc:f389:68c9:adda:86b1:f382:3e32]
Received-SPF: pass (mx2ef9: connection is authenticated)
Content-Type: multipart/mixed; boundary="------------B89h05r4Zq2Dzx2ISqFTYEUQ"
Message-ID: <ecd2f852-10f1-4e17-8e38-ac39bd8cf0c4@schanzis.de>
Date: Thu, 24 Sep 2026 11:11:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: alsa-devel@alsa-project.org
From: Wolfgang Schanz <wolfgang@schanzis.de>
Subject: [BUG] Non-functional internal microphone on Lenovo IdeaPad Slim 5
 16AKP10 (83HY)
Autocrypt: addr=wolfgang@schanzis.de; keydata=
 xsFNBGpuH9IBEADDuY26qMnK92zWYabaNUQt8UBZw70BVUKS/Z01f10uDMywRfC+ZvhfMyLM
 SoOkquRFvHxYgSRkxtxwgKro+Cav1zeOPaZnwny2XhGIQEM+l087+TOyp3F83FogrI+ulWxt
 8cEOXr2b/Cj9ZeGKXy7sm0PolC25ArhtzjEDM3dHanF094u1ewnhzjbsSbz6GiEazLX16tki
 94nbdoSqxcrnTfCYJSATabRo7NYXqSVBlwElJVpiInOR9BvdEM231NdmlsCgsUP2HZitzmUu
 w9DO/MB7epzby1TzhJRzZqXilRqn5ltaX72MPonxHRd3IRvKsLz8eAzaHnjPlRjE997EkZ46
 xSDeYBVc7PJagj2938TphqwaVG2csWeHem3DJ1nA0FDXVIKjNx4pMRguqlgWT7jBC7o2PS4C
 ZpZtFp0E/dvSEcWFAfae0vr6fuSnPwlH0SL177YezXTeST88DWWENPqQP/Keur7j9RB/SdWF
 9HPgGes/Rya1VYhsMjUQYJqvZ6sG2wCsurx17B/t9H2LO1xbfWmnGCa9L6xdnJiXoydK5kTU
 5dqgVlZK8lSo16alPiGbk0uq3Osocm9WvjKZmXxOL1gtUoDD/N3yX/jYHaM35dRexlm76Vju
 4KNduhhT5MXIqnjug3CnFfMJROrvlfC8WZ/fBODZ1nK8J5UjiQARAQABzSZXb2xmZ2FuZyBT
 Y2hhbnogPHdvbGZnYW5nQHNjaGFuemlzLmRlPsLBjQQTAQgANxYhBGjClmvYpMW/WiEZrIdT
 QWQssMbMBQJqbh/UBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQh1NBZCywxsyenQ//
 S1ZmD0gKaw6Xw1pT3wymzEMPjcPzG4uHOUkO9p8mo9wusuqIl3uScpVw0Xe2WJ7zDHNLF2Oj
 koreinvwD/hZzfual8+GXmE741iORrBbeYWmkg70I7UIts5XG8gp1RaKRgylfFZdHgMQGHv9
 zp0V3Bdo/JMWKur9Ph88Q02lFilvr28T/VCIQ0cxC6mkwEt1IW8Npnj7IcPWLQXAxIoaYQCv
 X3r+aN9xMYNkxtvb7naivTAGvKWAhWYc/s2/aLu77V4HEH4Z8bOVH5yemfdbcimDttN++ROB
 KjgYHT9/26k7EPgLNoy7YxcO0Q3wZKdPokMoIaRVUtVNE/8mAVloKRF/fLLzHo8F5ErHJKXV
 D/ot53fbXItrfmLRsbLYZPlkfJiB19XLh8MOtuc6sMAOIioGvVwjcq9HaV5qUAAuVpxcDyKc
 JU3Dk+5GxgZGZ2dZr/X1UXiQT41VNPdaFuGRpKnwCgYx1+brUxTSnZn4Rcnb4x81JvxrtoVE
 R32xMcewuYSqPgDuBFRxb+kyvcS0BQs4KuvO1dhFqd8nGVAsMHEO5cLROCVDN1ZJz1649fZi
 nHr7/NtI/OV8ebv4mdn0ZS8iMi1cuC/Uy/GAlKormoDXuZdGV4UsfpP8BGv6I42z3h/Dxstv
 qwL3c9gmV745UGDq806xQrKLKh6uH7xVtMPOwU0Eam4f1AEQAJtwx0GtOn8Lb73wXhRauCI/
 KbLzF6Q6uRrWCA6TPCaVa+vaZCY18f8rpYyX/ioPIOHIeTLDFaKJ0ZchB7fuK54cL+/mxY5j
 aNyTKsPGBU4/eze1jG2bcPCUJAAvCnXereOsLmAHS8sPPmer4y8ynnWv4KRs0Me49he1NlGv
 PO9cAkpZpAtUBcA0gHa8WJdgB/gsHFtenRZWm3Q3/edx6RvaZn5EDr4nfTNq4b80kootRJ5A
 0L840RpXSpGfBDtd2G9Hc5l8jsntTYrhtOnmLllTzApH/uI2CUgmnwFKDrB+3lv5Ld/NW35/
 PZ5xQMFGQqiGPONRV9/piuXjXKzp5AJBMqJFgy+XI3I+KHrqolwOLQzR32iP3bAoGRmim22F
 fg84DVGdEuvQ9R0v2LARTq5AGzbp9sTKe5s1YVk6jS8oS/ufMB6kTHY19SDb8ymeTpLDXnH5
 D+VKh7mOXMhhPPkRQ2PaF/boUQD7o5UJJq1EdjFrwweJ7p04h1n/f7lAz40miameaG/hOWYr
 HW1Anxgiw8z2A7yClYWe4zSsVyVpWs9cd8JXjGQ0GTynWRWcbW1/hBsf5AW9X4ZKCgDZ25/Q
 EJyGa1pGVwUJD5Wdl/ax0dqM8qFIgBYHkiGJlMyiu1EL2UAnE5UB2PYevBZNZ7/GZ7NQfviW
 6NVR+3eXPL1lABEBAAHCwXwEGAEIACYWIQRowpZr2KTFv1ohGayHU0FkLLDGzAUCam4f1QUJ
 BaOagAIbDAAKCRCHU0FkLLDGzFTlD/9OwCjmicnVtJ3EjPHIw9crMwL8spqS4y4811e+MFBQ
 i3vlKYPud+R57Lzh6YZlH1VW9NqZB8HBpHO+6TII5iZA5blhojD/W3bJyM5GRRCI/G7vAWM4
 WXxXh4QSoC1SGe38ZvjDqc/rhdXfWQLeiAuB4EFAyWHrJs68/41m4WKM8OmTlabXQX/rIQfP
 hmimog9mcdQJToN5F9Cy/bsPwkiRQtqKqjQjYfRKNPzNNy0TlwQfOQzK4uTfsLYZ00649Ahk
 BS7qp7IGx2P5oh1mfJBExv3uDeUSJe+PQWGTB7QEOCVKkkqe7P7ajU0wfXSz7YQ477+BpZRz
 M4C8bVAWB/96x5/vJQz7Y6jlUow3JcqT94O/MPlSDqOX5lOXMNb0v+ezSWEUqCVJiDQbEgX/
 4F1bqeZ91y+0z+DaVTiltSTY07tYKx8IhSwOAhRaK/yEQBr5qPKYXJuC2RAoCY87/KFdNKQa
 vtIufp9Ta5Cq0WHG97gVgfprNYR+wrfySpIuGjs2X34PeGr6YFurlJC7VwD2FScT5biTUt2q
 +IGz4s2GzNhioTJCUtwO2+OHXakDlSunInoWmtDYtTIgdnN1zjGyQapbvnCPTFK3S2eHC1HK
 58aOs07IulQHudaSKcaZRYeZdrNLSWTqRQBB9RIVemIv1jPfedkGpZ85dizu4ZTSDA==
X-PPP-Message-ID: <179024110491.231766.10545949729765995272@mx2ef9.netcup.net>
X-NC-CID: lIscp7snG8wyhXW6idJi8xbg2DF+vQdbAHEUb5t1FCRYM8+w
X-MailFrom: wolfgang@schanzis.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: NPT4JWD6C2LNC5SKSLOP6MSMSTWC26BE
X-Message-ID-Hash: NPT4JWD6C2LNC5SKSLOP6MSMSTWC26BE
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:05:37 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NPT4JWD6C2LNC5SKSLOP6MSMSTWC26BE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This is a multi-part message in MIME format.
--------------B89h05r4Zq2Dzx2ISqFTYEUQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi (with the help of Claude.ai),

I'd like to report a non-functional internal microphone on a Lenovo
IdeaPad Slim 5 16AKP10 (DMI product name "83HY", board
LNVNB161216, BIOS R0CN26WW) running Ubuntu 26.04.

Both exposed capture devices (the Conexant SN6140 HDA codec path and
the AMD ACP PDM DMIC path) enumerate correctly and have all mixer
controls unmuted at full gain, but recordings from either device
contain only a brief power-on/off click with no audio signal at any
point in between.

This looks like the same class of issue fixed recently for other AMD
laptops via a DMI quirk entry, e.g.:
- "ASoC: amd: acp: Add DMI quirk for Lenovo Yoga Pro 7 15ASH11"
   (product 83W5), merged into for-7.1
- "ASoC: amd: yc: Enable internal mic on MSI Bravo 17 C7VF"
- Various prior "ASoC: amd: yc: Fix non-functional mic on Lenovo 82xx"
   patches

Full details, system info, dmesg excerpts, codec pin dumps, and the
troubleshooting already performed (mixer levels, PipeWire profile,
module parameters, raw arecord tests on both capture devices) are in
the attached bug report.

A separate community report of the identical symptom on the same
laptop model is open here: [Arch Linux forum thread URL].

Could someone advise whether this needs a new DMI quirk entry (e.g.
in sound/soc/amd/acp-config.c or the relevant acp6x/acp70
machine-driver quirk table), similar to the 83W5 fix? Happy to test
any proposed patch or provide further dmesg/ACPI dumps on request.

Thanks,
Wolfgang

--------------B89h05r4Zq2Dzx2ISqFTYEUQ
Content-Type: text/markdown; charset=UTF-8;
 name="bugreport_ideapad_slim5_16akp10_mic.md"
Content-Disposition: attachment;
 filename="bugreport_ideapad_slim5_16akp10_mic.md"
Content-Transfer-Encoding: base64

IyBCdWcgcmVwb3J0OiBJbnRlcm5hbCBtaWNyb3Bob25lIG5vbi1mdW5jdGlvbmFsIG9uIExl
bm92byBJZGVhUGFkIFNsaW0gNSAxNkFLUDEwCgoqKkNvbXBvbmVudDoqKiBTb3VuZCAvIEFM
U0EgLyBBU29DIEFNRCAoQUNQKQoqKlN1YnN5c3RlbSBhcmVhOioqIGBzb3VuZC9zb2MvYW1k
L2AgKEFDUCBETUlDIG1hY2hpbmUgZHJpdmVyKSBhbmQvb3IgYHNvdW5kL3BjaS9oZGEvcGF0
Y2hfY29uZXhhbnQuY2AKCiMjIFN1bW1hcnkKCk9uIGEgTGVub3ZvIElkZWFQYWQgU2xpbSA1
IDE2QUtQMTAsIG5laXRoZXIgb2YgdGhlIHR3byBhdWRpbyBjYXB0dXJlCmRldmljZXMgZXhw
b3NlZCBieSB0aGUga2VybmVsIHByb2R1Y2VzIHVzYWJsZSBtaWNyb3Bob25lIGlucHV0LiBC
b3RoCmlucHV0IGRldmljZXMgYXJlIGNvcnJlY3RseSBlbnVtZXJhdGVkIGJ5IEFMU0EvUGlw
ZVdpcmUsIG1peGVyIGxldmVscwphcmUgdW5tdXRlZCBhbmQgYXQgZnVsbCBnYWluLCBidXQg
cmVjb3JkaW5ncyBjb250YWluIG9ubHkgYSBicmllZgpwb3dlci1vbi9wb3dlci1vZmYgY2xp
Y2sgd2l0aCBubyBzaWduYWwgaW4gYmV0d2Vlbi4KClRoaXMgbWF0Y2hlcyB0aGUgd2VsbC1r
bm93biBjbGFzcyBvZiBidWdzIHdoZXJlIGEgbGFwdG9wIG1vZGVsIGlzCm1pc3NpbmcgZnJv
bSBhIG1hY2hpbmUgZHJpdmVyJ3MgRE1JIHF1aXJrIHRhYmxlLCBzbyB0aGUgaW50ZXJuYWwK
bWljcm9waG9uZSBoYXJkd2FyZSBpcyBpbnN0YW50aWF0ZWQgYnV0IG5ldmVyIHByb3Blcmx5
IGJvdW5kL2Nsb2NrZWQuClJlY2VudCBleGFtcGxlcyBvZiB0aGUgc2FtZSBwYXR0ZXJuIGJl
aW5nIGZpeGVkIHZpYSBETUkgcXVpcmtzOgoKLSBgQVNvQzogYW1kOiBhY3A6IEFkZCBETUkg
cXVpcmsgZm9yIExlbm92byBZb2dhIFBybyA3IDE1QVNIMTFgIChwcm9kdWN0IGA4M1c1YCks
IG1lcmdlZCBpbnRvIGBmb3ItNy4xYCBieSBNYXJrIEJyb3duLCBNYXkgMjAyNgotIGBBU29D
OiBhbWQ6IHljOiBFbmFibGUgaW50ZXJuYWwgbWljIG9uIE1TSSBCcmF2byAxNyBDN1ZGYCwg
TWF5IDIwMjYKLSBgQVNvQzogYW1kOiB5YzogQWRkIERNSSBxdWlyayBmb3IgTVNJIFJhaWRl
ciBBMTggSFggQTlXSkdgLCBNYXkgMjAyNgotIE11bHRpcGxlIHByaW9yIGBBU29DOiBhbWQ6
IHljOiBGaXggbm9uLWZ1bmN0aW9uYWwgbWljIG9uIExlbm92byA4Mnh4YCBwYXRjaGVzICg4
MllNLCA4MlRMLCA4MlYyLCA4MlFGLCA4MlVHLCA4MlNKLCBldGMuKQoKV2UgcmVxdWVzdCB0
aGF0IGEgc2ltaWxhciBETUktYmFzZWQgcXVpcmsgZW50cnkgYmUgYWRkZWQgZm9yIHRoaXMK
bW9kZWwgKERNSSBwcm9kdWN0IG5hbWUgYDgzSFlgKS4KCiMjIFN5c3RlbSBpbmZvcm1hdGlv
bgoKLSAqKkxhcHRvcCBtb2RlbDoqKiBMZW5vdm8gSWRlYVBhZCBTbGltIDUgMTZBS1AxMAot
ICoqRE1JIHN5c3RlbS1wcm9kdWN0LW5hbWU6KiogYDgzSFlgCi0gKipETUkgc3lzdGVtLXZl
cnNpb246KiogYElkZWFQYWQgU2xpbSA1IDE2QUtQMTBgCi0gKipETUkgYmFzZWJvYXJkLXBy
b2R1Y3QtbmFtZSAvIGJvYXJkX25hbWU6KiogYExOVk5CMTYxMjE2YAotICoqQklPUyB2ZXJz
aW9uOioqIGBSMENOMjZXV2AKLSAqKkRpc3RyaWJ1dGlvbjoqKiBVYnVudHUgMjYuMDQKLSAq
Kktlcm5lbCB2ZXJzaW9uOioqIGB1bmFtZSAtcmAg4oCUIDcuMC4wLTMxLWdlbmVyaWMKLSAq
KkF1ZGlvIHN0YWNrOioqIFBpcGVXaXJlIDEuNi4yICsgV2lyZVBsdW1iZXIgMS42LjIKCiMj
IEhhcmR3YXJlIGRldGVjdGVkIChsc3BjaSkKCmBgYAowNDowMC4xIEF1ZGlvIGRldmljZTog
QU1EL0FUSSBSYWRlb24gSGlnaCBEZWZpbml0aW9uIEF1ZGlvIENvbnRyb2xsZXIKICAgICAg
ICBTdWJzeXN0ZW06IExlbm92byBEZXZpY2UgMzg1NgogICAgICAgIEtlcm5lbCBkcml2ZXIg
aW4gdXNlOiBzbmRfaGRhX2ludGVsCgowNDowMC41IE11bHRpbWVkaWEgY29udHJvbGxlcjog
QU1EIEF1ZGlvIENvcHJvY2Vzc29yIChyZXYgNzIpCiAgICAgICAgU3Vic3lzdGVtOiBMZW5v
dm8gRGV2aWNlIDM4YzYKICAgICAgICBLZXJuZWwgZHJpdmVyIGluIHVzZTogc25kX2FjcF9w
Y2kKICAgICAgICBLZXJuZWwgbW9kdWxlczogc25kX3BjaV9hY3AzeCwgc25kX3JuX3BjaV9h
Y3AzeCwgc25kX3BjaV9hY3A1eCwKICAgICAgICBzbmRfcGNpX2FjcDZ4LCBzbmRfYWNwX3Bj
aSwgc25kX3JwbF9wY2lfYWNwNngsCiAgICAgICAgc25kX3NvZl9hbWRfcmVub2lyLCBzbmRf
c29mX2FtZF9yZW1icmFuZHQsIHNuZF9zb2ZfYW1kX3ZhbmdvZ2gsCiAgICAgICAgc25kX3Nv
Zl9hbWRfYWNwNjMsIHNuZF9zb2ZfYW1kX2FjcDcwCgowNDowMC42IEF1ZGlvIGRldmljZTog
QU1EIFJ5emVuIEhEIEF1ZGlvIENvbnRyb2xsZXIKICAgICAgICBTdWJzeXN0ZW06IExlbm92
byBEZXZpY2UgMzhiNgogICAgICAgIEtlcm5lbCBkcml2ZXIgaW4gdXNlOiBzbmRfaGRhX2lu
dGVsCmBgYAoKQ29kZWMgb24gMDQ6MDAuNiBpcyBhICoqQ29uZXhhbnQvU3luYXB0aWNzIFNO
NjE0MCoqCihgYWxzYS5jb21wb25lbnRzID0gIkhEQToxNGYxMWY4NywxN2FhMzgyNCwwMDEw
MDEwMCJgLCBQQ0kgU1NJRApyZXBvcnRlZCBieSB0aGUgYXV0by1wYXJzZXIgYXMgYDE3YWE6
MDAwMGApLgoKUmVsZXZhbnQgbG9hZGVkIG1vZHVsZXMgZnJvbSBgZG1lc2dgOgpgYGAKc25k
X3NvY19uYXU4ODIxIHNuZF9hY3AzeF9ybiBzbmRfYWNwNzAgc25kX2FjcF9pMnMgc25kX3Nv
Y19kbWljCnNuZF9hY3BfcGRtIHNuZF9hY3BfcGNtIHNuZF9zb2ZfYW1kX2FjcDcwIHNuZF9z
b2ZfYW1kX2FjcDYzCnNuZF9zb2ZfYW1kX3ZhbmdvZ2ggc25kX3NvZl9hbWRfcmVtYnJhbmR0
IHNuZF9zb2ZfYW1kX3Jlbm9pcgpzbmRfc29mX2FtZF9hY3Agc25kX3NvZl9wY2kgc25kX3Nv
Zl94dGVuc2FfZHNwIHNuZF9zb2NfYWNwaV9hbWRfbWF0Y2gKc25kX3NvY19hY3BpX2FtZF9z
ZGNhX3F1aXJrcyBzbmRfYW1kX3Nkd19hY3BpIHNuZF9oZGFfY29kZWNfY29uZXhhbnQKc291
bmR3aXJlX2FtZCBzbmRfaGRhX2NvZGVjX2hkbWkgc291bmR3aXJlX2dlbmVyaWNfYWxsb2Nh
dGlvbgpzb3VuZHdpcmVfYnVzIHNuZF9zb2Nfc2RjYSBzbmRfaGRhX2ludGVsIHNuZF9pbnRl
bF9kc3BjZmcKc25kX2ludGVsX3Nkd19hY3BpCmBgYAoKIyMgQ2FwdHVyZSBkZXZpY2VzIGV4
cG9zZWQKCmBgYAokIGFyZWNvcmQgLWwKS2FydGUgMTogR2VuZXJpY18xIFtIRC1BdWRpbyBH
ZW5lcmljXSwgR2Vyw6R0IDA6IFNONjE0MCBBbmFsb2cgW1NONjE0MCBBbmFsb2ddCiAgU3Vi
LUdlcsOkdGU6IDAvMQogIFN1Yi1HZXLDpHQgIzA6IHN1YmRldmljZSAjMApLYXJ0ZSAyOiBh
Y3BwZG1tYWNoIFthY3AtcGRtLW1hY2hdLCBHZXLDpHQgMDogRE1JQyBjYXB0dXJlIGRtaWMt
aGlmaS0wIFtdCiAgU3ViLUdlcsOkdGU6IDEvMQogIFN1Yi1HZXLDpHQgIzA6IHN1YmRldmlj
ZSAjMApgYGAKCiMjIENvZGVjIHBpbiBjb25maWd1cmF0aW9uIChjYXJkIDEsIENvbmV4YW50
IFNONjE0MCkKCmBgYApOb2RlIDB4MWEgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDQ4Yjog
U3RlcmVvIEFtcC1JbgogIENvbnRyb2w6IG5hbWU9IkludGVybmFsIE1pYyBCb29zdCBWb2x1
bWUiCiAgUGluY2FwIDB4MDAwMDAwMjQ6IElOIERldGVjdAogIFBpbiBEZWZhdWx0IDB4OTVh
NjAxMjA6IFtGaXhlZF0gTWljIGF0IEludCBUb3AKICAgIENvbm4gPSBEaWdpdGFsLCBDb2xv
ciA9IFVua25vd24KICAgIERlZkFzc29jaWF0aW9uID0gMHgyLCBTZXF1ZW5jZSA9IDB4MAog
ICAgTWlzYyA9IE5PX1BSRVNFTkNFCiAgUGluLWN0bHM6IDB4MjA6IElOCgpOb2RlIDB4MTkg
W1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDQ4YjogU3RlcmVvIEFtcC1JbgogIENvbnRyb2w6
IG5hbWU9Ik1pYyBCb29zdCBWb2x1bWUiCiAgUGluY2FwIDB4MDAwMDEzMjQ6IElOIERldGVj
dCwgVnJlZiBjYXBzOiBISVogNTAgODAKICBQaW4gRGVmYXVsdCAweDAzYTExMDMwOiBbSmFj
a10gTWljIGF0IEV4dCBMZWZ0CiAgICBDb25uID0gMS84LCBDb2xvciA9IEJsYWNrCiAgICBE
ZWZBc3NvY2lhdGlvbiA9IDB4MywgU2VxdWVuY2UgPSAweDAKICBQaW4tY3RsczogMHgyMDog
SU4gVlJFRl9ISVoKYGBgCgpOb3RlIHRoZSBpbnRlcm5hbC1taWMgcGluIChgMHgxYWApIHJl
cG9ydHMgYENvbm4gPSBEaWdpdGFsYCB3aXRoCmBDb2xvciA9IFVua25vd25gIGFuZCBgTWlz
YyA9IE5PX1BSRVNFTkNFYCwgd2hpY2ggbG9va3MgbGlrZSBhCm5vbi1mdW5jdGlvbmFsL3Bs
YWNlaG9sZGVyIHBpbiBlbnRyeSByYXRoZXIgdGhhbiBhIHJlYWwgYW5hbG9nCmNvbm5lY3Rp
b24g4oCUIGNvbnNpc3RlbnQgd2l0aCB0aGUgaW50ZXJuYWwgbWljIGFjdHVhbGx5IGJlaW5n
IHJvdXRlZAp0aHJvdWdoIHRoZSBBTUQgQUNQIFBETSBwYXRoIChjYXJkIDIpIHJhdGhlciB0
aGFuIHRocm91Z2ggdGhpcyBjb2RlYy4KCiMjIFN0ZXBzIGFscmVhZHkgdGFrZW4gKGFsbCBy
dWxlZCBvdXQgYXMgdGhlIGNhdXNlKQoKMS4gVmVyaWZpZWQgQUxTQSBtaXhlciBsZXZlbHMg
b24gYm90aCBjYXJkczogYENhcHR1cmVgLCBgTWljIEJvb3N0YCwKICAgYEludGVybmFsIE1p
YyBCb29zdGAgYWxsIGF0IDEwMCwgbm90aGluZyBtdXRlZC4KMi4gVmVyaWZpZWQgUGlwZVdp
cmUvV2lyZVBsdW1iZXIgc291cmNlIHNlbGVjdGlvbiBhbmQgZGVmYXVsdCBkZXZpY2UKICAg
dmlhIGB3cGN0bCBzdGF0dXNgLgozLiBTd2l0Y2hlZCBQaXBlV2lyZSBBQ1AgcHJvZmlsZSBm
cm9tIGBwcm8tYXVkaW9gIHRvCiAgIGBIaUZpIChNaWMxLCBNaWMyLCBTcGVha2VyKWAgb24g
Y2FyZCBgYWxzYV9jYXJkLnBjaS0wMDAwXzA0XzAwLjZgIOKAlAogICBubyBjaGFuZ2UgaW4g
YmVoYXZpb3VyLgo0LiBSZWluc3RhbGxlZCBgc29mLWZpcm13YXJlYC4KNS4gQ29uZmlybWVk
IG5vIHJlbGV2YW50IG1vZHVsZSBwYXJhbWV0ZXJzIGV4aXN0IGZvciB0aGUgbG9hZGVkIEFD
UAogICBkcml2ZXIgKGBtb2RpbmZvYC9gL3N5cy9tb2R1bGUvKi9wYXJhbWV0ZXJzL2AgZW1w
dHkgZm9yCiAgIGBzbmRfYWNwX3BjaWAsIGBzbmRfc29mX2FtZF9hY3A3MGAsIGBzbmRfcGNp
X3BzYCkuCjYuIERpcmVjdCBgYXJlY29yZCAtRCBodzpYLDAgLi4uIC12YCB0ZXN0cyBvbiAq
KmJvdGgqKiBjYXJkIDEKICAgKFNONjE0MCkgYW5kIGNhcmQgMiAoYWNwLXBkbS1tYWNoKTog
aW4gYm90aCBjYXNlcywgb25seSBhIGJyaWVmCiAgIHBvcC9jbGljayBpcyBoZWFyZCBhdCB0
aGUgc3RhcnQgYW5kIGVuZCBvZiB0aGUgcmVjb3JkaW5nLCBubyBsZXZlbAogICBtb3ZlbWVu
dCBvbiB0aGUgVlUgbWV0ZXIsIGFuZCBubyBzaWduYWwgaW4gdGhlIHJlc3VsdGluZyBmaWxl
IGF0CiAgIGFueSBwb2ludCBpbiBiZXR3ZWVuLgoKIyMgRXhwZWN0ZWQgYmVoYXZpb3IKClRo
ZSBpbnRlcm5hbCBtaWNyb3Bob25lICh3aGljaGV2ZXIgcGh5c2ljYWwgcGF0aCBpcyBjb3Jy
ZWN0IOKAlCBQRE0KYXJyYXkgdmlhIEFDUCwgb3IgdGhlIFNONjE0MCBhbmFsb2cgcGF0aCkg
c2hvdWxkIGNhcHR1cmUgYXVkaW8uCgojIyBBY3R1YWwgYmVoYXZpb3IKCk5vIGF1ZGlvIGlz
IGNhcHR1cmVkIG9uIGVpdGhlciBleHBvc2VkIGNhcHR1cmUgZGV2aWNlOyBvbmx5IGEKcG93
ZXItc2VxdWVuY2luZyBwb3AvY2xpY2sgaXMgYXVkaWJsZSBhdCB0aGUgc3RhcnQgYW5kIGVu
ZCBvZiBhCnJlY29yZGluZy4KCiMjIEFkZGl0aW9uYWwgbm90ZXMKCi0gVGhlIGJvYXJkIG5h
bWUgYExOVk5CMTYxMjE2YCByZXBvcnRlZCBieSB0aGlzIHN5c3RlbSBpcyBhIGdlbmVyaWMK
ICBMZW5vdm8gcmVmZXJlbmNlLWRlc2lnbiBib2FyZCBuYW1lIHRoYXQgaGFzIGJlZW4gcmV1
c2VkIGFjcm9zcyBtYW55CiAgdW5yZWxhdGVkIG1vZGVscy95ZWFycyAoZS5nLiBpdCBhbHNv
IG1hdGNoZXMgYSBtdWNoIG9sZGVyIDIwMjAKICBJZGVhUGFkIEZsZXggNSAxNEFSRTA1IFJl
bm9pci1iYXNlZCBxdWlyayBlbnRyeSksIHNvIGFueSBuZXcgcXVpcmsKICBmb3IgdGhpcyBz
eXN0ZW0gc2hvdWxkIG1hdGNoIG9uIGBETUlfUFJPRFVDVF9OQU1FICI4M0hZImAKICBzcGVj
aWZpY2FsbHksIG5vdCBvbiB0aGUgYm9hcmQgbmFtZS4KLSBBIHNlcGFyYXRlIGNvbW11bml0
eSByZXBvcnQgb2YgdGhlIGlkZW50aWNhbCBzeW1wdG9tLCBvbiB0aGUgc2FtZQogIGxhcHRv
cCBtb2RlbCwgaXMgb3BlbiBoZXJlOiBodHRwczovL2Jicy5hcmNobGludXgub3JnL3ZpZXd0
b3BpYy5waHA/aWQ9MzA5NjI0CgojIyBSZXF1ZXN0CgpQbGVhc2UgYWRkIGEgRE1JLWJhc2Vk
IHF1aXJrIGVudHJ5IGZvciBETUkgcHJvZHVjdCBuYW1lIGA4M0hZYAooTGVub3ZvIElkZWFQ
YWQgU2xpbSA1IDE2QUtQMTApIHRvIGVuYWJsZSB0aGUgY29ycmVjdCBtaWNyb3Bob25lIHBh
dGgsCmZvbGxvd2luZyB0aGUgc2FtZSBwYXR0ZXJuIGFzIHRoZSByZWNlbnQgYDgzVzVgIChM
ZW5vdm8gWW9nYSBQcm8gNwoxNUFTSDExKSBmaXggaW4gYHNvdW5kL3NvYy9hbWQvYWNwLWNv
bmZpZy5jYCwgb3IgdGhlIGVxdWl2YWxlbnQKYGFjcDZ4LW1hY2guY2AvQUNQNzAgbWFjaGlu
ZS1kcml2ZXIgcXVpcmsgdGFibGUgaWYgdGhpcyBtb2RlbCB0dXJucwpvdXQgdG8gdXNlIGEg
ZGlmZmVyZW50IEFDUCBnZW5lcmF0aW9uLiBIYXBweSB0byB0ZXN0IGFueSBwcm9wb3NlZApw
YXRjaCBvciBwcm92aWRlIGZ1cnRoZXIgYGRtZXNnYC9BQ1BJIGR1bXBzIG9uIHJlcXVlc3Qu
Cg==

--------------B89h05r4Zq2Dzx2ISqFTYEUQ--
