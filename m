Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF74CD37BE
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 14:45:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01A8B6020A;
	Mon, 11 May 2026 16:45:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01A8B6020A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778510741;
	bh=FXcBzww6HhDltvfKCBcniDcrLdoOUy64Px0Kdfu7oI0=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=B67vN8+5Q3W7NrPftpUCEIdr1pU/6e8FaOK1Xz9vC9JFrbbcQHuXZmq/bbMoQQCD7
	 fG7GN1z1fjLinue7z+K3z2D551AEuzptdvji1OIaisPWSjs1EDGrJfPnatfI5hGuFP
	 1/WXnP7/L7dxYSTKdOs8covDhiSeNd/Tyi9dpJkw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F335F8065B; Mon, 11 May 2026 16:44:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BF28F8063D;
	Mon, 11 May 2026 16:44:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C4CB0F80448; Sun, 10 May 2026 15:32:42 +0200 (CEST)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D90A3F80149
	for <alsa-devel@alsa-project.org>; Sun, 10 May 2026 15:32:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D90A3F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cYO51TzS
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-6949831a7bcso1850308eaf.1
        for <alsa-devel@alsa-project.org>;
 Sun, 10 May 2026 06:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778419958; cv=none;
        d=google.com; s=arc-20240605;
        b=CPNaUUrbkXRy2YAYnRD5NEzrIBcA8Arm49ecTzyJVuR2rRALqQgmmfsMPxDzae3K+M
         oOFEFKzMsekS/hOT4S3ko3dSe0RNcKBkUOiN/ewULcIMbRPowhGze06cZXWArSW8l3X4
         bmoTWVCHKe6MRB1RuBt4LukPFV//NFtdKcGI4opykjGDAjJBTLfVfNfyiyJ6pJKCoxAJ
         3NNDwIYP9v37j26s2DZPZ0P37i/23ZANeDF9kqjTuGSCWyYyAkH6xCM76J6ZLOVk0M5Q
         /qlobId9ghGp9hiY6YEgp7ZgUV064fiBoy+6qYuiUIVBEd+LyLwTscqih8OnXKQM/d63
         Wwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Vkpv8jz7pVTNI0xFYxzeOxZF0Tc2wiwkpJIHujOffsI=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=d8LQwwJo0l+lWnqppspIVAYGYU6pe/ax3+40LBywHY/Ig+4XOyUEzFCHaZ2j0uq8b4
         98zmSWqqaracJSes5hH40EoIpJaT20KqGHJnkuV8PzhpDfKkUB7w+eoGG0j4R6QQCAqj
         bv6QA8wb7PVvasNqKYDGvv9jhHALd1cQfZ/ThkYHY4NYmPjgWNP/46Va1jrnAc7plrCi
         RipKA0NhFlKEo1xqIBE02g0pq517MMCAsgaCwjXlx+zvIu8cSRIDgi18nWQ1Immz7yOB
         i8pEgG2pqOkfG4Lswy6j0LVkqcQkagKXcKmbYxfDVjJ2ouDrafYnMb3OEMRfpmuea68c
         mjiQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778419958; x=1779024758;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vkpv8jz7pVTNI0xFYxzeOxZF0Tc2wiwkpJIHujOffsI=;
        b=cYO51TzS6EO8QKbTQrm+GUaNmuw+uiBw1i10ivNbx8DtaNRLZO1GOZaXd9pk9gfA0Y
         7nIdkYPmjTJPn6kepP42xMg2t02ArBOwKGWntLcRNM+i8nivtNuDkaFeKBwhRDOVy5nb
         F053NrjdNA00y+IazCAxPxyUX9pP/IXzPTW9/eIRuPsBvJc15h1xeF5v0yOFdr7Y6AC7
         qDL6k4yMG1XtT21CFEBrsIWLhW1abRp2RoQtuVZR/dIznQZVk1g7OEksv9UkgX6LCBbM
         fP9f0Xrem7ad2ynkZVhR8GnJNR6YZUy97LgLDx7rJeiN1gh81mUU4hfolqOymoFW9vbi
         4gfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778419958; x=1779024758;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vkpv8jz7pVTNI0xFYxzeOxZF0Tc2wiwkpJIHujOffsI=;
        b=Yh8kOzB88ylGV7gvoSnyvm1y/Ezc9XPji4p/GPfLCB7/JJhAjCV6XnSvNH3lhmCyMr
         SqR8CD0g2mAClMuaU6mh0kPbSM0jEIYjw881YyhqrDu2pVt0lZ9g6m0HHHjLCjE2EOhh
         /HFYdYpOGHwIE5G/jbJr4W1GqEU7d3gAhwtSVjqdkrEvwkK4yW4gqmfqEOn8sH+KPEdI
         hPmjlUV69OQ6UPkRhwOqfCA2ubxE2ohkCg7Ue0NaIGJWYl5nQ5GhK20Rnp7R2Bfnwl/r
         NAu/5kEYagD7aYEbYpTPCd4QaZFdU/Brov3jzLFuNU/bgkDyIwpd0wpNtodPfNHu7Uxf
         wETA==
