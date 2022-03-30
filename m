Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C35BC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Mar 2022 20:20:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB4A21930;
	Wed, 30 Mar 2022 22:19:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB4A21930
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648671637;
	bh=krOpzqZYP4KS2Z8cD/XZzKNcU0Sx2zMyTG0WsFb2OUQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=t2oQAOOygvW5N0LkyIW74McIyfwKgHylQq7w31Yq6MrmuzCIwCyrxXPd7NBiIa14m
	 zjCq1Z1bWZuASK9ZpMU+Ke9uSSqMvVdkbUbe0h/DoWx6XaL9JWIgmcrLnfJY1Gpafr
	 1TANHtGJuWhGamhP6NngtDo2Ijwu8uddJBh+ZHHk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 34BBCF80425;
	Wed, 30 Mar 2022 22:19:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9ECDF80506; Wed, 30 Mar 2022 22:19:44 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 538EBF800F2
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2022 22:19:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 538EBF800F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="L/84DZpb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648671581; x=1680207581;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=krOpzqZYP4KS2Z8cD/XZzKNcU0Sx2zMyTG0WsFb2OUQ=;
 b=L/84DZpbN/pu7Mp/X3Dk9eGx7l3nyr+uGOh+7EfaoFPJTa3h3ABEenl8
 KRF9HE1QrRheesl86sipaaehbtY2zYawckg77ZzMAcpHeSS+vPtlAk0x8
 QMUlh5G64sUPHp/iOmV28xE1W6bX3iqCSI4MGgnskc5ihrEF61f7E0144
 8rwkXSRAfhoORi4HAzvGEpcSR1izlMDb6QPY1GQWuzOIGSfSId/8Qo7sT
 pjh8XzzGPoFxzc6w3Pyg2LXXGkFsCiMMZRSZmhdhNXlYmO1mZ7WUFAI4R
 BgJE+YbG7PCbe3LapDya98dJipjBmZW3VtKeSlxWjZJwEDd7Z0+gE8wgq Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="322819822"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; d="scan'208";a="322819822"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2022 13:19:35 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; d="scan'208";a="522045015"
Received: from ggunnam-mobl.amr.corp.intel.com (HELO
 rsridh2-mobl1.localdomain) ([10.254.28.195])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2022 13:19:35 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 00/11] ASoC: SOF: Miscellaneous fixes for IPC and trace
Date: Wed, 30 Mar 2022 13:19:15 -0700
Message-Id: <20220330201926.1330402-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

This series includes some miscellaenous fixes pertaining to IPC, DMA
buffer and DMA trace.

Libin Yang (2):
  ASoC: SOF: extend the interface to stop DMA trace
  ASoC: SOF: disable dma trace in s0ix

Peter Ujfalusi (8):
  ASoC: SOF: Intel: hda-loader: Use local snd_dma_buffer
  ASoC: SOF: Remove dmab and dmab_bdl from snd_sof_dev struct
  ASoC: SOF: ipc: Add max_payload_size field in struct snd_sof_ipc
  ASoC: SOF: ipc: Use ipc->max_payload_size for message/reply size
    checking
  ASoC: SOF: Drop support for mapped control data
  ASoC: SOF: ipc: Use msg->reply_data directly in
    snd_sof_ipc_get_reply()
  ASoC: SOF: Drop 'header' parameter from tx_message() API
  ASoC: SOF: Remove header from struct snd_sof_ipc_msg

tangmeng (1):
  ASoC: SOF: Remove redundant return statements

 sound/soc/sof/compress.c         |  8 ++--
 sound/soc/sof/debug.c            |  2 +-
 sound/soc/sof/intel/hda-dsp.c    |  8 ++--
 sound/soc/sof/intel/hda-loader.c | 12 ++---
 sound/soc/sof/intel/tgl.c        |  6 +--
 sound/soc/sof/ipc.c              | 76 ++++++++++++--------------------
 sound/soc/sof/ipc3-pcm.c         |  8 ++--
 sound/soc/sof/ipc3-topology.c    | 25 +++++------
 sound/soc/sof/ipc3.c             |  4 +-
 sound/soc/sof/pcm.c              |  5 +--
 sound/soc/sof/pm.c               | 20 ++++++---
 sound/soc/sof/sof-audio.c        |  3 --
 sound/soc/sof/sof-audio.h        |  1 -
 sound/soc/sof/sof-client.c       |  2 +-
 sound/soc/sof/sof-priv.h         | 26 ++++++-----
 sound/soc/sof/trace.c            | 61 ++++++++++++++++---------
 16 files changed, 131 insertions(+), 136 deletions(-)

-- 
2.25.1

