Return-Path: <SRS0=Bo48=LO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01048C48BDF
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 11:18:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839F7610EA
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 11:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839F7610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0C3A16D0;
	Sun, 20 Jun 2021 13:17:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0C3A16D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624187905;
	bh=OfUiVNmBFTHlrsfW6CzlrHT/dZVKq3gESxQTYa6X/WY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eeH47NVBz3gKntTIlt8ACbBMb0HcYqPhUm/ALt6MBOZhoZPX7/ehf36GYHwlbpK4d
	 oCAcokC2L9hvben5iLHEFlyp9AgfIImHe7qgBkyco0NKfW6mgv4QaxS4mEhUj/+akw
	 T1+qQEXZPULVbBVGnwPxb8TuXDJTs01DHgg2yKaU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D573F8025F;
	Sun, 20 Jun 2021 13:17:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A555F80268; Sun, 20 Jun 2021 13:17:33 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE936F80137
 for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2021 13:17:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE936F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="i2ZZhgWR"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FB9F6108E;
 Sun, 20 Jun 2021 11:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624187847;
 bh=OfUiVNmBFTHlrsfW6CzlrHT/dZVKq3gESxQTYa6X/WY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i2ZZhgWRRC+5tj5S8vgp2GEx3lnCTHSrIFOckDydhZ/zi115ukcX6jOyTWF+WkTx/
 95tna5wknOSf3FkZXvkbpuHG9xsHocZYpFtajSTFeoXS5at8ziNxiDGerw9t5o5Nyb
 NY8ou0pqspqxQvQT5Xz9R3R37NFKhUyZHYhMbDBAiXBLx1NND+9ZQXdqwiZhA35r0y
 An2kCwRin5WZ1fSQe3idUA7TMoDcP2oTm1lh03mDD6PrlfH5g3RM8SGjeLyq8uIVDz
 UCAzVnHkvGTXwHNxNDzqiFdBgpc+AtfPIa2mXHrakRyuYY4Eqa17D1V1XKER16apyX
 Lz2C+vQ7c3/uA==
Date: Sun, 20 Jun 2021 16:47:22 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH v2] soundwire: bus: Make sdw_nwrite() data pointer
 argument const
Message-ID: <YM8jwosKEbNlVXkp@vkoul-mobl>
References: <20210616145901.29402-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616145901.29402-1-rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
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

On 16-06-21, 15:59, Richard Fitzgerald wrote:
> Idiomatically, write functions should take const pointers to the
> data buffer, as they don't change the data. They are also likely
> to be called from functions that receive a const data pointer.
> 
> Internally the pointer is passed to function/structs shared with
> the read functions, requiring a cast, but this is an implementation
> detail that should be hidden by the public API.

Applied, thanks

-- 
~Vinod