X-Gm-Message-State: AOJu0Yz6O4bNkDGxU03fEtrV5lninEn+lr3tseJfLapsVVv2j6HlqQX+
	sLoKCAgug1E8o3/s9zrytmm/7fscvAg2l4QUDMaQlJNIU828yKcjkSXGBj58doJdRisEQ66ZGa1
	jJ5r1B5VU00/BiZf6B9FyIxTWr67l8KCm2ZqflaY=
X-Gm-Gg: Acq92OEbcd+GE6TiuK2/e8/1pTUm1eL8ip0xHuI+RtNdImBfw/SxgmZfzbZESZttZ8Z
	GgPGM2k5r/BxEtiJqvsD0bLBgWvvOx9GSLxn6BbUmKKsAL0KshawkFZU1Z75agVG4mN0di8TYQn
	zVF8YHbp+fJiCdGfQJesCoU/5Mqqrvgq14SQ49wGt++vzdIDwAXSI2bFZSM8u63jwYK7qCGRD5a
	OOpnyeZYdk3KwoQSvyjFCbn3rhM58UVtLZgFPk227bRcfP7neYLe0WAtald11WE5ahvPRj0DlhD
	/U5wtVS5g24sOAZSpgggo9o=
X-Received: by 2002:a05:6820:1606:b0:696:2b5a:b513 with SMTP id
 006d021491bc7-69b25b7db67mr5356146eaf.21.1778419958300; Sun, 10 May 2026
 06:32:38 -0700 (PDT)
MIME-Version: 1.0
From: Haider <haiderwantstokhs@gmail.com>
Date: Sun, 10 May 2026 18:32:26 +0500
X-Gm-Features: AVHnY4IDZWzP17t52NCvFyI-nGRCGTGnNYqP7PiOPc4Jt97trn7Bi0dg-65jUxg
Message-ID: 
 <CANjSYJsJ2LCV5dLJX34vYbcuuWSa9i08FLrp8CE8C8QiUnTOBg@mail.gmail.com>
Subject: =?UTF-8?Q?HP_EliteBook_845_G10_internal_microphone_not_working?=
	=?UTF-8?Q?_on_Linux_=28ALC245=2C_SSID_103c=3A8b72=29_=E2=80=94_needs_kernel_fixup?=
