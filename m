Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC011C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Apr 2022 08:45:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA9521750;
	Tue,  5 Apr 2022 10:44:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA9521750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649148313;
	bh=nXHwI0lbM1sZwxBKRPdZsJoQ9VExflU+okzXpIRAZpQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=r3wf/1tstzzpy0NdZpR0onkvAALUsoU3xr1DAc+3AoqRdNuX7yMYX1uT0OnLZe8Ml
	 0hU/UbX7oMdIMAl/fDuOR65J4j/sU/16va3oxxJSct2TPIC6mFDDRQK3FJnGA9Fs9E
	 1msDDzGzVuc6nUukXJjs6fVZtCkMFLTXNvia36rI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 460AFF8016A;
	Tue,  5 Apr 2022 10:44:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E6FEF8016B; Tue,  5 Apr 2022 10:44:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FB08F800D1
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2022 10:44:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FB08F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GnAGq086"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7A862614E5;
 Tue,  5 Apr 2022 08:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E67C385A5;
 Tue,  5 Apr 2022 08:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649148257;
 bh=nXHwI0lbM1sZwxBKRPdZsJoQ9VExflU+okzXpIRAZpQ=;
 h=From:To:Cc:Subject:Date:From;
 b=GnAGq0867/gnj3C+jk+gAeVtT7D2qggDRysgca1EWKYLBzHVCsuFYaknoCKr5dXE9
 9ibkXElDFItQuppVhPUyhZWD5pXecpH/oC9iBhyKNR9A6BeMJ8lRRTIUsSf5EV5EJt
 y8+mYshvmCsdx9Z43JEsZXfPd2dSerJP5jdiP/Jz7QrceE9YT1cqo7M65nSKCPyJ3T
 BLLar7OaBIlgrZH/XW7bYBdvKdVTAYhdmHY97rcqZLZVvNXuNqiMcXloi/O10zfkeU
 Zkc5RqD7w8DfoXy1tWlbFBpnZa4j3VOrSL2C5WHEcjsfTxb5GoJXN/kNYumpCiIyIt
 HYKtajren9n2Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
 (envelope-from <mchehab@kernel.org>)
 id 1nbenP-001IBk-Ak; Tue, 05 Apr 2022 10:44:15 +0200
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 0/2] Make headphone work on Huawei Matebook D15
Date: Tue,  5 Apr 2022 10:44:11 +0200
Message-Id: <cover.1649147890.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 linux-kernel@vger.kernel.org
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

At Huawei Matebook D15 two different GPIOs are used to control the output:
	- gpio0 controls the speaker output;
	- gpio1 controls the headphone output.

Changing both at the same time cause spurious events that are mis-interpreted
as input events, causing troubles on apps. So, a delay is needed before turning
on such gpios.

With this patch, plugging a headphone causes a jack event to trigger the speaker
supply, powering down the speaker and powering up the headphone output.
Removing the headphone also triggers the power supply, powering up the speaker
and powering down the headphone.

Mauro Carvalho Chehab (2):
  ASoC: Intel: sof_es8336: support a separate gpio to control headphone
  ASoC: Intel: sof_es8336: Huawei Matebook D15 uses a headphone gpio

 sound/soc/intel/boards/sof_es8336.c | 68 ++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 10 deletions(-)

-- 
2.35.1


