Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FB7C433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Nov 2022 00:08:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 766C916B4;
	Wed, 30 Nov 2022 01:07:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 766C916B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669766895;
	bh=wqpaOP9IsZBH4xn9d7qF8ePQ5O6RD8RKVwSH35DW6JU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oQaTybr1+paNhFtr6bhX9E3g5iodYDNHSWuR8jGLykrXax4nL33r07iRCSPflemm8
	 P4q827FZaHPEgvVr/TWjh9326OakegbFiIRkxPFd9glWhhvGdj0VJbGsIWQez7RAo+
	 0AiTWQvxKBSwUt2wb/ZsRJaquXQIPjoKLWp1E59Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA123F802DF;
	Wed, 30 Nov 2022 01:07:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D36BAF8053D; Wed, 30 Nov 2022 01:07:03 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC571F801F7
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2022 01:07:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC571F801F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pzg9Lrsv"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A7BF46195B;
 Wed, 30 Nov 2022 00:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21CAC433B5;
 Wed, 30 Nov 2022 00:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669766817;
 bh=wqpaOP9IsZBH4xn9d7qF8ePQ5O6RD8RKVwSH35DW6JU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pzg9LrsvWEBJN7bAuXvrptbKPXn+k3MOzdQsc03W0U2yB7xE1wLAZSqd5zWe9v11g
 utn/GeuyqrvWNjUms+nVCNonG2oPraHksmVqfZ8NN84/e+tSlKsMGUQnuv6DBY97vA
 gQslbLlamDGy8GArqCHjFZsqnZitPD4045N7sOGYgFx3W4SEFm7xSo/bFD3HJDoh8h
 q6+dbmsWzetI5tnt0af3YxNDarXv2Otove+RUvKFbw/y/+OVhq/9HLZlfM2wOsgGrF
 0SAdkPdTcz4r3We+7yIKtwFONN5R/rsnfeeCCh2qYY4Ih0gCvnJBXHClfn4K37qyaY
 s1nVYZkNp0AqA==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
 Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1 2/6] kselftest/alsa: Report failures to set the requested
 sample rate as skips
Date: Wed, 30 Nov 2022 00:06:04 +0000
Message-Id: <20221130000608.519574-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221130000608.519574-1-broonie@kernel.org>
References: <20221130000608.519574-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2201; i=broonie@kernel.org;
 h=from:subject; bh=wqpaOP9IsZBH4xn9d7qF8ePQ5O6RD8RKVwSH35DW6JU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjhp5sBJwm+lWb68cs/Kqx+6TVtUwnlH1Z4xrws870
 u3bklPeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4aebAAKCRAk1otyXVSH0Lw2B/
 0SOPiFYC3iUaqOGezP5DUzGqUqe4Z68//nb3p1BMeDnELLkK7eIj12TGHaewlYHfKGkXUKcuDMHkAd
 UWRER1A+GZfGVwQidHIDV1ZhWjL0KC/YrpcKxsH+/ODtUy1KOzw4IazeZNHhNl0APY1PJvYmk/Epmv
 3JjUmZR7RsXJCEmo8GmmTBGxGutXsocHwAIou3UWzvgW8EuW3kDkDqAxaZvlrbYwJvE+awd9OlrBYA
 HQReQvrOnS5leguzyjYi2TUbcj3PSaFPCAQb2syWOcXmDqNq3Zq4LCxERxYZbDlD3duYx35BXh3qk0
 OHO3Zcf3Dqin5dKUUWXYQYo6PRWcFW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linux-kselftest@vger.kernel.org
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

If constraint selection gives us a sample rate other than the one that we
asked for that isn't a failure, that is the device implementing sample
rate constraints and advertising that it can't support whatever we asked
for. Report such cases as a test skip rather than failure so we don't have
false positives.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index b8923e494e50..6a9e4af828ee 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -317,6 +317,7 @@ static void test_pcm_time1(struct pcm_data *data,
 	bool pass = false, automatic = true;
 	snd_pcm_hw_params_t *hw_params;
 	snd_pcm_sw_params_t *sw_params;
+	bool skip = false;
 
 	snd_pcm_hw_params_alloca(&hw_params);
 	snd_pcm_sw_params_alloca(&sw_params);
@@ -391,7 +392,8 @@ static void test_pcm_time1(struct pcm_data *data,
 		goto __close;
 	}
 	if (rrate != rate) {
-		snprintf(msg, sizeof(msg), "rate mismatch %ld != %ld", rate, rrate);
+		snprintf(msg, sizeof(msg), "rate unsupported %ld != %ld", rate, rrate);
+		skip = true;
 		goto __close;
 	}
 	rperiod_size = period_size;
@@ -487,11 +489,20 @@ static void test_pcm_time1(struct pcm_data *data,
 	msg[0] = '\0';
 	pass = true;
 __close:
-	ksft_test_result(pass, "%s.%d.%d.%d.%s%s%s\n",
-			 test->cfg_prefix,
-			 data->card, data->device, data->subdevice,
-			 snd_pcm_stream_name(data->stream),
-			 msg[0] ? " " : "", msg);
+	if (!skip) {
+		ksft_test_result(pass, "%s.%d.%d.%d.%s%s%s\n",
+				 test->cfg_prefix,
+				 data->card, data->device, data->subdevice,
+				 snd_pcm_stream_name(data->stream),
+				 msg[0] ? " " : "", msg);
+	} else {
+		ksft_test_result_skip("%s.%d.%d.%d.%s%s%s\n",
+				      test->cfg_prefix,
+				      data->card, data->device,
+				      data->subdevice,
+				      snd_pcm_stream_name(data->stream),
+				      msg[0] ? " " : "", msg);
+	}
 	free(samples);
 	if (handle)
 		snd_pcm_close(handle);
-- 
2.30.2

