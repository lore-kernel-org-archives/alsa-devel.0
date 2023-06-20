Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6D1EB64D8
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jun 2023 22:10:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF32184B;
	Wed, 21 Jun 2023 00:10:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF32184B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687299051;
	bh=oc8eRilh+UL0gC7vlGxWO3QMKLhgfG0/Q1DqxC6qW1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gP577KmpVxPLJO4pQA8nK8A05KUqK5s1Yy7gqEN+WTCLb5IP8jytcHWt/r+qbthgO
	 ao/YH2dXcJKAdmDlMxwfpOhhnFQhho+sAHFMC39N5XLSAslCEKYEUbAt9fTY2vNMXB
	 w/uG2mN98ONObUdNNNFxRWA9hxD6qlhSOYCSdpJA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22AEAF80564; Wed, 21 Jun 2023 00:09:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8BB10F8055C;
	Wed, 21 Jun 2023 00:09:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9428CF80141; Wed, 21 Jun 2023 00:08:59 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [46.235.227.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A0497F80124
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 00:08:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0497F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=AgGTpQXD
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk
 [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 19D056606F70;
	Tue, 20 Jun 2023 23:08:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1687298929;
	bh=oc8eRilh+UL0gC7vlGxWO3QMKLhgfG0/Q1DqxC6qW1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AgGTpQXDGsH0OD9JD+Nzxs0bnMhhciLwkp5WIGj2hR1zoh0/1+YRYjc587FRHxGjq
	 V+fgot0OR4R+WL8FMkWEZU0NRDcTBNe79beD8IKJGFyD5jrsLcWhnTlgZETmu/0gyw
	 FbePyK0jXkQrdD2oqpAD0A/yofnyqUhZSCUPtiIwKonnusW8tPn9esgU8KK0XcfF3L
	 t33x3DByTCf+UclqDEGYM+5BcHCcDczAw06p3sbF/T7wT34jD60cRPO8Tn6oOdlc/z
	 KA7YJVXA3DdGO4syUyOB8ZwaFx+ZQR7BJL5Y3zSOJgEOuIYr1fVz4OgsAnxeSbRA7m
	 1o+1hTSpcIIdw==
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
Subject: [PATCH 1/2] kselftest/alsa: pcm-test: Move stream duration and margin
 to variables
Date: Tue, 20 Jun 2023 18:08:25 -0400
Message-ID: <20230620220839.2215057-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620220839.2215057-1-nfraprado@collabora.com>
References: <20230620220839.2215057-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IMKF2XZANIKHURKLUAXMD3ZQPBUSHLPY
X-Message-ID-Hash: IMKF2XZANIKHURKLUAXMD3ZQPBUSHLPY
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
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The duration to stream for and time margin to consider the stream failed
are currently hardcoded values. Move them to variables so they can be
reused and more easily changed.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 tools/testing/selftests/alsa/pcm-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index 3e390fe67eb9..a2b6db33b513 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -258,6 +258,8 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 			  const char *test_name, snd_config_t *pcm_cfg)
 {
 	char name[64], key[128], msg[256];
+	const int duration_s = 4, margin_ms = 100;
+	const int duration_ms = duration_s * 1000;
 	const char *cs;
 	int i, err;
 	snd_pcm_t *handle = NULL;
@@ -442,7 +444,7 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 	skip = false;
 
 	timestamp_now(&tstamp);
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < duration_s; i++) {
 		if (data->stream == SND_PCM_STREAM_PLAYBACK) {
 			frames = snd_pcm_writei(handle, samples, rate);
 			if (frames < 0) {
@@ -472,8 +474,8 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 
 	snd_pcm_drain(handle);
 	ms = timestamp_diff_ms(&tstamp);
-	if (ms < 3900 || ms > 4100) {
-		snprintf(msg, sizeof(msg), "time mismatch: expected 4000ms got %lld", ms);
+	if (ms < duration_ms - margin_ms || ms > duration_ms + margin_ms) {
+		snprintf(msg, sizeof(msg), "time mismatch: expected %dms got %lld", duration_ms, ms);
 		goto __close;
 	}
 
-- 
2.41.0

