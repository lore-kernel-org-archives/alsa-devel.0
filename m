Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFACC7EE30
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Feb 2023 02:10:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D86C4832;
	Mon, 27 Feb 2023 03:10:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D86C4832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677463854;
	bh=IS4E8InAGrbTyS6pyTXTPfpU5meQkkuySQEAfPB2g0k=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=q9vgVb42j2gywMrwfbQORBqu3RDAKQYOPUc0QhfeMRjEg+ow7cGLkrMHAWRXoW5A+
	 67QpTgeKupRxJ01gCtOzZO65/63Nr48T0o0ZWw8Fa/D0TIVYNgsq4TEcYC/OqlT/AU
	 TPSmgWDu/91jvOiSz/wVpmCJIC8Wf7kW0j1oUsR4=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 643ACF8049C;
	Mon, 27 Feb 2023 03:09:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06A52F8049C; Mon, 27 Feb 2023 03:09:41 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E8301F80236
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2023 03:09:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8301F80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RsHuURZ6
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id DC8C9B80CC1;
	Mon, 27 Feb 2023 02:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C19DC433EF;
	Mon, 27 Feb 2023 02:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677463776;
	bh=IS4E8InAGrbTyS6pyTXTPfpU5meQkkuySQEAfPB2g0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RsHuURZ6D5BrEJyJ8814XFdCpU3Wnb+anDLXpRj0Z//qODXD2e1qFaPBODHPgen1l
	 nIUBBvRJjDyJ8oom/7Xw9AkaMBKtdJGv++oCGyUOK+qIriCpWStBK/8UQfRvPFHa0K
	 fHpF4eVq9C8w2AxWVdvouybMMipSHckPqm8UVtj1fzoCPbnYJm6X4faEmRGVbYSK0q
	 +m+eGAKckITUHk874/4y1oVgG8pXsrNJTRkKPWj42ZXXs9slk8Z3GrTUo6GYcWkvMc
	 RueIsS6hA6lKRvCyKxkyD45nMrczYG+iLWpZCewFb627N2KoLtvnoswrmWQfSM3DeI
	 u9TlIv45eHVfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 13/25] ASoC: soc-compress: Reposition and add
 pcm_mutex
Date: Sun, 26 Feb 2023 21:08:36 -0500
Message-Id: <20230227020855.1051605-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230227020855.1051605-1-sashal@kernel.org>
References: <20230227020855.1051605-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NHSVW64RU56NUTVRDUFKVG4624JDP4GL
X-Message-ID-Hash: NHSVW64RU56NUTVRDUFKVG4624JDP4GL
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: =?UTF-8?q?=EA=B0=95=EC=8B=A0=ED=98=95?= <s47.kang@samsung.com>,
 Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>,
 vkoul@kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
 alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NHSVW64RU56NUTVRDUFKVG4624JDP4GL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: 강신형 <s47.kang@samsung.com>

[ Upstream commit aa9ff6a4955fdba02b54fbc4386db876603703b7 ]

If panic_on_warn is set and compress stream(DPCM) is started,
then kernel panic occurred because card->pcm_mutex isn't held appropriately.
In the following functions, warning were issued at this line
"snd_soc_dpcm_mutex_assert_held".

static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
		struct snd_soc_pcm_runtime *be, int stream)
{
	...
	snd_soc_dpcm_mutex_assert_held(fe);
	...
}

void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
{
	...
	snd_soc_dpcm_mutex_assert_held(fe);
	...
}

void snd_soc_runtime_action(struct snd_soc_pcm_runtime *rtd,
			    int stream, int action)
{
	...
	snd_soc_dpcm_mutex_assert_held(rtd);
	...
}

int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
	int event)
{
	...
	snd_soc_dpcm_mutex_assert_held(fe);
	...
}

These functions are called by soc_compr_set_params_fe, soc_compr_open_fe
and soc_compr_free_fe
without pcm_mutex locking. And this is call stack.

[  414.527841][ T2179] pc : dpcm_process_paths+0x5a4/0x750
[  414.527848][ T2179] lr : dpcm_process_paths+0x37c/0x750
[  414.527945][ T2179] Call trace:
[  414.527949][ T2179]  dpcm_process_paths+0x5a4/0x750
[  414.527955][ T2179]  soc_compr_open_fe+0xb0/0x2cc
[  414.527972][ T2179]  snd_compr_open+0x180/0x248
[  414.527981][ T2179]  snd_open+0x15c/0x194
[  414.528003][ T2179]  chrdev_open+0x1b0/0x220
[  414.528023][ T2179]  do_dentry_open+0x30c/0x594
[  414.528045][ T2179]  vfs_open+0x34/0x44
[  414.528053][ T2179]  path_openat+0x914/0xb08
[  414.528062][ T2179]  do_filp_open+0xc0/0x170
[  414.528068][ T2179]  do_sys_openat2+0x94/0x18c
[  414.528076][ T2179]  __arm64_sys_openat+0x78/0xa4
[  414.528084][ T2179]  invoke_syscall+0x48/0x10c
[  414.528094][ T2179]  el0_svc_common+0xbc/0x104
[  414.528099][ T2179]  do_el0_svc+0x34/0xd8
[  414.528103][ T2179]  el0_svc+0x34/0xc4
[  414.528125][ T2179]  el0t_64_sync_handler+0x8c/0xfc
[  414.528133][ T2179]  el0t_64_sync+0x1a0/0x1a4
[  414.528142][ T2179] Kernel panic - not syncing: panic_on_warn set ...

So, I reposition and add pcm_mutex to resolve lockdep error.

Signed-off-by: Shinhyung Kang <s47.kang@samsung.com>
Link: https://lore.kernel.org/r/016401d90ac4$7b6848c0$7238da40$@samsung.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-compress.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 2050728063a15..9146bec146c1e 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -116,6 +116,8 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	if (ret < 0)
 		goto be_err;
 
+	mutex_lock_nested(&fe->card->pcm_mutex, fe->card->pcm_subclass);
+
 	/* calculate valid and active FE <-> BE dpcms */
 	dpcm_process_paths(fe, stream, &list, 1);
 	fe->dpcm[stream].runtime = fe_substream->runtime;
@@ -151,7 +153,6 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_OPEN;
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
 
-	mutex_lock_nested(&fe->card->pcm_mutex, fe->card->pcm_subclass);
 	snd_soc_runtime_activate(fe, stream);
 	mutex_unlock(&fe->card->pcm_mutex);
 
@@ -182,7 +183,6 @@ static int soc_compr_free_fe(struct snd_compr_stream *cstream)
 
 	mutex_lock_nested(&fe->card->pcm_mutex, fe->card->pcm_subclass);
 	snd_soc_runtime_deactivate(fe, stream);
-	mutex_unlock(&fe->card->pcm_mutex);
 
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
 
@@ -201,6 +201,8 @@ static int soc_compr_free_fe(struct snd_compr_stream *cstream)
 
 	dpcm_be_disconnect(fe, stream);
 
+	mutex_unlock(&fe->card->pcm_mutex);
+
 	fe->dpcm[stream].runtime = NULL;
 
 	snd_soc_link_compr_shutdown(cstream, 0);
@@ -376,8 +378,9 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 	ret = snd_soc_link_compr_set_params(cstream);
 	if (ret < 0)
 		goto out;
-
+	mutex_lock_nested(&fe->card->pcm_mutex, fe->card->pcm_subclass);
 	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_START);
+	mutex_unlock(&fe->card->pcm_mutex);
 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_PREPARE;
 
 out:
-- 
2.39.0

