Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_NAME_MR_MRS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B3FC433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 17:39:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBE023EF2
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 17:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBE023EF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=berkeley.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF1951738;
	Fri, 11 Dec 2020 18:39:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF1951738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607708395;
	bh=o1AUqD0pgkA678igUdwSCeHS6206+G3H5La7l6vrS4g=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bUlcR8AxgLT1sO+Vj8wR5cGy9/wLVLLuP9QT5h+v/WLSM1D9a4UEM/S5gAxPXDe6J
	 SNVsR9h1tRRCrt7ysUX9iA+VqzdfpGNrt4rd64iyuO7tLxJF0VYq1DaISUwLmO2gsL
	 kumcaAJg+soZZPcmTLhCOXz1c6dDLFjqNraUXuRI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25BE8F801D8;
	Fri, 11 Dec 2020 18:39:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E029AF8016E; Fri, 11 Dec 2020 00:10:33 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F95BF800E1
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 00:10:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F95BF800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=berkeley-edu.20150623.gappssmtp.com
 header.i=@berkeley-edu.20150623.gappssmtp.com header.b="rsZHYCIl"
Received: by mail-lf1-x133.google.com with SMTP id y19so10652155lfa.13
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 15:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=berkeley-edu.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=ngWQV55Kf2zVtmLkLg3PzKmxbT1Q+g8lKza65q1ZL88=;
 b=rsZHYCIlDWD6yWOUtKh1vOnCbljY3N0jL5ADDG4rE5i5GEMSLJR/uzdN9FsiahNpaW
 RgH5/NggJ5SmZ7pxiH8B1qv4FROTgPlbE7eZwRchX1UbeyjjGCz+QvLdaDEsk3GPXFgI
 cdOuHjo8fHylX9IHAVhmPZrQ/MfAex+BnN3/+gNHfhLy8KDjXSyjczvMb5AdU6zy9GEZ
 V050LGrJ5xShbqYeZJWdmoDVBf+C/RPxpFBatAFxiGPDXv8rdzCsxScAMNzhrMWMZjd8
 u52mveYVjDL+cId0W2XBS6tcScsmrEb/4oKTZKFic88D/6/qvS3dbtcfDvTmlIS0ZE/N
 RVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ngWQV55Kf2zVtmLkLg3PzKmxbT1Q+g8lKza65q1ZL88=;
 b=pqNxlmCUpfv+kuKWM/oixwFthZtJhMRF4s+DhC+pUMFO3Xm14zQMd4DgdMFKFtuAt9
 l0uTOHNGfEDlAyOdGbz8N1A7wdUPTSplmH73cIj2jv9/e0woe5H89jECeAlUbwzSTF5I
 FM4cd4KoXGY3SembmSbnMn7vq9SzLjm02LuRaOi3FPiV4VW7HhBEM69Jqo4MPlQyYzWs
 vVcySYtLFUtLXfIC+G8/wKNq1N8tbYxHVjuhRK0OsaP+EZ0/z2GLLIFzP9WQfR920fOD
 nGzTDClYtSC6SWl6OZBr4mj4qUECKdf0A/3MXp8RnCKuPtXUW0yj0U0ZJ1XFtsAAr7U6
 GiVQ==
X-Gm-Message-State: AOAM530CwJAR0zzPJEU1c4jQcEjaxmkvsAodsMMFvR6u3un8uIw8z9Pe
 sXN4/ZzTEJT6SFg4+Z57jM1pIKSoNJB9HhYbvT3gQEpLrUi3Yw==
X-Google-Smtp-Source: ABdhPJyLNOLeyIHut8fgYLOLJQKoXRMb1eJBDDNOJbSE1pgz4O6agEsTVABf9M1tVrK9YaGflxGNqh+Euz9tR+JfEDo=
X-Received: by 2002:a19:7b02:: with SMTP id w2mr1820435lfc.37.1607641820493;
 Thu, 10 Dec 2020 15:10:20 -0800 (PST)
MIME-Version: 1.0
From: "Mr. Indro Fedrigo" <indro.fedrigo@berkeley.edu>
Date: Thu, 10 Dec 2020 15:10:09 -0800
Message-ID: <CAFir9wpY6WXq9PHV3t-zj4QdJdEMSwMuu6GrY+0AMOra6Q3ebg@mail.gmail.com>
Subject: HP Envy 32" snd_hda_codec_realtek
To: alsa-devel@alsa-project.org
X-Mailman-Approved-At: Fri, 11 Dec 2020 18:39:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi All,
I=E2=80=99ve been trying for a while to get the Audio working on my HP Envy=
 32
All-in-one desktop.
It has a Bang&Olufsen audio system that works perfectly with windows, but
it absolutely mute with Ubuntu 20.04- Centos Stream - Fedora 33 - OpenSUSE
Tumbleweed...
I can get sound output, using Bluetooth, on other devices but nothing from
my speakers.
I=E2=80=99m attaching the output of alsa-info.sh to begin with, if anybody =
has any
idea. I can provide any other kind of system info if that could help.
Thanks.
Indro Fedrigo
UC Berkeley

http://alsa-project.org/db/?f=3D943238345fb524c3e60f2348b8b39b824d8cdc05
