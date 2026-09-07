Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9EEC79F82
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:41:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CAEF760338;
	Tue,  8 Sep 2026 20:41:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CAEF760338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788892875;
	bh=GOgl2AuYHF4o6a4Lhc4SJicPmu0YSPNh3S5k/cExEnc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=o3Aq52Q5khwyp1eOc7CbFXXv+Ui2TkXxbA8FQL/uuXKSGSMG9FS8Hzo2nR9nyAZU4
	 l+P6ULUutilpjNXuNkTV9Hkg7pVRVbD/8agHkk0ve4ztrtpGskMZbkGDcOVVrTaoef
	 NCVLWxVELv+f6RhR6klQ4TRpEJ4VpXmVFmOBLljA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 74F19F8970F; Tue,  8 Sep 2026 20:36:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CA2AF89716;
	Tue,  8 Sep 2026 20:36:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BAA00F80571; Mon,  7 Sep 2026 05:17:44 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788751063;
	b=LnAfoIp9x0POLdaZzMwftcFXxGJbxwVnvd0i9dZn+P1HgYyPTSgzWoWcscY426y1oduT
	 54U+grVxARsjeEwDsBmegfPGIE4Th2597fLONKxh7pp0IQoQ59YNpj7DLu1Kqkkc1448z
	 L7S9WH46i5U7a/bc7AKyApr5VvnzBMcMrOU/8BVJw4gQ4d9h6+4bog1dXnoZCutDplL/V
	 ZtF2DzoYo/UOAPVmXyqaJp1MYadorD13QdkM28KS2+x+z/QN+UnBL04ju25U3z1Mu2Hnm
	 v5HFpDAv+AHBUq6K4HuGv+FD5HT4tj58l0LBo5626IAZ/DvGnOuLrUIDCyXpOrPljdg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788751063;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GOgl2AuYHF4o6a4Lhc4SJicPmu0YSPNh3S5k/cExEnc=;
	b=HU7O9PfjD0efZbaswgu+I2qv4Hn/GOOkSsZT7cTW7GohiC2sGS48GGjoIi+NahDD57dp
	 boh1/hMF/fiCkY+/NasPVLHYFAUuuYgfnX383LoNtTWtAE6/nWdlJMLMb1wu0C+IIf8vg
	 Gq+YHgoMn/FACfLv6Syprlj4z/1Ul+slZqochJ99Moo9QU+Eln4OQQHTEG3TCIC1zEJ7v
	 rcggmeyfZZyMIX9PcB5MfByI/jE3jyjkR/jPzohkgK5bsNN51UuTeR9L6w4UPLkqxMfhn
	 Ia9MLyIZtMaHumOSKMLLkzdW05WnWQjw8X5ARd0yVV35rLDJgHdPuFr/YiV5ccWDNIw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WyWLHM2Q;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A57D6F80088
	for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2026 05:17:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A57D6F80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WyWLHM2Q
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cf452def93so33921065ad.1
        for <alsa-devel@alsa-project.org>;
 Sun, 06 Sep 2026 20:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788751060; x=1789355860;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O/1O+V3m/DlTGUY8KpefTzcFfj5+Q1Ib789WR1OBDhI=;
        b=WyWLHM2QUaBVtETMc8Yi/VUiKOIV8ZNEFxTP6job9esZqKtpSbZcSqspHbQu+oM2qJ
         H0xB5XJlj3ItW5LebJHcQqyTklLs9MP15rVJi9XWPu+7dTDBqV3qRM72r/WIPk5ike4Q
         ZQMvrUgKthAmnZSQxApJA4W29e9QpWBYf2m01qJ6qlEDUqJHTfgy3CI3oGp1w7TdiodQ
         X0g6l9b++8ngAuQgC/RO2mEpG3TDNg44LpFXJgagRIaOMhhNdh3VQmf2AhLXJek5sD2o
         QgpJKNUXbgQC29EuKqB2WpzdiaCWvd7MP9qKLzQWZOhzeQ8dSUpaDDWARGtdWU12e5Yh
         MI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788751060; x=1789355860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O/1O+V3m/DlTGUY8KpefTzcFfj5+Q1Ib789WR1OBDhI=;
        b=OgPTed5CudbKdVfwqUiv6M9qMAtsg5KEwjW3faSjNG/VXORnQnOuz8foKWUwW1THqg
         xYki+3sSVF/kR5cH4NOEsXYLK3eok4fL3f0xZov7AnuCIjuS4y35XC7flQ4bhMYz7THg
         6DEULS59BlalphWNozrWncYhB9ptXvZk716zk1WG+vF26ZqjUdIWQ/LwQjtCXk+bTI6S
         NZrM0UfTGHZU2VMNc+8xvWkaZ4D4vE0uLPqMw4aQ9YhXcwL01pVd0elVmRi4nOWgJ/or
         hG1oP/jUnX+QqjmYULEFJvnoTGngtrQKGRNEBRVJjlc9i5cYTfJNu5EqrnFQ2icDPa87
         cfzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWc21Bn9M2TRyAp/qbRoE513rfaW6AH4+XChumKlRE/PwaMsAsZfqP4h7FEMe+yEfYHkv9MWLaGHmD@alsa-project.org
