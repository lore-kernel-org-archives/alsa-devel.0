Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150DCC982D7
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Sep 2026 14:25:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 793B56020D;
	Sat, 19 Sep 2026 16:25:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 793B56020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789827926;
	bh=dUIpai9ou9B5J3VaKuOLptEiGqLXnibfYtETAyT5CW8=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Tp3A3UHjIzcWxpruP9Ud+IM6sC+lisn6DvhzRCdgyCJwQHoGr6gXaVER5i57CCblB
	 d6vHRm5Vr/NPP7oK6MXGRUbRcxo9GAB07UGwqz9aJ3WrNII639VpwRU25R/jjDrFh7
	 j8vqAt2AoQ1nG2T52GwJLUE9HOMCzE7iHDn2f3QA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0843F805F5; Sat, 19 Sep 2026 16:24:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F0158F805FB;
	Sat, 19 Sep 2026 16:24:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C39CEF80557; Sat, 19 Sep 2026 16:24:44 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.217.178.61
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789827883;
	b=RifXncvsbhRo7C7MFpIolLBv9FUE656MPQAzc99ZzCF/PDOqRqnlc3LHOhENRwz4YyNz
	 sWXUsjr5GBNjnqC/NL9jTemqoL1MjX0dHC3yS+RWYK5f9NS7VyH5B96aD+A2iR10nGhBe
	 svUfgOAKFHlvjDV8Hb4p8+3x/OMn1nt8wSTqmnwuZM/f8GbCwbsy67re/aEURnwEJu34l
	 +Xjp6M84A+RnsHuZnDUijfg4D5iAz31AsGPwpgZ+5/eKTpijtDib3gox3sR2kSz9I8HJg
	 ROkyYkH4FMN5qx5elfowvv98FXklJi/BvmlDLKWJSivjm0Xup44FAudYYrXG+XDp7XQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789827883;
	h=DKIM-Signature:DKIM-Signature:Date:From:To:Subject:Message-Id:
	 Mime-Version;
	bh=dUIpai9ou9B5J3VaKuOLptEiGqLXnibfYtETAyT5CW8=;
	b=pysBq7NhjV4trtmzV71DE6s91keiZPzPQkNDmBeHC3tfmhei2v1iuegslQpzwUOkRMnl
	 XM7ITq9xNHaP+R2Ai7DqnZBvaFFFiWqgw2MyBbkIGCc4kMmrkdTNce8xS3+64dUl0QXHf
	 L3jlWF7qJ4cfjS/lYta+CA4HLCYw6W2h7mQ4Ee0rYmUcl64o1A7yfEaZlPQ8o83psVYYm
	 L/NjgZql4hecNU3bdflfH6PRbwnt/T+mJEjc6o2Nkw2Vjpv5K6qRbpDja4U4TFmWZqjUb
	 pqCM5vZ02vddLXBB9fpHsDAAVpdK3nCtZ2bIzHEq9xkDvt+3J4oDr53EP5up6unBgNw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=fail reason="signature verification failed" header.d=gorgnet.net
 header.i=@gorgnet.net header.a=ed25519-sha256 header.s=b1 header.b=gJLpRLCv;
	dkim=pass header.d=gorgnet.net header.i=@gorgnet.net header.a=rsa-sha256
 header.s=a1 header.b=CthQmjb7;
	arc=none smtp.remote-ip=95.217.178.61
