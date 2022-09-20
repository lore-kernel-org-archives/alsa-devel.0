Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71194C54EE9
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Sep 2022 14:55:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A33D5852;
	Tue, 20 Sep 2022 16:54:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A33D5852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663685717;
	bh=O8KQr7wPUK3ZibBNcT9t4k/CtqODUMIs88VQ5mauWzs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AENPLuYdtsdQsiF7pd/SOwzsybV+Nv9DjUOvx7doGIQLkL21utJNLG5KYTBbqR46r
	 1yPzBn3hNQhAcVtd04SQaI/P7Jq6aBNvYBFjnKyOAAIvOcfX1GHc/7OyXbVm271Xqh
	 VlsqmFixNr1docuJDUsucQP3vIAgj7OJ520PJaCg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36694F80171;
	Tue, 20 Sep 2022 16:54:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ECE42F800F2; Tue, 20 Sep 2022 16:54:25 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ABF66F800F2
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 16:54:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ABF66F800F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Aqse+/TW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663685663; x=1695221663;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=O8KQr7wPUK3ZibBNcT9t4k/CtqODUMIs88VQ5mauWzs=;
 b=Aqse+/TW//mpkqNgX7EnhIVhF8Txf5K3Kkf/hvmPgQdVjxh5giCWmFrE
 k36IqujINmlTep5GTZtSQ4dEJjwDowAaSB2Y76aMz5Rj1o4wIz0q4jhAf
 b5OvG3xdujaORFNlRSacYpsrhRzkLSDCZPPK00yedvsN2wHTlUjyNJsFD
 v/oqbS+Px47iK2OHmQUq2YZIk2aREPzNw8m3+DCuSEX1EWLbU7Fi1CGkK
 QYDOKr2/wzVCpcZijITCqujFSOr+eGQKWfEkUcnZRRlONNuHEy1EeZrlE
 R3E4Qr0Ov5wKJksYF5vWtwLVfP0stNTzyuwqR8vz+AQGe/eiAu7gjS3lC w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="301095339"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; d="scan'208";a="301095339"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2022 07:54:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; d="scan'208";a="681341650"
Received: from atcamara-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.209.87])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2022 07:54:16 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ASoC: SOF: ipc4-topology: minor cleanup
Date: Tue, 20 Sep 2022 16:54:03 +0200
Message-Id: <20220920145405.2089147-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Two updates on warnings reported by cppcheck.

Pierre-Louis Bossart (2):
  ASoC: SOF: ipc4-topology: clarify calculation precedence
  ASoC: SOF: ipc4-topology: remove useless assignment

 sound/soc/sof/ipc4-topology.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.34.1

