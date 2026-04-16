Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAEAF99C81
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2026 19:57:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F20B601B8;
	Sat, 18 Apr 2026 21:57:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F20B601B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776542261;
	bh=ZooAt7p6jPntW1YbeP2aqO8rsXxoS/oUytCS7sk08aU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Cz5x4anzWqjgeAKI8E13dMV9n6DXdftO3uT87aMVXz8s5We0ZsaRiyEN7j8LTLstN
	 U3DIXPGkLSWleSznDQW7tZ6HOk/0Mhgz7O0fpMntzeukQGi+VL5l9i8J7lWklybD1p
	 dOSnUWnsJSGVHaG19Mo0BwCKu4omNY6X0/SRgxYQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC4F6F805F0; Sat, 18 Apr 2026 21:57:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CF3BF805F7;
	Sat, 18 Apr 2026 21:57:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 86445F8049C; Thu, 16 Apr 2026 21:12:00 +0200 (CEST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B3F76F80212
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2026 21:11:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3F76F80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rzYv07gO
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-953c5738c03so4888569241.2
        for <alsa-devel@alsa-project.org>;
 Thu, 16 Apr 2026 12:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776366716; x=1776971516;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei8DlWRj/5LvEuu82gy17xwjpCba51gok+pto1yd8aA=;
        b=rzYv07gOO81tzjPLfa0NQQ9YgHA0UycRcUogWXUrxwL/zAf7up2HEpIGgrqvB8rh7k
         8j4wpclWjDtpeMgnAW+DAVg0CDGLK4f+htS1qSrDt6HFAaWIyZ28VBVJP76qRL+AYzVc
         yKOoZEgTUnf07IxxohSW0rY2vlxIqQSR1UZ0JF+VJxlWHX1XDieLtdSNf3yAxAXTLS/C
         N0AboqE7VPvLfUlez4AsIS3ZwqKmSEWsTanIiauBe1CQgK25zx0xgpdELcBldhvf8TqW
         4klWorrEGCUSyPQOqdoGD0v5jnU0Cz7VjWTpOp/3vajZMmbmynkiWJgjWDieaO8coem0
         us/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776366716; x=1776971516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ei8DlWRj/5LvEuu82gy17xwjpCba51gok+pto1yd8aA=;
        b=D9l0sRVnuvZuKcQb9+JTiocL4RfAE3dTcuHFMH5rCvR1NakVIW5+q0+MZSgMEWHgCz
         KElxO47lHXbOORLmTM50Fm0JdHWWICe70rUt9dWNW/DkHu59ZPZJ7EkRNC2a2ihkkAwU
         EwQAjIxKf6lQa8IjlhYKspxmJnJR/x5VbqHw/Y2WWc803lAX6i2sEj0D8IGyU/j7Ksl9
         u24jrvgaJ1Nyd+FfUS4heP0bPBXBP5CL4moQ6oYi8KUqpWi/wE8idTxSLaiSPdat1acG
         SCO6+wgq9sy8F1RXVR12drQQrjcbLgRTnq8ZRXfWyto3X40qgwGW8umYtD7dXek+4a/E
         3ZVA==
X-Gm-Message-State: AOJu0YxeO+ihpXBXm6zUOKWwTG2PHj7ojZVZQSi6tZnOs5mLORGAKIO3
	vR1zhwOHk6mDGu4kQIVZkrtje93yEIMU/SI/P47dnppX+X4PnZnnzy0kJOXStXyO
X-Gm-Gg: AeBDiesIHc1UDhmNSe1ykTbocpe0/YtTdNVIktpCxeWXfet7HUt8OFtAyC4u8KqMQqK
	C/Yq1ZrCKlXo0yt+ZUB2q5g3MorE+B5Bv5QTW+LkR2146cocGu7SEpRR/WoIrHVAWTmeGaRHMjh
	hYtftjdc3frZCyz3+eEh7so7LEwdgDiPPLm0tDNIu3nhQ3AXLjhMEwVEow4+zAGZSTrNyZ9dYjr
	+DFVd+08FAnuIHbHcA6OBNhEIRksP4If9XtwfF1ImYQTQRU3w/Qn1Vd+xG6xFUI34Ud3CtyweOS
	pJnw5SmfKhhWbv+mCSG1r54NbGiavM2m3F3F6ZlgQ26+o1cWfkFCx1boqCfCREZq9bMi+7aDsSm
	Cds7UwPVhrf5WyaHd+f5kHcTVnpKAsM16LIo0GhyypFTy2ibgnLQks4wS+a8+Qm1kxiYz+l+13W
	tdyZ4GQEkm4cIru2g1LY4NllG89rnKrxoU45jfRbY=
X-Received: by 2002:a05:6102:4a89:b0:607:95f4:53b5 with SMTP id
 ada2fe7eead31-616cafd45d6mr305957137.4.1776366716109;
        Thu, 16 Apr 2026 12:11:56 -0700 (PDT)
Received: from MSI ([2803:c600:d219:caa8:ca92:d824:5198:4486])
        by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-616638ef7c1sm537219137.0.2026.04.16.12.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:11:55 -0700 (PDT)
From: Juan Pablo Fuentealba Bizama <jpfuentealbabizama@gmail.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	linux-sound@vger.kernel.org,
	Juan Pablo Fuentealba Bizama <jpfuentealbabizama@gmail.com>
Subject: [PATCH v3] ALSA: usb-audio: Add quirk for SmartlinkTechnology M01
Date: Thu, 16 Apr 2026 15:11:49 -0400
Message-ID: <20260416191149.12088-1-jpfuentealbabizama@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: jpfuentealbabizama@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 7VAN2VJPSZXAXDAXJCENMYJQY7YGKFYX
X-Message-ID-Hash: 7VAN2VJPSZXAXDAXJCENMYJQY7YGKFYX
X-Mailman-Approved-At: Sat, 18 Apr 2026 19:57:01 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7VAN2VJPSZXAXDAXJCENMYJQY7YGKFYX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add quirk entry for SmartlinkTechnology M01 USB microphone to enable the standard mixer interface.

Signed-off-by: Juan Pablo Fuentealba Bizama <jpfuentealbabizama@gmail.com>
---
 sound/usb/quirks-table.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 803e03d4d77b..283135d880db 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3772,6 +3772,18 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+{
+	/*
+	 * SmartlinkTechnology M01
+	 * USB audio device that needs standard mixer quirk
+	 */
+	USB_DEVICE(0x301a, 0x159b),
+	QUIRK_DRIVER_INFO {
+		.vendor_name = "SmartlinkTechnology",
+		.product_name = "M01",
+		QUIRK_DATA_STANDARD_MIXER(QUIRK_ANY_INTERFACE)
+	}
+},
 #define QUIRK_RME_DIGIFACE(pid) \
 { \
 	/* Only claim interface 0 */ \
-- 
2.53.0

