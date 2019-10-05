Return-Path: <SRS0=ok5v=X6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78533C3E8AB
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Oct 2019 09:00:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0184E20873
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Oct 2019 09:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CB9Co7p8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cJpLy7YH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0184E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F062169B;
	Sat,  5 Oct 2019 10:59:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F062169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570266042;
	bh=v0Bdj7/isEnSQYPIhkBS+NGX6VBf1u8wq4N637ca6Kw=;
	h=Date:In-Reply-To:References:From:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CB9Co7p8WCFjtKHjr8tfw5g+KH97ZJOugtLLrQRGyHpq6zNBlXy53n6cPbD4r7MP3
	 0jZYf75oaYeI7HSX78ZSeZ1Kcm7ADqtXb1DwfnR7ujkjWdv+1s/42rn/GXUmL8kmDD
	 2Q1h978K7yLc/asjtUwwTcQoj1xnzfzUi9nTa8vQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0B20F8064C;
	Sat,  5 Oct 2019 10:56:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82346F80659; Sat,  5 Oct 2019 10:55:59 +0200 (CEST)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B882F8063D
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2019 10:55:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B882F8063D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="cJpLy7YH"
Received: by mail-pg1-x54a.google.com with SMTP id z7so5980077pgk.11
 for <alsa-devel@alsa-project.org>; Sat, 05 Oct 2019 01:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=kmoQ5EfiuLPugExVdasoEEQ+xSgNc8VlrAlw91YpZWU=;
 b=cJpLy7YHnMDaIZiQzeucIuhSVgVwX/T/uIRDaMaSWPVblQ1e6ymh7GXJqCSmCo4GXT
 Jc4Zmu6OfUG4aPCpr9xLNxy2Pg7kez9HhFw8cfrclIghRTESqS1mpvNj3dUYHfUXsT5A
 FULp7yHNmqg+oQw3WzNeS+HE5cZIT4WPaZZ0opOgmdiLNNd1hvFoVNmUaw/zSuc4dbDk
 BdzwAmte2M0xqJHk/PLUy9QFN8/zwxad23V4tOmwXFHOMEZN0kU9WkcdO+Pt2hyF8zgF
 1jvdGrqX3/r0jRSgdQYggIbZf4ZTaHWpAXTxyVZOuqWfWuRCvqMdkBgJBUu/oLmJkBov
 gRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=kmoQ5EfiuLPugExVdasoEEQ+xSgNc8VlrAlw91YpZWU=;
 b=byV6u4Sq7kyYqVzyh2rbI9wqbyO7IFHxSyJKi3xhtKyJKu+T7/YLmKWcAOU3r0y1ev
 D4dc5SUoequLATUNHgRJBRlOBfXriLiq7qjnaDrLT4FbvRvj+IGbMzPkT6RTCt3QBFdc
 S36x0oR9zsDU3HlvOah6TQ2SLhMik1xN5c4lTdR7DID/grcDo9Ykr1Zjxrx+iAHF4GpS
 QuCljzS+FYMGK1avH1ErA95w7p3wJxpg9eU+4AUAgrvwiM2WKJSprkC3RzNDQSvS6uCd
 ljbUO/0GI8EsnP0N079l9Vx98b1wclnGpobzztJFSrNh3Kfh0A6OpHH00zwemR8Vpyl3
 Joow==
X-Gm-Message-State: APjAAAWC1E1k7Sfv1PKQzz6Gomf/sXx3JPiWH6N5xbNxkFu1k9sVNtxb
 m1BK5Dm388rsFvuoB2v/sd11qDG8vCdr
X-Google-Smtp-Source: APXvYqwynwoYoFkQk/iqR6Um03rnnEYqoeUKYCC03KFr+9G5mr1Gtv+8iqBgDOJh+ZT7W5oEvjXdNeqyTLf/
X-Received: by 2002:a63:1515:: with SMTP id v21mr1565875pgl.270.1570265755484; 
 Sat, 05 Oct 2019 01:55:55 -0700 (PDT)
Date: Sat,  5 Oct 2019 16:55:05 +0800
In-Reply-To: <20191005085509.187179-1-tzungbi@google.com>
Message-Id: <20191005164320.06.I0df85fe54162426e31f60a589d9b461c65df2faa@changeid>
Mime-Version: 1.0
References: <20191005085509.187179-1-tzungbi@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Cc: gwendal@google.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 cychiang@google.com, drinkcat@google.com, tzungbi@google.com,
 robh+dt@kernel.org, enric.balletbo@collabora.com, bleung@google.com,
 dgreid@google.com
Subject: [alsa-devel] [PATCH v2 06/10] ASoC: dt-bindings: cros_ec_codec: add
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

- Add "ec-shm" for binding to shared memory exposed by EC.
- Add "memory-region" for binding to memory region shared by AP.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../bindings/sound/google,cros-ec-codec.txt   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
index 0ce9fafc78e2..cb46bc082b4b 100644
--- a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
@@ -10,8 +10,26 @@ Required properties:
 - compatible: Must contain "google,cros-ec-codec"
 - #sound-dai-cells: Should be 1. The cell specifies number of DAIs.
 
+Optional properties:
+- ec-shm: Shared memory region from EC.  It contains 3 unsigned 32-bit
+          integer.  The first 2 integers combine to become an unsigned
+	  64-bit address.  The last one integer is length of the shared
+	  memory.
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
+		ec-shm = <0x0 0x10500000 0x80000>;
+		memory-region = <&reserved_mem>;
 	};
 };
-- 
2.23.0.581.g78d2f28ef7-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
