Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C5D606A31C
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=sbml/8GZ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vv/GO3cX
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9983F6023E;
	Mon,  9 Nov 2026 16:05:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9983F6023E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236724;
	bh=6JjxnfNEM0/d08ViPEp7FQmQLR9ZqhexrnxsdNRPIWA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=sbml/8GZNEFsuNzpmg5SboTFr5fscTrlBU1IubCD2E/Qvz5fthimj+mSa2k90pgba
	 RUOfAi2LOvSKeLvFwl/wAUQYymyZ+AKlHOk8pce3RuzAI8SM5VqVG/b556LsRpJd/J
	 ZsxU4KT9nHSGRuOsF2rMS+pDZexe6wVX+Ak82wd8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1CD49F89625; Mon,  9 Nov 2026 16:01:37 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CF1EF806C1;
	Mon,  9 Nov 2026 16:01:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 453C9F80538; Sun,  8 Nov 2026 18:17:38 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794158257;
	b=hcLaH24NeuUfPIakZYRSKRK3slTCn6wt/JoOCjJWUV7mTlXhB5aDdel7XWxJxyU8w8b3
	 xQ38HLvgj0dNFRHvX8Fq5If+NSzXhYB0raVTDjsSM2hRfFy+6gFFF4xpb+WuU4lSiB+zO
	 Ivqk2nQkfNOTaN29qWA7tgae6zr6eirGg+GTEzmdHlJyCPcJyy3h7KRXNLMaJX60vfsC+
	 o/43103Qj6E6TyHvInOnqRHHMKZ9NIgJIQWcp2PcuG/VObRMJ6zm7BoroKfS1zfWUCYGj
	 0OLanKZZeQkATfAwpDqIEscuk81Bf2ubxvgz5icRKlphMp09+Jfwua21hjB94nnd0eA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794158257;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6JjxnfNEM0/d08ViPEp7FQmQLR9ZqhexrnxsdNRPIWA=;
	b=S9ZugdzxRjjlHEuLDg8XxAtRdBNjMhL+i4gYLGg87ZTzKHWEu3lXjh8vXrObzCiZMp2Q
	 HUNLXvorGit7ho4H9qgk8+isYB0nN9QaNkPGS+ozvW32MGPH7TacmMjZXSxjFDmA7thdN
	 /Kp39RiOKh597dlHs6qt8YAI/QEkEhtwJefeB9RJwqfRK3J/a5rGpNMqOzE/I+0v0bXFv
	 YwQX8zkGICThn2vSUxfkGMTRmYyUfJKO5sdgox/PYxMHPFhBBJ+Wzo+1gELC8GqRc5lmy
	 1bXIxhveyrWuhdFUMVYqeWVI0BlncJ9JfEhhAMR/U/L4EE+pqNm2qoHERNn95AI9EtQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="Vv/GO3cX";
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com
 [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9C213F80124
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2026 18:17:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C213F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Vv/GO3cX
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1b2513decc3so185301c88.1
        for <alsa-devel@alsa-project.org>;
 Sun, 08 Nov 2026 09:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794158254; x=1794763054;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xrZCsGFBJGE8YTdUW/NXxb7L9++8m8GQvAjnd7WRUIM=;
        b=Vv/GO3cXhU4b6AHPCbyJkAeU1Yf3O/6HF2J+brxABaeyOrIDvlzhrDfaa8Mc/l0IfD
         ZQgyYTVSQFFM0ngviE7NfWJfL/154FPL+kcT+LWbStSfhjYMwGU0JJaq3UeysVkEhjhE
         ZDTwgdc28g8gX+y9+8cOaTG17RC1zncZoPAlRa84Z3J82yBT0n2E/9+3iaJxoCV20Gk/
         3MuqfkCTOedYUX7giaRz3cqRQVEYSl/lNdl7I8o9SG4iQarOKD2zbnwrtgp2plQxatPA
         z/EEPV7DcePolWuHTcTguKlWXvClQirflVhB/yRjvlAUad+Dwx6/k0L23XQUEYWoinyI
         L1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794158254; x=1794763054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xrZCsGFBJGE8YTdUW/NXxb7L9++8m8GQvAjnd7WRUIM=;
        b=u8q9AydiAiyu95mCKxaw4ogjYsfAO+oRTi2dBIb/SEFQ/6lFZlJ5KEKQqaYzyMKhuk
         tDUMMACCDpCsN2l3fsuAMlBFwNV19ubnZlhSN+0PETpxknylQGLRCC+gHrX4WswZIPHw
         TAuBWuDjVW0H09Bl+aRr5RFMwL+Z2JrsZ3Rm23yPYP5u5mIE9/Q/55uku2yz5Yl6RKMe
         CwV4ryH9RViIvbPilyZjyvsUT2Nye//LaDr32lW0w+qIKBoKtNi/S7rVjIEvHTUbwNlw
         7zYOCEKmVPx5emORAM5lqXzid+ii4UCKQ6tHdGCm4z9n9zBWaOyZcpoM8o6s+MoiqEAP
         cPHg==
X-Forwarded-Encrypted: i=1;
 AL+hErH43J7Iqzqzk/hnaBdmnA6o+d+/7S4XjhLGo6lBSssl+u4TadL6m++AnmxTLhhIbM1vB0rB/nHY7kdH@alsa-project.org
X-Gm-Message-State: APuU4Z/7ptHuCYAQgFyo7Co0WndFNTLdCXE9wfMe5FiVSmG6ibEJzDad
	ebiCslMdKfmTrXyiv52vT3I5WwIt9j4a/c8gCPVPen7Y3uR+N03iqM9z
X-Gm-Gg: AYBFou3RqYETFLUY6FcrvN0+C7CcF37fKoKwl3dkfJh5VkLXoPrcoUB6IFOfTp1M6ew
	M/recT6qTW2AaFaC/VIMQlQWXF0Ah2KRI/ws3kIqp5hxxLSxMXCxE9UsswCI9wMragagWelSmat
	Q/S7Ancua6WYx7fIbiZ7TE+XElBngpqajCkNVdutMehYiS/kUMHXBdfD+FxRy+xrH43URpuLim8
	zyzT4tzEWnHVw7NPXgf124IQHadEOoXvG/AXczWvLjajLci4q3EjVbwnsf3xjqA0twgpcAw01tW
	BatNXV8kLkHYKtV+N1O0j00MNeul1cjoAYcmAHE8YIsbajvr/R1W600LrEp3UFc4qc9rvOUjACo
	JxL5KGa0qHsQWGmlR+t2CtbOnEhWVzpDftMc6TUhEc9L++vRtSLG+nWIy41p+Ci10UtZWjGFcod
	3w7auQ/wd+IFPRF4birnkLqEzP8qDkN8xp1COJasLFFKBxphFodkN+rfQe2vrxr1PlO87icKjCL
	iR9b2A7SKJdBIenfYlYMHW48/80OHXtw+V6lz2pGa6reWunh9/R3flgxn+7g3kylFq1/KRXeVD5
	aEvmF6w234Gemlw04bD50epZwqf2nstd4P3KEENcOsvOtyRP
X-Received: by 2002:a05:7023:a42:b0:195:1a77:85f4 with SMTP id
 a92af1059eb24-1b39feefaa6mr2960462c88.24.1794158253619;
        Sun, 08 Nov 2026 09:17:33 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372665db8bbsm5983442eec.22.2026.11.08.09.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 09:17:33 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v2] ASoC: twl6040: cancel jack-detect work on component remove
Date: Mon,  9 Nov 2026 02:17:22 +0900
Message-ID: <20261108171722.695360-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: hj351016@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: TETY23I3KDIQUBQA2Y2NCGT4W22OPX6I
X-Message-ID-Hash: TETY23I3KDIQUBQA2Y2NCGT4W22OPX6I
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:00:53 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TETY23I3KDIQUBQA2Y2NCGT4W22OPX6I/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

From: Hyunjung Ko <hj351016@gmail.com>

twl6040_remove() frees the plug IRQ but does not drain the delayed
jack-detect work (hs_jack.work, twl6040_accessory_work) that the IRQ arms.
hs_jack lives in the devm-allocated twl6040_data, so a work still pending
at remove runs after the private data is freed -- a use-after-free.

Cancel it after free_irq(), which stops the work from being re-armed.

Fixes: a2d2362edf9f ("ASoC: twl6040: Add jack support for headset and handset")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
v2: Rebase onto current ASoC (did not apply, per Mark's note); trim the
    commit message to the essentials.
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

