Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B526CD5BC8
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 15:13:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1967160251;
	Tue, 26 May 2026 17:13:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1967160251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779808410;
	bh=R9M2QSXfPzAy9TLslT6I1ER4Rl08I+dWPfnMU1/VokM=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=LEZdSwhxiS/t7AVzeDaKJtD6MMHN0G9tN74nTmCRvWtGeVTxOfIH/kTIelL6PCrxC
	 PNcZm8Gwx07KZYRazvugW/T7sOV3fpkJO98WQSoLPTT9NQ+RV2QyA9rxAIVicEmUhz
	 9GronO70tGtDXzCr2CYjK8OPzMRbAJTlwd1JmXDg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69826F8060D; Tue, 26 May 2026 17:12:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 052C1F80613;
	Tue, 26 May 2026 17:12:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D7F1F80557; Mon, 25 May 2026 11:09:57 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E8515F800C1
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 11:09:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8515F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=helsingborgslabbet.com header.i=@helsingborgslabbet.com
 header.a=rsa-sha256 header.s=google header.b=B2MIjeik
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4904c1ce4c1so27130355e9.3
        for <alsa-devel@alsa-project.org>;
 Mon, 25 May 2026 02:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779700191; cv=none;
        d=google.com; s=arc-20240605;
        b=I4kFVmtsjrxT0CMywItf7iEke8jpYIMjFZIaxgoumbBCI40EYBqV7Dzmy4Uoy8LejD
         rWCldv7aX3t0z/ay9BBDDUobn3+3Lof+Dz1jTpaZO4s+JPE8hCGF1yiXwQNPdyK4KNnP
         6ktHWpLAy7DGLWjK/mEMx1XIa8WopB+06Bf439DzT4y5XnWWHqxcGVleETJ8MIznG+F7
         qOPrdHHyRoB10xzkqMVNK8kTQpUMe2SMa3wyh5Z9Y4SziQ7hfgoBkoAN3dDq7enPEYjo
         NTwACSDx2nfAVpo7afSEIWJ7eXE9GhJGYsz3zlIe4OGb5p1dtGq9lcdaJsbSDH9lcsI/
         NAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=8OHfeC8Ku6s5hDeh3i7MxfIPhgNHUXCN9RJJIb8LW1w=;
        fh=mtR6cuj0NexQ7uU1aPTXcSgI50hpK73d69m3eLj2Gfc=;
        b=kKwFs1ZL3JZ+yR8VUYVHD6N4rL7vxEjLzrP9qtFRVWcPd+6F+D2yzchbiSu6i/F9HN
         ZjKJnId3/LzHDtTeWqRwHA75B/NNBRpgVWF6CGJMYoWWmlNvjW/nra6XN97lceQ1jaz/
         EQ9U6c05+cE4hm/mT2txxgaBbfNr7BfckfkyFY8SaT2tfWtF7KyO9Yi3yvvw+Yd5hr/S
         6qnIjsTRjBLlKsx2/0jEKU5tpLPU4BTomIaGBruNU1qlUzRQxhVJro6nkBWDIJ6ALZ6V
         BNLS00VlpW01vTtdp7SF5SFswV48yT6cEbDICofG+D2IHcaAOARPstTXyajSulDxucM2
         lDBQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helsingborgslabbet.com; s=google; t=1779700191; x=1780304991;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8OHfeC8Ku6s5hDeh3i7MxfIPhgNHUXCN9RJJIb8LW1w=;
        b=B2MIjeikoE/jh3haCHG4Ss1/3B/ACsXJqkHDwDFSornTWl+/AXA0nJghJL2ETKOEtM
         MxPmIzEifnzjlg6CUZp7uGaIxySl1addRmQ4kEbt6VDyweTqYGYZBtTy6qTEpbscsA8Q
         RVrGc/FE5bTLGsbJ2adDKsuaf5oqNYuYNmpnOv01zBYfzk15CUfUsYGXOjSp3EI2RIiT
         1/94oeigAr/Ejne+VYQSOkbMiOyBDh8ebW0CzTNEK0cqeZRT2G3wUZIa1f27TKXm8g7g
         yP/EvMocBVu6UGTSpbYphRGd4HjzunBiyhb423Ti338gVqY/bH3l55p7fl5wUmAb1cXd
         iCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779700191; x=1780304991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OHfeC8Ku6s5hDeh3i7MxfIPhgNHUXCN9RJJIb8LW1w=;
        b=XZLVZmDdSTcYl3NoyuIB4TYTV7qjJAUrabT8zYJx5j5O1FNjfPCss4Dq7foohnjqeu
         hvpojjNuUwsHPT5r4lKly7gVJIoSD9ImzDCdVea6KuwfpouEG0CpFLUCJ4fGNR/pAwMs
         tdUpL63zbuxxNL9zCO6x83DX3ctBoiLtpiNGp5bWooza7B6rFMrQgkWBARILn0oFLvtj
         pL9hvcLHgMtIV31j5pRqIKlZI0uAkyRPXE5I3x2+oZR6IRNz/6HHXPHL9VANelm8oHlU
         mZTXjeCgqx4AVWuK1jtZcrXfmOQ990zmX3iG6IpkT/awwpxENEv6lMbpgchPDOsX1/BV
         rDtQ==
