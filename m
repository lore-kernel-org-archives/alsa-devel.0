Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A67C43458
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:56:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 035D060257;
	Tue, 30 Jun 2026 13:56:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 035D060257
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782820571;
	bh=lvXuicJUDw1XULckticqmeYIQAnOyup782sw+YNV4cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IZjnpIZSNLHl1FP2jXmvfOvQGApUYkrkdMhlrYYJC4ZVcnHzfW/1yAN0AaVTO9hvt
	 Y3Blh03RiyKfjln4wgTwm2qT+P1cKGzSWEEshS9tuZBvXdVQl/QUWvZCWnJQITb4lt
	 RlSTrzD5Q0KawBoRTPE5sAqbRSnSdiaD7eLVQRsQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AB1E8F806D4; Tue, 30 Jun 2026 13:54:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D7BFF806D4;
	Tue, 30 Jun 2026 13:54:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3152F805AA; Fri, 26 Jun 2026 15:48:07 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782481683;
	b=iD8yesa3gko4FXHX4MTEr6X4nrlMv86tE45qXZ1kSLFMgQkLr1tHezZzVvyZPtD16euQ
	 qIloLjsbNngislRvUW+uYznwR0ml9brtHYoMJFtfVOoxQ1iPVFRxlB0ov6sf8nrQ0m9S5
	 OJqs8ZPPH89C4cPOlQls0aU0lMampn90mRDPot7ZEh1N0n7r0A5lJxlSECT29geAF6suS
	 iLiUow8aX4T+LcNfRo8u9sIWiC9qIbeWrZEw/94r9o3ikBmZFkbi58Zhg7oDbmRYtN31N
	 keopfFZfhrtgFP8ANl7kyr557DzAoBwyLPzKKaDwLbquZtulNXPBoXSLX6pxz8sZCgA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782481683;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lvXuicJUDw1XULckticqmeYIQAnOyup782sw+YNV4cs=;
	b=en0Auc8tugG4aL5WGGFF5EhXSK3OIVfTcHV9ExxncSdAC2kcd6fj7EldtjwKjTUaS40q
	 ouTBQWs+CtQhY57395oEQGvlr8+2FIGTLgSzXJ5L6Htt4ylF/F1xihrTz51In7lkyQII5
	 2VJiAkkAfKQBrITuFOa5pd3v3AdX9pB+vLBfRiA49nDyEdiMifzqzWMAseb/r10clnpXl
	 E5PPQhVtM5Z/t2Cfa2FpP9mVJ7CyeMaxxtzKPLXObWIn8PFvyI4e1jysCegIRSCX7ruNE
	 sGhAWwjyx22ZFdaYzXqghjukGJ16JSwoyPkR5JrPkkVqh997yx+02ZicYpiWWz/U1NA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mPeH1HK6;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 35AC0F8047D
	for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2026 15:48:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35AC0F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mPeH1HK6
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49222fb062bso10419065e9.1
        for <alsa-devel@alsa-project.org>;
 Fri, 26 Jun 2026 06:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481681; x=1783086481;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP2B2dV7fW3H14lJ2diBc/sAn3zNx/rIDakhi1Twryw=;
        b=mPeH1HK6u7a67axEpVWjSolfmmKUJ2nFjjSCpEMpBQor8HpWzZVOFkOxu/wkfPlOjm
         6sz1JU8PjqNA2e7Eya/hFFlTlmJCqKbTd87k0oUiK10D8hhzHk2bOHdIJA/VbPA7bWfT
         MazJUM300I0h7kj6/MHaurw3pOIb1idL29KY1Cc2+jOiLxaVbsPRbUnf8pjgIc8kW/2K
         EwTvrLj8TnWgBN/NBTxg4uLByTkqyIoa1ieSpkeyfCT4Gu0MhyvNIbHPPH0Q58KX4g0S
         iwkvwdvcDNF70PQgD9xulFUUSVk8QowQ27ZiSKfd4VY4QuzKQwTO88fSr3xQghHGamta
         aIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481681; x=1783086481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oP2B2dV7fW3H14lJ2diBc/sAn3zNx/rIDakhi1Twryw=;
        b=jIidyU8KmB9v97xs4h484uV1R+7Gbi1esczaknmzcb4ZHvgR17sTSMWowlwpAqPaM3
         4CUSlvtnM0vwI3fVV0swTmUoSH6rfJxjgex0Z5ynXJF1/jQpOjFw5i+yEjjgGdv7Ltl+
         9czOnm8luJ10BUp98ZL3EPOfz0v2QhGnhzalxsJBrtOF+GdIjnE8xtWYN2eeU4Rqh+2p
         GTL2yMTuVecZegEDruDOJJUnhq2s8lDh6ThufBx5NqcW+8eREv7zYL0fVWbmeEufc7jo
         PA/bDEhKliDeBFoM/mY31NW536dw76f2VkIL49pfdAXlhhAdCctk7+1xWVMm1EQz2kRJ
         RCCQ==
X-Gm-Message-State: AOJu0YzS/B1INiG6VUh56eQjRg+ce51Ha/CGc9Z/dKtSB/q/nTTIY3ik
	lGVp8CYOFMbD5gOxK2p6i1l3hCyJ1SHAq+vmRnzJF5tBSdh6acFcg+aK
