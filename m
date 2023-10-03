Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AB0E7AD75
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Oct 2023 15:59:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55129DF0;
	Tue,  3 Oct 2023 17:58:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55129DF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696348773;
	bh=x4+F/ayjzolbI5Z0chsY8fDErsz5v4RnO2hda7AbeCk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ACmtPrykDQIb/8HZyhHH4oEFbeoXvZ/+opcOHeXCBkeu1rg4NzFiCdvnTg8iyhkQR
	 bK7ESp2txaH9mGKACaW9sugNSvRTKGXdwPMwZLoO59Q3KgpEPm9iCdJx8O84R51Md7
	 DsxyG1xXOlTsZKgim1aXmOVlPs9AaR2CjtbOCiXI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15FC3F80166; Tue,  3 Oct 2023 17:58:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 81F63F80558;
	Tue,  3 Oct 2023 17:58:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27E26F80570; Tue,  3 Oct 2023 17:58:37 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E8947F80310
	for <alsa-devel@alsa-project.org>; Tue,  3 Oct 2023 17:58:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8947F80310
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IBYUGpgV
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id D9910B81B67;
	Tue,  3 Oct 2023 15:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0063C433C9;
	Tue,  3 Oct 2023 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696348710;
	bh=x4+F/ayjzolbI5Z0chsY8fDErsz5v4RnO2hda7AbeCk=;
	h=From:To:Cc:Subject:Date:From;
	b=IBYUGpgVFFgQoig5s2QW9LJjtYjJMW/WRBBlkYxbnXnMZ72pTEve2G2zYTs8NlzQC
	 DMROuAtz1IOdXT2P7PH5FdCV2TyV7+4d+EQjSzOHLqYHZTd2v0m+wPGemgTuUu76+V
	 DzsFOHEzOqMe9GBFpU+3L2CHK+MoMjTj72OQPe3km4ANp0YzfFJ++XYMhXZ8wWlyiM
	 F3Oq2/pvgfp6fu79JHz3ushUpTm2PB7R06dNmYLJ0BqJJnrOzgNc5xV1XIWgYr7+B3
	 pXaj4vaMuVdbf4wYl6hR62AurNdj0Cy3OqHOzg6idqQCl6mCJSnW5UvTMnvyXrwNW2
	 UGGkHRPlmsqdA==
Received: from johan by xi.lan with local (Exim 4.96)
	(envelope-from <johan+linaro@kernel.org>)
	id 1qnhnF-00074l-2r;
	Tue, 03 Oct 2023 17:58:41 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/7] ASoC: codecs: wcd938x: fix probe and bind error handling
Date: Tue,  3 Oct 2023 17:55:51 +0200
Message-ID: <20231003155558.27079-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MEQ2JI4VGOL43KWL5SRAPHN467AIHEJO
X-Message-ID-Hash: MEQ2JI4VGOL43KWL5SRAPHN467AIHEJO
X-MailFrom: johan+linaro@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MEQ2JI4VGOL43KWL5SRAPHN467AIHEJO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The wcd938x codec driver happily ignores error handling, something which
has bitten us in the past when we hit a probe deferral:

	https://lore.kernel.org/lkml/20230705123018.30903-1-johan+linaro@kernel.org/

Fix up the remaining probe and component bind paths that left resources
allocated and registered after errors to avoid similar future issues.

Johan


Johan Hovold (7):
  ASoC: codecs: wcd938x: drop bogus bind error handling
  ASoC: codecs: wcd938x: fix unbind tear down order
  ASoC: codecs: wcd938x: fix resource leaks on bind errors
  ASoC: codecs: wcd938x: fix regulator leaks on probe errors
  ASoC: codecs: wcd938x: fix runtime PM imbalance on remove
  ASoC: codecs: wcd938x-sdw: fix use after free on driver unbind
  ASoC: codecs: wcd938x-sdw: fix runtime PM imbalance on probe errors

 sound/soc/codecs/wcd938x-sdw.c | 27 +++++++++++-
 sound/soc/codecs/wcd938x.c     | 76 +++++++++++++++++++++++++---------
 2 files changed, 83 insertions(+), 20 deletions(-)

-- 
2.41.0

