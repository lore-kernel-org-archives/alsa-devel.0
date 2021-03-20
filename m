Return-Path: <SRS0=zHol=IS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031E8C433DB
	for <alsa-devel@archiver.kernel.org>; Sat, 20 Mar 2021 22:24:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D6061933
	for <alsa-devel@archiver.kernel.org>; Sat, 20 Mar 2021 22:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D6061933
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49EE0825;
	Sat, 20 Mar 2021 23:23:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49EE0825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616279087;
	bh=5ri7z9HUwcW1kq8gRf2WeYQty/fDPMU4vrpORlsp/vc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PH+L1VSHPPeNYx7xJFimEnQ0JcMvlk2ko4Ns0xAeAzZYMtsM5KcJDSbtdvMuMWssr
	 v3xJIyIDeQv2B2ZC6yy7kh/LsUpIf/gl4866qidPB1jRcw0J8Hnkmd7DOwv/JjstQt
	 gohzW27f1XUHoRxU3wnDMY+WeOLofBzP2tFllCxE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF89EF80163;
	Sat, 20 Mar 2021 23:23:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3B4C8F80165; Sat, 20 Mar 2021 23:23:56 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6CBCF800BB
 for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2021 23:23:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6CBCF800BB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="cyTyFV3H"
Received: by mail-qv1-xf29.google.com with SMTP id t16so6872749qvr.12
 for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2021 15:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3IoRiMiCXfHlMDAYVKlK+AcDstpRUpfO/zO8PeDHvaA=;
 b=cyTyFV3HPdUr/17t9zHdbMObKhaJqemNf8iSSO/o7fEQ0gdeBoJWtrPGTNXeevVXrv
 M1oevWp7y+XVSXO+08+EqVUwktTguXR8G8AgHjOmUkW2PShRIcDnbAu5qwmmYZ2pdZ8s
 heBPKidp+XRi1eqbB5Q3vLDtGE33lddjFJEnTMM9jXy3lYqK50PitCKkx7r1eXSl8RdS
 p10SWa7J/5EhqnC7Ow2CUTwwLQ1TNEU8bwShHctfZXla/1juw/37pbOmIL/AX6QtAAA/
 Vb1dO7mzmxw/NPmvyc1NOYNpCkZiWqjYbbLzAxQq+PAWwRGF+hp73ReJ16obMN74FKdi
 RsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3IoRiMiCXfHlMDAYVKlK+AcDstpRUpfO/zO8PeDHvaA=;
 b=bWMAiJKrCtR/2QVbMb+N3LCp5N8NdEGDjFClyOo0pUumC4a2UuAGRBji9Mlb3StTdT
 ECAQuQ6mXNJ6iqXw7nMX9DE0cD1WoKjdquEXXbwtHy6ofRLA3dLMaLaj45dkQcHUzc1Z
 SZbu5r9ereIae09GfgF0CIoO2tuzSMfyscOuB4nPWHkrpUGFjpTewrRkXCnkIaPGtzmV
 kzFsB6AOgrKFy5O6mD7nJjY0jMcCyAicAP8BuLL8MjgP9N1pJuaIRERMhXpbi2/tysiI
 GVX0fhOQzHVBdvFWEgM4J6St5w5WCBWPiEUL/oQ0XIdS9gleKZwT9TT6CAYd6kY+LXko
 Wv0A==
X-Gm-Message-State: AOAM530ShcoTxu9YSr954O9JWcuFy3Bu+Ag3IxA8Sij5JiEJ+7JGyKwD
 X3iqS/aO3vRaUNTlOTEQT3c=
X-Google-Smtp-Source: ABdhPJwzW2oFWYnl+cKTtdjNpadmWiznxWn8HpkyNmH/1vwMvPivj7nAQgAWc9LqmaF+dWcHRxDBvA==
X-Received: by 2002:ad4:4ab0:: with SMTP id i16mr15313202qvx.1.1616279029043; 
 Sat, 20 Mar 2021 15:23:49 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
 by smtp.googlemail.com with ESMTPSA id i6sm7570213qkk.31.2021.03.20.15.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Mar 2021 15:23:48 -0700 (PDT)
From: Tong Zhang <ztong0001@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Romain Perier <romain.perier@gmail.com>, Allen Pais <allen.lkml@gmail.com>,
 Leon Romanovsky <leon@kernel.org>, Jasmin Fazlic <superfassl@gmail.com>,
 Tong Zhang <ztong0001@gmail.com>, Mark Brown <broonie@kernel.org>,
 Joe Perches <joe@perches.com>, Tom Rix <trix@redhat.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] ALSA: hdsp and hdspm,
 don't disable device if not enabled
Date: Sat, 20 Mar 2021 18:23:33 -0400
Message-Id: <20210320222337.243368-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series fixes issues in hdsp and hdspm. The drivers in question want
to disable a device that is not enabled on error path.

v2: add fix to rme9652

Tong Zhang (3):
  ALSA: hdsp: don't disable if not enabled
  ALSA: hdspm: don't disable if not enabled
  ALSA: rme9652: don't disable if not enabled

 sound/pci/rme9652/hdsp.c    | 10 ++++++----
 sound/pci/rme9652/hdspm.c   | 10 ++++++----
 sound/pci/rme9652/rme9652.c | 10 ++++++----
 3 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.25.1

