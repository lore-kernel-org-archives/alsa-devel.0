Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F73BC27C54
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Jun 2024 13:37:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FC5FDF8;
	Thu,  6 Jun 2024 15:37:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FC5FDF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1717681032;
	bh=MM6fkK8XHPM0718xjZqOzva4JDdePDF+AbiQ7dw5a7M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=iZ2DlV4b2TQ7DfQDBPZVtytGmF0f5HlKSc7fN/iaAbRdI3fJtWPmDjKoAYMJ88HbW
	 o/fskBLG2oWNDDrU/nfCS5gE3u8I+OHNa1iq93scJNXNe3Lz3VIh1JfG9GBXtqxSUE
	 PEaLBW0b5WI30swyBGwUsHG9rnxrcEkYeAQtKi6k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3B98F804FD; Thu,  6 Jun 2024 15:36:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C00CF805AF;
	Thu,  6 Jun 2024 15:36:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 94FDFF804FD; Thu,  6 Jun 2024 15:36:35 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 67A13F80088
	for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2024 15:36:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67A13F80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=K1O06Use
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B845061DC4;
	Thu,  6 Jun 2024 13:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BB0C2BD10;
	Thu,  6 Jun 2024 13:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717680981;
	bh=MM6fkK8XHPM0718xjZqOzva4JDdePDF+AbiQ7dw5a7M=;
	h=From:To:Cc:Subject:Date:From;
	b=K1O06UseC055ZhGFRluqlbSzmMQBEQAPMxFY+PmTyF+Z7A4YA2qoLiX/e0dfHt9/i
	 0HQW2ODRjikdjWd6pfHgiMUY2WDhSeTJ2/QEmK48t9GrsG2y20/amNjTW6C5tF87C4
	 InSfk2oJ/+ys+PrPaccHMYqONAVw9r9wD/9HGnx7ZZgP3S1y/hXaOxQFXaFmtP40hB
	 elAx9C2zW/OOCMmVLji3DmRXnXth8AjEcuLuwiKiqnG5q0pFOG1Yu0VytE/xDSIgTE
	 smRtTye7falKPwEAQoPsXY2MNsuChXIC56YWbi5Vkx2CrF96V/tezQF1DXhKzsf3Xx
	 Ms18IJ+uQQMcA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org
Subject: [PATCH] slimbus: generate MODULE_ALIAS() from MODULE_DEVICE_TABLE()
Date: Thu,  6 Jun 2024 22:36:14 +0900
Message-ID: <20240606133615.986035-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VS64TAOHE6XJPF3PQGB5UUTAWEI2TJO6
X-Message-ID-Hash: VS64TAOHE6XJPF3PQGB5UUTAWEI2TJO6
X-MailFrom: masahiroy@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VS64TAOHE6XJPF3PQGB5UUTAWEI2TJO6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Commit 9e663f4811c6 ("slimbus: core: add support to uevent") added the
MODALIAS=slim:* uevent variable, but modpost does not generate the
corresponding MODULE_ALIAS().

To support automatic module loading, slimbus drivers still need to
manually add MODULE_ALIAS("slim:<manf_id>:<prod_code>:*"), as seen in
sound/soc/codecs/wcd9335.c.

To automate this, make modpost generate the proper MODULE_ALIAS() from
MODULE_DEVICE_TABLE(slim, ).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/devicetable-offsets.c |  4 ++++
 scripts/mod/file2alias.c          | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 518200813d4e..9c7b404defbd 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -153,6 +153,10 @@ int main(void)
 	DEVID_FIELD(i3c_device_id, part_id);
 	DEVID_FIELD(i3c_device_id, extra_info);
 
+	DEVID(slim_device_id);
+	DEVID_FIELD(slim_device_id, manf_id);
+	DEVID_FIELD(slim_device_id, prod_code);
+
 	DEVID(spi_device_id);
 	DEVID_FIELD(spi_device_id, name);
 
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 5d1c61fa5a55..99dce93a4188 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -960,6 +960,16 @@ static int do_i3c_entry(const char *filename, void *symval,
 	return 1;
 }
 
+static int do_slim_entry(const char *filename, void *symval, char *alias)
+{
+	DEF_FIELD(symval, slim_device_id, manf_id);
+	DEF_FIELD(symval, slim_device_id, prod_code);
+
+	sprintf(alias, "slim:%x:%x:*", manf_id, prod_code);
+
+	return 1;
+}
+
 /* Looks like: spi:S */
 static int do_spi_entry(const char *filename, void *symval,
 			char *alias)
@@ -1555,6 +1565,7 @@ static const struct devtable devtable[] = {
 	{"rpmsg", SIZE_rpmsg_device_id, do_rpmsg_entry},
 	{"i2c", SIZE_i2c_device_id, do_i2c_entry},
 	{"i3c", SIZE_i3c_device_id, do_i3c_entry},
+	{"slim", SIZE_slim_device_id, do_slim_entry},
 	{"spi", SIZE_spi_device_id, do_spi_entry},
 	{"dmi", SIZE_dmi_system_id, do_dmi_entry},
 	{"platform", SIZE_platform_device_id, do_platform_entry},
-- 
2.43.0

