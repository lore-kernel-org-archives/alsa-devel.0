Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C28AC982E1
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Sep 2026 13:25:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C20E60216;
	Sun, 20 Sep 2026 15:25:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C20E60216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789910752;
	bh=ZF/mTNSLJ/98FhpnmS2qToVkGfJrS+0CByyOcRCfWNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=R3gtl0K3poQyFY0E06i4sTsxZIqFjf1ZBT9p2U+SQLrYYF5A4vBQOpz0saOp715E0
	 uBnmL+nVv+SKqNhlSTrUyC+NwPqiuuPDGGmvAwjhwPNIH0ZfCJRxpKRw/KPRZU+0XX
	 ObbHMBVmbQzyQrCyN7Pu8t7eS8T0oSazr+7ywyes=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B82CF80602; Sun, 20 Sep 2026 15:25:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 44099F80601;
	Sun, 20 Sep 2026 15:25:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 28850F804B4; Sun, 20 Sep 2026 15:25:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.217.178.61
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789910703;
	b=HzalCwBm79BJxwTqINCXW06TFP3Zdtfl+eAjDjL/airHgAPYExgNNRAg4YH+vz/Vztoz
	 Y/JQxrE7GzGjQfbej+oz157N87V38mnNl5PRjOY/Yrj3OO5RdLTkx/hRHKFAu0elx9Hgp
	 ib6HW3PAyA9HGpRKPuulQOh4MEMWa2Ji81kMfJS1URbFhpIXWIudMJiMLE4DcZT3XEQk9
	 Gvr9qrdji4UnsvFzKUPhrihYVtQnSYrksCK7lA7UzRCswCPrS1QzuY5yhaO6u2hch2gds
	 exoR6y4ZOv2YZa5nhpIgzvLivrkkTrs1UejKZUpcK5p025jOCN+B7fUClLiEed/l6Og==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789910703;
	h=DKIM-Signature:DKIM-Signature:Date:From:To:Subject:Message-Id:
	 Mime-Version;
	bh=ZF/mTNSLJ/98FhpnmS2qToVkGfJrS+0CByyOcRCfWNQ=;
	b=UU/sIEQT0Yt3ih9Fitz7BacMPppiCtDCqmfzsVh+zOH7EbEkzbAFWWatpOSAvyBh6WQx
	 0hr1ftT6fYZCRgO2zl5Nq0kcRGeMuO9DoCfHwat1AN8xnAwFLRCBOxRDVyZppGhRy8HfT
	 EyQQU7h/ZDnU9I2Tc3XcrU4dPFRv7VvLWffdFeYbgEqL4utR74J/7r8yFU5c3ihNXSNuV
	 Ql9Ekr7LG0hHVPHbaAgj786WhzBt8mKgjQIPfyBOAFngDw99j4Ey60/9lb/X6ThfHXLDo
	 afX+angSrcA+3cY8yqph5yaWIhu5nqYlttdOEdFeSy67uCoBV+3Y4h2AmGshwjBGJ1A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=fail reason="signature verification failed" header.d=gorgnet.net
 header.i=@gorgnet.net header.a=ed25519-sha256 header.s=b1 header.b=t8mFgh62;
	dkim=pass header.d=gorgnet.net header.i=@gorgnet.net header.a=rsa-sha256
 header.s=a1 header.b=N8X9WxEA;
	arc=none smtp.remote-ip=95.217.178.61
