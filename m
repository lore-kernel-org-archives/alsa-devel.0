Return-Path: <SRS0=kfZ2=6Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05081C3A5A9
	for <alsa-devel@archiver.kernel.org>; Sat,  2 May 2020 11:57:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84618216FD
	for <alsa-devel@archiver.kernel.org>; Sat,  2 May 2020 11:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eD9f7fvK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKaTQpT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84618216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AABC41665;
	Sat,  2 May 2020 13:56:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AABC41665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588420647;
	bh=1yEsKoU0oUSVvOLYtVrEg1plY1Addk/1bazSbloP00c=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eD9f7fvKmOmyFO3nkZYsrsU/SaYaoBRizwwARbwGdS5cZR9p/m1QWAyxsfo1I6eb7
	 2eMOGIhRZ7jntqFb/MXKQMgTlEKHxPdPNMYZzlPxYNLBl/ZCTcLs2fD6utgnoUiu2n
	 EBFbvZOFShVHAqqaIvq9M5COAvhO3Hm57PvyCdns=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39265F800E5;
	Sat,  2 May 2020 13:56:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 830F8F801F7; Sat,  2 May 2020 13:56:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F806F800E5
 for <alsa-devel@alsa-project.org>; Sat,  2 May 2020 13:56:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F806F800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pKaTQpT7"
Received: from localhost (unknown [117.99.89.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 229292137B;
 Sat,  2 May 2020 11:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588420587;
 bh=1yEsKoU0oUSVvOLYtVrEg1plY1Addk/1bazSbloP00c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pKaTQpT73raZfKKWJXWPxWtNmxWPm+a18Wdh5WRmTe2QX+EhMC8PV25R0y20AJE/n
 tBWi37pQnaRl3hyl1JzL+hV1JP3VXLRXGZFjv8A6XLoHSYoHtrG3fe2NC7VH/QXv24
 1lElS1Cpbce2EvnfcOc/1P0dXErb1lioXWWCNJR8=
Date: Sat, 2 May 2020 17:26:14 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 1/4] Documentation: SoundWire: clarify TDM mode support
Message-ID: <20200502115614.GR948789@vkoul-mobl.Dlink>
References: <20200419185117.4233-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419185117.4233-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

On 20-04-20, 02:51, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The current description of stream topologies does not explicitly
> mention 'mirror' topologies used for audio amplifiers, where all
> amplifiers see the same data and generate a different output based on
> configuration or dynamic information. Add examples and notes to
> explain how channels can be transmitted and mapped.

Applied all, thanks
-- 
~Vinod
