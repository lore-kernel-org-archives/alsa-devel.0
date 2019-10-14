Return-Path: <SRS0=QzCZ=YH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF969C4CECE
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:26:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358E52064A
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fTP5dsvM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="N3zOlB/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358E52064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FDE7168B;
	Mon, 14 Oct 2019 12:25:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FDE7168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571048759;
	bh=CE8yEALoX9XV+pb22Bo+pCAhIKtwdlRca6PynkM5i6g=;
	h=Date:In-Reply-To:References:From:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fTP5dsvM0l3ycgnbI7gEP64iSQhHxWJwD2dGXh4uk1hwMbfQp+EAgapIaxIWdx67d
	 fO7rPdrf7wL9lkJuRRUJjJPIXaQLteWy/7LI8PIthy4pHJySP4mjHaWP81A4dEYhrt
	 mCZ+SOGXrpeArC1yBFzeeEkfGYQMfPAZMbPRFA/A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E57BF8064C;
	Mon, 14 Oct 2019 12:21:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2199CF8065A; Mon, 14 Oct 2019 12:21:12 +0200 (CEST)
Received: from mail-yw1-xc49.google.com (mail-yw1-xc49.google.com
 [IPv6:2607:f8b0:4864:20::c49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58CF9F8064C
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2019 12:21:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58CF9F8064C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="N3zOlB/4"
Received: by mail-yw1-xc49.google.com with SMTP id r64so13362845ywb.3
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2019 03:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=XgqYLp8QE4sKY6T/CHyXC6pEfRRtY39w1iQMg2ui9u8=;
 b=N3zOlB/4lch/asTMrEw8d0DdWtHMiByItCHgG594nS9uGJk9pHpSGFLAAgTOPQ0Wuu
 QC3BE2xnZTzOpFbK2bDNqOKLYxaz622c9Q2dda7XzcPzTOCSNdVTLHfTeGettDUdTJ+w
 Uin7vDYg6fUemhstw8yuaSr51r1mTueBstArhZMdIcjUpNVI0cmPE8OmtXZuET0CZS70
 JrGZs2qsEA2EzKA96zA6kb/jA0O8Od5tQUSkxx92ynkhwE3sPiGeipTN3mfHkVZqTRbe
 MRh/F+L5vy0R3QYPq8GzSg2ohnADcor8mS2xzrxlXs+sJuMxqhVXr3Vh65D58qfijuUS
 ioBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=XgqYLp8QE4sKY6T/CHyXC6pEfRRtY39w1iQMg2ui9u8=;
 b=I7cIB4+ubLw7kxZKSCT5qUBkZRclnUzhytPfjs5qN7lQmd0IV/5KRq8T6Ii7Ncc53a
 9mahiAIPoQl3Ri09r17sv405QlXkARKzQU/YmoVsFBaa/3Pnp0jbqgB9A93oWTKgNOIT
 xDPPEjwzEC/sLsCAd4six6jzPsQTTBulxX2KA8ZHQBUUrxML1NnVmYYiCuII8BXkTGO0
 3hhvgqhNGNQO3QntchI0Lg3UO0kFglStl2Jam1zg8ubcu5I6YAMJxUe7617uh510M87C
 yEfUrRvYbhMm480vd5quW6G/uILQ4M/FajIRcU3fBwRU/rH30Vzr4QEzxqirVJgHlEOi
 ZMlA==
X-Gm-Message-State: APjAAAUTQAonyfI7iyKsrIkuvtEB4qszAuanwVR7+k8FZErLhiVHYT6x
 kqesC9TEEdaOoeyWn4gWwJ3VFmvaE95y
X-Google-Smtp-Source: APXvYqwW5i75j27W0HgQo7RU9ozz6st1lqaUFAeJy25+lpciXO2LUkFk2QK1CfASkPeZuZWzuRlff+frMdcE
X-Received: by 2002:a0d:dd08:: with SMTP id g8mr12992732ywe.194.1571048468353; 
 Mon, 14 Oct 2019 03:21:08 -0700 (PDT)
Date: Mon, 14 Oct 2019 18:20:18 +0800
In-Reply-To: <20191014102022.236013-1-tzungbi@google.com>
Message-Id: <20191014180059.06.I0df85fe54162426e31f60a589d9b461c65df2faa@changeid>
Mime-Version: 1.0
References: <20191014102022.236013-1-tzungbi@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Cc: gwendal@google.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 cychiang@google.com, drinkcat@google.com, tzungbi@google.com,
 robh+dt@kernel.org, enric.balletbo@collabora.com, bleung@google.com,
 dgreid@google.com
Subject: [alsa-devel] [PATCH v3 06/10] ASoC: dt-bindings: cros_ec_codec: add
	SHM bindings
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

- Add "reg" for binding to shared memory exposed by EC.
- Add "memory-region" for binding to memory region shared by AP.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../bindings/sound/google,cros-ec-codec.txt   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
index 0ce9fafc78e2..8ca52dcc5572 100644
--- a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
@@ -10,8 +10,26 @@ Required properties:
 - compatible: Must contain "google,cros-ec-codec"
 - #sound-dai-cells: Should be 1. The cell specifies number of DAIs.
 
+Optional properties:
+- reg: Pysical base address and length of shared memory region from EC.
+       It contains 3 unsigned 32-bit integer.  The first 2 integers
+       combine to become an unsigned 64-bit physical address.  The last
+       one integer is length of the shared memory.
+- memory-region: Shared memory region to EC.  A "shared-dma-pool".  See
+                 ../reserved-memory/reserved-memory.txt for details.
+
 Example:
 
+{
+	...
+
+	reserved_mem: reserved_mem {
+		compatible = "shared-dma-pool";
+		reg = <0 0x52800000 0 0x100000>;
+		no-map;
+	};
+}
+
 cros-ec@0 {
 	compatible = "google,cros-ec-spi";
 
@@ -20,5 +38,7 @@ cros-ec@0 {
 	cros_ec_codec: ec-codec {
 		compatible = "google,cros-ec-codec";
 		#sound-dai-cells = <1>;
+		reg = <0x0 0x10500000 0x80000>;
+		memory-region = <&reserved_mem>;
 	};
 };
-- 
2.23.0.700.g56cf767bdb-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