X-Gm-Message-State: AFuF++nChu3BzcHmDHVif8h9qdfF0lwtwVKugQJpICVUTE1bo312kWDm
	9XZxR6O4xOmb/WQMuRQRF1iPwF/0fVkx9xou5HSv0+f/dhUMohD6Jak=
X-Gm-Gg: AYBFou2xsYrggjVYtDHzDFo4LhmVGDYQvyWNnX4ABPyz3z3MdXf6H3VjZ+JdA2TWBW/
	6uNSE3BpJ4WPPV9ctsBygc4sNrgHIkbIwZl82ggYmNrKzaRDxeHSx7kbO409pg+Vdw7P0fLfHkU
	EfFjHM5Lk0FSfwmd8WTnkTWBPuNgwi6r83o7a1rFHzCWreHP4480v0xiqrzAjYvH6Hj/ZlyCRIz
	Bh6tey6jz+8qMDz/cfzPI0ex791d2aW/fBzX7wZwsD59WKZePocMVFxrk1sbsJRuWJA2JbXp9x8
	kA+wm+Y7xxsUZlg4Uvpfj/QptR/EoJET2oZWUYbGXYf7wmtqsq+st+1h38PGlZnHG7q7g2ahXzU
	q/B7tNcDfyg+JRMVIQytFCoDZL/Y+EqjRu5dygTImrMvPg/VIbgfSdmYAwP6VBKQoV5hfd9qqWx
	TbkO7Bh9vRqO3wrJZ0EGG9RY8YKf6rGi+4CE7xTbGQwwMjTav8qVkBkFOdCIbF5hFFBEDTYlhEr
	kZj2pmgtNsdJCtb
X-Received: by 2002:a17:90b:2ccd:b0:398:baa7:4c2f with SMTP id
 98e67ed59e1d1-39b27c442f8mr16208923a91.5.1788751059655;
        Sun, 06 Sep 2026 20:17:39 -0700 (PDT)
Received: from Nitro17 (S010660cf843d99e8.mh.shawcable.net. [70.75.72.188])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b2a6cb7c8sm5206120a91.1.2026.09.06.20.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 20:17:39 -0700 (PDT)
From: Aaron Welwood <abwelwood@gmail.com>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Aaron Welwood <abwelwood@gmail.com>
Subject: [PATCH] ASoC: amd: yc: add quirk for Acer Nitro AN17-41 internal mic
Date: Sun,  6 Sep 2026 21:17:38 -0600
Message-ID: <20260907031738.17257-1-abwelwood@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: abwelwood@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 63SMQOC4YVJERUZCXMSLLNEIWEMXLVUI
X-Message-ID-Hash: 63SMQOC4YVJERUZCXMSLLNEIWEMXLVUI
X-Mailman-Approved-At: Tue, 08 Sep 2026 18:35:33 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/63SMQOC4YVJERUZCXMSLLNEIWEMXLVUI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The Acer Nitro AN17-41 uses "RB" as its board vendor and has no entry
in yc_acp_quirk_table, so acp6x_probe() finds no DMI match, registers
no card, and the internal digital microphone records only silence.

Add a quirk entry for it so the DMIC is enabled.

Signed-off-by: Aaron Welwood <abwelwood@gmail.com>
---
Tested on an Acer Nitro AN17-41 (board Spacia_PEH, BIOS V1.26).
Without this entry acp6x_probe() returns -ENODEV and the internal
DMIC records silence; with it the acp6x card registers and the
microphone captures normally.

 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 21d7ec0..65c4d13 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -388,6 +388,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Nitro ANV15-41"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "RB"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Nitro AN17-41"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.55.0

