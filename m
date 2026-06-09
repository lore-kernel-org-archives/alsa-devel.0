Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07DCCD98C7
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:59:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 858F6601E8;
	Wed, 10 Jun 2026 09:58:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 858F6601E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781078343;
	bh=dutndU8+cI0L4KGQYy4jkru3ykh56BKLQKuNQ1kzv24=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=JdUevRRDzjJleFfzOu7z+Fbuaqfjt9WToq8Esg+tdR3VCQTkS4TGciQiGfqsNOd3x
	 azssoo6CQN4Smam0B272kk9vGCrjBsJiZMVqMuMwltEGBROhx1r+t85ROou0Mm6ZkX
	 WDcSqOF4Jpqa92THEegoGqH++ER740uGn03M78Zc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AC8E1F80600; Wed, 10 Jun 2026 09:58:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C11EF805FF;
	Wed, 10 Jun 2026 09:58:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 39886F8058C; Wed, 10 Jun 2026 00:18:12 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781043491;
	b=QDEPKPr/OTO0skAM8Apgk+9XD4hDfS3BBWO3/uobQNlP/0GzBJWEKCFAui1ycMqt+ofU
	 sTGbtRbCgH1BwpRY2UCIb1ygFdxC0pZDEuQYsMeCYKmhj2mLDQHdjP6KRPtojvWHTkfIA
	 ZKmGkyIYqqQQVw8YLIiU85Bp7aVZT4WZumCnvZ2eg8d3MLWlY+8bn1QSDAmuOCZ/90Qko
	 fCsbjcf2Y/arudYNlsAHW05I2ZzfjCg0+QMb6CusiDaQ2B0qmtqrvCcxM7R1SBEZUTMDX
	 ilChuV7NXWQ96mcyWI55r76JQn58ZwJUjXKYCoKKpa//FZYP9J3Zjxs4YG4yOnMMtnA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781043491;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dutndU8+cI0L4KGQYy4jkru3ykh56BKLQKuNQ1kzv24=;
	b=XsbCdo5G0xalER8ma4weweNvNUYqgPynzRPRj8xMJGJ/UpyL7/yzwwqGWPASN6xoze8T
	 YWRPl8NXecqUUeIL9wHP/bcwcO+mTFKAcn1rVzkquMDE2dr9Wufuhq6ELE4iiYaYLfhTF
	 58UQm0j1nkDvCarbI3cjCK68umU+9yR2YnzKnLDT6TnzCFL4XNteHZu9ODPP4U+KdFADu
	 lsfBRvxrcyeFyZ+LuEwEeACLRb29ddsX7y99KH5uEkMJHAEH2ftK0uG3QJPf9pDZBNOXi
	 6j9Tx8iRfSLYViNNsHvo2JxZOrjXv8K/kIsFBfH+ko16lFUcmmwHwIAnOH5Z7VVUQwg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=furtwJ1k;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 47EB2F8011B
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 00:18:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47EB2F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=furtwJ1k
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-660323f7b27so6321087d50.3
        for <alsa-devel@alsa-project.org>;
 Tue, 09 Jun 2026 15:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043488; x=1781648288;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tGfokoYOXR1yq2j8xLsJgcyhToU2nvWmATxx6CnYdB0=;
        b=furtwJ1kuwWnj8SurTv4otpZ6TFPIRZl/SEV3TRpETA5gO5anVZN/MquNNHfYfySKX
         KwH9cqRp5mribKXJA0XOY6CrAwapUpNcgq9xhqfO6zu3sS8HqUP+W35N9JOIK4nM0FJr
         BhnwbJJJBEmdliFUtCt3RKdXoP5GIVGYOYGPr2A++z7tZ4XwMVqJkqUXB7Y7MkgA8nTx
         TFW3Xkoo9EnQtgAm0AzCQKx42oFPbsvV6iE5Bb86xJPtCBeh/POkvpxS1KBqtKUE0yFm
         ItSfSLHWYpkDxcWeTiymyvwJAOjgPVOD1KeCrecVSpPkjWs0QwguMiYiDt1KZy5K5ikz
         43hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043488; x=1781648288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGfokoYOXR1yq2j8xLsJgcyhToU2nvWmATxx6CnYdB0=;
        b=qAQAx+/+tWWdHNS4mh2kEbbUEwo5LMRqfsSEIseQzikqrvgFHogWCC/hX7zYp0DTON
         Aq3rteuxZT3UVcRt6Hd9ioyRQazmmuCJ/cFW2IF0cTkjyepM6sFm7+DLHKjk23clWSJ5
         EcW2FdgC0eSTk0HnHllIkWLiglMQjHNIn07xw372RZ5UJqAAl9ddloGy4w6WI7C8tQod
         6GQQTzfIxttxtYtBRZCIewMhmr355dHZcbP2PV0ZU1gqz7ErHL6LKmnTlCcuhjRcEwJT
         9q5bFfcyKxvCsMJeIOFpiEMU+NjbUI6gF4G6i1c02SpaFVpKSExdz0LO06eV0yiAM1XW
         tcgQ==
