Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F076CD3445
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2026 13:54:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1B8D6021B;
	Fri,  8 May 2026 15:54:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1B8D6021B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778248462;
	bh=UvWQbTHYpO0cgyGhyOctinN1JH9Iket436cflA5fTuw=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZGRB7Oy7N9sRGCftZzFdFcqFv09sXFPgl/M5pWUd7E5nppq669mjaEJQrqEAjEHOS
	 HDrzx/OafPiJyGlG3ZKEhknX/fbfnKERFZHVS6wA9DZADiC45nXhZstmHdXtN/ires
	 ca5JAaP49nxj0yDMGJCV0NF3JIrecOm9/kY5t0lc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E71BF805E8; Fri,  8 May 2026 15:53:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DE1AF805F2;
	Fri,  8 May 2026 15:53:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89E36F804F3; Fri,  8 May 2026 15:53:44 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AD21EF80169
	for <alsa-devel@alsa-project.org>; Fri,  8 May 2026 15:53:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD21EF80169
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZgpVB/kv
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-899a5db525cso12731926d6.3
        for <alsa-devel@alsa-project.org>;
 Fri, 08 May 2026 06:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778248421; cv=none;
        d=google.com; s=arc-20240605;
        b=KJfLn0rfNqdLPGeFUra8c78tGKXB8UpSXD3LkXHPVyPvj9qQ+X9PEYAvnQnsRRORtN
         5Fwukm97BLflTABuoEK+WmNzkD5lGO7U7ZJC26Uxx9yOIGsSmsqjxd0ic4Rl06xw6za2
         BgXlcO3szOa9cZD4GL+DKT4i/HUmdUueob0wCd+gr0hS30zhBjjjznO30NoNo6wAGKZ9
         JIaXbugDhntk0F+4iWdmsgyCsFCnnhX+UVlTDlKWth2aJXL73M1iLvKjfHH4Wnrci+xQ
         HHKy9m2wFPurQIhoXkeHEqRHM7HMQ85PXoid4eB6j+M2XRdPRYskDxvsOnqfgGZBNtLe
         qA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QtAgIieeGs/jHobwPUg6SLjPlAiw0DjETgfEBVBDTro=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=do7SCr5XDQ5mKBTTsOgzFvBwtQCIG55iVP+zfhWW5PLn4IDQNMvgFrSd7yypkDVSL9
         J4WHtl7avVgWW7P3rHY2YmSTbFVtvz7vWatetqa5URCfFedlHUHaWfsv0Ob9p4DdRGAQ
         o5U983HBQJ9v6vVC+7oM8/MFRyn+azn+kCTmijcfYgaFEEgqk16P2KHB1Y8EVVDfGnhA
         gbVAh1ThWtCcbqYnuWxO1RZnnyy07R1kAfomXHxYRBqsCGBun4MCIymnwUN+IU+pEd/H
         4uz0xFmWnK3NyBTJoVVfSywYQTJdNUkyyuvoXw4Put/f1yIiqMm/CpmAheeEhGNSjFQq
         T2Sw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778248421; x=1778853221;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QtAgIieeGs/jHobwPUg6SLjPlAiw0DjETgfEBVBDTro=;
        b=ZgpVB/kvLTyu7Mm8ketnWfE1ynlkDL90QeJyzMH6NB29w0o+wv+2qqHfcmYQsDZRkT
         BgIcOjM71V94bVavVxTfrI3dp0qYN0/1zRvGfJ5lFk8mVq/E7ODlPu8HUZO+/IUoView
         /6tRQ2q9GC5esj+IrNehZIGGCByKnDrLQ4NTRYUk78iuyCPbmbNLNCsaPUkc+DB4EkFO
         4kf8Adw+6MbH+yEx3ApMEL5pR4N1TCi41EIK0dHeqTCMKNBWrw1LjmMl/dv2WGxs9iBO
         bIv/YEsWzAo0zav42s8oSWsjcEOk5Ae+3zW8tAyg7E9iZuQ2yA98OurFbxdYq8gfx9zI
         T0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778248421; x=1778853221;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtAgIieeGs/jHobwPUg6SLjPlAiw0DjETgfEBVBDTro=;
        b=LeJVP0a0gapEY7CJxwPgjYLC+eFKshLjo/J5DKYAYD86EYjspYhUoA0TZXWvtd9DS7
         QkJPrH6EqPggveCRPDfKu00VC9iTtaotByTdbvfKCrCBVD1aiME2VcjXe7Qkafe5e97E
         iN+LYAJTpwaP1mlbTLReHDay5x67S6Fvv3LwQjQK5jGB8PGvxDIbVl1z7XDIMRxMp9Ua
         bz7vR3AzF/9PTUepNEtYOVUe5nRcHxhtKMsPCa+KuSZxQM0SpztLkVQkfj+iqVtr/Pcy
         jOew2zKMFArb/5dy59X/8GPNNq/KjJux6HkG2t+WbxqQ62hT/uBJtGLrADEU7UkMbF+g
         FsqQ==
