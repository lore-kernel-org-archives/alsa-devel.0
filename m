Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CB6E7106C
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Sep 2023 13:25:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE773E88;
	Thu, 21 Sep 2023 15:24:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE773E88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695302748;
	bh=+fkPXRPdVstynPHGk4w9UgEKJcmvJdZ1sFSMw6sYnEI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ParBI5aclWIBmhDgLdcQSKfEpgXxh2ayDqRC2z3eOHr8/6caTqngggPoytbtkWk28
	 SEwm/XGeFGN3HybkhaBIuLzs16b3Rd1TRalxBxoSdEA/wl5n5JazINk8QjacQ7acdx
	 sm9zL3X0RKdNV/Lq+VWbGKlkFR329iB89dzEOa+0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A9BCF805F1; Thu, 21 Sep 2023 15:23:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F552F805AD;
	Thu, 21 Sep 2023 15:23:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7EE3F8025A; Wed, 20 Sep 2023 06:18:48 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6F3E8F80125
	for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2023 06:18:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F3E8F80125
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=Zb+wCa5f
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c108e106f0so4634461fa.1
        for <alsa-devel@alsa-project.org>;
 Tue, 19 Sep 2023 21:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695183520; x=1695788320;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+fkPXRPdVstynPHGk4w9UgEKJcmvJdZ1sFSMw6sYnEI=;
        b=Zb+wCa5fp/nBBQbr9nrRYjd8g2CfbgIRV7Nn9vm5I9q8CiAsxwvSsMjWVTFweZ+uAH
         cHX7VwTfFWYbbNNyhSiuZfcZToD+GM0SNWJQv0b36hzXd71odOCEXgj+O6G1Sth8kUkr
         rmPIR84pyoEiBruAgKYwOa9tzwPm3fnxu7V+qoilqYJIeeKCSe/qmRZqNA6SqFcp/gY/
         9SZ4N48BXHztfQCwutlOaHQy9cBGA3wHg0s4iSDzx+vTrRtFwb3DN1vQuOPW3XpTLtmG
         p//BrnZ9V1VWHAMz0wb2vt4z0UgTkG4+fdE4dn7ayzkut1OPF4kuTJnuzF3JZULtQHAP
         JooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695183520; x=1695788320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fkPXRPdVstynPHGk4w9UgEKJcmvJdZ1sFSMw6sYnEI=;
        b=Lqz6uaZaIm/7CmdVR9m7JmfX4R821F/dYj7dcr+f8xkL/RLOTMt+9s7voHG6ckJth7
         EKWbfMsvZzM6G4fm2iJQNt95/6aFpTrD8rcH3i/+txe36xim2fSg/z09QWLMbLIdEJ2T
         kLp8fgRy7WN/Vvdl0HPAOb+dpTiVDRE8DR8wwnX7HMPcy9Kj8d1pvcJe+fUeHOdgY2Lg
         TBGp9fYU5S0CijLDdNwYrfwmxNhgre07O/hLw8QRsFPort5T5erD/0xLzqPbIIgUlEYJ
         yCYHskssK0sgqKtYeMvWhmvcFSrqteQEpeVrkmT6GhU69epRuxyN/QUqvshyVVKPESDy
         b7WQ==
X-Gm-Message-State: AOJu0YzcxbfxkBefFkbN1a+e6zHkih5xC4LSV4auogatxOeN1Eq1bTER
	AbrPj/nYlkDNPwEOvVBzItk8TGyj4sn+Eql2ez451VRXPoOICvE3
X-Google-Smtp-Source: 
 AGHT+IHcUUN3UeK/0FtxmnSmjr5hlxfzMuGqTs8KNbXwHRawArbK0BZ6sri7guVyxMa8uOXKA9anW5KXwzWS0M/mChE=
X-Received: by 2002:a2e:6a09:0:b0:2bd:1f8d:e89d with SMTP id
 f9-20020a2e6a09000000b002bd1f8de89dmr1091573ljc.3.1695183519608; Tue, 19 Sep
 2023 21:18:39 -0700 (PDT)
MIME-Version: 1.0
From: yu tian <tianyucode9603@gmail.com>
Date: Wed, 20 Sep 2023 12:18:28 +0800
Message-ID: 
 <CADMex3N0yR60Hzkbg5Qx5MNZaqmx59-HKDB=MEEMvG2fL4QM_Q@mail.gmail.com>
Subject: sound/hda: Module loading problem of controller and codec
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: tianyucode9603@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: XW6SPX5QB246SBDJRQFBD73TB2IBFHM6
X-Message-ID-Hash: XW6SPX5QB246SBDJRQFBD73TB2IBFHM6
X-Mailman-Approved-At: Thu, 21 Sep 2023 13:22:53 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XW6SPX5QB246SBDJRQFBD73TB2IBFHM6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Takashi,
The following commit only gives a warning in menuconfig:
"Set to Y if you want auto-loading the codec driver"

d8f66c71d547 ("ALSA: hda - Add warning texts when codec driver Kconfig
doesn't match")
78e34f34ac27 ("ALSA: hda - remove PCI dependency in Kconfig")

The problem with module loading is because when SND_HDA=3Dy,
sound/pci/hda/hda_bind.c is not compiled as a module.There is a
=E2=80=9C#ifdef MODULE=E2=80=9C in the codec_bind_module function in this f=
ile. Why
can't it be deleted directly?Or am I missing something?
