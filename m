Return-Path: <SRS0=oqyN=5V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC8EC2BA1A
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Apr 2020 18:37:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A96B2051A
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Apr 2020 18:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CFKN7+Xx";
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSWI8xVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A96B2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6297A1686;
	Sun,  5 Apr 2020 20:36:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6297A1686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586111863;
	bh=XkyfmgHoZ3aOcN63uJCO6/itOb7I3P+gXNjXLYXHdkw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CFKN7+Xxd/KRAjMzhiTCoXESejiIeR6K69TLYeJbQOcOo+cPNgDHd231xz0BHtXD1
	 LF8qpltxLji62mTZwPTjk8wKHIMYSzUK6/thUJhtOvimbfAEDJzUeGhBC84icY2PUN
	 zul2bFwjNg4CZ3UW+L8lHmGFt1pqVnx8kZdxMRY4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F61EF80257;
	Sun,  5 Apr 2020 20:35:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8FEAF8015A; Sun,  5 Apr 2020 20:35:10 +0200 (CEST)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11841F801D8
 for <alsa-devel@alsa-project.org>; Sun,  5 Apr 2020 20:35:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11841F801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="hSWI8xVK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586111705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkyfmgHoZ3aOcN63uJCO6/itOb7I3P+gXNjXLYXHdkw=;
 b=hSWI8xVKVlcIG1h92RrE0KLfD+wupe95ES8Zjk/iTYCQIWtXew+E57k4AwkRQoJVsq0UIj
 +d8IcxAWCOUoUQPtAwAQcWRvqx2Fx4bRy9ZJKatAlvzj7YTqmAtRc0gPSo2sZoaYI3mDRd
 04urtHPFVSuODD4SbeGCDl2ARRbTlL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-vJzndI5qPHiHcqhHsx_knw-1; Sun, 05 Apr 2020 14:35:01 -0400
X-MC-Unique: vJzndI5qPHiHcqhHsx_knw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EBF5800D50;
 Sun,  5 Apr 2020 18:35:00 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 700209D349;
 Sun,  5 Apr 2020 18:34:59 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 3/5] chtrt5645: Add MEDION-E1239TMD60568-0.1-Wingman.conf
 symlink to chtrt5645-dmic2.conf
Date: Sun,  5 Apr 2020 20:34:52 +0200
Message-Id: <20200405183454.34515-3-hdegoede@redhat.com>
In-Reply-To: <20200405183454.34515-1-hdegoede@redhat.com>
References: <20200405183454.34515-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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

The Medion Akoya E1239T 2-in-1 uses a digital mic connected to the
dmic2 pin, rather then the default analog mic on in2.

Add a long name symlink to chtrt5645-dmic2.conf for this, so that
the right config is used.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/chtrt5645/MEDION-E1239TMD60568-0.1-Wingman.conf | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 ucm2/chtrt5645/MEDION-E1239TMD60568-0.1-Wingman.conf

diff --git a/ucm2/chtrt5645/MEDION-E1239TMD60568-0.1-Wingman.conf b/ucm2/ch=
trt5645/MEDION-E1239TMD60568-0.1-Wingman.conf
new file mode 120000
index 0000000..7823e31
--- /dev/null
+++ b/ucm2/chtrt5645/MEDION-E1239TMD60568-0.1-Wingman.conf
@@ -0,0 +1 @@
+chtrt5645-dmic2.conf
\ No newline at end of file
--=20
2.26.0

