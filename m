Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C591C606A321
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=TjAQm1TB;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vga4zEZI
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4207E60270;
	Mon,  9 Nov 2026 16:04:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4207E60270
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236690;
	bh=j9Pq4bbDohDDg/bQUl5SsWOy1H0MqIVL1ys2RuNcyMQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=TjAQm1TBuCvCzXZzMW8jbRtHHfSc2dNiIwA1GXkvJyZbcPS1splc7nImgr3a6Z3zO
	 ABUha5JYArg24tFLKwVry4p2HScWO3DvnIxlqjb4ZeqX9UYhSb9UvWGOjen7jlSYuN
	 b8luXxoD6o+GRRB1FGINcYeQXqnvbcmmuis1FR5s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 776A9F80C78; Mon,  9 Nov 2026 16:01:29 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A569EF805F9;
	Mon,  9 Nov 2026 16:01:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E51EEF805A8; Sat,  7 Nov 2026 15:20:23 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794061223;
	b=KVA2Rb5R7ZQ+nV/JLgliQUY/hI2GLjvCsP66vRP8J2XE9DZ7oji/knjM/VpZ0qYnY1TX
	 jfSuma3mjGDjMIBFujySKPJNGUAaZGGjDJ8/Jv0R0h9JxY60VDFiPCDc5ncSDbj5+S/PU
	 Q+xF8dnrkPaNd4bajlJ3lmfqJaKD6LxSasDGj3PaIdxIWDYOHfU7Kzj1/jKJ+ODXiR+oX
	 Wc6DchDme7S4Bipsz5TXG39g22w2gB9ZWDlmvggHr5VxvAQVg/VyIbcYlKJFruQWV2nfy
	 9DvvJMkhqfwT+eH7G6XQOW96HxmVSBIr/h3s0hjNw88CR+Gn3YsBtl/pszuRfytVF/A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794061223;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=j9Pq4bbDohDDg/bQUl5SsWOy1H0MqIVL1ys2RuNcyMQ=;
	b=fzZ3YArMhpWTSfibYNSSEmvBBqbDh5hxlhaDfRf1DnPLjezTTuGKawplG31jPUx7Sv+7
	 Yj8PvMxmjGlSBhk65KaYuLUQ47elKMAuqWfR1lMEjWG/tJewdrlKJXFBB9mEgVgQaf7NW
	 C1WJ6AEu4CtHl+F5aVtKQ4cTgdnqbdY6yjuOU+ZWGENzrdHlUG+hYL5UE9FtYt2Dqc9wY
	 AxBmJ+gFmaC0vYmMtzfimO31Gb8kLqRFpJg8wRzdSLUfBNrd/8N2MOSRnAgydvOrvrMOt
	 nFY2rZkk3N8OoeRpAdEDahdJikmx2qXgcYkn7ig+zgYboBg5AQdpNL7Oz7QN/PlqM5g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=vga4zEZI;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 00833F80538
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2026 15:20:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00833F80538
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=vga4zEZI
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-36ff9c9da34so2098385eec.1
        for <alsa-devel@alsa-project.org>;
 Sat, 07 Nov 2026 06:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794061219; x=1794666019;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nq7TMgdP67AQJEH8b+kZWGdLv4SVRS2B3Pui2dDDqM8=;
        b=vga4zEZIczRF/c0gCCsFLPs/Jn1w5nYV67/AhXPsSmAvS+feCjY4XCjW/Gwdj2hHhT
         aQEAmvghoeswvKRy6mW/1KOhbGmPZpC+bM0poAWOTvf6nAIeHRU6N0SIdDQ7dmuoq9C1
         Pe9JkJWBEVEDXDRzfmXHxfzIzP43OH6JMhnxDCPbIC38CqEpWzIaZshGijqcWcASOMs2
         tmYEOZnYDqwvO61eSCvZAlMuLdr2YpXMLbK6K0g4Tq79HQZFgr8l8UFOriYGrhAPP03R
         VECJBgn74LbzfExxT8tfgxjTgFS1De3OIkFs/NbtonCh7Vr70HN6WlDjH/N1zjVW8CRD
         iNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794061219; x=1794666019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nq7TMgdP67AQJEH8b+kZWGdLv4SVRS2B3Pui2dDDqM8=;
        b=PLNgM5QZ7sK0ep2RkucKlSGMgFKIxHmuD31wGAHBJpu8vhM9C6O31UdGNPXxt4H8kH
         ZUFYVN6XP9qbP64lIT7SrjsQRYo5dw3MbUldz6KQ8LnyWXXcE2FumH3fnMpB4rZC20Eo
         0V9Qm9O/duiwMobVRXCdlNtqKkKtQbWMHCtEHXU3m9dFz1CV/WpW39SWiDEfn60rvJAL
         zakKCPX38IBf18ol84DOjJEy+X1mzRYvVuyt2tzU2y6tWfNfNqZ7Ssn94klAI09OcdLf
         nrWcuKVdph29tzMuKF6nWVvaAwEQWbpAI60mv7Ha5Kck1cl08S4wukU5W2RYsfVGaJOg
         0r/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtS7CoGZNfdFXTWF/01sh2SF50XCat/tXdlD+8MQccSZukfx3QJIeMP+apPEyxziM0afzdyuxP6cDf@alsa-project.org
