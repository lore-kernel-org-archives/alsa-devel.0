Return-Path: <SRS0=Rw3p=A2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71062C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 04:38:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4A5206D5
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 04:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ktnd5gcW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAvWgash"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4A5206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 755D415DC;
	Wed, 15 Jul 2020 06:37:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 755D415DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594787926;
	bh=FkgBXyuF+XFNy5qc841ZACxfHHnjVQ7pJoeeVggha0s=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ktnd5gcW55TFtM38aN7ut3yS5QNcWHYxKO0/4TukoY3UjIzh/mbEpLSt1QNunMSHV
	 WWV9iaVUmNH08WGR5AJe1b6Yx13MKE1SCMbOxQKXmYDx0MJtC2u9loGY+Us9NMpukp
	 3EhSKYfLdUSMPt0/NsH5Cjel8mCVSUeoBfy2c2YM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6E02F80217;
	Wed, 15 Jul 2020 06:37:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2BB5DF8021D; Wed, 15 Jul 2020 06:37:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE047F80113
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 06:37:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE047F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HAvWgash"
Received: from localhost (unknown [122.171.202.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D92C6206D5;
 Wed, 15 Jul 2020 04:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594787864;
 bh=FkgBXyuF+XFNy5qc841ZACxfHHnjVQ7pJoeeVggha0s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HAvWgashKtwF64JCAequp2kjP2D8UhkjrctzbtPez1zqgxCBjiyQIA4o7RsxWaTMZ
 YmJLbBXCq73ZED4/dlJ02++/UXojBplD+/xSLXNC0mertqMM06YmF3Y8F6kNpW5mD6
 0btJ/Wm9TMm8fTPYipKTAxdd35KiS1uPQ+/wdN0U=
Date: Wed, 15 Jul 2020 10:07:40 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: change SoundWire maintainer
Message-ID: <20200715043740.GM34333@vkoul-mobl>
References: <20200703192644.751-1-sanyog.r.kale@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703192644.751-1-sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 lgirdwood@gmail.com, gregkh@linuxfoundation.org,
 ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 yung-chuan.liao@linux.intel.com
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

On 04-07-20, 00:56, Sanyog Kale wrote:
> Add Bard as SoundWire maintainer from Intel and change Sanyog's
> role as reviewer.

Applied, thanks

-- 
~Vinod