X-Gm-Message-State: AOJu0Yzosdr0hgzc9S0r0/q8WSWX0V8goMOXuhppbxxSR33pBhPOaLXH
	82wyJ+F8Ufb19GJniCT5ixvZHTeylbP3Mf4YN/mLZhTRbf2UzhlZ7nWMLMINaBs851lQcigHvfm
	zTF4BG5SEtCs2escazqbA7x1x7i5QNFoPXpahzUqPQ7g1I/Zv2KAxfPOS
X-Gm-Gg: Acq92OHz09QQlBuELeoob9XgHJrp+WtgWlog8XsbjhFUorBstLRXKa6GJaBE0+CV+QW
	y2St+l5fUjtP0qxjPWxaLvDsiRYq4s/xWwXNJ6S1aZlxRQI2gk68CWz8jbNskO4BayF9O/5X9QJ
	MiBphlDxjCv7p1rvvevO2NpJAajobj6IJH/DEXQlGPYdCtT7g+abqAAnjh8/drmjM/1rXQvL6Ja
	bnV2/BqlReq+CGmxsSLM6zF/HETfTDzo0qNdMK4BhtRmReQW9Baxijj4wbuoXPXjD7XZnQswnL/
	k9TFMq8=
X-Received: by 2002:a17:907:7f93:b0:bd8:d0e4:dabe with SMTP id
 a640c23a62f3a-bdd267cb7c4mr126142766b.39.1779432116595; Thu, 21 May 2026
 23:41:56 -0700 (PDT)
MIME-Version: 1.0
From: Joakim Andersson Lee <joakim@helsingborgslabbet.com>
Date: Fri, 22 May 2026 08:41:46 +0200
X-Gm-Features: AVHnY4JthxHaG4x9n4h3Op8T6GIzeeSaz0nmmrHOMXjSjgo0ypc54hcraKq6B-Q
Message-ID: 
 <CAHab4-0EBRkKVVv0zvKVHqCbSCsjvr1aE1m8bdi-cAvSareHig@mail.gmail.com>
Subject: 
 =?UTF-8?Q?ASUS_TUF_Gaming_A14_=28FA401EA=29_=E2=80=94_could_you_help_add?=
	=?UTF-8?Q?_an_ACP70_SoundWire_quirk=3F?=
To: hasunpark@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: joakim@helsingborgslabbet.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: DO2AILOXLAPHPOAVHFFDMF53NPOL4HFK
X-Message-ID-Hash: DO2AILOXLAPHPOAVHFFDMF53NPOL4HFK
X-Mailman-Approved-At: Tue, 26 May 2026 15:12:44 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DO2AILOXLAPHPOAVHFFDMF53NPOL4HFK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

I hope you don't mind me reaching out directly =E2=80=94 I was wondering if=
 you might
be able to help me with something.

I have an ASUS TUF Gaming A14 (2026, FA401EA) with the Ryzen AI Max+ 392
(Strix Halo), and I've been trying to get the internal speakers working on
Linux. First off, thank you for the AMD ACP70 SoundWire work =E2=80=94 the =
ProArt PX13
(HN7306EA) quirk that landed in 7.0 looks very close to what my machine nee=
ds.

On a stock Fedora 44 kernel (7.0.9) the internal speakers stay silent:

    platform acp_asoc_acp70.0: warning: No matching ASoC machine driver fou=
nd

(PipeWire shows only a Dummy Output; aplay -l shows only the HDMI card.)

My laptop seems to use the same ACP70 + TAS2783 setup. Its DMI is:

    board_vendor =3D "ASUSTeK COMPUTER INC."
    product_name =3D "TUF Gaming A14 FA401EA"
    board_name   =3D "FA401EA"

>From what I can tell, it might just need an entry in soc_sdw_quirk_table[]
(sound/soc/amd/acp/acp-sdw-legacy-mach.c), mirroring the HN7306EA one:

    {
        .callback =3D soc_sdw_quirk_cb,
        .matches =3D {
            DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
            DMI_MATCH(DMI_PRODUCT_NAME, "FA401EA"),
        },
        .driver_data =3D (void *)(ASOC_SDW_ACP_DMIC),
    },

For what it's worth, the speakers do work out of the box on SteamOS on this
exact laptop (only HDMI-out is broken there), so the hardware seems fine =
=E2=80=94 it
just looks like mainline is missing the FA401EA entry.

I'd be really glad to help however I can =E2=80=94 I'm very happy to test p=
atches and
send over dmesg, the SoundWire enumeration, or anything else useful from th=
e
actual hardware. Just let me know what would be most helpful.

Thank you so much for all the work you put into this.

Best regards,
Joakim
