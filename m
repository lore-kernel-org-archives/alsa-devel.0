Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BD6C2D0A8
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:06:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C29A2145D
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="toJMvBfO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xmHe9xSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C29A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E83D173D;
	Wed, 23 Sep 2020 12:05:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E83D173D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600855562;
	bh=DE1HC6bZAXC33BhPSJIUP9LjJZr0AuwIVj0yEXHmm9I=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=toJMvBfOrpEUwE/9mla5Btja0Bgh6ymPAd4KbFBdJJEDKx8gkexGkQCxN5Wv4j9wz
	 ICdjd3gnSnMRt2V/n/lofF57j7RS3QlWDI3ozFqHwKG3H8o1f0PIZAFpOfLhWLThRp
	 /A8lAAszW8Wq3H/8RZz97PBQQHGg1Etjfc5RdiJs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FE15F80162;
	Wed, 23 Sep 2020 12:05:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D7D0F801EC; Wed, 23 Sep 2020 12:05:11 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25BD8F8015F
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 12:05:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25BD8F8015F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xmHe9xSM"
Received: from localhost (unknown [122.171.175.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7CF3A2076E;
 Wed, 23 Sep 2020 10:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600855503;
 bh=DE1HC6bZAXC33BhPSJIUP9LjJZr0AuwIVj0yEXHmm9I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xmHe9xSMEV5pB89hrTgj1EP5WkwKR+ZiNWJr7T6rKXh2axCnNhkV7Vzbsg1Zea3Ud
 aRCQiE9luiQszMla+TFhNPH7qaLdHFTTJ2eypuN+UQ4KcNl2iXE2ywDEhJ1aGY/0TH
 EvSu8QXo1HcDQQcHw+Sh0tdIFw+H0GOmbOMmz6EU=
Date: Wed, 23 Sep 2020 15:34:55 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] soundwire: remove an unnecessary NULL check
Message-ID: <20200923100455.GG2968@vkoul-mobl>
References: <20200923083235.GB1454948@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923083235.GB1454948@mwanda>
Cc: kernel-janitors@vger.kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
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

On 23-09-20, 11:32, Dan Carpenter wrote:
> The "bus" pointer isn't NULL so the address to a non-zero offset in
> middle of "bus" cannot be NULL.  Delete the NULL check.

Applied, thanks

-- 
~Vinod
