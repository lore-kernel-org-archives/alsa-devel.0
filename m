Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ECBEB64D8
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jun 2023 22:10:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40C7A823;
	Wed, 21 Jun 2023 00:09:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40C7A823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687299020;
	bh=O6nBVgd9ap44QM7G+RNtH4uWhatsD2Et596Aj8S3xvg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=m6FnVVxbQ6pUDYRxfU1I1Vv2yG9I73rN8R+6/BnZ3Cie9eZOHwgFFCO8DVyUTneWl
	 Su0Xm5pxyy88C+fSi63O8jTq8cLq6/M2G0Lm6yNgZ5wAvKWHzCDnOvQgDVT2GGxdOW
	 LNGX+73RvCV0HtfjXZqEXTkP4jpXb0ngjVdViG4E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 48D44F80132; Wed, 21 Jun 2023 00:09:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 11525F80141;
	Wed, 21 Jun 2023 00:09:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9AE98F80169; Wed, 21 Jun 2023 00:08:55 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [46.235.227.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AF22CF80022
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 00:08:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF22CF80022
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=Ttr8MNyz
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk
 [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 6C9A96606F5C;
	Tue, 20 Jun 2023 23:08:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1687298927;
	bh=O6nBVgd9ap44QM7G+RNtH4uWhatsD2Et596Aj8S3xvg=;
	h=From:To:Cc:Subject:Date:From;
	b=Ttr8MNyzYdZv+GJsMJOL981JZeLwZ/t3Sjv+BcXrwDJdB0PI0e0P6CkCe458Usbux
	 4jwGX0yH4RLDpX0TvwjlE44iCWq7oqjRF8o/aBIeM7X4VL0PJKbMp4KJpALSCAr/pB
	 9L7ncbp5op9y9Fmq1QefLswM8Yvqv1eer7+Eca9Rlc9W1hHeS9U0xGfsVW3+YM2ENF
	 4DgHN6LQj4qewFmHpZd9GLzOoRq3UzfsQ/QfflVWnYdbr2Frryd6WvMJ6La+lJMkI/
	 AqZAujRDwtAxjQHMBmHSlXNpDu1wJhvzuM/Jkrrebs8giusGcbS9rWt8t+nDuYA81p
	 lCgYQOTijMpiw==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Shuah Khan <shuah@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] kselftest/alsa: Decrease pcm-test duration to avoid
 timeouts
Date: Tue, 20 Jun 2023 18:08:24 -0400
Message-ID: <20230620220839.2215057-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: POC7JUG547D67P4GSFJH3FP7O5TLAZIE
X-Message-ID-Hash: POC7JUG547D67P4GSFJH3FP7O5TLAZIE
X-MailFrom: nfraprado@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/POC7JUG547D67P4GSFJH3FP7O5TLAZIE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


This series decreases the pcm-test duration in order to avoid timeouts
by first moving the audio stream duration to a variable and subsequently
decreasing it.


Nícolas F. R. A. Prado (2):
  kselftest/alsa: pcm-test: Move stream duration and margin to variables
  kselftest/alsa: pcm-test: Decrease stream duration from 4 to 2 seconds

 tools/testing/selftests/alsa/pcm-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.41.0

