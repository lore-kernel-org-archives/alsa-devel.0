Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54D9C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 14:19:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1263E2146E
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 14:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bcWar3zp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=st.com header.i=@st.com header.b="kNlkEtLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1263E2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4CAE8852;
	Wed, 18 Dec 2019 15:18:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4CAE8852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576678762;
	bh=oCPp5MJFALt3LAElmq4GoQQO+cHmOvrsn+MfVceeQe0=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bcWar3zpEOqHDt6dQX5efA6r4vRitVESvrqT91WTkoYKyEQWLqCVxWx6e5FlB0bo1
	 eYxczvzcdb2LlKOzmK9sA9PamWh2B6clgox5ZtINqPYHLkNs9lGjo2XQpbfTEwte48
	 aakgVGdBR1cUis1UrFsdySoqm9lGPTypXt5y3T6U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 49700F80255;
	Wed, 18 Dec 2019 15:18:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6FEF0F80258; Wed, 18 Dec 2019 15:18:20 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 736CCF8014C
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 15:18:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 736CCF8014C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="kNlkEtLS"
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBIEIF4E006567; Wed, 18 Dec 2019 15:18:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=VkB1F9j4Bc2882ixkvjF3/YhIbvozsdCU4TfcGwrFI4=;
 b=kNlkEtLSNW+jito3GFcNjm/sDFWH6hj6tulB7EUTOT7R8nKigUr9I+aNUmO/JTcM2m61
 SXbi0X1pLqkdcpeasKFt2DgBAZhbLMgk/NDtyV+Y1ryqgiKamQ2MxAHceYSUNeQ8URRU
 7UX2HX914cxki2JimUHPgSMZOcy3ajS+CIk6IT0t7rjvGQ3q1kIZJXrPqiXaV3hNpSJb
 h2Kiwt1GrxydNRuU2WAzOd4aR6dFoGmyWqW+MBg22xzZZSjyT0OaJzrrPSa4uNeavmUG
 vXboDxvkn9yM2Hh1QCr2DzIWXdI8r3NSxX6+QC1SNLm6H2uVr0KWpD4MLVxDpfiXcuLy qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2wvp374uak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Dec 2019 15:18:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7F88D10003A;
 Wed, 18 Dec 2019 15:18:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 508D72BEAD4;
 Wed, 18 Dec 2019 15:18:10 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec 2019 15:18:09
 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
To: <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Wed, 18 Dec 2019 15:16:46 +0100
Message-ID: <20191218141646.23256-1-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_04:2019-12-17,2019-12-18 signatures=0
Cc: arnaud.pouliquen@st.com, Olivier Moysan <olivier.moysan@st.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [INTERNAL REVIEW] asoc: sti: fix possible
	sleep-in-atomic
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Change mutex and spinlock management to avoid sleep
in atomic issue.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif_player.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 48ea915b24ba..2ed92c990b97 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -226,7 +226,6 @@ static void uni_player_set_channel_status(struct uniperif *player,
 	 * sampling frequency. If no sample rate is already specified, then
 	 * set one.
 	 */
-	mutex_lock(&player->ctrl_lock);
 	if (runtime) {
 		switch (runtime->rate) {
 		case 22050:
@@ -303,7 +302,6 @@ static void uni_player_set_channel_status(struct uniperif *player,
 		player->stream_settings.iec958.status[3 + (n * 4)] << 24;
 		SET_UNIPERIF_CHANNEL_STA_REGN(player, n, status);
 	}
-	mutex_unlock(&player->ctrl_lock);
 
 	/* Update the channel status */
 	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
@@ -365,8 +363,10 @@ static int uni_player_prepare_iec958(struct uniperif *player,
 
 	SET_UNIPERIF_CTRL_ZERO_STUFF_HW(player);
 
+	mutex_lock(&player->ctrl_lock);
 	/* Update the channel status */
 	uni_player_set_channel_status(player, runtime);
+	mutex_unlock(&player->ctrl_lock);
 
 	/* Clear the user validity user bits */
 	SET_UNIPERIF_USER_VALIDITY_VALIDITY_LR(player, 0);
@@ -598,7 +598,6 @@ static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
 	iec958->status[1] = ucontrol->value.iec958.status[1];
 	iec958->status[2] = ucontrol->value.iec958.status[2];
 	iec958->status[3] = ucontrol->value.iec958.status[3];
-	mutex_unlock(&player->ctrl_lock);
 
 	spin_lock_irqsave(&player->irq_lock, flags);
 	if (player->substream && player->substream->runtime)
@@ -608,6 +607,8 @@ static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
 		uni_player_set_channel_status(player, NULL);
 
 	spin_unlock_irqrestore(&player->irq_lock, flags);
+	mutex_unlock(&player->ctrl_lock);
+
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
