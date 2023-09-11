Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5193CA0ECF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Sep 2023 10:04:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04D3DA4D;
	Tue, 12 Sep 2023 12:03:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04D3DA4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694513082;
	bh=k3aG2oQywuos/6ywQGuRdO49vLYN7Pk+k83oMuNx66c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Ir6BPoS6jsOBwQ/wyKee1n7mpIxIZbMeilKc2rmONnZLk9Lmt2OvhADkud7/AWkwy
	 IdCLHPxY/48D5Kw6lWVY9oGdxg67gLTZtWG5Q/fS/rIr6wKb2sKpIMd4Y1X1nUKo09
	 hUTNl0gG94Q3IoDrc89zg5tf1cYC4hE/b81zNBAs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA43EF80580; Tue, 12 Sep 2023 12:02:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 41C6BF80589;
	Tue, 12 Sep 2023 12:02:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 652CDF80425; Mon, 11 Sep 2023 23:35:03 +0200 (CEST)
Received: from abi149hd126.arn1.oracleemaildelivery.com
 (abi149hd126.arn1.oracleemaildelivery.com [129.149.84.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 13BA5F801F5
	for <alsa-devel@alsa-project.org>; Mon, 11 Sep 2023 23:34:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13BA5F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=augustwikerfors.se header.i=@augustwikerfors.se
 header.a=rsa-sha256 header.s=oci-arn1-20220924 header.b=Ui1++Qnd;
	dkim=pass (2048-bit key,
 unprotected) header.d=arn1.rp.oracleemaildelivery.com
 header.i=@arn1.rp.oracleemaildelivery.com header.a=rsa-sha256
 header.s=prod-arn-20211201 header.b=JSopP8Ez
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=H8VUP4moo1XVYiRBDWgPNjnI1wJ8sH7VT2dNJjvItbc=;
 b=Ui1++Qndmy2QHhaV+7pzDFIxdz19lDQ0nF7u5P6pgSLjeCeOtMSqM5zkmDVx+nGlDeF+npYf/EDo
   xgYGFzn6QLN9Uq1Wq4tq3lTs2kEq+Mx+/FQbYVQf2dfTNp+YIHzEkRVetZYzd2C45mJShkP64aHZ
   m+nXLmrw32PM87K7zAMGTevje5ToT3Le5K0IsROXVJ3cIRaWduucnjS1HFVbdwONUO8KQ+/SgKBF
   3GMI3jq+fQMmcqusgZ8+9M36tASH19foDu9O9FaM/EKh0BJ6GyB7cYp7/+Lf0Ump+yCMNd3+Km4l
   QpKknvb60SIngLeqJNN+sitEX6ljptF9VjSOOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=H8VUP4moo1XVYiRBDWgPNjnI1wJ8sH7VT2dNJjvItbc=;
 b=JSopP8Ez2n2cBaDICKbnGcBItDOAOI+phWUeuAV0HdXGhhtiUckXkRMBX8+Tp742pFsMlPFs0a6X
   KCRYseziCIFozk1feU7wnNam+wtVNkp0uohT8J/HTzx0vHn3jmh+yVqLITNyCiKrzbhnwaAw0SYl
   Q8+LbOEp6XhNtvmgr1ZUyeXC/wH0WCGjK0wCO/yW7TNz5TRfPkFRE0dUuV9ivVFsA1gVCy0w1h7Q
   Izvye0882rP14tePg/LIFYNTnLKTpW1F7PQWZ9mmknwvUPMJLf6p82ZjLjYL7nQsE1b6TgS7uN8/
   9nOrVLuLO9hCvnWz/+9bOJ7Gf36foUXrqEFWgA==
Received: by omta-ad1-fd3-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230808 64bit (built Aug  8
 2023))
 with ESMTPS id
 <0S0U005F4BY4I430@omta-ad1-fd3-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for alsa-devel@alsa-project.org; Mon, 11 Sep 2023 21:34:52 +0000 (GMT)
From: August Wikerfors <git@augustwikerfors.se>
To: Liam Girdwood <lgirdwood@gmail.com>,	Mark Brown <broonie@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,	regressions@lists.linux.dev,
	August Wikerfors <git@augustwikerfors.se>
Subject: [PATCH] ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG
Date: Mon, 11 Sep 2023 23:34:09 +0200
Message-id: <20230911213409.6106-1-git@augustwikerfors.se>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta: 
 AAFMhxbHdTEVooZy00RNFw7yNWnRQQsRpdo9xMUMs12GakU/CcQg5lXkTxfeIA1j
 UFC2bx3C9ai1vUeHgw7DlDUTwUvNnakXPNuP/9PBnItFjHy74MvfuXwtSMbCJB6A
 1tq49LjnovOvuJaaKoOLpHmaUwihYygrZ0NskHMCvG+Ya2LrCQV4Z91bxlpABATm
 0aCkdMB/ay/tt5qdUfURlxKAkE7+VtonAn4T1zFO1b6QF9qjQ6QeuIKVsSh27Bh7
 m7ixkOhf+O0s0cSm52XWlURppqJ0oZhVFAdreofJtft7i2DpEmu+tEWB50HDKD8O
 9FP65fTGZKXDHukdaVZ8C2aiVB51bGU8cCIWtyrvXiTTvZIp3pVjPm294qEdv5Eq
 UXeyJjuA8d1inICTPE/Y9+RcbL1iee1IHdBSWHxaoz/icagQhPXllMxEkWJmTRpp B0l52TU=
X-MailFrom: 
 bounces+alsa-devel=alsa-project.org@arn1.rp.oracleemaildelivery.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: CUNX2BIHZGGCZEZ3XNUQFSV5OXPWLQR7
X-Message-ID-Hash: CUNX2BIHZGGCZEZ3XNUQFSV5OXPWLQR7
X-Mailman-Approved-At: Tue, 12 Sep 2023 10:02:26 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CUNX2BIHZGGCZEZ3XNUQFSV5OXPWLQR7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Like the Lenovo 82TL and 82V2, the Lenovo 82QF (Yoga 7 14ARB7) and 82UG
(Legion S7 16ARHA7) both need a quirk entry for the internal microphone to
function. Commit c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on
Lenovo 82SJ") restricted the quirk that previously matched "82" to "82V2",
breaking microphone functionality on these devices. Fix this by adding
specific quirks for these models, as was done for the Lenovo 82TL.

Fixes: c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on Lenovo 82SJ")
Closes: https://github.com/tomsom/yoga-linux/issues/51
Link: https://bugzilla.kernel.org/show_bug.cgi?id=208555#c780
Cc: stable@vger.kernel.org
Signed-off-by: August Wikerfors <git@augustwikerfors.se>
---
 sound/soc/amd/yc/acp6x-mach.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 59aa2e9d3a79..94e9eb8e73f2 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -213,6 +213,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
@@ -220,6 +227,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82TL"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82UG"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.42.0

