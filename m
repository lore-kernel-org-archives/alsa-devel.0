Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C19C25B78
	for <alsa-devel@archiver.kernel.org>; Mon, 20 May 2024 22:28:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23E1CE85;
	Tue, 21 May 2024 00:28:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23E1CE85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1716244093;
	bh=A4335sSIXxSmnvWq25uzN3eOtMetrX9olnAwnD6I3O8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=fATI1tSu6TgEBSHFlaDSywsrewm+jnJ0JCFa8+PkMI5DmDQ5gBYqGCsUJxZJ7CUMP
	 kwDrA8jaB+2z3K/3SQRromqZjWUUvMKnEJ/gm1RPBHYEUXYr5Xi1FG0iAmqrXGLEN6
	 DNLg3b3WnZ3wsxOEcx5JdVG0HIdtPAIcLtvTiLLk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 62AA7F805A0; Tue, 21 May 2024 00:27:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DC27F805AD;
	Tue, 21 May 2024 00:27:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E05ADF8026A; Tue, 21 May 2024 00:27:34 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CD126F80051
	for <alsa-devel@alsa-project.org>; Tue, 21 May 2024 00:27:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD126F80051
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jSWUVzZs
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 65911CE0D6B;
	Mon, 20 May 2024 22:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B863C32786;
	Mon, 20 May 2024 22:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716244043;
	bh=A4335sSIXxSmnvWq25uzN3eOtMetrX9olnAwnD6I3O8=;
	h=From:To:Cc:Subject:Date:From;
	b=jSWUVzZsOzzfjNNR6COy5iu43SEw9an/h08K3UwU44Y8aVHFtKBEliBun26ei13rR
	 Fks3mR3dWTpbxbCJpAkbW2+ORuu2WsixgPMnQfErAm0C32EBNFgffeGp+naaJDq3Lk
	 3IZltRLT0E4TSBsXggeBVzqhI84BB6B6IqkMpukjqeAVp6pP2PunWg0j/UFy+x8uNR
	 bDUbyXUbWQN9T0UTLNz+vJezXrmSTZ9baBQ6NU156HgcqQJVif7yTnPyUOzGhHd3ZM
	 R3ppI4db2qLhDkviAeXGdQH2LGTMjzrUstRk0AmDM+6ciPpDCL0o7lK2ZiP6B8BWCL
	 Ic8GCXrXq+IKQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: stm32: Ensure compatible pattern matches
 whole string
Date: Mon, 20 May 2024 17:27:05 -0500
Message-ID: <20240520222705.1742367-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 42MYNY6QUUSNYXS6UQ76QRAAAG2LDQ3T
X-Message-ID-Hash: 42MYNY6QUUSNYXS6UQ76QRAAAG2LDQ3T
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/42MYNY6QUUSNYXS6UQ76QRAAAG2LDQ3T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The compatible pattern "st,stm32-sai-sub-[ab]" is missing starting and
ending anchors, so any prefix and/or suffix would still be valid.

This also fixes a warning on the example:

Documentation/devicetree/bindings/sound/st,stm32-sai.example.dtb: /example-0/sai@4400b000/audio-controller@4400b004: failed to match any schema with compatible: ['st,stm32-sai-sub-a']

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/st,stm32-sai.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
index 59df8a832310..f555ccd6b00a 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
@@ -68,7 +68,7 @@ patternProperties:
     properties:
       compatible:
         description: Compatible for SAI sub-block A or B.
-        pattern: "st,stm32-sai-sub-[ab]"
+        pattern: "^st,stm32-sai-sub-[ab]$"
 
       "#sound-dai-cells":
         const: 0
-- 
2.43.0

