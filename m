Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAE9C43334
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jul 2022 20:06:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 367A51F1;
	Fri,  8 Jul 2022 22:05:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 367A51F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657310798;
	bh=0fQy1CH2WBdn+UGEY/eX7fA4biQ/XRfjqS89ee8/eHA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cyo1EH6Jx8B7ZjdyRDq7Qhx9LYS7036fdMgISCk4ZKDPwRqMgffwW+OEU8bDjX2z8
	 L/p8S79oxV7+wS42DI+kjFZ6ND39jOaiA4nomfOpiufPgNQ5dwyL+PzaJ9mQgT9Ybz
	 eefsHDdAJ+9B+aczPUeruRssiJF7kCag/TcsYZmk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB5D5F80537;
	Fri,  8 Jul 2022 22:05:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44FBEF80539; Fri,  8 Jul 2022 22:05:46 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16576F80537
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2022 22:05:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16576F80537
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ROzNFlsf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657310744; x=1688846744;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0fQy1CH2WBdn+UGEY/eX7fA4biQ/XRfjqS89ee8/eHA=;
 b=ROzNFlsfqaZo8A48FsIjDf1hvJ/xFiO7gUImzzY0NIts/KHD55FPLc7A
 A0lqqg64ZYpOhnltmoRrCgR8IKM5puR/vaTCwJsjvspp2l0Ofj8iLSZIW
 iefuTmOGzru3rlgAbv057OREIS2p69RQMPzSB2+t+8bUHzltYVkURkHX+
 lBQ7zNrEL595IBgmXJUOQ5/1rsxvXv1dGD7Zao/8Qpjl1W2zzRFgqOc9Y
 Pv4HeizTWDuTVLkLuxqCjJw+fFCKDwKKpmPVjyPLfuN92EgWDHIqDhZER
 XonOe8hd+m9Bug7/juQg0MAKbZkdCf9Yl8IrivGDnhB22fsvulQcyCQ5A w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="284378841"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; d="scan'208";a="284378841"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2022 13:05:32 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; d="scan'208";a="651691914"
Received: from gcisnero-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.87.49])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2022 13:05:30 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ASoC: SOF: ipc4-topology: fix error and memory handling
Date: Fri,  8 Jul 2022 15:05:14 -0500
Message-Id: <20220708200516.26853-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Two patches to improve error and memory handling. When IPC4 is used,
some of the flows were incorrect.

Libin Yang (2):
  ASoC: SOF: ipc4-topology: check dai->private in ipc_free()
  ASoC: SOF: ipc4-topology: free memories allocated in
    sof_ipc4_get_audio_fmt

 sound/soc/sof/ipc4-topology.c | 59 ++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

-- 
2.34.1

