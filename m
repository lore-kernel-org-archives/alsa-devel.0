Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45F9C4451B
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:10:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBF2B601F3;
	Fri, 17 Jul 2026 17:10:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBF2B601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784301026;
	bh=1DslkhfwbiJvEz46a3AyAcYrjJgaYmqYcA8277kw1Mo=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=aMnuEW7ZRrNG4kFrJCvnsRHTS6avHDBCecJaZra5jOvPWY5MVfuRQImVQURExaXKz
	 XCPZLjm1WG6Xsmsprshq80Om/cbRx6OmwPhyqHC9IkAaOyDZFxPWIcbVzVE44b4/ph
	 BtCzR0kk7MRi4/YhwCJaoWa3nmCS+drHnl8NWaFw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F667F805FF; Fri, 17 Jul 2026 17:09:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D2D2BF805FF;
	Fri, 17 Jul 2026 17:09:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E98A3F80526; Fri, 17 Jul 2026 17:09:45 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.169
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1784300985;
	b=Ac3D/RSZk7lmbQyEj4tumojPn8MYUCaUYYOVBFgsvN3wbjQfOD69nxzXle3g1YTnHZtF
	 w3cArdFculTYAKl3S0rBBLN3Ix/+fLBqH7YgwE2NgT2oevNJSnfO2QU+ZqgsSbT3cAfmB
	 orESYazIacCxDu0fH5Y+JI87BSduzGTKsV48YEU7QVmNHx0tmRS+QEoJJAlXFb2INCDLS
	 YiTqXD8bDwUebrnPB6NVX359JrwW2pHjjdpDnVXnc14NF/ebvl41jvMUHIx/BHF/hOaD9
	 rNxhs06Nt43r0JfSoz6jNOu9e65+Fzpm3/EkvpBBvuDopZitAYRM5hJFdrVfbDBnHOg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784300985;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=FjORrjpRgjzX+mV85AnPQBgL6W+O7Z78YF0VyoLk8wE=;
	b=lm+PIbNN6LuULV72PUAM3hQL7txrVBR1ZjT3ylWPXPIkh1uGjiz/9W9nHh6Q6HDho8Fn
	 /BvP9AMiTmpMc5dVIoK/3ydadhC/nrPBFX9+U8oT83kd8S2A8cL5FS26/H5C6EzE4Pjqw
	 +0zQrt/frMdPGP56nzYSZlXeZClgzvo9VKktTupg6WK3+ZCLiKbAzj0pRBW6CngIlPGYF
	 xwNChXzOC+GDSw9ypczZSM6FgzyZe2B02PnrTAs5XSfOKvcylYliZQy/bgnh/6ngHuyhM
	 dVeISecROP6oB2ePCq6FW3amdiKTfXXdUwa6c8rRxRcwdXS9ll2opHSOXN6p7DQuxwA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=hsZNlJ8b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 66DEBF8025A
	for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2026 17:09:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66DEBF8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=hsZNlJ8b
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-ca6bda96134so463856a12.3
        for <alsa-devel@alsa-project.org>;
 Fri, 17 Jul 2026 08:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784300982; cv=none;
        d=google.com; s=arc-20260327;
        b=W1rVatyYpUBOkKntnVIGAEeeYSPJYmE/4p7kT5/MnOhrJ1+NHsfx8oaWskDYO44nYR
         O6J7s67Q5hnchMrs7RGB4gIEnO6rR0vUxAF1NcR0rTTBrgTZMykNWmE/Kj85uM9e1GLU
         zTdiJ+T7+WU9KHB+xH+mBWfMnKB+WYeyZGzJfHbK4mWcx5BNq6iw7EWjvXWUHAx4pvoQ
         XzAXuP4rQbqCcBCYC/BgiSs1ZTgdFPuU9FWwmZvpRJwpNvgVJNJbCVcohTINkWljEC5s
         G0Kw13mo8hwUH2ksqH1x+QVyFEP3a9cl99NT3qxj6qYAphIunZoA0+rBmjfC4ELfAlCx
         bBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=a3GbprOUWPVyPV2ZleGXlt6qKHTuq/qV3lUdwE3HjhI=;
        fh=+Ze04VPT5qbxKO/UZIoGNm+tS+O0IHH4ohBHWziwaDo=;
        b=UTyPxA3kfCp6HyAcTKgxKpI9rMC6PPaBSfnVWs7zzw5u7CsPYI0lT93iPDFbTc1uU7
         EzX5Twz5qjhkkBLV+Zlx+ce3KYpCqDdmiXgIoMyatp9SbkwDgiOXvV/j10Q9sxsR2CsW
         T7ELjOuX12kGgWFS8LHAeGx9/i7c2Pp28YvzFZcKr8ye/U5jOtIMXiH1mEnAxICiq3rg
         kJLd9EiXeQ8EqOCTXrcFcx+K40171LwkN6Q7vfgYf0D8LTmOjfYQf9+cOkCvz/LRi4Vm
         3QVpCcK2kTdYwInFDqpCX4K7s3xUuYTXH9CB9J5+HS1rn0u8bc4xJuipMkaN1wxH6p7D
         v9JA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300982; x=1784905782;
 darn=alsa-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=a3GbprOUWPVyPV2ZleGXlt6qKHTuq/qV3lUdwE3HjhI=;
        b=hsZNlJ8brSZG2fZYzukrkuFYuZu/GXWfg4CFtT+GYBApC/mfXpY2x2bj4Mv7/YhfDd
         FDr5DdHWdi6t/Nlm9Ys5F9YXXdQNqIKD7q9oGLQNnlcjJfhBtYGX7NQdkVQCZAqdeVfc
         uoXECH+E0UPJjRPqMq5BXsRes9NjM9Q80r0+ej71IZHximx0JN4hCv1234JuSGirDzih
         IOyUrSi2hvu7S/ruReZHrvsvSOsYAHjAwSiu2Y5OeZ3sWAETIvQEMq1uhB0l3Etqwbm/
         VZ37Iej+NDvDCz7aFRn0FTh3dnpBpG47VSAH41HBATHU6K1hglnlOB33lC+P8L/rnsMB
         o8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300982; x=1784905782;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a3GbprOUWPVyPV2ZleGXlt6qKHTuq/qV3lUdwE3HjhI=;
        b=pb0xfpPyaXu+wvidQzNMzwLPiVETDd/j4Redq+IzYKA6cG/DYMI6/rbcSNo44zu5mG
         07t947/KcaoX3nquQLSSvBTkKPnHs2GZEFRRHjitTz7GRliub9CW3qoNzCu2uxCAlnmK
         ODCLtWqMOi5G93jFsOvJPvJSpqm9Zw6ObFdlpXrO8vH/rcr65t3gq23WoF/fixpT/ozs
         q2aUO4noo8alyNnYFIIWxVf1kGP6c1Fgm0iVEq+kVehhwy4RuP1wuFpunTO7IugOcZ/o
         pO5MQvJVLxMBBVvnR2L93VobaeoyX9HG4YFzYyyj+PxAwYxMn4UTZHIOLnCCelb4MeZA
         4t0w==
