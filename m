Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097A8C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Dec 2022 10:24:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33E4416BE;
	Wed, 21 Dec 2022 11:24:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33E4416BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671618293;
	bh=0HKF5kFFAWbKZ+YlKgDkRtlCYbPqq/TgtBsScZmB4pc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=WLlwXQBRANGQrc5x7zb+d4RxZJGwqbaGm/t5cNKr77MXc+2PGHg/UpKSCRkggLj+m
	 PHhEgY74Ikflg+hjH79tsseMDkG/kGTDses582ACHeLv0xu6XQ/k58zD6hVPh4YO9T
	 U91VfGfai9uV0OMz/mT3rfb1vZCh6kDXLFmYIh5k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D054CF8024D;
	Wed, 21 Dec 2022 11:24:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ACDCDF804B0; Wed, 21 Dec 2022 11:23:31 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B150FF80022
 for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2022 11:23:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B150FF80022
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=j60Opbjo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671618208; x=1703154208;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0HKF5kFFAWbKZ+YlKgDkRtlCYbPqq/TgtBsScZmB4pc=;
 b=j60OpbjoWTgJek/HoKCStuel8hP7EmR/ZQURuedIbFZuZ2Vjh5Gx+ctv
 OTFqnNVAYPJunnh7oXXJnepJ3i3eN4xyNs2JICdVqKpOQh5X0GrPUj6Bc
 7LWRIYBoIZcPWk7Gg/UTEzvxO3VboNAuBlw2iL+W5t4cvXu4D/o2cH3HG
 hAROyvgKFGrGzdT5Mfn9RHY0HCBWOk+HiouE/7kOMMSpqKx0OUMVF23a6
 dlEdzIiSkhBq1PEuBaRT0z/ENoVqrhe15evCXgqQAAi55rcHOqeYL7g3K
 b6ZmiDA2seotwFzTZqHcEusLy1Bypv38xtO4NfJ61Bb0e3XirhVdBe58P g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="406078606"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; d="scan'208";a="406078606"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2022 02:23:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="681984271"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; d="scan'208";a="681984271"
Received: from cofearra-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.20.202])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2022 02:23:20 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH 00/11] ASoC: SOF: Extend the IPC ops optionality
Date: Wed, 21 Dec 2022 12:23:17 +0200
Message-Id: <20221221102328.9635-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, rander.wang@intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

This series will extend the IPC ops optionality to cover it up to the existence
of the top level ipc pointer itself. There is no functionality change.

The reason for the extended optionality is that we have "DSPless"
debug/development support coming up (currently it is in SOF's topic/sof-dev
stable branch) initially supporting Intel's HDA platforms.

As the name suggests, in this mode the DSP is completely ignored by the linux
driver stack (no firmware loaded, only using HDA directly).

The DSPless mode is aimed to help us to verify our Linux stack on new platforms
where the firmware is not yet in the state that we can reliably use it, but the
hardware and programming flows can be tested already.
There is no plan to make DSPless a production target for SOF Linux stack.

While this is preparatory series aimed to unblock the DSPless support, it has
been integrated into sof-dev separately and we have lots of new features
depending on it (went in between this set and the DSPless support).

I still have some minor tasks to complete for the DSPless to make it a bit more
versatile, but I don't want to block other, stable features for upstreaming.

Regards,
Peter
---
Peter Ujfalusi (11):
  ASoC: SOF: sof-audio: Treat tplg_ops->route_setup() as optional
  ASoC: SOF: sof-audio: Update documentation for sof_ipc_tplg_ops
  ASoC: SOF: Add helper macro to be used to get an IPC ops
  ASoC: SOF: pcm: Extend the optionality of IPC ops to IPC as well
  ASoC: SOF: control: Extend the optionality of IPC ops to IPC as well
  ASoC: SOF: sof-audio: Extend the optionality of IPC ops to IPC as well
  ASoC: SOF: topology: Extend the optionality of IPC ops to IPC as well
  ASoC: SOF: pm: Extend the optionality of IPC ops to IPC as well
  ASoC: SOF: sof-priv: Mark fw_tracing ops optional in documentation
  ASoC: SOF: trace: Use sof_ipc_get_ops() in sof_fw_trace_init
  ASoC: SOF: trace: No need to check for op pointer in
    sof_fw_trace_free()

 sound/soc/sof/control.c   | 44 +++++++++----------
 sound/soc/sof/pcm.c       | 18 ++++----
 sound/soc/sof/pm.c        | 12 +++---
 sound/soc/sof/sof-audio.c | 57 +++++++++++++-----------
 sound/soc/sof/sof-audio.h |  6 ++-
 sound/soc/sof/sof-priv.h  |  6 ++-
 sound/soc/sof/topology.c  | 91 +++++++++++++++++++++++----------------
 sound/soc/sof/trace.c     |  8 ++--
 8 files changed, 138 insertions(+), 104 deletions(-)

-- 
2.39.0

