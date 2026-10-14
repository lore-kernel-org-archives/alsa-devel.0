Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55332CC6B24
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:55:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1EB2601F9;
	Wed, 14 Oct 2026 08:54:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1EB2601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791960909;
	bh=ZZMWOHcPV/ZhcCh6nhXHqg0hT5jW2Fa66GrVcbh8aAE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=EK+xZm26x4MuW1Sx55mplULUds0lXMvt9bs72XKe0StKniQTHiFaNUz4ren3KA/aG
	 mw7JgHEbpXM8QEOmhgEa9fbk3T1hMuqRg+l/WO2uF4Du3HL7Sj9oiK7T1IIRs8tv68
	 R9/q5ke7z8DjigYRKelFouD6yToXdkYEIvI1l0Jw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F1D8F805FD; Wed, 14 Oct 2026 08:54:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 83796F805F3;
	Wed, 14 Oct 2026 08:54:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12641F80448; Wed, 14 Oct 2026 08:54:30 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791960865;
	b=mx0OlDpmOu8wwq9IJfqd97UOSC6Rutmw7eqs/vEiDYyqUsdcCsCUsr9uJ6zaDQlBzmfz
	 UicSGUBnrA56Nw04jqubJKfsKU2NHji+GzIkWxlMfXM7yvTyPEpe0BJRd8pw8lCPhOedx
	 lAg/sSlCs1bN5fQwUEg8FBRN4NcSUXvmExuwVvXbCKExX+qLq7aNoFua6uKbuVFFpjbMr
	 Bn11jktpyaqXeZJZ1AkukxrvNQlHy3/5TJv4HIdUgUveab5nU+Fa+7VFCzJU6f516MZTd
	 zTTJk6OmdE+gRuFL0c3qWX9r41KxkjgiZlrT1igJTKkUD1jADF3Nk9bFYKyugxgmfLQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791960865;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZZMWOHcPV/ZhcCh6nhXHqg0hT5jW2Fa66GrVcbh8aAE=;
	b=EzwfGhiTICtFDSpE3dKKHlUYwtYIAeMCQs/QI6VQ4OdDR0wtM0yVVNXRhfe53UbWI56v
	 GN5YAKHMRG4Y+yEjC/ZRgKbRdr83Celx0xOa2IIlNj+aj+yaWLJd9R1LPOuPA3qCImxEO
	 tXpui2+sxpjrjD/4/Z8S1YaoYC6/5C0sUnNYVMNY64ZK378DfiRKCO7wObRfuhl882Hbl
	 fxqbNR+2KviGPYFTiTP0NTH/RCJZNSH9saA3pRIQ774VlOMe0uyB3Q2yP1sGFV13lwK2w
	 T0hnvlt5n1TNOhGXrG1l6g23yEm5yBOvDm0UWcdIxMrOodzncAiRMb+OQtdgi3WQXjA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=M+ZQFRKh;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B28D9F80038
	for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2026 08:54:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B28D9F80038
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=M+ZQFRKh
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a02667ccebso26614615e9.0
        for <alsa-devel@alsa-project.org>;
 Tue, 13 Oct 2026 23:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791960864; x=1792565664;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t/EWJwREj/j/NhglPdJXCtWU3i+1LaWly6FUhVKlieA=;
        b=M+ZQFRKhZTH3axy4gX2tdT1wrAm9s5xIYqS3JO7O1A/6oRs8pJaY2TC8SQdBjPquZ4
         m7fkiG2JDagP1y4ssELbpWms+9sgBMIaI9KDVsepy/eqEw6tW4vpiK2RSuKqm1AkE6xc
         DFIh9kxE7o1YodLKsKKdDZpMx9Iz9F1272onUCJeg57Hy3tDMKsVCK6DDx+GPiCjzyjp
         itrlilu24qBrEsdfa1vD5SjTE6L9M5UmqGAnGA8DGG5LzXZFQnE9o/JqSt5d7e9urzM5
         l+66VIUZwfyr3cVRKahnNEiZ8e1Eabfru6aC+nv00VBp8lIFMOcDieMnQobW1zsgZ3Fe
         QIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791960864; x=1792565664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t/EWJwREj/j/NhglPdJXCtWU3i+1LaWly6FUhVKlieA=;
        b=lyiJ3iYWaIFeQNEiUxi4WMYYGt34R+f+FsrH+GjdkWRzue11WuxqbRbwmAmHuDGiCQ
         faNR41Mqg6ujwNMnm3sxm5lPrDq+K3VeIukilWL1Th3BbcDp0K+oQJV3aYHsKJXhT4ZP
         hgewhgFIF/c5wRwg86Np7ltJe2kCoY0QoR0wb03ervDa0TO/LeLE5/1K5UAm1jib2zp5
         SrdXK6tt2WoVvBqm6geK18dkePzE9ecjR3fY+X54yUOkL9EdZaHgaQRqk7kSmDaqQlfF
         SA3YH0s+ppcI4yEfVMKPr6Swlryy0pCOs5skp7ejQKnJwRbXIxNq5+W7d+cjbR8XBLbM
         Z04A==
