Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB52DC4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 03:00:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688BC611C8
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 03:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 688BC611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E731E1674;
	Tue, 24 Aug 2021 04:59:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E731E1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629774043;
	bh=C2ngJIfw6+4H3MzOicEhJ8VLrQWeRG4I8tqJG7vSrEk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jO1cYwnJ8Z5VtpHs/kAjbX4kv+xZUS4Zc9C9TCXzR44d8ijRRQZgG6mpZTvFp+c9G
	 CpM40YQqxuQ6AeAFPinc2h1BkeZzf26ndqQXXX5Rgs+DEI8D3Xvd1muRH8HM+IZvww
	 Lg3rm212ALz0+D0rBlmxjFxO36NuT1oysFzC0LvI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 081A4F804FA;
	Tue, 24 Aug 2021 04:58:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 587F4F804FB; Tue, 24 Aug 2021 04:58:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60DD4F80430
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 04:58:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60DD4F80430
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cXrWrL5m"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59D2C61178;
 Tue, 24 Aug 2021 02:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629773897;
 bh=C2ngJIfw6+4H3MzOicEhJ8VLrQWeRG4I8tqJG7vSrEk=;
 h=From:To:Cc:Subject:Date:From;
 b=cXrWrL5mKh2yAQvYX7kjjsAWVwBjzEQP5lY6++e9Jo5lrpydWRXZXy08DBbhcFEKf
 WW0u7SEuXGMxAvTDn2KKyuw299+3mWQuSJdtUgQCZOo2mscjA4bkVqEok+j63XFOsu
 GeLlQOz2v9UCHwx6T3SYtSM73I3Fs32RLClhDiWnHKwSpCHj7UM3c9iiuR5QumT3TT
 vO6XLu4pW7li2zWQGF49O6LXDIhOIcIoB+lz4sMvEWlfwOMUvctyvyIXTP7siCdzLa
 WW09czJKzTW8ykW6F+ay27O2eqH+lxolUNdslrmyzpiafzIL7M6YYZMxaUS4atgXIj
 6GtT3ZET6Vi0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	srinivas.kandagatla@linaro.org
Subject: FAILED: Patch "slimbus: ngd: set correct device for pm" failed to
 apply to 4.19-stable tree
Date: Mon, 23 Aug 2021 22:58:15 -0400
Message-Id: <20210824025815.658976-1-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
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

The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c0e38eaa8d5102c138e4f16658ea762417d42a8f Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 9 Aug 2021 09:24:27 +0100
Subject: [PATCH] slimbus: ngd: set correct device for pm

For some reason we ended up using wrong device in some places for pm_runtime calls.
Fix this so that NGG driver can do runtime pm correctly.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20210809082428.11236-4-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index c054e83ab636..f3ee8e036372 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -618,7 +618,7 @@ static void qcom_slim_ngd_rx(struct qcom_slim_ngd_ctrl *ctrl, u8 *buf)
 		(mc == SLIM_USR_MC_GENERIC_ACK &&
 		 mt == SLIM_MSG_MT_SRC_REFERRED_USER)) {
 		slim_msg_response(&ctrl->ctrl, &buf[4], buf[3], len - 4);
-		pm_runtime_mark_last_busy(ctrl->dev);
+		pm_runtime_mark_last_busy(ctrl->ctrl.dev);
 	}
 }
 
@@ -1257,13 +1257,14 @@ static int qcom_slim_ngd_enable(struct qcom_slim_ngd_ctrl *ctrl, bool enable)
 		}
 		/* controller state should be in sync with framework state */
 		complete(&ctrl->qmi.qmi_comp);
-		if (!pm_runtime_enabled(ctrl->dev) ||
-				!pm_runtime_suspended(ctrl->dev))
-			qcom_slim_ngd_runtime_resume(ctrl->dev);
+		if (!pm_runtime_enabled(ctrl->ctrl.dev) ||
+			 !pm_runtime_suspended(ctrl->ctrl.dev))
+			qcom_slim_ngd_runtime_resume(ctrl->ctrl.dev);
 		else
-			pm_runtime_resume(ctrl->dev);
-		pm_runtime_mark_last_busy(ctrl->dev);
-		pm_runtime_put(ctrl->dev);
+			pm_runtime_resume(ctrl->ctrl.dev);
+
+		pm_runtime_mark_last_busy(ctrl->ctrl.dev);
+		pm_runtime_put(ctrl->ctrl.dev);
 
 		ret = slim_register_controller(&ctrl->ctrl);
 		if (ret) {
@@ -1389,7 +1390,7 @@ static int qcom_slim_ngd_ssr_pdr_notify(struct qcom_slim_ngd_ctrl *ctrl,
 		/* Make sure the last dma xfer is finished */
 		mutex_lock(&ctrl->tx_lock);
 		if (ctrl->state != QCOM_SLIM_NGD_CTRL_DOWN) {
-			pm_runtime_get_noresume(ctrl->dev);
+			pm_runtime_get_noresume(ctrl->ctrl.dev);
 			ctrl->state = QCOM_SLIM_NGD_CTRL_DOWN;
 			qcom_slim_ngd_down(ctrl);
 			qcom_slim_ngd_exit_dma(ctrl);
-- 
2.30.2




