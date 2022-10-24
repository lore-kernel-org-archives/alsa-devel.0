Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6185FC38A2D
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Oct 2022 16:54:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D7C96F1A;
	Mon, 24 Oct 2022 18:53:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D7C96F1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666630460;
	bh=Ij6IV9VpB18z2Do0mKvsbrEsTnKplhyNPa8kMEHxCSE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qHKyO9MH1OoePB33wiPCCV+qoicuNlxYmW9my+Cs/uLsJSDb+DML1//h4btZ0hbr2
	 jAF7HrqTaKDv4EB0HQQlgnYhVyPAn75Id7nveVvBh3l53WImGd49Xu7Vm6W3K5P87r
	 YPoT2DwgjzNjkf9/bZ0CP1gFl2qhqE8wIUuPj2+Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C7C6F80542;
	Mon, 24 Oct 2022 18:53:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F207F80240; Mon, 24 Oct 2022 18:53:28 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4001EF80240
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2022 18:53:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4001EF80240
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ML09TqoZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666630406; x=1698166406;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Ij6IV9VpB18z2Do0mKvsbrEsTnKplhyNPa8kMEHxCSE=;
 b=ML09TqoZlVb53PNXSwBo88gnFNRhJIry/LzO4hUjaIFkL9xxZinvuzfW
 6QqVG9Rwoxqovmjs+oIc/CNnmkiM6nBj2Yno4/wsfT3FSvgjAEUrTEfO0
 YeeCsDfdtYmh8/UmkY40XCBDructpecz/FF55koIcffs/Xnf5nLBBNVNU
 Q9bPvHwLQZ2LZ4fNwNTbdcmVoO9+h2lNOmKNRcaJ9LcbcJNDDg2S95jh8
 MLDSFe8M07qsROb6yPknyfYqOn3B4TYutTIi4C/fx9I/c3BzbOm1Lgwmn
 unLDoXgZNTzVgKi54eATBiBhNHxZG1lo4BEYMFSYRrCpyRGksJoHm3Uwl A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="393787379"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; d="scan'208";a="393787379"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2022 09:53:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="609263038"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; d="scan'208";a="609263038"
Received: from tdsilva-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.213.186.236])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2022 09:53:21 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 00/16] ASoC: SOF: Intel: HDaudio cleanups
Date: Mon, 24 Oct 2022 11:52:54 -0500
Message-Id: <20221024165310.246183-1-pierre-louis.bossart@linux.intel.com>
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

This is the part1 of my HDaudio cleanups, before the addition of
to-be-announced HDaudio extensions.

The patchset includes more consistent use of read/write/update
helpers, removal of useless waits, structure members and programming
sequences, removal of confusing sharing of private_data between FE and
BE.

Additional patches are coming to split the controller, codec and
multi-link management functionality in well-identified files.

Pierre-Louis Bossart (16):
  ASoC: SOF: ops: fallback to mmio in helpers
  ASoC: SOF: Intel: use mmio fallback for all platforms
  ASoC: SOF: ops: add readb/writeb helpers
  ASoC: SOF: ops: add snd_sof_dsp_updateb() helper
  ASoC: SOF: Intel: hda-dsp: use SOF helpers for consistency
  ASoC: SOF: Intel: hda-dai: start removing the use of
    runtime->private_data in BE
  ASoC: SOF: Intel: hda-dai: use component_get_drvdata to find hdac_bus
  ASoC: SOF: Intel: hda-dai: remove useless members in hda_pipe_params
  ASoC: SOF: Intel: hda-ctrl: remove useless sleep
  ASoC: SOF: Intel: hda: always do a full reset
  ASoC: SOF: Intel: hda: remove useless check on GCTL
  ASoC: SOF: Intel: hda-stream: use SOF helpers for consistency
  ASoC: SOF: Intel: hda-stream: rename CL_SD_CTL registers as SD_CTL
  ASoC: SOF: Intel: hda: use SOF helper for consistency
  ASoC: SOF: Intel: hda-stream: use snd_sof_dsp_updateb() helper
  ASoC: SOF: Intel: hda-stream: use readb/writeb for stream registers

 sound/soc/sof/intel/bdw.c            |  6 +---
 sound/soc/sof/intel/byt.c            | 12 ++-----
 sound/soc/sof/intel/hda-common-ops.c |  6 +---
 sound/soc/sof/intel/hda-ctrl.c       | 41 ++++++++--------------
 sound/soc/sof/intel/hda-dai.c        | 31 +++++++----------
 sound/soc/sof/intel/hda-dsp.c        | 12 ++++---
 sound/soc/sof/intel/hda-loader-skl.c | 30 ++++++++--------
 sound/soc/sof/intel/hda-loader.c     |  4 +--
 sound/soc/sof/intel/hda-stream.c     | 47 ++++++++++++-------------
 sound/soc/sof/intel/hda.c            |  5 ++-
 sound/soc/sof/intel/hda.h            | 25 +++++++-------
 sound/soc/sof/intel/pci-tng.c        |  6 +---
 sound/soc/sof/ops.h                  | 51 ++++++++++++++++++++--------
 sound/soc/sof/sof-priv.h             |  4 +++
 14 files changed, 136 insertions(+), 144 deletions(-)

-- 
2.34.1

