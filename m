Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300BCC433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Feb 2022 15:58:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4B791782;
	Tue,  1 Feb 2022 16:57:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4B791782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643731091;
	bh=SbklKS9KQyDDauUd9qvaAwrtFGgLiaGtMtmOYdLzNmU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Imkw1+xPN9L0LGxdS9woLEC/35pf57spj9iUnjWynb+YF1tbmTAd+utu+K9kBa55D
	 9I2iw83auLyTa/+gIjuzE07wjJElyKS130vztippoWZ2G7HzTx0wtkUJrjEcKmAm5Q
	 4zm5eTzj347XF3Tkr2RTFoROKJ4/OQ5I4W2ezQCY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76169F8012C;
	Tue,  1 Feb 2022 16:57:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46F14F80139; Tue,  1 Feb 2022 16:57:16 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ECB60F800F8
 for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2022 16:57:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ECB60F800F8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UYYADJmd"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D921A615A4;
 Tue,  1 Feb 2022 15:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4058FC340EB;
 Tue,  1 Feb 2022 15:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643731029;
 bh=SbklKS9KQyDDauUd9qvaAwrtFGgLiaGtMtmOYdLzNmU=;
 h=From:To:Cc:Subject:Date:From;
 b=UYYADJmd6PS+jCOc3kAD/nusjxDKqK7UjcFIZrpOSJzGOchShfcS7r451J6XhRY3M
 /ucoNdZ9AQdSa9EdJ+gdTTI8jEXd1tr0cpabewhVQBpMG1dqZzsIrjgOGzZZWAt7dX
 T0Fah+gCTmvVRX1c19AZe6cRDkVdndQyeX1uMVG3DuhhiT7JFySVq8RrLAbTXqDyya
 RRmK+TRcApi37xBHKOK5tkSM/xLZQEDURWeNjkJL2WEkeDECsrMr9Ot0JSzj9YYSVK
 CilPC6ZOlwhxG2dkE6LIiAKsQC4vHzrx2wodQf8qgEP2qrAFzUkDmSEsPVM3tapzET
 PopELxMs41uGg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v1 0/4] ASoC: ops: Fix stereo change notifications
Date: Tue,  1 Feb 2022 15:56:25 +0000
Message-Id: <20220201155629.120510-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=748; h=from:subject;
 bh=SbklKS9KQyDDauUd9qvaAwrtFGgLiaGtMtmOYdLzNmU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh+VgpFt9kcyLC5Q7J+724KS7tQR0Rk8xG/2vOKofR
 cHhAugeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYflYKQAKCRAk1otyXVSH0J8GB/
 9YO/VV7A3GnqBYC4EvoOCpVzzBW/dWN7ZMazvrBhlYmayq8sQlgF9/M1+5jPt+qXXPPbF9XQtTYJjB
 /fVZVHI/xfdomEtxv9hxpPttjZua7mYSoHYaBMu55IKWY7uqPrhzubEkyVLu2nrgF+B2NiaivwJfc+
 0weVGDuGLqTfj58CgnHu3nwGahvaHgXXq1p1uBbLCtWnmveEDFI0S2+5qGfrlgFOTP/plOi1UnYzoU
 k8p5Gnr96Es2uUXEIw4le2FivskoHYuyoXkU41Tja14bWGJMs0qOBbiwoM8Z5/+1EC1tFlPgAWqC/O
 wv4XQSnZM8XCd10/pryZjnr9Qmtx5D
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

The event generation coverage I just wrote shows that the generic ASoC
ops fail to generate events for stereo controls when only the first
channel is changed, we just return the status for the second channel and
discard that for the first.

Mark Brown (4):
  ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw()
  ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw_sx()
  ASoC: ops: Fix stereo change notifications in
    snd_soc_put_volsw_range()
  ASoC: ops: Fix stereo change notifications in snd_soc_put_xr_sx()

 sound/soc/soc-ops.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.30.2

