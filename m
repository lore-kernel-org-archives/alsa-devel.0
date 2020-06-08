Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4938BC433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 20:23:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42A520760
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 20:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="guBWTRFD";
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9yXtA5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42A520760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE5901666;
	Mon,  8 Jun 2020 22:22:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE5901666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591647825;
	bh=DpVojzMldugHOSzPy6RQtYJvOJ+Q38ny7fLzUpoKpEg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=guBWTRFDrGEsQGLlcroATNnd/R7OLCpmJvHGculQ85EQU21BtAMogdB4dZA2r6yxi
	 fjriQcexSpOmYoR9e1Ca0Hb4Rs+c/b8SCzrBs+s51UPRbT36VRJ1V9JmL862jGL7DJ
	 4txbHe32NheIxMRHI3aRZnVlNcGiDn3iWE19m2Ak=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09D30F80252;
	Mon,  8 Jun 2020 22:22:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE3D8F8024A; Mon,  8 Jun 2020 22:22:01 +0200 (CEST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7734AF801F7
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 22:21:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7734AF801F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="D9yXtA5X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591647716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GpPR6RsDOD4hrMM6xdsXvrAFDyX9FDj3mr9rK3LUyFQ=;
 b=D9yXtA5Xpxx76WZqV/qBqwG69cFjL/AqhnMdfoRbr8oiBLLqRDA3Hw5Uy/wRrIJx+m7MpD
 mIF0gGJx02ts61bjIdf/DrnGuKO+jQRW8y/f80aqs5iN8j0VSZzmb68F3T3YslGfS5ylzX
 3zP89tET5o6acKVxVpXLVGDxXxX+lhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-eMFr9ZIKNmOTFJ_kDy9FbQ-1; Mon, 08 Jun 2020 16:21:52 -0400
X-MC-Unique: eMFr9ZIKNmOTFJ_kDy9FbQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B510100CC92;
 Mon,  8 Jun 2020 20:21:49 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-122.ams2.redhat.com
 [10.36.114.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 571696116D;
 Mon,  8 Jun 2020 20:21:47 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 3/3] chtrt5645: Add ASUSTeKCOMPUTERINC.-T101HA-1.0.conf
 symlink to chtrt5645-dmic1.conf
Date: Mon,  8 Jun 2020 22:21:42 +0200
Message-Id: <20200608202142.92894-3-hdegoede@redhat.com>
In-Reply-To: <20200608202142.92894-1-hdegoede@redhat.com>
References: <20200608202142.92894-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The Asus T101HA uses a digital mic connected to the dmic1 pin, rather then
the default analog mic on in2 (just like the Asus T100HA).

Add a long name symlink to chtrt5645-dmic1.conf for this, so that
the right config is used.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/chtrt5645/ASUSTeKCOMPUTERINC.-T101HA-1.0.conf | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 ucm2/chtrt5645/ASUSTeKCOMPUTERINC.-T101HA-1.0.conf

diff --git a/ucm2/chtrt5645/ASUSTeKCOMPUTERINC.-T101HA-1.0.conf b/ucm2/chtrt5645/ASUSTeKCOMPUTERINC.-T101HA-1.0.conf
new file mode 120000
index 0000000..b4d2816
--- /dev/null
+++ b/ucm2/chtrt5645/ASUSTeKCOMPUTERINC.-T101HA-1.0.conf
@@ -0,0 +1 @@
+chtrt5645-dmic1.conf
\ No newline at end of file
-- 
2.26.2