X-Gm-Message-State: AOJu0Yx9V/N0dcr42NehdjKSAsGt1XEtJPLuvaNPaBLyvJdbLTPWg3W4
	IFX5+DkkpERff6IcEZcOPxAWgeVD23iB3xLBWUcbsOfuStq6NGsucWxA
X-Gm-Gg: Acq92OG9X4/ZZZ+qD3PNgW78Avq3Uow0ImhNyTQz6A81wG8g4w+OldeN6hQqqRXpONr
	Lu46l+JfpfoO6aq0oM61CHa7DaEzvzf/i8AyLhpvKU9rTJF50ZemSYvnIBC6mvtVsuF/m2I35jF
	gZTIbHGdgFBs2C7wukmxPxQRthsv9bOpJKNIF5j9Sc6OCuaZQe+KT7uGywN4KS4t48HdqeuwLJ9
	jzng99+YWoo6VPLwE12M4ZuO2aNs4HcoyQSwZlhWvEQp5gbmtJv5oxE1H5Uh465g6Zdpm/WgM6H
	NaJjx3d7jAVPz69rKsv+0LouB7Cu9EF3DF4zFnGePYJYwmxBZh+vIO42tTjYgfRsAbHW0xyfxtp
	bpevf7stYO97P2lsOGEb+Nv015nqhVHmaFpgA8NVoaiv0pzjm7FwOtrWGF4EE9T5gdRG3JyNvuK
	2D2Hrw5PDdBzGCgy0Vr8lFVmA4Sbhs+Zp6qQfX+VMKxnvQi8olxPO7MoXz0g9vZgzQGeZUorR9a
	VOWypdgB0YTSntIgAnoihhl4zeI2Z7ykUtqisI=
X-Received: by 2002:a05:690e:134b:b0:660:ec14:ef87 with SMTP id
 956f58d0204a3-66106f153cemr19770783d50.34.1781043488238;
        Tue, 09 Jun 2026 15:18:08 -0700 (PDT)
Received: from alsa-dev.int.suenodeluz.com.do ([74.244.193.113])
        by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d6205a5bsm11414260d50.10.2026.06.09.15.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:18:07 -0700 (PDT)
From: Frank van de Pol <fvdpol@gmail.com>
To: tiwai@suse.de,
	perex@perex.cz
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Frank van de Pol <fvdpol@gmail.com>
Subject: [PATCH 0/1] ALSA: usb: Add support for Reloop Jockey 3 DJ controllers
Date: Tue,  9 Jun 2026 18:16:42 -0400
Message-ID: <20260609221643.3439698-1-fvdpol@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: fvdpol@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 4KIFLET25AJG4QXNIYC2DJBQWFBSXBJM
X-Message-ID-Hash: 4KIFLET25AJG4QXNIYC2DJBQWFBSXBJM
X-Mailman-Approved-At: Wed, 10 Jun 2026 07:58:24 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4KIFLET25AJG4QXNIYC2DJBQWFBSXBJM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


Hi Takashi, Hello ALSA community,

After being away from active ALSA development for some 25 years or so, I am 
happy to submit this patch to introduce a dedicated driver supporting the 
Jockey 3 series of DJ Controllers made by Reloop (specifically covering the 
Master Edition and the Remix variants).

I initially evaluated the feasibility of integrating the required logic to 
handle the non-standard proprietary Ploytec framing protocol into the standard 
USB-audio driver via quirks. However, doing so would require introducing 
numerous hardware-specific exceptions throughout the core layout, adding 
significant complexity. A clean, isolated driver subdirectory provides much 
better long-term maintainability without cluttering the existing class-compliant 
architecture.

I have successfully validated and stress-tested this driver across three 
distinct hardware architectures to ensure robustness regarding DMA, timing, 
and memory alignment:
 - x86_64 (Standard PC desktop environment)
 - armhf (32-bit legacy environment on a Raspberry Pi 1B)
 - arm64 (64-bit modern SoC environment on a Raspberry Pi 4)

I look forward to your review and feedback, and I am more than happy to 
make architectural adjustments as required.

Best regards,
Frank van de Pol


Frank van de Pol (1):
  ALSA: usb: Add support for Reloop Jockey 3 DJ controllers

 MAINTAINERS                       |   7 +
 sound/usb/Kconfig                 |   1 +
 sound/usb/Makefile                |   1 +
 sound/usb/jockey3/Kconfig         |  19 +
 sound/usb/jockey3/Makefile        |   3 +
 sound/usb/jockey3/jockey3.c       | 841 ++++++++++++++++++++++++++++++
 sound/usb/jockey3/ploytec_codec.c | 116 +++++
 sound/usb/jockey3/ploytec_codec.h |  34 ++
 8 files changed, 1022 insertions(+)
 create mode 100644 sound/usb/jockey3/Kconfig
 create mode 100644 sound/usb/jockey3/Makefile
 create mode 100644 sound/usb/jockey3/jockey3.c
 create mode 100644 sound/usb/jockey3/ploytec_codec.c
 create mode 100644 sound/usb/jockey3/ploytec_codec.h

-- 
2.47.3

