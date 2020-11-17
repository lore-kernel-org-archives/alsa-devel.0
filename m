Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620CDC388F9
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 01:36:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B282463C
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 01:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kRMiyz6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B282463C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41EE917B1;
	Tue, 17 Nov 2020 02:35:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41EE917B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605576997;
	bh=yWQS2baKMDYITvSpskrYEXeTFoCe+XswzoL9Lry1AeY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kRMiyz6rUXuLStZnR5CufqGJNiTGJ1cyCOmM6POVcc56/GR47kM0Sf4JIb4l7ZDI+
	 TWhkrk9FWkJJEw69pF4NMJxJ0/8c640XAnHGiiGwCAJkJIK/lfRRPw7GPRXpMZAicW
	 rL+QbOnSgnFFW1W6vbHOt/R9S5KKcqaOnZWJ+BhA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1193AF804D6;
	Tue, 17 Nov 2020 02:34:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C084F802A9; Tue, 17 Nov 2020 02:34:06 +0100 (CET)
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com
 [209.85.161.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3ABF4F8010A
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 02:33:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3ABF4F8010A
Received: by mail-oo1-f67.google.com with SMTP id z13so4371837ooa.5
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2020 17:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PIVuRHuQpPLtHXGEDoAwUODOVnqOwSMNScZjMJ33YwE=;
 b=nVV4rPAG0RikG/83l56DmJqi848SEYrHD4aqnDKexkrAPJ6CH909MiA0t5AXvIsv/5
 0oemqTZ4Xo0ASS/Ad7tpIsh6G/10taz+m3yiljec0B+UeTvKbKJfvBbSVxVbiFgIJ4kR
 kJKVIQtq3xHKdsdV0ERwG9dlBOb9iwLwnE8XPvIQj7JiVI8u0KCMZ3oMf7SUlFU8N2W6
 vYUOFd3QebwZPWCuI45qEhHjKhaojUb+iqDSzz89q2HAA3KloqPXkGm6L/2e9UbGQJ6u
 LpDtLp1QYoRABfwDC8ge+FjLio5nydSEjAak/2RGXyg9tcJPldmm7rC/Z+dGN8CaMijV
 W1hA==
X-Gm-Message-State: AOAM532IW5L3TnEuivOVoTprgq05NNV+/bEg1Gyvh7cbhgxE2LzBRiqu
 7IIAgTyn3yZhFfbjBZoC8A==
X-Google-Smtp-Source: ABdhPJyh7k15dAFdbxkEOsVwyoHF5mvXPEsj3sCoz0n4Vx6Avi75UW55OWe8b49iffOzcTA3D2l6nQ==
X-Received: by 2002:a4a:c018:: with SMTP id v24mr1515621oop.2.1605576830587;
 Mon, 16 Nov 2020 17:33:50 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id j9sm3861325oij.44.2020.11.16.17.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 17:33:49 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/4] ASoC: graph card schema rework
Date: Mon, 16 Nov 2020 19:33:45 -0600
Message-Id: <20201117013349.2458416-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Sameer Pujar <spujar@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Lubomir Rintel <lkundrak@v3.sk>
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

This series updates Sameer's patch to repartition the graph card binding 
schema and incorporate the OF graph schema. The schema was also mixing 
card node and DAI node properties, so I've split the DAI part (the 
'port' node) into a separate schema.

There's another problem that 'frame-master' and 'bitclock-master' have 
inconsistent types of boolean and phandle. Having the properties just 
point to the local or remote endpoint within an endpoint node is kind of 
pointless. We should have gone with just boolean, but looks like we 
already have several users. MMP OLPC is the one platform using boolean, 
but it happens to work because the properties are effectively ignored 
and CPU DAI as the master is the default.

Rob

Rob Herring (3):
  ASoC: dt-bindings: Use OF graph schema
  ASoC: dt-bindings: marvell,mmp-sspa: Use audio-graph-port schema
  ASoC: dt-bindings: Refine 'frame-master' and 'bitclock-master' type

Sameer Pujar (1):
  ASoC: audio-graph-card: Refactor schema

 .../bindings/sound/audio-graph-card.yaml      | 106 +-----------------
 .../bindings/sound/audio-graph-port.yaml      |  72 ++++++++++++
 .../bindings/sound/audio-graph.yaml           |  45 ++++++++
 .../bindings/sound/marvell,mmp-sspa.yaml      |  25 +----
 .../bindings/sound/renesas,rsnd.yaml          |  12 +-
 .../bindings/sound/simple-card.yaml           |   6 +-
 6 files changed, 132 insertions(+), 134 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/audio-graph-port.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/audio-graph.yaml


base-commit: e2e99930ec006c6fe1d62af339a765ade71a0d9a
-- 
2.25.1