X-Gm-Message-State: AOJu0YxmedHtgfjoa/0R28lRBfzNdNVof1bfdQi+apN5qYX23DcK/k40
	yU7lgZhSoe257iWVcG2bE79CR7f2XiczOB2hArT4E8dasY8hITwsodKy+KoUSy6WUFvPhVyWkfs
	unqztcufEpk0uiy5y0LfBs0E/XYKu6QNizWmO
X-Gm-Gg: AfdE7cnLcD0ND92gg9nX9TpJEHwq/3N+896JyfqK/vg3XZ8hsJUJbOMqr62oh8zrbi+
	E6QLI52BGKtq9SznE1niuB47ffwQlT9NCepQEXGRBju0aV4I/HuZGVqwi9bpqwIJ6Rmq6oXDnlk
	X5P00pbUSZiA4P/LCs2oaNarxVEU4aslKNf68f2a4uj6Y6WJSf+7V1aTHs7SZcMmJxlG2uumtxh
	JKmNavHT0Ul3+jAtvjisv+hKEUBmrf8MnClMcZXNA5TB0xJbgbf4DDqzmYPNfC4/UayleZSvgMJ
	EjZ5jwYw0ydh
X-Received: by 2002:a17:902:f686:b0:2c9:d8c6:1db3 with SMTP id
 d9443c01a7336-2cf349c0eedmr27014605ad.8.1784300981571; Fri, 17 Jul 2026
 08:09:41 -0700 (PDT)