To: alsa-devel@alsa-project.org
X-MailFrom: haiderwantstokhs@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: U3RDPNML6TRKRG5THUMVPY4PUJXPCW2U
X-Message-ID-Hash: U3RDPNML6TRKRG5THUMVPY4PUJXPCW2U
X-Mailman-Approved-At: Mon, 11 May 2026 14:44:32 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/U3RDPNML6TRKRG5THUMVPY4PUJXPCW2U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGksDQoNCkknbSByZXBvcnRpbmcgYSBidWcgd2hlcmUgdGhlIGludGVybmFsIG1pY3JvcGhvbmUg
ZG9lcyBub3Qgd29yayBvbiB0aGUNCkhQIEVsaXRlQm9vayA4NDUgMTQgaW5jaCBHMTAgTm90ZWJv
b2sgUEMgcnVubmluZyBMaW51eCBrZXJuZWwgNy4wLjUtYXJjaDEtMS4NCg0KVGhlIG1pY3JvcGhv
bmUgd29ya3MgY29ycmVjdGx5IG9uIFdpbmRvd3MuIE9uIExpbnV4LCB0aGUgaW50ZXJuYWwgbWlj
DQpwaW4gKDB4MTIpIGlzIGNvcnJlY3RseSBkZXRlY3RlZCBieSB0aGUga2VybmVsIGF1dG9jb25m
aWc6DQoNCiAgc25kX2hkYV9jb2RlY19hbGMyNjkgaGRhdWRpb0MxRDA6IEFMQzI0NTogcGlja2Vk
IGZpeHVwIGZvciBjb2RlYyBTU0lEDQoxMDNjOjhiNzINCiAgc25kX2hkYV9jb2RlY19hbGMyNjkg
aGRhdWRpb0MxRDA6IGlucHV0czoNCiAgc25kX2hkYV9jb2RlY19hbGMyNjkgaGRhdWRpb0MxRDA6
ICAgSW50ZXJuYWwgTWljPTB4MTINCiAgc25kX2hkYV9jb2RlY19hbGMyNjkgaGRhdWRpb0MxRDA6
ICAgTWljPTB4MTkNCg0KVGhlIGludGVybmFsIG1pYyBhcHBlYXJzIGluIHBhdnVjb250cm9sIGJ1
dCBjYXB0dXJlcyBubyBhdWRpby4gQm90aA0KdGhlICJJbnRlcm5hbCBNaWNyb3Bob25lIiBhbmQg
Ik1pY3JvcGhvbmUiIHBvcnRzIGluIHBhdnVjb250cm9sIGFwcGVhcg0KdG8gY2FwdHVyZSBmcm9t
IHBpbiAweDE5ICh0aGUgaGVhZHBob25lIGphY2sgbWljKSBvbmx5Lg0KDQpQaW4gMHgxMiBkZXRh
aWxzOg0KICBQaW5jYXAgMHgwMDAwMDAyMDogSU4NCiAgUGluIERlZmF1bHQgMHg5MGE2MDEzMDog
W0ZpeGVkXSBNaWMgYXQgSW50IE4vQQ0KICBNaXNjID0gTk9fUFJFU0VOQ0UNCiAgUGluLWN0bHM6
IDB4MjA6IElODQoNCk5vZGUgMHgyMyAoQURDIG1peGVyIGZlZWRpbmcgQURDIDB4MDgpOg0KICBD
b25uZWN0aW9uOiAweDE5IDB4MWEgMHgxYiAweDFkIDB4MTINCiAgQW1wLUluIHZhbHM6IFsweDAw
IDB4MDBdIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdDQoN
ClRoZSBjdXJyZW50IGZpeHVwIGZvciAxMDNjOjhiNzIgaXMgQUxDMjg3X0ZJWFVQX0NTMzVMNDFf
STJDXzJfSFBfR1BJT19MRUQNCndoaWNoIG9ubHkgaGFuZGxlcyB0aGUgQ1MzNUw0MSBhbXBsaWZp
ZXIgYW5kIExFRC4gTm8gbWljIHJvdXRpbmcgZml4dXANCmlzIGFwcGxpZWQuDQoNCk1hY2hpbmUg
aW5mbzoNCiAgTWFudWZhY3R1cmVyOiBIUA0KICBQcm9kdWN0OiBIUCBFbGl0ZUJvb2sgODQ1IDE0
IGluY2ggRzEwIE5vdGVib29rIFBDDQogIENvZGVjOiBSZWFsdGVrIEFMQzI0NSAoVmVuZG9yIElk
OiAweDEwZWMwMjQ1LCBTdWJzeXN0ZW0gSWQ6IDB4MTAzYzhiNzIpDQogIEtlcm5lbDogNy4wLjUt
YXJjaDEtMQ0KICBCSU9TOiBWODIgVmVyLiAwMS4xMS4wMA0KDQpQbGVhc2UgbGV0IG1lIGtub3cg
aWYgYW55IGFkZGl0aW9uYWwgaW5mb3JtYXRpb24gaXMgbmVlZGVkLg0KDQpUaGFua3MNCg==