X-Gm-Message-State: APuU4Z+oVszvJgMxTUYjFwpKH6q9XAyfcx9fx+AL9tQ69b7EAo2NhJSi
	2k8vuOoxqg4ykbba8noYMrujZrcHGeHCEsIEPyTaawVD23AKNNsbdP2M
X-Gm-Gg: AYBFou0Ws7UhbLshtIp2vjIEiUNlgSD/l8A0fgtI3ZCF3s1ZPee/2+RYoYstpcd5DB0
	c0ipC3m39MWtnE+q6Sar0tnZR6CQd0zrnFWV1IgItWy5sd98VNj73UvjfMC7V3sTFxe724JaSYm
	zVBw/UeuJRV1UAoWkODKfH+BcRjNK2ADrXRlQv9LttFcZ7pFqSq6VE1HayM2L758Ht8sJodGzau
	hNJ4hE8887u7CoxIAidqQuGijoUgKdfT8kPSKzrE9q2OyLAwPs5AjawIrtkFGuiHCkXRFSWL+iw
	9jSTJwirXB0PO5R/Jqs0u1FVq8OqlkbQVz9Lqyb1YvWBY5zmtcedov1hdIOEJ4MaXrkeI8WDYe+
	W06xzysevxwWzw52Us3sogCO5qGd0lpIJSCX5jA8cLosJL3bBjia4ZHceAxPqvgatqespApKmQX
	7mCEADsTQe14M0yIM23cmEDL6psdv7/5EXA+LaZuAR5cQaluHWq7qUpJRmjddCkXY56YgazCDKQ
	oBzIJmq2saFas5ZaKy8R+pPWN/Ro490tD2i2vjIryddALkUW2OvPRLb1dpHkXuYMSU8RiFl3o0D
	0ooHChAx/IwfrloIzWErPXFudj+AZNlXRYD7sMDcKegKV1DYXMFnQMW1Chp1CoEP2KnGAGc=
X-Received: by 2002:a05:701b:2505:b0:185:fd0c:4585 with SMTP id
 a92af1059eb24-1b25d346ecbmr6821632c88.33.1794061218976;
        Sat, 07 Nov 2026 06:20:18 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4840f3sm25727366c88.5.2026.11.07.06.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:20:18 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: twl6040: cancel jack-detect work on component remove
Date: Sat,  7 Nov 2026 23:20:06 +0900
Message-ID: <20261107142006.3711973-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: hj351016@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 773ZHGC4Y3UMRNITJOFWF4436ANFAJIZ
X-Message-ID-Hash: 773ZHGC4Y3UMRNITJOFWF4436ANFAJIZ
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:00:53 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/773ZHGC4Y3UMRNITJOFWF4436ANFAJIZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

From: Hyunjung Ko <hj351016@gmail.com>

twl6040_remove() frees the plug IRQ but does not drain the delayed
jack-detect work that the IRQ arms, so the work can run after the
component and its devm-allocated private data have been freed.

The plug IRQ handler twl6040_audio_handler() queues hs_jack.work with a
200 ms delay, and the worker twl6040_accessory_work() dereferences the
component via container_of():

	struct twl6040_data *priv = container_of(work,
				struct twl6040_data, hs_jack.work.work);
	struct snd_soc_component *component = priv->component;
	...
	twl6040_hs_jack_report(component, hs_jack->jack, hs_jack->report);

priv is devm_kzalloc(component->dev) and is released by devres once
component removal completes. twl6040_remove() only calls
free_irq(priv->plug_irq, component); it does not cancel hs_jack.work. A
jack event that fires in the ~200 ms window before removal leaves the
delayed work queued; it then runs against the freed priv/component after
twl6040_remove() returns and devres frees priv (use-after-free).

Cancel the work after free_irq() (so the now-detached IRQ handler can no
longer re-arm it) in twl6040_remove().

Found by static analysis and code review; not tested on real hardware
(needs a TWL6040 audio codec with headset-detect wiring).

Fixes: a2d2362edf9f ("ASoC: twl6040: Add jack support for headset and handset")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 sound/soc/codecs/twl6040.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 650836f..826bde1 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1136,6 +1136,7 @@ static void twl6040_remove(struct snd_soc_component *component)
 	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
 	free_irq(priv->plug_irq, component);
+	cancel_delayed_work_sync(&priv->hs_jack.work);
 }
 
 static const struct snd_soc_component_driver soc_component_dev_twl6040 = {
-- 
2.43.0

