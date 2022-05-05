Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60928C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  5 May 2022 05:31:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B179D16F3;
	Thu,  5 May 2022 07:31:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B179D16F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651728716;
	bh=8kMHklN4KFLGvY9O3L5assGUk2B2vhyKiKS6l9EU7kA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=G+RtIO0AFSZHAHzCjJtT6KyK9kyHCPmPZ953ZguzzquAfgj9Az08uuPUY+tTxQo4S
	 b8ZmdyavznjdJpoq2uz3nV7K+lpdrpJ/qwCXqBwvYIRsm9QH9nr4YMoU2VEhdus9Oy
	 Xd20R75Q6YKdchUg2ymGfd0VsnypVFyRi5AiTSB8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39E36F8016B;
	Thu,  5 May 2022 07:31:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57C98F8049C; Thu,  5 May 2022 07:31:04 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BAB72F800F0
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2022 07:30:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BAB72F800F0
X-UUID: 4ae4368406e540c48d433c6a1b1bb64e-20220505
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:2d09d3ce-53f4-4c3c-ac13-69aad7ea2789, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
 CTION:release,TS:75
X-CID-INFO: VERSION:1.1.4, REQID:2d09d3ce-53f4-4c3c-ac13-69aad7ea2789, OB:0,
 LOB:
 0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
 CTION:quarantine,TS:75
X-CID-META: VersionHash:faefae9, CLOUDID:ab25a2b2-56b5-4c9e-8d83-0070b288eb6a,
 C
 OID:fe998435e740,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
 ,QS:0,BEC:nil
X-UUID: 4ae4368406e540c48d433c6a1b1bb64e-20220505
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <tinghan.shen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 134474226; Thu, 05 May 2022 13:30:51 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Thu, 5 May 2022 13:30:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 5 May 2022 13:30:49 +0800
From: Tinghan Shen <tinghan.shen@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Javier Martinez Canillas
 <javierm@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, Sudeep Holla
 <sudeep.holla@arm.com>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Borislav Petkov <bp@suse.de>, Michal Suchanek <msuchanek@suse.de>, "Cristian
 Marussi" <cristian.marussi@arm.com>, Etienne Carriere
 <etienne.carriere@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Simon Trimmer <simont@opensource.cirrus.com>, John Stultz
 <john.stultz@linaro.org>, TingHan Shen <tinghan.shen@mediatek.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>, YC Hung <yc.hung@mediatek.com>, 
 Tzung-Bi Shih <tzungbi@google.com>, Curtis Malainey
 <cujomalainey@chromium.org>, Mark Brown <broonie@kernel.org>
Subject: [RESEND PATCH v7 0/1] firmware: mtk: add adsp ipc protocol for SOF
Date: Thu, 5 May 2022 13:30:47 +0800
Message-ID: <20220505053048.13804-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: Project_Global_Chrome_Upstream_Group@mediatek.com,
 alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

This patch provides mediatek adsp ipc support for SOF.
ADSP IPC protocol offers (send/recv) interfaces using
mediatek-mailbox APIs.

This patch was tested and confirmed to work with SOF fw on 
MT8195 cherry board.

changes since v6:
- rebase to matthias.bgg/linux.git, v5.18-next/soc
- Prefer "GPL" over "GPL v2" for MODULE_LICENSE

changes since v5:
- fix WARNING: modpost: missing MODULE_LICENSE() in drivers/mailbox
  /mtk-adsp-mailbox.o. Add MODULE_LICENSE in the last line.
- Due to WARNING: Missing or malformed SPDX-License-Identifier tag
  in line 1 in checkpatch, we don't remove SPDX-License in line 1.

changes since v4:
- add error message for wrong mbox chan

changes since v3:
- rebase on v5.16-rc8
- update reviewers

changes since v2:
- add out tag for two memory free phases

changes since v1:
- add comments for mtk_adsp_ipc_send and mtk_adsp_ipc_recv
- remove useless MODULE_LICENSE
- change label name to out_free


TingHan Shen (1):
  firmware: mediatek: add adsp ipc protocol interface

 drivers/firmware/Kconfig                      |   1 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/mediatek/Kconfig             |   9 +
 drivers/firmware/mediatek/Makefile            |   2 +
 drivers/firmware/mediatek/mtk-adsp-ipc.c      | 161 ++++++++++++++++++
 .../linux/firmware/mediatek/mtk-adsp-ipc.h    |  65 +++++++
 6 files changed, 239 insertions(+)
 create mode 100644 drivers/firmware/mediatek/Kconfig
 create mode 100644 drivers/firmware/mediatek/Makefile
 create mode 100644 drivers/firmware/mediatek/mtk-adsp-ipc.c
 create mode 100644 include/linux/firmware/mediatek/mtk-adsp-ipc.h

-- 
2.18.0