X-Gm-Message-State: AFq9FYIpNBnskKbnmaFak9Kgfpo6jv6UgjmzDvifxuYz4rBafgCJYTWX
	2uQeW+bcm86/CAu2cD0mPW+Brgr7US84bL72YoFI4ZlPEwGgI19A8xgS6SKCwknOozUoogsy
X-Gm-Gg: AYBFou0lsibcKRmTucJ1QdTmw7FKow3ihWhGrbKhiIfNmQ4xGwFXIP97bhbPJZJVsDS
	ZOCWAYo3r+UIf2e8kDwKwI/ryg8s3jNnwBGCf0ur3jxhNybIItg0xj4KPD1t68KVKsBLEVMapIR
	AdKY0u0dadGo7DAlawHFmHVwZm7MFArst+wGkEADCUyHOYjhhqVmBFqBCO/KrFz26Ynfi7MeH1O
	mk3StpCKKMC8k451yziI+gTHqIgIzM/VarjqVEb2QjPKu8TnK6fokNgjdcDjS6msuZvuen99XF6
	HJBr8nzyNvvzGBJDAYkTUtE3bAEpzY1Yo/3xs3N0ewywquMYB6Ekb59i0CBHtuXoBFvVkwZI8av
	k8f76aeCpb0aV6MwpLL6oEbkZB9kACV//j5xMC6ceojVUYPh0aokCF9SjP22ZaYpLPES7KJbxUx
	0fxG9mSgsP1FzrbesDx5e8LyVO1cC7m3ljdO4zqfQPlYMFD2JWh/USI6kytfzJcBH/BvwilJZ+/
	wsWlKRIfxzeu4Wudtxo9fEwG/IzVzufwue8z5Xwqfvm0FB6dexeOUh4qJaWG30AR3MxfHzz
X-Received: by 2002:a05:600c:3e8f:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4a18e44653cmr298080405e9.4.1791960863433;
        Tue, 13 Oct 2026 23:54:23 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c1e33d2sm612095515e9.0.2026.10.13.23.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:54:22 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: alsa-devel@alsa-project.org
Cc: perex@perex.cz,
	tiwai@suse.de,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	"Claude Opus 5.5" <noreply@anthropic.com>
Subject: [PATCH] pcm: direct - check channel bindings against the opened slave
Date: Wed, 14 Oct 2026 11:54:17 +0500
Message-ID: <20261014065417.261594-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZNX5Z3AOKJ3JIHA3ZYZOIE2U7C3ABAYR
X-Message-ID-Hash: ZNX5Z3AOKJ3JIHA3ZYZOIE2U7C3ABAYR
X-MailFrom: mikhail.v.gavrilov@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZNX5Z3AOKJ3JIHA3ZYZOIE2U7C3ABAYR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

A dshare or dsnoop PCM whose bindings name slave channels the hardware
does not have indexes the slave's channel areas past the end of the
array and reads or writes audio through whatever lies there.

snd_pcm_direct_parse_bindings() checks the bindings against the channel
count the configuration asks the slave for, but the slave is set up with
snd_pcm_hw_params_set_channels_near() and may take fewer, and nothing
checks the bindings again. dmix skips such channels while mixing;
dshare and dsnoop do not.

Seen with the UCM split profile of the Topping M62, whose ten playback
channels go to five stereo dshare devices. After a bad contact the card
enumerated at full speed with two channels of S24_3LE, and WirePlumber
crashed on every start while probing the profile: closing
m62_stereo_out:M62,0,6,7 made do_silence() take the areas for channels
6 and 7 from the heap past the two-entry array and write silence
through what it found there.

