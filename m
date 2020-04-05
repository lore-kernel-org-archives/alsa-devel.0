Return-Path: <SRS0=oqyN=5V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD722C2D0F4
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Apr 2020 13:38:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D14206C3
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Apr 2020 13:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k7pB0o4B";
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnwQk3KG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D14206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83ECE1660;
	Sun,  5 Apr 2020 15:37:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83ECE1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586093912;
	bh=Wnbd0yNcOX0K1gv+OAadmit2rPOXKreH56u0k/x+wM4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k7pB0o4B5A/iEfkuOI3H0RPhIW8YiCBjFb4bQjI330DgOX1rELAhrGuZLZjYWn26v
	 gdk7uEiuHmUWU95VaYSYEYT9Yj2zYCI+PzVTuz97gakry1SmdC8YG+oYYIIt4w4Kbi
	 LFzYlhHm8gG/yUMyRmhM/CaYo0enHvDAKTENhX3A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D74AF8015A;
	Sun,  5 Apr 2020 15:37:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B93CF801D8; Sun,  5 Apr 2020 15:37:40 +0200 (CEST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C92DF800E4
 for <alsa-devel@alsa-project.org>; Sun,  5 Apr 2020 15:37:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C92DF800E4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="VnwQk3KG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586093855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wnbd0yNcOX0K1gv+OAadmit2rPOXKreH56u0k/x+wM4=;
 b=VnwQk3KGxamZfhB0ky0XFXF5qAhyJGxN+PXeiCHwvN16uJiGQ6Sasl9EnTNAXI3GE//lMg
 yTpSdiuZ4ttef+xTLl/xxWKBODLowXxHvQjNcs2KfHsyFUCOFMSp7/III51Ykbbntb+VZU
 Mzgl5p7ddUvrsFerPit6qYiMf+vMpHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212--msFIa2jPKOW3G1sOD6Dag-1; Sun, 05 Apr 2020 09:37:32 -0400
X-MC-Unique: -msFIa2jPKOW3G1sOD6Dag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 373FA100550D;
 Sun,  5 Apr 2020 13:37:31 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7ABF10027AF;
 Sun,  5 Apr 2020 13:37:28 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 flove@realtek.com, shumingf@realtek.com,
 Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v3] ASoC: Intel: bytcr_rt5640: Add quirk for MPMAN MPWIN895CL
 tablet
Date: Sun,  5 Apr 2020 15:37:26 +0200
Message-Id: <20200405133726.24154-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

The MPMAN MPWIN895CL tablet almost fully works with out default settings.
The only problem is that it has only 1 speaker so any sounds only playing
on the right channel get lost.

Add a quirk for this model using the default settings + MONO_SPEAKER.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards=
/bytcr_rt5640.c
index 6bd9ae813be2..d14d5f7db168 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -591,6 +591,17 @@ static const struct dmi_system_id byt_rt5640_quirk_tab=
le[] =3D {
 =09=09=09=09=09BYT_RT5640_SSP0_AIF1 |
 =09=09=09=09=09BYT_RT5640_MCLK_EN),
 =09},
+=09{
+=09=09/* MPMAN MPWIN895CL */
+=09=09.matches =3D {
+=09=09=09DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MPMAN"),
+=09=09=09DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "MPWIN8900CL"),
+=09=09},
+=09=09.driver_data =3D (void *)(BYTCR_INPUT_DEFAULTS |
+=09=09=09=09=09BYT_RT5640_MONO_SPEAKER |
+=09=09=09=09=09BYT_RT5640_SSP0_AIF1 |
+=09=09=09=09=09BYT_RT5640_MCLK_EN),
+=09},
 =09{=09/* MSI S100 tablet */
 =09=09.matches =3D {
 =09=09=09DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Lt=
d."),
--=20
2.26.0