Received: from gorgnet.net (gorgnet.net [95.217.178.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8D79CF80495
	for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2026 15:25:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D79CF80495
Authentication-Results: alsa1.perex.cz;
	dkim=fail reason="signature verification failed" header.d=gorgnet.net
 header.i=@gorgnet.net header.a=ed25519-sha256 header.s=b1 header.b=t8mFgh62;
	dkim=pass (2048-bit key,
 unprotected) header.d=gorgnet.net header.i=@gorgnet.net header.a=rsa-sha256
 header.s=a1 header.b=N8X9WxEA
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple;
  d=gorgnet.net; s=b1; x=1790515280; q=dns/txt; h=Received:
  Received:Date:From:To:Cc:Subject:Message-Id:In-Reply-To:
  References:Mime-Version:Content-Type:Content-Transfer-Encoding;
  bh=ZF/mTNSLJ/98FhpnmS2qToVkGfJrS+0CByyOcRCfWNQ=; b=t8mFgh624VVku
  ARhsS8uphlIDtEI1vUgAcWv6TpnJtz9mX0uKWgyYn3FJJDy5YbhYgJkI/XAQjcOJ
  XJObYaVDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=gorgnet.net; s=a1; x=1790515280; q=dns/txt; h=Received:
  Received:Date:From:To:Cc:Subject:Message-Id:In-Reply-To:
  References:Mime-Version:Content-Type:Content-Transfer-Encoding;
  bh=ZF/mTNSLJ/98FhpnmS2qToVkGfJrS+0CByyOcRCfWNQ=; b=N8X9WxEAdgaaA
  /5cR4PWlpTmRQghRrc5XNx9mmfkEkRRLPr/PefGaAqE2NHz9/AhCQ/UNEz6nxvyk
  fQuwji7iB2Z4Fxb7BzpIUsngqUn+Vz6A1gXdkL3SZRWlM+u6Zx2zyvbsahcZx8JS
  XjeEriirB3R9y4NvMTujR2giyoQLyk/guAiRzWmU021uLHGYfQ7WpK5v+qEW0t0q
  vnx9K8QZRNK7GEG/v86XHkHRjIAuGwKUXlXRfEeMEtSy2WK6u38wbZgTtGsw5LFX
  +Ppp39wqnj/2TpD2HmU8/wpKdPa8TJiND4oS19OlFG1F9vbIrOZFAMCpnWD8vCHN
  KSy/mGIhw==
Received: (qmail 8628 invoked from network); 20 Sep 2026 13:21:20 -0000
Received: from unknown (HELO void1) (gorg@gorgnet.net@38.240.16.98)
  for <alsa-devel@alsa-project.org>
  de/crypted with TLSv1.2: ECDHE-ECDSA-CHACHA20-POLY1305 [unknown/unknown]
  by 0 with ESMTPSA; 20 Sep 2026 13:21:20 -0000
Date: Sun, 20 Sep 2026 06:24:58 -0700
From: George Matsumura <gorg@gorgnet.net>
To: alsa-devel@alsa-project.org, perex@perex.cz
Cc: tiwai@suse.de
Subject: Re: [PATCH] alsa-lib: Revert
 "A try to fix one rouding problem in refine"
Message-Id: <20260920062458.bef6ad9e4972c868216aad0f@gorgnet.net>
In-Reply-To: <f3961c4b-3aba-46b3-844b-0fcd3ad9ce73@perex.cz>
References: <20260919072437.ecc0cf4d5c702127dc77ac0e@gorgnet.net>
	<f3961c4b-3aba-46b3-844b-0fcd3ad9ce73@perex.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-musl)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: NMFTKCDF6XNBYCXFMKICPWAEEMWGMLOL
X-Message-ID-Hash: NMFTKCDF6XNBYCXFMKICPWAEEMWGMLOL
X-MailFrom: gorg@gorgnet.net
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NMFTKCDF6XNBYCXFMKICPWAEEMWGMLOL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 19 Sep 2026 17:02:51 +0200
Jaroslav Kysela <perex@perex.cz> wrote:
> Can you replicate this issue with aplay (use similar stream parameters as 
> firefox)? Please, show the exact command to reproduce this.

Certainly, I apologize for not doing so in my original message. I was
able to replicate the issue with the following aplay command, with
parameters similar to what I believe deadbeef was using:

aplay -f float_le -r 44100 --buffer-size=8192 --period-size=1024 \
  <testfile>.raw

The following asound.conf was used:

defaults.pcm.!card 1
defaults.ctl.!card 1

pcm.!default {
    type plug
    slave {
        pcm "dmix"
        rate 48000
    }
}

> Also, only "if block" should be eventually reverted. The debug prints should 
> be preserved.

A patch with this change exclusively is provided.

Thank you for the quick reply and your time in evaluating this. Do not
hesistate to let me know if anything else would be helpful.

Regards,
    George

Signed-off-by: George Matsumura <gorg@gorgnet.net>
---
diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index d54be3c2..be712d34 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -210,7 +210,7 @@ static int snd_pcm_rate_hw_refine_cchange(snd_pcm_t *pcm, snd_pcm_hw_params_t *p
 #ifdef DEBUG_REFINE
 	snd_output_t *out;
 #endif
-	const snd_interval_t *sbuffer_size, *buffer_size;
+	const snd_interval_t *sbuffer_size;
 	const snd_interval_t *srate, *crate;
 	int err;
 	unsigned int links = (SND_PCM_HW_PARBIT_CHANNELS |
@@ -229,26 +229,6 @@ static int snd_pcm_rate_hw_refine_cchange(snd_pcm_t *pcm, snd_pcm_hw_params_t *p
 	err = _snd_pcm_hw_param_set_interval(params, SND_PCM_HW_PARAM_BUFFER_SIZE, &t);
 	if (err < 0)
 		return err;
-	buffer_size = snd_pcm_hw_param_get_interval(params, SND_PCM_HW_PARAM_BUFFER_SIZE);
-	/*
-	 * this condition probably needs more work:
-	 *   in case when the buffer_size is known and we are looking
-	 *   for best period_size, we should prefer situation when
-	 *   (buffer_size / period_size) * period_size == buffer_size
-	 */
-	if (snd_interval_single(buffer_size) && buffer_size->integer) {
-		snd_interval_t *period_size;
-		period_size = (snd_interval_t *)snd_pcm_hw_param_get_interval(params, SND_PCM_HW_PARAM_PERIOD_SIZE);
-		if (!snd_interval_checkempty(period_size) &&
-		    period_size->openmin && period_size->openmax &&
-		    period_size->min + 1 == period_size->max) {
-			if (period_size->min > 0 && (buffer_size->min / period_size->min) * period_size->min == buffer_size->min) {
-				snd_interval_set_value(period_size, period_size->min);
-			} else if ((buffer_size->max / period_size->max) * period_size->max == buffer_size->max) {
-				snd_interval_set_value(period_size, period_size->max);
-			}
-		}
-	}
 #ifdef DEBUG_REFINE
 	snd_output_stdio_attach(&out, stderr, 0);
 	snd_output_printf(out, "REFINE (params):\n");