Received: from gorgnet.net (gorgnet.net [95.217.178.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 212B3F8011B
	for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2026 16:24:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 212B3F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=fail reason="signature verification failed" header.d=gorgnet.net
 header.i=@gorgnet.net header.a=ed25519-sha256 header.s=b1 header.b=gJLpRLCv;
	dkim=pass (2048-bit key,
 unprotected) header.d=gorgnet.net header.i=@gorgnet.net header.a=rsa-sha256
 header.s=a1 header.b=CthQmjb7
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple;
  d=gorgnet.net; s=b1; x=1790432460; q=dns/txt; h=Received:
  Received:Date:From:To:Cc:Subject:Message-Id:Mime-Version:
  Content-Type:Content-Transfer-Encoding; bh=dUIpai9ou9B5J3VaKuOL
  ptEiGqLXnibfYtETAyT5CW8=; b=gJLpRLCv9q9QKSYn/t8uhxLrKNEG6UuFkPFU
  8aCiMFmefywssewOONjvvIz/eaKNfVfRc+wFbizoX7IhuoWrBw==
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=gorgnet.net; s=a1; x=1790432460; q=dns/txt; h=Received:
  Received:Date:From:To:Cc:Subject:Message-Id:Mime-Version:
  Content-Type:Content-Transfer-Encoding; bh=dUIpai9ou9B5J3VaKuOL
  ptEiGqLXnibfYtETAyT5CW8=; b=CthQmjb7HNhDE2J9e3ItoQyA6i/zU8YmO1DX
  TH4A+TLx3D5cWb8b2p8uAteO4d6Hi688mpsdWuvj2Z3uR9rjITDubQReV/5BuFNU
  M5H9Flfl6Hnu8OQqg9shwJKJHYmNYblwlNNQ+HorYuTwJwVDcDID1/nnutpf5gzb
  Q4cVJ1oRYoJsqnl6bYwyO0NWNvtzVZvCVhxKObGRYLt1lNWzGv/mVZHSnrpMTXqE
  kHNhR4cfvLdwRv09iUhjsZgkPv3JR1zsr5eedWVa6v0asQh/rl15Uka7hyWZSpEb
  0yL51XHG37qKe2OxjH8s5JNGRu3OVqHWK3DMkGGV2VJrX33c7A==
Received: (qmail 16781 invoked from network); 19 Sep 2026 14:21:00 -0000
Received: from unknown (HELO void1) (gorg@gorgnet.net@38.240.16.98)
  for <alsa-devel@alsa-project.org>
  de/crypted with TLSv1.2: ECDHE-ECDSA-CHACHA20-POLY1305 [unknown/unknown]
  by 0 with ESMTPSA; 19 Sep 2026 14:21:00 -0000
Date: Sat, 19 Sep 2026 07:24:37 -0700
From: George Matsumura <gorg@gorgnet.net>
To: alsa-devel@alsa-project.org, perex@perex.cz
Cc: tiwai@suse.de
Subject: [PATCH] alsa-lib: Revert
 "A try to fix one rouding problem in refine"
Message-Id: <20260919072437.ecc0cf4d5c702127dc77ac0e@gorgnet.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-musl)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: Y2XIKOOXON6JRO6CCGXDDKLVDUYQYDJO
X-Message-ID-Hash: Y2XIKOOXON6JRO6CCGXDDKLVDUYQYDJO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Y2XIKOOXON6JRO6CCGXDDKLVDUYQYDJO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Greetings,

When attempting to use ALSA directly (without any sound server such as
pulseaudio) with a configuration using the plug plugin, using parameters
where sample rate resampling is necessary, snd_pcm_hw_params or
snd_pcm_set_params may fail, returning EINVAL.

This is because refinement rule 7 in pcm_params.c requires the
period_time to remain an interval rather than a single value if
period_time does not perfectly divide period_size. The code that was
introduced with this change converts the interval to one of its extrema,
leading to -EINVAL, indicating an empty inteval, being returned by
snd_pcm_hw_rule_mulkdiv.

I encountered this when attempting to play 44100 Hz audio with firefox
and deadbeef in a configuration that required the plug plugin to
resample the audio to 48000 Hz for a slave dmix plugin. The follwing
debug output (enabled with RULES_DEBUG in pcm_params.c) was produced at
the end of configuration:

refine_soft '(null)' (begin)
ACCESS: MMAP_INTERLEAVED MMAP_NONINTERLEAVED
FORMAT: S16_LE
SUBFORMAT: STD
SAMPLE_BITS: ALL
FRAME_BITS: ALL
CHANNELS: 1
RATE: 44100
PERIOD_TIME: 21000
PERIOD_SIZE: [926 926]
PERIOD_BYTES: ALL
PERIODS: (4 5)
BUFFER_TIME: (104988 104989)
BUFFER_SIZE: 4630
BUFFER_BYTES: ALL
TICK_TIME: 0
Rule 0 (0x7f8d59fd9530): FORMAT=S16_LE -> S16_LE SAMPLE_BITS=[1 4294967295]
Rule 1 (0x7f8d59fd9480): SAMPLE_BITS=[1 4294967295] -> 16 FORMAT=S16_LE SAMPLE_BITS=16
Rule 2 (0x7f8d59fd93f0): SAMPLE_BITS=16 -> 16 FRAME_BITS=[1 4294967295] CHANNELS=1
Rule 3 (0x7f8d59fd9360): FRAME_BITS=[1 4294967295] -> 16 SAMPLE_BITS=16 CHANNELS=1
Rule 4 (0x7f8d59fd92d0): FRAME_BITS=16 -> 16 PERIOD_BYTES=ALL PERIOD_SIZE=926
Rule 5 (0x7f8d59fd92d0): FRAME_BITS=16 -> 16 BUFFER_BYTES=[1 4294967295] BUFFER_SIZE=4630
Rule 6 (0x7f8d59fd93f0): CHANNELS=1 -> 1 FRAME_BITS=16 SAMPLE_BITS=16
Rule 7 (0x7f8d59fd92d0): RATE=44100 -> NONE PERIOD_SIZE=926 PERIOD_TIME=21000
refine_soft '(null)' (end--22)

PERIOD_SIZE previously had a value of (926 927), which would have
allowed rule 7 to run correctly, before being converted to [926 926] in
snd_pcm_rate_hw_refine_cchange.

I believe this arose from a similar issue:

https://bbs.archlinux.org/viewtopic.php?id=259785

This reverts commit 37728639ae05de702825d96bd1d42e24ae772248. In doing
so, it allows for period_size to remain an open interval in this case
and for configuration to proceed successfully.

I am unsure if this is the case, but I suspect that the bug that
37728639ae05de702825d96bd1d42e24ae772248 was originally meant to
address was later resolved by de88f0e58617e0fef265ec136efccb297e735571.

Thank you for reading this, and I apologize for any parts of it that
were unclear. Please let me know if there is any other information that
I can provide.

Regards,
    George

Signed-off-by: George Matsumura <gorg@gorgnet.net>
---
diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index d54be3c2..c1e2616d 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -34,10 +34,6 @@
 #include "bswap.h"
 #include <inttypes.h>
 
-#if 0
-#define DEBUG_REFINE
-#endif
-
 #ifndef PIC
 /* entry for static linking */
 const char *_snd_module_pcm_rate = "";
@@ -207,10 +203,7 @@ static int snd_pcm_rate_hw_refine_cchange(snd_pcm_t *pcm, snd_pcm_hw_params_t *p
 {
 	snd_pcm_rate_t *rate = pcm->private_data;
 	snd_interval_t t;
-#ifdef DEBUG_REFINE
-	snd_output_t *out;
-#endif
-	const snd_interval_t *sbuffer_size, *buffer_size;
+	const snd_interval_t *sbuffer_size;
 	const snd_interval_t *srate, *crate;
 	int err;
 	unsigned int links = (SND_PCM_HW_PARBIT_CHANNELS |
@@ -229,44 +222,7 @@ static int snd_pcm_rate_hw_refine_cchange(snd_pcm_t *pcm, snd_pcm_hw_params_t *p
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
-#ifdef DEBUG_REFINE
-	snd_output_stdio_attach(&out, stderr, 0);
-	snd_output_printf(out, "REFINE (params):\n");
-	snd_pcm_hw_params_dump(params, out);
-	snd_output_printf(out, "REFINE (slave params):\n");
-	snd_pcm_hw_params_dump(sparams, out);
-	snd_output_close(out);
-#endif
 	err = _snd_pcm_hw_params_refine(params, links, sparams);
-#ifdef DEBUG_REFINE
-	snd_output_stdio_attach(&out, stderr, 0);
-	snd_output_printf(out, "********************\n");
-	snd_output_printf(out, "REFINE (params) (%i):\n", err);
-	snd_pcm_hw_params_dump(params, out);
-	snd_output_printf(out, "REFINE (slave params):\n");
-	snd_pcm_hw_params_dump(sparams, out);
-	snd_output_close(out);
-#endif
 	if (err < 0)
 		return err;
 	return 0;
