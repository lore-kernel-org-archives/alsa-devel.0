Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3050C7EE31
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Jun 2025 13:25:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB9EA6028F;
	Fri, 27 Jun 2025 15:24:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB9EA6028F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1751030702;
	bh=FXgCVQg29xOjyufmDx2h3U4xzkRyePHzuqYijSCrFKk=;
	h=Date:To:From:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=eRJrmZ5r9Zxoft2DfRIzD9veUtXnIV42j7cqW5v947OqXVinBnnKcXYsr7qkwhY23
	 QwK9JujKEURwSaqiVyMS6b0Ii4Zq16W155L2oxFzHw1tFgb04/tKmSHd/LOGYttEij
	 sXbtwwvGvjCrKWOof7bwi8upk7EFp9qTyYuxe4Mk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4E5F7F80699; Fri, 27 Jun 2025 15:23:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B13DF80697;
	Fri, 27 Jun 2025 15:23:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3895EF80424; Mon, 23 Jun 2025 00:58:10 +0200 (CEST)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch
 [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5B126F80087
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2025 00:58:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B126F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=FUTiJ206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1750633087; x=1750892287;
	bh=FXgCVQg29xOjyufmDx2h3U4xzkRyePHzuqYijSCrFKk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FUTiJ206dDlEqFwmj3QoCEUKArZFq0mtMfcDE0uQR1bQqBhxdd+oTMBDYiTjc6i2X
	 pe/afTntg55zoqjdoUAOvByxxpJUXajCLwBqRPteJimzli1QNahQqFzVBLTjCmXyGO
	 cD+8+5EYaj26+NKd1OJBPNwBrDhp0htfIXFsa4OAxrKlPi1LzQ5RVKOhwbDsf7O9b4
	 xPVOKi+BQNSRVWTUVH0GPbTwte/qFdtMTKMQZHIu27vGZKku+dYipdu6dyjs2rcPvW
	 TKArklvUCC6QwgfhO3NUroAKajJ6j4KEq0OHVG2tZsLh8qBlb5jOAJ1QBCbRzKZ4DS
	 mdd4i0Vwplsrg==
Date: Sun, 22 Jun 2025 22:58:00 +0000
To: broonie@kernel.org
From: Yuzuru10 <yuzuru_10@proton.me>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Yuzuru10 <yuzuru_10@proton.me>
Subject: [PATCH] ASoC: amd: yc: add quirk for Acer Nitro ANV15-41 internal mic
Message-ID: <20250622225754.20856-1-yuzuru_10@proton.me>
Feedback-ID: 69774799:user:proton
X-Pm-Message-ID: e9c87519a1144c14e2af0cfc88eb17c421809c90
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MailFrom: yuzuru_10@proton.me
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: GVAXNX6GJ3VNUGU76Z3SWAUJNBFNZNT4
X-Message-ID-Hash: GVAXNX6GJ3VNUGU76Z3SWAUJNBFNZNT4
X-Mailman-Approved-At: Fri, 27 Jun 2025 13:23:20 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GVAXNX6GJ3VNUGU76Z3SWAUJNBFNZNT4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch adds DMI-based quirk for the Acer Nitro ANV15-41,
allowing the internal microphone to be detected correctly on
machines with "RB" as board vendor.

Signed-off-by: Yuzuru <yuzuru_10@proton.me>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 98022e5fd428..499f9f7c76ee 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -353,6 +353,13 @@ static const struct dmi_system_id yc_acp_quirk_table[]=
 =3D {
 =09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
 =09=09}
 =09},
+=09{
+=09=09.driver_data =3D &acp6x_card,
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "RB"),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "Nitro ANV15-41"),
+=09=09}
+=09},
 =09{
 =09=09.driver_data =3D &acp6x_card,
 =09=09.matches =3D {
--=20
2.50.0


