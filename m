Return-Path: <SRS0=5dB9=7Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5C2C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:27:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC392065C
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tUzVRaBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC392065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F994167F;
	Thu, 11 Jun 2020 16:27:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F994167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591885675;
	bh=G89wVttd5+0SNyPEk524aEUBQf1Ycsbg8KgZe2hwP9Y=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tUzVRaBJ6BVzE/1LkuDd5lkvMaEqQPv55gGRSYGTvQNSVHmaoYEMma/Xwhff+onY9
	 4rwrgCBMpkGpX0fTkcaUhITSrsjyY1ARUxuAGS2sEWXFhdmXM+FqYmv95qPwoUxnUx
	 dPzG3s1vl0xwRaOhpkensKr75gTRYzSIq4ek9Big=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F1F7F800CC;
	Thu, 11 Jun 2020 16:27:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4EBD7F8028C; Thu, 11 Jun 2020 16:27:03 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1409BF800CC
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2020 16:26:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1409BF800CC
IronPort-SDR: 2cuP4xQeFDiNp8MAjCQy/oHfhBIG5VzDyXLWFFu6EolO4umb+x1YDQ5Uj+B0yy98dori9Rno3L
 YyPYKLVZarMA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2020 07:26:54 -0700
IronPort-SDR: 7qFKjaG5KXJ6TLnuhh60ybUUGQZ9/dDE0yt/TKPG4fatYhRyg/wZB0anc2ZH9uM+hfIG9+zMmC
 AztVg6o4xXcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; d="scan'208";a="314827486"
Received: from ttvo1-mobl.amr.corp.intel.com ([10.251.138.170])
 by FMSMGA003.fm.intel.com with ESMTP; 11 Jun 2020 07:26:54 -0700
Message-ID: <b7e0b822a9deea506acaa40e0e31cc9f488bb446.camel@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: hda: unsolicited RIRB response
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Date: Thu, 11 Jun 2020 07:26:54 -0700
In-Reply-To: <1591883073-17190-1-git-send-email-brent.lu@intel.com>
References: <1591883073-17190-1-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 sound-open-firmware@alsa-project.orgDRIVERS, "commit_signer:6/16=38%,
 authored:6/16=38%, added_lines:123/248=50%, removed_lines:36/84=43%,
 Kai    Vehmanen DRIVERS \)" <kai.vehmanen@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Keyon Jie <yang.jie@linux.intel.com>, "authored:2/16=12%,
 added_lines:21/248=8%, removed_lines:5/84=6%, \),
 Liam    Girdwood DRIVERS \)" <lgirdwood@gmail.com>,
 Pierre-Louis Bossart DRIVERS <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, 15/16=94@,
 "Daniel Baluta  DRIVERS \)" <daniel.baluta@nxp.com>,
 Zhu Yingjiang <yingjiang.zhu@linux.intel.com>, linux-kernel@vger.kernel.org
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

On Thu, 2020-06-11 at 21:44 +0800, Brent Lu wrote:
> The loop implementation could not solve the unsolicited response
> issue because the RIRBSTS is cleared after leaving the
> snd_hdac_bus_update_rirb() function. So the next loop will fail the
> status test against the RIRB_INT_MASK and skip all the RIRB handling
> stuff. On the other hand, there alwasy could be unsolicited responses
> in the last loop regardless the number of loops.
> 
> Clear the RIRB interrupt before handling it so unsolicited response
> could trigger another RIRB interrupt to handle it later.
Hi Brent,

Thanks for the patch. Is this fix for a specific issue you're seeing?
If so, could you please give us some details about it?

Thanks,
Ranjani

