Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12D5C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Nov 2021 12:31:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AF5518B0;
	Thu, 25 Nov 2021 13:30:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AF5518B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637843509;
	bh=AaplSJcaA2YBxCRpksAOyjPYoi31FZ3J8Qsh3gmg/YM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JA7cMwkhl5Btfl1zUHt8HOvb7Hpi5EzgyCHqma8D3baC7qgp7Cl7bjOFXzenXXhaA
	 Shvxsh5EEqJRxOQ1dAIvN6lQkpPCpvwAllZh0EryBezzvFb3VulZeQQdle/GLrBhzf
	 7LwHc8pbJ+pwztFKvER6hQGgCLuXEBXSILDO9AQA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2B51F804AB;
	Thu, 25 Nov 2021 13:30:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37F97F804AC; Thu, 25 Nov 2021 13:30:07 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB265F8007E;
 Thu, 25 Nov 2021 13:29:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB265F8007E
X-UUID: 129784d5bfb44144b4f2eec4b7cff5e6-20211125
X-UUID: 129784d5bfb44144b4f2eec4b7cff5e6-20211125
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <allen-kh.cheng@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1394779487; Thu, 25 Nov 2021 20:29:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Thu, 25 Nov 2021 20:29:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 25 Nov 2021 20:29:42 +0800
From: allen-kh.cheng <allen-kh.cheng@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v4 0/3] This patches provide ADSP IPC support for MT8195
Date: Thu, 25 Nov 2021 20:29:22 +0800
Message-ID: <20211125122925.1303-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK: N
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, cujomalainey@google.com,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com, Mark
 Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 Daniel Baluta <daniel.baluta@nxp.com>, linux-arm-kernel@lists.infradead.org,
 sound-open-firmware@alsa-project.org
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

Mediatek ADSP IPC is used to send notification or short message between
processors with dsp.·

It will place the message to the share buffer and will access the ADSP mailbox
registers to kick dsp.

Two mailboxes used to send notification or short message between processors with
dsp

changes since v3:
- reorder MTK_ADSP_IPC_MBOX config
- remove some redundant code
- remove lock in mtk-adsp-mailbox

changes since v2:
- seperate adsp_mailbox into two instances

changes since v1:
- fix dt_binding_check error

Allen-KH Cheng (3):
  dt-bindings: mediatek: add adsp-mbox document
  firmware: mediatek: add adsp ipc protocol interface
  mailbox: mediatek: add support for adsp mailbox controller

 .../bindings/mailbox/mtk,adsp-mbox.yaml       |  52 +++++
 drivers/firmware/Kconfig                      |   1 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/mediatek/Kconfig             |   9 +
 drivers/firmware/mediatek/Makefile            |   2 +
 drivers/firmware/mediatek/mtk-adsp-ipc.c      | 132 +++++++++++++
 drivers/mailbox/Kconfig                       |   7 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/mtk-adsp-mailbox.c            | 184 ++++++++++++++++++
 .../linux/firmware/mediatek/mtk-adsp-ipc.h    |  70 +++++++
 10 files changed, 460 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
 create mode 100644 drivers/firmware/mediatek/Kconfig
 create mode 100644 drivers/firmware/mediatek/Makefile
 create mode 100644 drivers/firmware/mediatek/mtk-adsp-ipc.c
 create mode 100644 drivers/mailbox/mtk-adsp-mailbox.c
 create mode 100644 include/linux/firmware/mediatek/mtk-adsp-ipc.h

-- 
2.18.0

