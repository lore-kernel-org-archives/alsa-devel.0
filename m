Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41810606A31A
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=NBDP9eRS;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=AcRU8I4T
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91E1C6025B;
	Fri, 23 Oct 2026 09:11:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91E1C6025B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792739476;
	bh=huIlFCsZCtW9EvCMUYovDzCuBbGv+HAK18qyT9nyhnQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=NBDP9eRSkWbPSo9GRsW214wSd2RZvelMpZ5vc+QmVpERmLCagCs3tNTbbgMNRtY/U
	 tfcIs3hmMg2OpLgVObKpK/aCl6oajB3NNLGwfCjl899X8MdG38gdOmqQD+EQs6Pyt/
	 IlxcYmrtOQ+FKRpKUvohPzjaAdPTW57SEwq7PgWg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 314AEF80727; Fri, 23 Oct 2026 09:09:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D525F8073C;
	Fri, 23 Oct 2026 09:08:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 619E7F804CC; Thu, 22 Oct 2026 15:02:51 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru
 [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F0085F8003A
	for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2026 15:02:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0085F8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=astralinux.ru header.i=@astralinux.ru
 header.a=rsa-sha256 header.s=mail header.b=AcRU8I4T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1792674164;
	bh=huIlFCsZCtW9EvCMUYovDzCuBbGv+HAK18qyT9nyhnQ=;
	h=From:To:Cc:Subject:Date:From;
	b=AcRU8I4TJmhY/vg88BXHFdtyNi0ehXLBmGvHCA4BqIG+gtSmUI1rXWTTzgd3aJDoH
	 6nVdoc3GQ3lyef9biEQGrMJ0uJLDVOh8fojvoixDLcfhNauS/PfIdj6KZxTRDe1bj+
	 gzYjGf4eiEiOkTC7xyYPl3KbDt3/z7H5q1dGcxfC9kwMX/ycDIyGPNVDvR+vwdpB0o
	 VLAxUjFIaZeq/BQ7hDy4x6fyH+jz0r+gKe8aDsP61JtZPA0Sr84MiNEDWTbZ3Lniz3
	 fw658tKVj/AUunBHjjKiAJyPbPWv3IgauYtt+8c1ORgMI7xAphNxTz6JsW9GbPe8fW
	 PnHTWWd0bmTTA==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id B1BFD269A5;
	Thu, 22 Oct 2026 16:02:44 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Thu, 22 Oct 2026 16:02:43 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.49.111])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4j9RC70RFCzRM8;
	Thu, 22 Oct 2026 16:02:43 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	HyeongJun An <sammiee5311@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] ASoC: codecs: hdac_hdmi: Validate written enum value
Date: Thu, 22 Oct 2026 16:02:05 +0300
Message-ID: <20261022130207.475-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/10/22 11:19:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 132 0.3.132
 b92628ca234da971a1a6d61b32804bb3075f0fd2, {diag_burst_silent},
 {Tracking_one_susp_tld}, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to},
 127.0.0.199:7.1.2;patch.msgid.link:7.1.1;new-mail.astralinux.ru:7.1.1;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1,
 FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206901 [Oct 22 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854,
 bases: 2026/10/22 12:20:00 #28725625
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/10/22 11:19:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
X-MailFrom: mdmitrichenko@astralinux.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: HGS7EH3GIU22K67LHRK5VAZ3N5IN2OJD
X-Message-ID-Hash: HGS7EH3GIU22K67LHRK5VAZ3N5IN2OJD
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:08:19 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HGS7EH3GIU22K67LHRK5VAZ3N5IN2OJD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

From: HyeongJun An <sammiee5311@gmail.com>

commit 0b08baeccdcf52fad328ad645f5b4fbee04eea34 upstream.

hdac_hdmi_set_pin_port_mux() uses the written enum value to index the
texts array before calling snd_soc_dapm_put_enum_double(), which validates
that the value is within the enum item range.

An out-of-range value can therefore make the driver read past the texts
array before the helper rejects the write. Move the lookup after the helper
has accepted the value.

Fixes: 4a3478debf36 ("ASoC: hdac_hdmi: Add jack reporting")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
Link: https://patch.msgid.link/20260609124317.38046-2-sammiee5311@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-74295
 sound/soc/codecs/hdac_hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 76e06c88f279..32f5b958cb80 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -906,12 +906,14 @@ static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
 	struct hdac_device *hdev = dev_to_hdac_dev(dapm->dev);
 	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_pcm *pcm = NULL;
-	const char *cvt_name =  e->texts[ucontrol->value.enumerated.item[0]];
+	const char *cvt_name;
 
 	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
 	if (ret < 0)
 		return ret;
 
+	cvt_name = e->texts[ucontrol->value.enumerated.item[0]];
+
 	if (port == NULL)
 		return -EINVAL;
 
-- 
2.43.0

