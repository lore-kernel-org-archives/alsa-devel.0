Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28462C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Dec 2021 13:11:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2EFD16FF;
	Fri, 24 Dec 2021 14:10:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2EFD16FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640351506;
	bh=G2fwsT9NyMtiC86IFcru5bhyB1XzknP0IUgrODzYyrw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SfLl/HMs3H4jG/Fo2R8mQJ0OOpaX7as0L/55/K1ScWzy8bnhLQjLCVxYE0JlA+a68
	 YoTVSGjNHhTKaMs4Q+cT3cv1w/nUaWi+mV39Rc9w2poWiADitPed71gr7E+nAqNrcc
	 2aE919ggK1yix7lFGbxNWkGcX4IiOf28vX5gj8Zk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 757FAF800FD;
	Fri, 24 Dec 2021 14:10:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7F4BF800FF; Fri, 24 Dec 2021 14:10:53 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64395F80084
 for <alsa-devel@alsa-project.org>; Fri, 24 Dec 2021 14:10:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64395F80084
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Oq6AbaAF"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 41EF1B82277;
 Fri, 24 Dec 2021 13:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB494C36AE8;
 Fri, 24 Dec 2021 13:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640351445;
 bh=G2fwsT9NyMtiC86IFcru5bhyB1XzknP0IUgrODzYyrw=;
 h=From:To:Cc:Subject:Date:From;
 b=Oq6AbaAFUyaYwb+5pANVia5grxZ1GtLLmQ/4YYJDsEcTY5zaYqQ95ylZQHP4UALfU
 Wf06HHf5rigxIhmoX/87uBcCt4txHjfZRdHWdk1QFQS0m5OtxXNMM3zLqjRwfLrslm
 aOgtR2mXftOg9mOa1VfPhYahsGdWer1bK0SiWEB5VQ6uyz78qt0RsWtAzSDbda+i8I
 vfC3RQdKJ2esFVkpXspHq1nQ0fZkKy+keh8003jYCC4fBi7E0BruTN8Vu4J9ZFXH3i
 2rdtFwQ7TewzaFGAq1jeLAHU3XFc8QtIPSPe8gvWzUxMkM2QiG0szy9jYcGCeyZW0I
 H1a2+fdRDD7nQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
 (envelope-from <mchehab@kernel.org>)
 id 1n0kLK-000UqE-Hd; Fri, 24 Dec 2021 14:10:42 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/1] sound: add quirk for Huawei D15
Date: Fri, 24 Dec 2021 14:09:48 +0100
Message-Id: <cover.1640351150.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 tiwai@suse.de, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Huajun Li <huajun.li@intel.com>, broonie@kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

Hi Pierre-Louis,

Based on my tests, Huawei D15 (Intel) uses SSP0 on es8336.

Add a quirk for it.

Please notice that, currently, only the internal speaker is working.
The topology for the internal microphone and for the headphones
is wrong. Enabling/disabling the other two quirks (GPIO and/or DMIC) 
doesn't cause any audible results, nor change the devices listed
on pavucontrol (tested with pipewire-pulse).

Mauro Carvalho Chehab (1):
  ASoC: Intel: sof_es8336: add quirk for Huawei D15 2021

 sound/soc/intel/boards/sof_es8336.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.33.1


