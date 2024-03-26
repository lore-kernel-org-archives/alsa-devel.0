Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64331C54E67
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Mar 2024 16:20:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB5362C3B;
	Tue, 26 Mar 2024 17:20:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB5362C3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711470029;
	bh=S3l1dZyZnQC7nwH1O/0scw5bzhAI9A79lxA/h5x0VvI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=aHuW7gl8Tlf/u7pUBT6th1tfLOb2CCmCWyaKk+/XQmLm/8xijWCPA8vHVNB3AnToo
	 DkMxWkqGTIZMuBSxpgJegHpg7ZM01bQITHacOCFl2mDY1dpKNcGip/eXeUblMPcmDE
	 QWZIt36IipRTZDXrjZb+kgA9nOoiYlHdKSkqFfZI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06DA8F8060B; Tue, 26 Mar 2024 17:19:22 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AD381F80603;
	Tue, 26 Mar 2024 17:19:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 50C15F802DB; Tue, 26 Mar 2024 17:19:11 +0100 (CET)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id E34E2F8025F
	for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2024 17:18:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E34E2F8025F
Received: from fedori.lan (51b68717.dsl.pool.telekom.hu
 [::ffff:81.182.135.23])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000007732E.000000006602F56D.0023D3A1;
 Tue, 26 Mar 2024 17:18:53 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2 0/4] ALSA: hda/tas2781: fixes for 6.9-rc1
Date: Tue, 26 Mar 2024 17:18:44 +0100
Message-ID: <cover.1711469583.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Message-ID-Hash: CN66YOHB43JSGF4IATRE6SA4RYVEP743
X-Message-ID-Hash: CN66YOHB43JSGF4IATRE6SA4RYVEP743
X-MailFrom: soyer@irl.hu
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CN66YOHB43JSGF4IATRE6SA4RYVEP743/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

This series removes the no longer needed digital gain kcontrol, which 
caused problems in tas2563, because the register does not exists there.

This series also adds locking and debug statements to the other 
kcontrols. They sometimes ran in parallel with tasdev_fw_ready, and 
caused weird sound problems.
https://github.com/tomsom/yoga-linux/issues/58

Regards,
Gergo

Changes in v2:
 - Do not remove dvc_tlv scale from tas2781-tlv.h as it is also used by
   sound/soc/codecs/tas2781-i2c.c
 - Add kcontrol name to debug statements
 - Add a new patch to remove a useless debug statement.

[1]: https://lore.kernel.org/all/cover.1711401621.git.soyer@irl.hu/

Gergo Koteles (4):
  ALSA: hda/tas2781: remove digital gain kcontrol
  ALSA: hda/tas2781: add locks to kcontrols
  ALSA: hda/tas2781: add debug statements to kcontrols
  ALSA: hda/tas2781: remove useless dev_dbg from playback_hook

 sound/pci/hda/tas2781_hda_i2c.c | 118 +++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 41 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.44.0

