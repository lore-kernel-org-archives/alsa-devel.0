Return-Path: <SRS0=S9OM=ZG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DFDC432C3
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 06:35:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2415D20709
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 06:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jy4dy/PC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UBTcQivG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2415D20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50AC51614;
	Thu, 14 Nov 2019 07:34:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50AC51614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573713341;
	bh=70NfjILFqxCsMXMWmJDR6wOp9PuJJhZVzqw8rJU+PbM=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jy4dy/PCEnzvIuz2Xp9M/eCdUSq/yAxyHrjLbo8JFzaCjCjRxj1Y5MgY1p/jOigqX
	 apUfKyC+gYUgQQT6xPmo0UwlCSP1+CaBYx4UHXkIPyWfbZrIYWU3j6Mv1r+3ls3318
	 kY8S4g+HN+sGf4dwbULIStHeGQFkAFKCIcTahQXc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2BBBF80084;
	Thu, 14 Nov 2019 07:34:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0055AF800CF; Thu, 14 Nov 2019 04:37:36 +0100 (CET)
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 176F1F8007E
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2019 04:37:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 176F1F8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="UBTcQivG"
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dcccbfd0000>; Wed, 13 Nov 2019 19:37:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 13 Nov 2019 19:37:30 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 13 Nov 2019 19:37:30 -0800
Received: from nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com (172.20.187.13)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Thu, 14 Nov 2019 03:37:28 +0000
From: Nikhil Mahale <nmahale@nvidia.com>
To: <tiwai@suse.com>
Date: Thu, 14 Nov 2019 09:06:59 +0530
Message-ID: <20191114033704.18171-1-nmahale@nvidia.com>
X-Mailer: git-send-email 2.16.4
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573702653; bh=iGTjDiypKLxHZCkI3dd7rWt8CK3JOMvqHtUEoDBj/hI=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 X-NVConfidentiality:MIME-Version:X-Originating-IP:
 X-ClientProxiedBy:Content-Type;
 b=UBTcQivGJZIoaV8Lcsmwk7C5DRxj3xFMvHoi6QxsNdPy92E9yuDBHSyqt2KH/cRD4
 Xh1V1J7NzDOwkCgOGj5rFlKV1exqBASMhFRhYXZkzqmVRaj3vvu6Ve9MAAD6fbWp7U
 muEH8EfACJpGxuz6aR0ig/w1DU1DLCmh74x5K3k9eWRUK8m62y/jD5sUypRVP+u67D
 t806zO97mEBl3AhUe7B3L2DuAw/bMCURIG21o18JvwdT1yInjD0rdM4KohPQ6uVJ8t
 eIEG4Db+OiQ9snLAUSTT2fw17u9G58jJgscpw0fdueDlLu7kWF4WwtJD5pxGy5vmWd
 YjMQQa4Mly7ug==
X-Mailman-Approved-At: Thu, 14 Nov 2019 07:34:48 +0100
Cc: alsa-devel@alsa-project.org, nmahale@nvidia.com, aplattner@nvidia.com
Subject: [alsa-devel] [PATCH v1 0/5] ALSA: hda - Add DP-MST support for
	NVIDIA codecs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Today, DisplayPort multi-stream transport (DP-MST) audio is not
supported on codec drivers which don't use the audio component
(acomp) binding.

The commit ade49db337a9 (ALSA: hda/hdmi - Allow audio component for
AMD/ATI and Nvidia HDMI) added the DRM audio component binding for
the NVIDIA codec drivers, but the traditional HD-audio unsolicited
event code path is still in use by the proprietary NVIDIA graphics
driver.

This patch set adds DP-MST audio support for non-acomp codec drivers
which use the traditional HD-audio unsolicited event code path. This
patch set adds DP-MST support for NVIDIA codecs.

The patch set has been tested for HDMI/DP-SST/DP-MST(4 dp-mst audio
streams) configurations on NVIDIA Kepler and Maxwell GPUs, using
both the nouveau driver and the proprietary NVIDIA graphics driver.

Nikhil Mahale (5):
  ALSA: hda - Rename snd_hda_pin_sense to snd_hda_jack_pin_sense
  ALSA: hda - Add DP-MST jack support
  ALSA: hda - Add DP-MST conn list support
  ALSA: hda - Add DP-MST support for non-acomp codecs
  ALSA: hda - Add DP-MST support for NVIDIA codecs

 sound/pci/hda/hda_codec.c      |   5 +-
 sound/pci/hda/hda_generic.c    |  16 +--
 sound/pci/hda/hda_jack.c       | 111 ++++++++++++------
 sound/pci/hda/hda_jack.h       |  26 +++--
 sound/pci/hda/patch_ca0132.c   |  24 ++--
 sound/pci/hda/patch_cirrus.c   |   4 +-
 sound/pci/hda/patch_conexant.c |   2 +-
 sound/pci/hda/patch_hdmi.c     | 255 +++++++++++++++++++++++++++++------------
 sound/pci/hda/patch_realtek.c  |  46 ++++----
 sound/pci/hda/patch_sigmatel.c |  12 +-
 10 files changed, 333 insertions(+), 168 deletions(-)

-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
