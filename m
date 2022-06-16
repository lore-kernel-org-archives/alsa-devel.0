Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F438C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jun 2022 22:30:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 860D01A24;
	Fri, 17 Jun 2022 00:29:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 860D01A24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655418622;
	bh=7UbYtxg7UlZuIW9ZfzC+gdYmHW308a8EmsIM6qjPT7s=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RYpDvQ7ZAeQAYhRYXxVBjmcuQpy3KC5+Zh4WzquXQnZ1kFElK65cFFPZ0r+9hGqJu
	 ErJWb9PBEuZ1HmRWKanXekRpqjZxu9a6nbyB/v0rEET/KNLYQNIMOUGbVa4n8vKYiQ
	 gROQiRImT6JhAjRgJbjOxenTWm+hTvqUxyrER9V0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1112FF80310;
	Fri, 17 Jun 2022 00:29:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42791F8012A; Fri, 17 Jun 2022 00:29:30 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC525F8012A
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2022 00:29:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC525F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="eNtFeWL1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655418566; x=1686954566;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7UbYtxg7UlZuIW9ZfzC+gdYmHW308a8EmsIM6qjPT7s=;
 b=eNtFeWL1Xp6lDmTq5DZNyEnZfQBdi6VcqczCq4kOae5xr2jYixNG2Q4W
 87KTj6QqLovYK8QpEtIVF+t73Ysy0aFYwjW3Jw1DpzZ8Qdi+My5eq7k1f
 tktIG7YH6wvNwbd6jaorW+l5DFbXbNdesI3oCJEC1vc0AgoVJpL7SCnxI
 hIuNKVXW2cdFxAvNugfVy4ETGxDeP7hYUbh+6Be/p5SJGDBtb1YxueGxw
 Gqslveupmi29r2dWXCGb1p9VR+Y5BQH8uGmbMqSqXzlEZwXZ3tfy/Hss9
 +dJ3DZnQzSsBNSD+v85us0mlXw90H6+kB7xmIhfywrQxmk1DfA8zgLne+ w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="365718818"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="365718818"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2022 15:29:19 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="653359636"
Received: from buckkenx-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.52.70])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2022 15:29:19 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ALSA: x86: intel_hdmi_audio: pm_runtime updates
Date: Thu, 16 Jun 2022 17:29:08 -0500
Message-Id: <20220616222910.136854-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Hans de Goede <hdegoede@redhat.com>, broonie@kernel.org,
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

While cleaning up the code to use pm_runtime_resume_and_get(), I
realized we never called pm_runtime_enable() for this driver. This is
potentially very invasive and error-prone, so feedback and test
results are welcome - all my BYT/CHT devices are not longer functional
unfortunately, and our CI MinnowBoard uses the 'other' HDMI solution
based on HDaudio.

In addition, the resume was assumed to be always successful, which
isn't a very good idea.

Pierre-Louis Bossart (2):
  ALSA: x86: intel_hdmi_audio: enable pm_runtime and set autosuspend
    delay
  ALSA: x86: intel_hdmi_audio: use pm_runtime_resume_and_get()

 sound/x86/intel_hdmi_audio.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.34.1