X-Gm-Message-State: AOJu0YxA5N5k6fUzLt7Aka25uqQBwQjSkvFNrcZmqrzsXHEQ0bBxCrbO
	yghppQUTTmUwewTQlP5pozPAskgbiZLH+hs3BqqFdPuSY6N6RwiFI1tE+tiz/VyRfV9ojDBRKJS
	E6gUV+y0WdpDca5cVScdyjUvqq2f52XQPF7VQ
X-Gm-Gg: Acq92OEGVmvC0qZ7lh+fO5+J0o3tEdpajhzTuwP9uS5l1T2ho3mFg2aJaEetdsoZzXY
	6t+1G4cvKONnqZVEAM6oXmYKdjq9FVkBolDJTUX3eVicXMVAODzOebTQ+Agb6ktffnH/5ES57mM
	sJtOXeWM18Qd8NFYZThMHpOargD/mSforG+OV79WCgPmPjoH0jFNnyRTV3Ga6OwhGOP7nzEw+I4
	orozmQ0johkUuMPtjqOG3OGiP+Ws0QcuSReKcnm+05MzZXcdNPqWJv3V+y/Gyr+FHSAgtaYsc6Z
	yI38mdAgK7GqWQqpq1BXQJNYVD7NIaN0boRQudKctssjhrlOOzF6
X-Received: by 2002:a05:6214:c42:b0:8a0:d08c:a721 with SMTP id
 6a1803df08f44-8bc68437fc0mr193178416d6.22.1778248420281; Fri, 08 May 2026
 06:53:40 -0700 (PDT)
MIME-Version: 1.0
From: Cillian Walker <cillianwalker@gmail.com>
Date: Fri, 8 May 2026 15:53:29 +0200
X-Gm-Features: AVHnY4LdKNhCEscTCXaDyj9YMzQEM3q_BuGsqdzdTWHpKvLUD28m7yhI3ep5y6I
Message-ID: 
 <CADV18bHXJHna=u6FFZipziMs+it6q2t4SDH5735A25iBMOUdYg@mail.gmail.com>
Subject: ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14IMH9
To: alsa-devel@alsa-project.org
Message-ID-Hash: P5PYC6NZ376C27TYLDYCM7MNZB7UM55S
X-Message-ID-Hash: P5PYC6NZ376C27TYLDYCM7MNZB7UM55S
X-MailFrom: cillianwalker@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P5PYC6NZ376C27TYLDYCM7MNZB7UM55S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8sDQoNCkkgaGF2ZSBhIExlbm92byBZb2dhIFBybyA3IDE0SU1IOSAoUENJIFNTSUQgMTdh
YTozOGNmKSB3aXRoIG5vbi13b3JraW5nDQpiYXNzIHNwZWFrZXJzLiBBIHNpbWlsYXIgZml4IHdh
cyBhcHBsaWVkIGZvciB0aGUgWW9nYSA5IDE0SU1IOSAoMTdhYTozOGI5KS4NCkNvdWxkIHlvdSBw
bGVhc2UgYWRkIGEgc2ltaWxhciBxdWlyayBmb3IgbXkgbW9kZWw/DQoNClNORF9QQ0lfUVVJUkso
MHgxN2FhLCAweDM4Y2YsICJMZW5vdm8gWW9nYSBQcm8gNyAxNElNSDkiLA0KQUxDMjg3X0ZJWFVQ
X1lPR0E5XzE0SU1IOV9CQVNTX1NQS19QSU4pDQoNCkJlc3QgcmVnYXJkcywNCkNpbGxpYW4NCg==
