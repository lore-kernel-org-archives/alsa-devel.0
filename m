Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0373C41535
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Dec 2023 04:37:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9780285D;
	Tue, 19 Dec 2023 05:37:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9780285D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702960633;
	bh=2mLoTryDSZ7UnWz4is4SFOD16BuDu3RRP2P3KdqM5dw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=S9n0iRItgBeONNvE1TGFtKtlJIwnxk1p2FUyAoV3XK/scoA5sPssfE4ehSFbQM7EU
	 pSXCLGzKWWILZ1SJscEQqEV5q31FD1t9sqRyFHLa2slaE8Q7d2sqauLWQA8u/aW2tK
	 Zte339X7NqM9SvHGzlsZSjmP8UjqFQXOQUbxO0AQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BFEE1F80579; Tue, 19 Dec 2023 05:36:36 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E80FF8056F;
	Tue, 19 Dec 2023 05:36:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2721DF80425; Tue, 19 Dec 2023 05:36:29 +0100 (CET)
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr
 [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F0639F80124
	for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2023 05:36:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0639F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256
 header.s=t20230301 header.b=qvKgtpWO
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id FRq7rIyAdCta3FRq7rLpYg; Tue, 19 Dec 2023 05:36:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702960580;
	bh=kg/q7rumzOx8Hl24GKVNgl/RrROwUKqK72wc4kbD3sE=;
	h=From:To:Cc:Subject:Date;
	b=qvKgtpWOoj4dZ6kz4iXiJrNQqE7l3qQNPalzgKRK2QqVljEog23aA11MgO7OVjQ4D
	 lV5bX8/tbcJ/oDgVc6LS+kvq0WvMWudFPLUREHVM+0pnJN/2m3TyAEwWD2mOExtGgF
	 ZeviyBnp6Z3OXgfwMrJH77HwMlVG//CwBUHbOAIPJKPYFZXArSWbqd/WHkQzlnEaJR
	 JBtoBYIUO49hcNIaz+uCnD5dn10f4do3kKO/bmmD1fNmopn9rtycfW7Hl+gazmAggz
	 3WZW4OcUBMJURMzxqbPBGM66x+YPhUrmo8hup1dejIGSdFbMQeDHdUGtpuPf3n3nXu
	 jXMgpqka5E5BQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Dec 2023 05:36:20 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH] slimbus: qcom-ngd-ctrl: Make QMI message rules const
Date: Tue, 19 Dec 2023 05:36:17 +0100
Message-Id: 
 <7d0660a356a148bb800dcb0e211eca4886785a6c.1702960557.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZGSP4EJKDXJM4DTF7M3XVIC2L2H2JHQH
X-Message-ID-Hash: ZGSP4EJKDXJM4DTF7M3XVIC2L2H2JHQH
X-MailFrom: christophe.jaillet@wanadoo.fr
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZGSP4EJKDXJM4DTF7M3XVIC2L2H2JHQH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Commit ff6d365898d4 ("soc: qcom: qmi: use const for struct qmi_elem_info")
allows QMI message encoding/decoding rules to be const, so do that here.

Before:
======
$ size drivers/slimbus/qcom-ngd-ctrl.o
   text	   data	    bss	    dec	    hex	filename
  30354	   1993	     96	  32443	   7ebb	drivers/slimbus/qcom-ngd-ctrl.o

After:
=====
$ size drivers/slimbus/qcom-ngd-ctrl.o
   text	   data	    bss	    dec	    hex	filename
  30738	   1593	     96	  32427	   7eab	drivers/slimbus/qcom-ngd-ctrl.o

Compile tested only.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 77aa6d26476c..efeba8275a66 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -220,7 +220,7 @@ struct slimbus_power_resp_msg_v01 {
 	struct qmi_response_type_v01 resp;
 };
 
-static struct qmi_elem_info slimbus_select_inst_req_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_select_inst_req_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_UNSIGNED_4_BYTE,
 		.elem_len   = 1,
@@ -262,7 +262,7 @@ static struct qmi_elem_info slimbus_select_inst_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info slimbus_select_inst_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_select_inst_resp_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_STRUCT,
 		.elem_len   = 1,
@@ -284,7 +284,7 @@ static struct qmi_elem_info slimbus_select_inst_resp_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info slimbus_power_req_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_power_req_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_UNSIGNED_4_BYTE,
 		.elem_len   = 1,
@@ -324,7 +324,7 @@ static struct qmi_elem_info slimbus_power_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info slimbus_power_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_power_resp_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_STRUCT,
 		.elem_len   = 1,
-- 
2.34.1