Check the bindings once the slave is open, against the channel count in
the shared memory, in both the first and the secondary instance paths,
and fail the open: a binding to a channel the slave does not have
carries no audio.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01UtgNSeUh5N6FdyeFTPugkp
---
 src/pcm/pcm_direct.c | 23 +++++++++++++++++++++++
 src/pcm/pcm_direct.h |  3 +++
 src/pcm/pcm_dshare.c |  4 ++++
 src/pcm/pcm_dsnoop.c |  4 ++++
 4 files changed, 34 insertions(+)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index a08bbe6d..184ced7b 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -1802,6 +1802,29 @@ int snd_pcm_direct_parse_bindings(snd_pcm_direct_t *dmix,
 	return 0;
 }
 
+/*
+ * snd_pcm_direct_parse_bindings() checks the bindings against the slave
+ * channel count the configuration asks for, but the slave is set up with
+ * snd_pcm_hw_params_set_channels_near() and may take fewer channels.
+ * Check them again against the channel count the slave really has.
+ */
+int snd_pcm_direct_check_bindings(snd_pcm_direct_t *dmix)
+{
+	unsigned int chn, schn;
+
+	if (dmix->bindings == NULL)
+		return 0;
+	for (chn = 0; chn < dmix->channels; chn++) {
+		schn = dmix->bindings[chn];
+		if (schn != UINT_MAX && schn >= dmix->shmptr->s.channels) {
+			snd_error(PCM, "invalid slave channel number %u in binding to %u, the slave has %u channels",
+				  schn, chn, dmix->shmptr->s.channels);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 /*
  * parse slave config and calculate the ipc_key offset
  */
diff --git a/src/pcm/pcm_direct.h b/src/pcm/pcm_direct.h
index 9a8c5527..8da2fa18 100644
--- a/src/pcm/pcm_direct.h
+++ b/src/pcm/pcm_direct.h
@@ -220,6 +220,8 @@ struct snd_pcm_direct {
 	snd1_pcm_direct_check_interleave
 #define snd_pcm_direct_parse_bindings \
 	snd1_pcm_direct_parse_bindings
+#define snd_pcm_direct_check_bindings \
+	snd1_pcm_direct_check_bindings
 #define snd_pcm_direct_nonblock \
 	snd1_pcm_direct_nonblock
 #define snd_pcm_direct_async \
@@ -327,6 +329,7 @@ int snd_pcm_direct_check_interleave(snd_pcm_direct_t *dmix, snd_pcm_t *pcm);
 int snd_pcm_direct_parse_bindings(snd_pcm_direct_t *dmix,
 				  struct slave_params *params,
 				  snd_config_t *cfg);
+int snd_pcm_direct_check_bindings(snd_pcm_direct_t *dmix);
 int snd_pcm_direct_nonblock(snd_pcm_t *pcm, int nonblock);
 int snd_pcm_direct_async(snd_pcm_t *pcm, int sig, pid_t pid);
 int snd_pcm_direct_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds,
diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index 4ef158c0..62cfc51c 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -777,6 +777,10 @@ int snd_pcm_dshare_open(snd_pcm_t **pcmp, const char *name,
 		dshare->spcm = spcm;
 	}
 
+	ret = snd_pcm_direct_check_bindings(dshare);
+	if (ret < 0)
+		goto _err;
+
 	for (chn = 0; dshare->bindings && (chn < dshare->channels); chn++) {
 		unsigned int dchn = dshare->bindings ? dshare->bindings[chn] : chn;
 		if (dchn != UINT_MAX)
diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index 6a803b2c..ca66d0f0 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -643,6 +643,10 @@ int snd_pcm_dsnoop_open(snd_pcm_t **pcmp, const char *name,
 		dsnoop->spcm = spcm;
 	}
 
+	ret = snd_pcm_direct_check_bindings(dsnoop);
+	if (ret < 0)
+		goto _err;
+
 	ret = snd_pcm_direct_initialize_poll_fd(dsnoop);
 	if (ret < 0) {
 		snd_error(PCM, "unable to initialize poll_fd");
-- 
2.43.0

