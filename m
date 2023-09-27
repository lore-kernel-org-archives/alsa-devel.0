Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1C2E77360
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Sep 2023 08:09:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06284E8B;
	Sat, 30 Sep 2023 10:08:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06284E8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696061347;
	bh=IjRi2C9d+1iihdr5PPf00qmqaEcEdtZT/5YA/9/rWgo=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=kwNwLwniJ2NMseOuFN8FfKwMYueeKrTY9A2RJNbemFuCPCMqL6MfjHDaKzj9oHC/S
	 A9gsHCoJ/TiYP7TiMxzbw08Z0x4CqZ64Rz/7AvvZLDgSLXDJ1g3Ss4X86YuEEjtBnh
	 UzDLdREAaqNbOTE8Hfxuex6ZmXgTi6sjxtl6rtWk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 03C09F801D5; Sat, 30 Sep 2023 10:06:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 68476F8061E;
	Sat, 30 Sep 2023 10:06:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27A5EF8016A; Wed, 27 Sep 2023 13:35:51 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AFF38F80130
	for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2023 13:35:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AFF38F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=d8nnpLbh
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6bc9c01e154so5860970a34.0
        for <alsa-devel@alsa-project.org>;
 Wed, 27 Sep 2023 04:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695814544; x=1696419344;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/RHfKURYW+rujQXoW6nOOC0qH2otqVlHZzY03WcXw7I=;
        b=d8nnpLbhR7/vVJR1m3WvRC8cU5jIeucrC/Gp4U69Qlk8yEg4l9Ba8FFfEetI548psu
         9yyK+SzJ8GI0M/txNEKnfFMy8VOoukddLSnf44yR5I0Jgd7z8jRqiIKflJgwhieVvo2u
         iHHUxcYPrJ9K4Q6+C+JoXbtPF95mBmPJIJtffqiVgBoUE69T3aiIiQ7h9MO67lcvTGWV
         g4u83tsVeZjvu417kBripBCeMAihAeIlc1sV0cdkgEaekm7e+QJLn2DFsoMbFvf/4cP8
         xXYwdyRCQoSy/vhZVL2KjiaVS4z9ChX/p8QnDhBvtwKe0QZdVarfAgLcciDkRU+lDjmo
         VRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695814544; x=1696419344;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/RHfKURYW+rujQXoW6nOOC0qH2otqVlHZzY03WcXw7I=;
        b=Gf1NIB5A2ocQXE1DHIszI66qZodgqff5LT/x+exN3/pdryHDrbws46PK03glksYLDf
         FX42dyMtNPq1YBUH8wqBMy19bv9TfamFn4+NhjTN2f921o+Jb8WlblEDAzgTZDM6iJAF
         nDDdE+4d2OMLSIzQZ567EMOkcEDPwy0vP3k60Zd78JAh4xgxw5OarmYhpokwiI1cnf6A
         xr9T0pMowTCkfPypni04lIFg8FXoZvBTnXIZ9pdGrRZ5Y8WqoJir2eV84a/PbLHb1ec1
         IExZlbWxrjadM52CN5v5godl8SZLva4zagezHwRDPB175cavid9PpBgQs37XCLVjb95E
         r5qQ==
X-Gm-Message-State: AOJu0YwiBofsrYLNNioiR7xQDN/Kpew8ywYFGZaeChS7fJxaxIqmTHqb
	sTSLD4O+8RCT+Ut9b05OEvsBsmSCVWa3gf5cJ3oymiD7vIoFQvA4
X-Google-Smtp-Source: 
 AGHT+IFXHb14Ocu/EbBG2pQXYStNdA4kNUpPT6YoERKp59r6JohnFuxqoOy0NmZdKk+PevbozAcmrmGTCr+wOhB+TWU=
X-Received: by 2002:a9d:4b83:0:b0:6bc:9c01:c2ca with SMTP id
 k3-20020a9d4b83000000b006bc9c01c2camr2997411otf.16.1695814543656; Wed, 27 Sep
 2023 04:35:43 -0700 (PDT)
MIME-Version: 1.0
From: Sepp Kyster <sepp.kyster@gmail.com>
Date: Wed, 27 Sep 2023 13:35:32 +0200
Message-ID: 
 <CA+c8_P_Vv_3zpapsLHjYQ59_VUn3U7cUDuA0U44KcqmbRhyNDA@mail.gmail.com>
Subject: Linux Pop OS Audio Problems
To: alsa-devel@alsa-project.org
X-MailFrom: sepp.kyster@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 4R3TAFKZBXR5JKYSODTISNQBY6OIWWXH
X-Message-ID-Hash: 4R3TAFKZBXR5JKYSODTISNQBY6OIWWXH
X-Mailman-Approved-At: Sat, 30 Sep 2023 08:06:35 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.8
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4R3TAFKZBXR5JKYSODTISNQBY6OIWWXH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8sDQooSSBob3BlIHRoaXMgaXMgdGhlIHJpZ2h0IGFkZHJlc3MgdG8gc2VuZCB0aGlzIHRv
LCBpZiBub3QgSSBzaW5jZXJlbHkNCmFwb2xvZ2lzZSEpDQpJIHJlY2VudGx5IGluc3RhbGxlZCBM
aW51eCBvbiBteSBsYXB0b3AgYW5kIGhhdmVuJ3QgYmVlbiBhYmxlIHRvIHVzZSB0aGUNCmJ1aWx0
LWluIHNwZWFrZXJzIHNpbmNlLCB3aGlsZSBleHRlcm5hbCBkZXZpY2VzIC0gYm90aCB3aXJlZCBh
bmQgd2lyZWxlc3MgLQ0Kd29yayBmaW5lLiBJIHJhbiB0aGUgYWxzYS1pbmZvIGNvbW1hbmQgaW4g
dGVybWluYWwgYW5kIGdvdCB0aGVzZSByZXN1bHRzDQpodHRwOi8vYWxzYS1wcm9qZWN0Lm9yZy9k
Yi8/Zj0yNGNmODY4MDRhOTM4Y2IyMDk3MWNmYjg2NzUyN2U2MjhkYjdmMjdhDQoNClRoYW5rIHlv
dSBmb3IgeW91ciBoZWxwIGluIGFkdmFuY2UNClNlYg0K
