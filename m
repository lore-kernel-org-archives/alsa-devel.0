Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68331C54E4A
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Mar 2024 17:53:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 85668828;
	Fri,  8 Mar 2024 18:52:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 85668828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709920380;
	bh=J64dE3WP+PZYmP2KxggN7FPTEDJqMClbq9ewdZ6bQpc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=SJmY/vFXH8lLBpf2Zb7JAdTa2jPpBelGsJVee9GYRMGUPCt031oKlTFZymYzrmeAI
	 iySiZPbrRaqgxfbn8lLd6NFtO5C6cUbAb3ilNbPXctWpbcuUa8cuiWxr0SAkH9a05G
	 nV9cveffui9pM/tP6y4i/ieaudF5s8kukfj8hpPE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ADD0DF80639; Fri,  8 Mar 2024 18:51:58 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DDF0F805F8;
	Fri,  8 Mar 2024 18:51:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80924F804B0; Fri,  8 Mar 2024 18:46:12 +0100 (CET)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id EB9DBF80087
	for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2024 18:42:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB9DBF80087
Received: from fedori.lan (51b693e7.dsl.pool.telekom.hu
 [::ffff:81.182.147.231])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000767FD.0000000065EB4DED.0020A5AB;
 Fri, 08 Mar 2024 18:42:05 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 0/5] ALSA: hda/tas2781: restore power state after
 system_resume
Date: Fri,  8 Mar 2024 18:41:39 +0100
Message-ID: <cover.1709918447.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Message-ID-Hash: FN5QKQZBRCW6FSM2UACNAOOCE4J6HGIQ
X-Message-ID-Hash: FN5QKQZBRCW6FSM2UACNAOOCE4J6HGIQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FN5QKQZBRCW6FSM2UACNAOOCE4J6HGIQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This series makes some simplifications, speeding up the start of the 
playback and restoring the power state of the amplifiers after 
system_resume.

Gergo Koteles (5):
  ALSA: hda/tas2781: use dev_dbg in system_resume
  ALSA: hda/tas2781: add lock to system_suspend
  ALSA: hda/tas2781: do not reset cur_* values in runtime_suspend
  ALSA: hda/tas2781: do not call pm_runtime_force_* in
    system_resume/suspend
  ALSA: hda/tas2781: restore power state after system_resume

 sound/pci/hda/tas2781_hda_i2c.c | 35 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 18 deletions(-)


base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
-- 
2.44.0

