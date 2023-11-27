Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85CAC4167B
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Nov 2023 13:46:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E75BA4B;
	Mon, 27 Nov 2023 14:45:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E75BA4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701092762;
	bh=nWNzdx1ZQxdZ03kfFEhJ5CyV5e697umCcQ1sKiUKoLY=;
	h=Subject:From:To:Cc:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=jmHnbK68eIHFV7ZPvksi2CKcMfWBtDG35jNxBntCwWA3sGFZgDgOiuuyMGymsmKDr
	 TE6sKpYZN7Tvs7tlDjFXAYMnmdiZhH2CaHEv16kiAGas8qQGTMC+OVxapxZhD4emQq
	 MrNVMwcCufcK/5VCyHavGVibLKb4vfctV4thUSXI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A8AFF8059F; Mon, 27 Nov 2023 14:45:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D5220F80563;
	Mon, 27 Nov 2023 14:45:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1BEBFF801D5; Mon, 27 Nov 2023 13:25:08 +0100 (CET)
Received: from smtp.livemail.co.uk (smtp-out-60.livemail.co.uk
 [213.171.216.60])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D3AFBF800F5
	for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2023 13:25:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3AFBF800F5
Received: from laptop.lan (host-78-146-56-151.as13285.net [78.146.56.151])
	(Authenticated sender: malcolm@5harts.com)
	by smtp.livemail.co.uk (Postfix) with ESMTPSA id EE7DBC5A53;
	Mon, 27 Nov 2023 12:24:59 +0000 (GMT)
Message-ID: <b9dd23931ee8709a63d884e4bd012723c9563f39.camel@5harts.com>
Subject: ASoC: amd: yc: Fix non-functional mic on ASUS E1504FA
From: Malcolm Hart <malcolm@5harts.com>
To: broonie@kernel.org
Cc: Sven Frotscher <sven.frotscher@gmail.com>, git@augustwikerfors.se,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org,  mario.limonciello@amd.com,
 regressions@lists.linux.dev, Sven Frotscher <sven.frotscher@gmail.com>,
 stable@vger.kernel.org
Date: Mon, 27 Nov 2023 12:24:59 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 (by Flathub.org) 
MIME-Version: 1.0
X-MailFrom: malcolm@5harts.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: YNNY6W3ZQWCKMN5YN2ELNHGEAOSYBLTF
X-Message-ID-Hash: YNNY6W3ZQWCKMN5YN2ELNHGEAOSYBLTF
X-Mailman-Approved-At: Mon, 27 Nov 2023 13:45:26 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YNNY6W3ZQWCKMN5YN2ELNHGEAOSYBLTF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Like other ASUS models the Asus Vivobook E1504FA requires an entry in
the quirk list to enable the internal microphone.

Showing
with 7 additions and 0 deletions.
7 changes: 7 additions & 0 deletions 7
sound/soc/amd/yc/acp6x-mach.c
@@ -283,6 +283,13 @@ static const struct dmi_system_id
yc_acp_quirk_table[] =3D {
			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
		}
	},
	{
		.driver_data =3D &acp6x_card,
		.matches =3D {
			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER
INC."),
			DMI_MATCH(DMI_PRODUCT_NAME, "E1504FA"),
		}
	},
	{



I have this laptop and I have tested this patch successfully.

Malcolm
