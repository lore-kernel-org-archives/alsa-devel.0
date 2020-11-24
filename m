Return-Path: <SRS0=dVJd=E6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC4DC2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 18:03:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29CE208C3
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 18:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hsOlKngW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29CE208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68BCB1714;
	Tue, 24 Nov 2020 19:02:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68BCB1714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606241024;
	bh=St6IvTuGUzdnsXtNy7do1NOmlfFmbdRNhppvZZYV4s8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hsOlKngWlB0+IPmb5pyAvb5fW54jntVTvDafUbsa7XqIH+v7v+rhzBruYHILY0fDF
	 A/2FYALrVi831UCdmKyssvm7qGhhssyXPbPi6s1u2kX+V7DzyHxRFjBLFazhuxIezR
	 8BwUb0EWRutZ2QpCeiRy34gL0o9iNWTddS00Zn6k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2EC8F80161;
	Tue, 24 Nov 2020 19:02:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7553F80128; Tue, 24 Nov 2020 19:02:52 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D9ACF80128
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2020 19:02:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D9ACF80128
IronPort-SDR: vntnzFYN2y24qovtTjGdoE2UVw047ww9nUeWSGVx8TxrNWIVMUDKCyd97TXYjgrCG7PqNbxTXU
 8C0TE6P9Rs1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="151830561"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; d="scan'208";a="151830561"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2020 10:02:42 -0800
IronPort-SDR: TautWT/PYJDzgmELxWtud6wDoVcbzE9wKxtI4VYJvbxg/X7divauPNlm3BHLQ486RYk3aKQoAU
 xLmLHLGxGRwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; d="scan'208";a="478584989"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga004.jf.intel.com with ESMTP; 24 Nov 2020 10:02:40 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 0/4] ASoC: SOF: Add 'memory_info' file to debugfs
Date: Tue, 24 Nov 2020 20:00:13 +0200
Message-Id: <20201124180017.2232128-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: lgirdwood@gmail.com, daniel.baluta@nxp.com,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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

Series that adds a new debugfs entry to query status of SOF FW memory
allocation at runtime. Information on used and free memory is shown
separately for each zone. A new IPC message is added for this purpose
and ABI minor revision is bumped accordingly to 3.18.

To implement this, additional FW configuration data needs to be
parsed from the firmware file and this is done in the first patch.

A few cleanups to surrounding code is done in separate patches.

Karol Trzcinski (4):
  ASoC: SOF: ext_manifest: Parse firmware config dictionary
  ASoC: SOF: Improve code alignment in header.h
  ASoC: SOF: Change section comment for SOF_IPC_TEST_
  ASoC: SOF: Add `memory_info` file to debugfs

 include/sound/sof/debug.h        |  41 +++++++++++
 include/sound/sof/ext_manifest.h |  20 ++++++
 include/sound/sof/header.h       |  10 ++-
 include/uapi/sound/sof/abi.h     |   2 +-
 sound/soc/sof/debug.c            | 117 +++++++++++++++++++++++++++++++
 sound/soc/sof/ipc.c              |   9 +++
 sound/soc/sof/loader.c           |  51 ++++++++++++++
 sound/soc/sof/sof-priv.h         |   2 +
 8 files changed, 248 insertions(+), 4 deletions(-)
 create mode 100644 include/sound/sof/debug.h

-- 
2.28.0