MIME-Version: 1.0
From: Grant Diffey <gdiffey@gmail.com>
Date: Sat, 18 Jul 2026 01:09:28 +1000
X-Gm-Features: AUfX_mwvoyqAz6mGAvoz7EtkYKc_VuaDyEUwiq6oChovjwAUVcEjFu4f8cAbqqw
Message-ID: 
 <CACckToUv2Y-T8xjeJ7_+39jPuQ1u5yksoMd=dFC=--n1s2ymhw@mail.gmail.com>
Subject: [PATCH] Apply Quirks to m-audio FTU for controls
To: ALSA development <alsa-devel@alsa-project.org>
Message-ID-Hash: VUEMS623QM3KG43ACY5HNAYKIBCF5HJC
X-Message-ID-Hash: VUEMS623QM3KG43ACY5HNAYKIBCF5HJC
X-MailFrom: gdiffey@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VUEMS623QM3KG43ACY5HNAYKIBCF5HJC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

R0VUX0NVUiBkb2Vzbid0IHdvcmsgb24gdGhlIGZhc3QgdHJhY2sgdWx0cmENCi0tLQ0Kc291bmQv
dXNiL3F1aXJrcy5jIHwgMiArKw0KMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpk
aWZmIC0tZ2l0IGEvc291bmQvdXNiL3F1aXJrcy5jIGIvc291bmQvdXNiL3F1aXJrcy5jDQppbmRl
eCA0MTE0OTU2MWFhMDYuLmFiNWQwMDhhMjc0OCAxMDA2NDQNCi0tLSBhL3NvdW5kL3VzYi9xdWly
a3MuYw0KKysrIGIvc291bmQvdXNiL3F1aXJrcy5jDQpAQCAtMjMyMCw2ICsyMzIwLDggQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCB1c2JfYXVkaW9fcXVpcmtfZmxhZ3NfdGFibGUNCnF1aXJrX2ZsYWdz
X3RhYmxlW10gPSB7DQogICAgICAgICAgICAgICAgICBRVUlSS19GTEFHX0dFTkVSSUNfSU1QTElD
SVRfRkIpLA0KICAgICAgIERFVklDRV9GTEcoMHgwNzYzLCAweDIwMzEsIC8qIE0tQXVkaW8gRmFz
dCBUcmFjayBDNjAwICovDQogICAgICAgICAgICAgICAgICBRVUlSS19GTEFHX0dFTkVSSUNfSU1Q
TElDSVRfRkIpLA0KKyAgICAgICBERVZJQ0VfRkxHKDB4MDc2MywgMHgyMDgwLCAvKiBNLUF1ZGlv
IEZhc3QgVHJhY2sgVWx0cmEgKi8NCisgICAgICAgICAgICAgICAgICBRVUlSS19GTEFHX01JWEVS
X0dFVF9DVVJfQlJPS0VOIHwNClFVSVJLX0ZMQUdfR0VORVJJQ19JTVBMSUNJVF9GQiksDQogICAg
ICAgREVWSUNFX0ZMRygweDA3ZmQsIDB4MDAwYiwgLyogTU9UVSBNIFNlcmllcyAybmQgaGFyZHdh
cmUgcmV2aXNpb24gKi8NCiAgICAgICAgICAgICAgICAgIFFVSVJLX0ZMQUdfQ1RMX01TR19ERUxB
WV8xTSksDQogICAgICAgREVWSUNFX0ZMRygweDA4YmIsIDB4MjcwMiwgLyogTGluZVggRk0gVHJh
bnNtaXR0ZXIgKi8NCi0tDQoyLjUzLjANCg==
