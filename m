Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A33C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 11:44:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163C664E7F
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 11:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163C664E7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8FD5F16CB;
	Fri, 29 Jan 2021 12:43:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8FD5F16CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611920666;
	bh=aN1CZo7Gs+WuhkM1EppmnErhAQFwv+m4ivyxMytIIJE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J30OxvvOSmEmpyyJ0IwJdM4EOgbBDQK+Uxf42iyHqAFmAY+prmTdlbi4J3gjXWc2s
	 huWw+6cxpmH77VhGXSQF+1Kt/DuVJUJjwgGQcrgL+W+zRd+ntPEoPmn6G/iSEtdJMm
	 QpHsTZfpapdhuQKfKJsm0Id1Ck3B5V0jWKLmM878=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DD35F804E3;
	Fri, 29 Jan 2021 12:42:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B225F804DF; Fri, 29 Jan 2021 12:41:59 +0100 (CET)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD3BDF804D8
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 12:41:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD3BDF804D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="RHSUeAej"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6013f47d0000>; Fri, 29 Jan 2021 03:41:49 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Jan
 2021 11:41:48 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 29 Jan 2021 11:41:45 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <thierry.reding@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
 <lgirdwood@gmail.com>
Subject: [PATCH 3/8] ASoC: audio-graph-card: Add clocks property to endpoint
 node
Date: Fri, 29 Jan 2021 17:11:05 +0530
Message-ID: <1611920470-24225-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611920470-24225-1-git-send-email-spujar@nvidia.com>
References: <1611920470-24225-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611920509; bh=8rCymPluJ1fUEPrMoQ5Gx5LsQlp+yRtKBAeGRmkhoEc=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=RHSUeAejZX/2wipK7eVJAIqlSkP/KYTyYjDGnCZ+v2XVCJBb0yj1kBzb2zKss3JX7
 XfCrcxwEMlL0NZ0VEzUmuY0qqe1wjQr9sILSNBqbpE7PEvJkL9QL4kE5o7VdRFvbBQ
 NqQT97p/0KTautZ1z/WyHJbX17919E9AE+cy8csMpnVrRwap5NNUEY/NsCpByyIWzF
 MBLg/c50VDX+dxDbO9gb5/2H8DWrQY53dYGJUDWcyFSPuRoAU0X/mr0uJ0Knc6I/Qg
 3Jlfz2FCaHx5+Vs1XXq7clmx/DU9x3JCqO4lSL+d7YpypsM5y3MI69ikgCFY7mue5i
 QNDg7T0DYYz2Q==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, Sameer Pujar <spujar@nvidia.com>,
 jonathanh@nvidia.com, sharadg@nvidia.com, linux-tegra@vger.kernel.org
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

Add optional 'clocks' property to audio port 'endpoint' node. One
such example is where SoC supplies a clock to external audio codec
component.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 Documentation/devicetree/bindings/sound/audio-graph-port.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index 766e910..08ed8f5 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -33,6 +33,9 @@ properties:
         properties:
           remote-endpoint:
             maxItems: 1
+          clocks:
+            maxItems: 1
+            description: Describes the clock used by audio component.
           mclk-fs:
             description: |
               Multiplication factor between stream rate and codec mclk.
-- 
2.7.4

