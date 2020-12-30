Return-Path: <SRS0=YQ6z=GC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5588C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Dec 2020 11:23:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373E0221F8
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Dec 2020 11:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373E0221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=me.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE1CE17CA;
	Wed, 30 Dec 2020 12:22:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE1CE17CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609327391;
	bh=6n+G5imY5NOpIGRR6k66vIskcgQ94nu/Ya5L2SXUFMY=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KAUQsoAd4cQdQbIe9uGf2lrb/lWaA89cGfo2zR0NNpUOR+Gq5BZltEioL3CBAUOq+
	 JD4SYQzW88ryakYRgt8n20ESm0TLvJX+JGYV1vMUQm2u5FeUrdIevlsEloWFHo4ZIh
	 KgsYAVMqL6mkMLSKzAGQYafKnDEG3qgzM549hmsg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EF45F801ED;
	Wed, 30 Dec 2020 12:22:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66BA7F801F5; Wed, 30 Dec 2020 12:22:20 +0100 (CET)
Received: from st43p00im-zteg10063501.me.com (st43p00im-zteg10063501.me.com
 [17.58.63.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 408AFF80141
 for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2020 12:22:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 408AFF80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="CzIz4Cd6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1609327332; bh=u8vNBKkJBeENQUWHNcyHxDvh/UkfG24ft3OMmx23qEc=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
 b=CzIz4Cd6SH1UJ4zvIiLNnHT930hV/hJtBL6VakiHYy+iACTYZVsTRHEy0vSrfPQcU
 tS5Qc4wFsAOEl5GRnqGrstvP4Yk53KKTNgZ/+37GnDKEV2V3hYDBR+p0SdyQaDmZHR
 XYtl8nx2qY1RjXioXab4JxN8ckx2sLnnDFkJuSi9NHSFUE9iIiLuufrcPWoaWZHEba
 f8Gigd0nBPUK5oNwuxI8hRsfU8fR4/bI66svxRHC7ZmmaVXPt7ggRBmb4Bk7FxEOD8
 9CPdylcm0A3SD/rW+ZNtBXk2eXWkxx2G9eOmEfUlZxuKhHSue3RM9wWGlrQgBx03X4
 GpAKQlfO8Kbpg==
Received: from HP-Pavilion-13 (static-168-222-226-77.ipcom.comunitel.net
 [77.226.222.168])
 by st43p00im-zteg10063501.me.com (Postfix) with ESMTPSA id B1FF9C80846
 for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2020 11:22:11 +0000 (UTC)
Date: Wed, 30 Dec 2020 12:22:07 +0100
From: Manuel =?iso-8859-1?Q?Jim=E9nez?= <mjbfm99@me.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/realtek: Add mute LED quirk for more HP laptops
Message-ID: <X+xi36k5pxo4NDcD@HP-Pavilion-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2020-12-30_06:2020-12-30,
 2020-12-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=613 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2012300070
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

HP Pavilion 13-bb0000 (SSID 103c:87c8) needs the same
quirk as other models with ALC287.

Signed-off-by: Manuel Jiménez <mjbfm99@me.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dde5ba209541..b77cef72c2d5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7964,6 +7964,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8760, "HP", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x877a, "HP", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x877d, "HP", ALC236_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f4, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
-- 
2.29.2