X-Gm-Gg: AfdE7ckd2io1JLe6QAhfam9Ie1ffLko3cIjgOV6TgTQ8dll3cmRc05Rs17Mqs0ulMCi
	o5PTxOVJ3eUnpphGQoehCi5agj0NC7FZIXiEvmKPDa0vQhpk3kB0OVdUnOLJV70mMPIYiqFbrY1
	fXvgtKTM1uSMsFXbgBOCjybHbSuOdhpW0cm9b65VJsz6eEUOwUofvVfHxN3585S0G5ISlI7eavJ
	wYPwE2aKyRn74X4zL70B8i/m5qiK0PIa/kLpOcsPvFibGmh5POKchujCAcf5Sv8/C2/eleMi4Q1
	tlwlf7nSNuqp6goCs0nfFhnEIl4beVXpMmfgk4m/YiJf4sSixVp/UfASSzUOU4njSHrkxWD0Br1
	Jm1FzJ+V0z1USWyLlCTt1oy+7oa8sTAImhrP9eV2M1Fn0vn5myPJerXSihll4Nt3jM6Ueq9P/uw
	eARBNL7Q0FJYD9OudxaxVImjb2mFo9XA/vThvkA+mDFhhCUAlylk7rwA==
X-Received: by 2002:a05:600c:350f:b0:492:7083:94bd with SMTP id
 5b1f17b1804b1-49270839502mr847625e9.28.1782481680893;
        Fri, 26 Jun 2026 06:48:00 -0700 (PDT)
Received: from localhost.localdomain (IGLD-80-230-60-93.inter.net.il.
 [80.230.60.93])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm7987878f8f.14.2026.06.26.06.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:00 -0700 (PDT)
From: Omer Cohen <nevergfx1@gmail.com>
To: tiwai@suse.de,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	security@kernel.org,
	Omer Cohen <nevergfx1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/6] ALSA: compress: remove illegal state mutation in poll()
Date: Fri, 26 Jun 2026 16:47:04 +0300
Message-Id: <20260626134709.27883-2-nevergfx1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626134709.27883-1-nevergfx1@gmail.com>
References: <20260626134709.27883-1-nevergfx1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: nevergfx1@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: RYF2YTMXJGDVDBNCDHSEV65BLXL7HPBS
X-Message-ID-Hash: RYF2YTMXJGDVDBNCDHSEV65BLXL7HPBS
X-Mailman-Approved-At: Tue, 30 Jun 2026 11:54:03 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RYF2YTMXJGDVDBNCDHSEV65BLXL7HPBS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_compr_poll() transitions runtime->state from DRAINING to SETUP
when it observes a drained stream.  This write is unsynchronized with
snd_compress_wait_for_drain(), which reads runtime->state in its
wait_event condition after the device mutex is dropped.

KCSAN flags this on an arm64 system:

  BUG: KCSAN: data-race in snd_compr_poll / snd_compress_wait_for_drain

  write to 0xffff0000c75c8200 of 4 bytes by task 282 on cpu 3:
   snd_compr_poll+0x29c/0x2c8

  read to 0xffff0000c75c8200 of 4 bytes by task 279 on cpu 1:
   snd_compress_wait_for_drain+0xa4/0x270

  value changed: 0x00000005 -> 0x00000001

poll() is a query operation and should not mutate stream state.  The
DRAINING to SETUP transition is already performed by drivers via
snd_compr_drain_notify() when drain actually completes.  The redundant
transition in poll() has been present since the initial compress
offload implementation but only manifests when poll() and drain run
concurrently from different threads.

Remove the state mutation from poll().  When the stream is DRAINING,
report it as ready so userspace can proceed without altering state.

Reproducer (requires any compress offload device, CONFIG_KCSAN=y,
CONFIG_KCSAN_STRICT=y):

  /* 4 threads on the same compress fd, ~2000 iterations to trigger */
  static int compr_fd;

  void *poll_thread(void *arg) {
      struct pollfd pfd = { .fd = compr_fd, .events = POLLOUT };
      while (!stop) poll(&pfd, 1, 10);
      return NULL;
  }
  void *drain_thread(void *arg) {
      while (!stop) ioctl(compr_fd, SNDRV_COMPRESS_DRAIN);
      return NULL;
  }
  void *stop_thread(void *arg) {
      while (!stop) { usleep(500); ioctl(compr_fd, SNDRV_COMPRESS_STOP); }
      return NULL;
  }
  /* main: open compress dev, SET_PARAMS, write data, START,
   * then spawn all 3 threads + repeat setup in a loop.
   * KCSAN fires within seconds. */

  Full reproducer source available on request.

Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
Cc: stable@vger.kernel.org
Reported-by: Omer Cohen <nevergfx1@gmail.com>
Signed-off-by: Omer Cohen <nevergfx1@gmail.com>
---
 sound/core/compress_offload.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index fd63d219bf86..XXXXXXXXXXXX 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -478,11 +478,8 @@ static __poll_t snd_compr_poll(struct file *f, poll_table *wait)
 	/* check if we have at least one fragment to fill */
 	switch (runtime->state) {
 	case SNDRV_PCM_STATE_DRAINING:
-		/* stream has been woken up after drain is complete
-		 * draining done so set stream state to stopped
-		 */
+		/* drain completed or completing, report ready */
 		retval = snd_compr_get_poll(stream);
-		runtime->state = SNDRV_PCM_STATE_SETUP;
 		break;
 	case SNDRV_PCM_STATE_RUNNING:
 	case SNDRV_PCM_STATE_PREPARED:
--
2.43.0
