Return-Path: <SRS0=/e/v=X5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D52C47404
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Oct 2019 14:36:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC2A215EA
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Oct 2019 14:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="a5UmIBn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC2A215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F1481672;
	Fri,  4 Oct 2019 16:35:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F1481672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570199793;
	bh=mpztWDG3a7TAKXWIYbr/ni07WlNiUpEm5PR6c0nYI40=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a5UmIBn+VXfDtWhotdFQUWD60rSBcq7tQNXGVbiGS8yXa7vKmg69LlcnDqVHz2TjY
	 z1zYq6mgRiSrdNlUYHcKXBnFTZVncwvaxJLB4JqQOZofPXn+dkUMjoG+l5idlaHbU6
	 1l4+wY2u/fQFDqlPyOgzbRhkDHVOCuT+T1mvHGdU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10DAEF800DE;
	Fri,  4 Oct 2019 16:35:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B266EF80391; Fri,  4 Oct 2019 16:35:41 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD085F800DE
 for <alsa-devel@alsa-project.org>; Fri,  4 Oct 2019 16:35:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD085F800DE
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Oct 2019 07:35:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; d="scan'208";a="222171135"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by fmsmga002.fm.intel.com with ESMTP; 04 Oct 2019 07:35:34 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org, tiwai@suse.de, kai.vehmanen@linux.intel.com
Date: Fri,  4 Oct 2019 17:35:26 +0300
Message-Id: <20191004143527.5575-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com
Subject: [alsa-devel] [PATCH 0/1] ALSA: hda: add fallback to polling to
	hdac_bus_get_response()
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hey all,

while debugging issues with some Intel platforms related to display
audio codec probe (see
https://lists.freedesktop.org/archives/intel-gfx/2019-October/214621.html ),
I found a discrepancy in behaviour between snd-hda-intel and SOF, despite
using the same snd-hda-codec-hdmi as the codec driver.

The specific problem I was debugging appears in a stress test
(designed to uncover the above display driver issue) where
driver-unload, s3-suspend, resume and driver-reload is done in a loop
and repeated for hundreds of iterations. When using SOF, I would get
occasional probe fail due to a missing HDA irq. The AZX snd_hda_intel
driver nicely survives this test. The explanation seems to be differences
in the hdac get_response() implementation.

While the specific issue could be solved with other means,
the git history shows a number of rare issues with HDA codecs
where polling has helped. It would seem best to align the logic
with the AZX driver implementation that has seen much more usage
over the years. This will benefit SOF and any other users of the HDAC
library.

Kai Vehmanen (1):
  ALSA: hda: add fallback to polling to hdac_bus_get_response()

 sound/hda/hdac_controller.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
