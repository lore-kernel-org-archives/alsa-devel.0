Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614A9C433E2
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:34:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0ACE20716
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S1NcdhEg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwh8y8yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0ACE20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DD7918BC;
	Thu,  3 Sep 2020 12:33:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DD7918BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599129238;
	bh=YFlDB95nKM1SZdLZ0MVDpqJ2y3FZn9MeGhr5mbp3gf0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S1NcdhEgMWrw5tOo5G4Gi59QdhHM98YScyTak/Tofo3S47Cw9O9r0KmvHQGTmSDbo
	 jyI8sOqQ/jm+6mmmqX00wmzZadJysb4ViLa7cDhlpsfZqfKoBv8CM1IOFartYDOjUE
	 mDbzB+buobrHgknbSsvtuNrZDZWiobbH3TwbD1K4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A68A5F8020D;
	Thu,  3 Sep 2020 12:33:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9397CF80217; Thu,  3 Sep 2020 12:33:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1DBCF800BA
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 12:32:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1DBCF800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qwh8y8yt"
Received: from localhost (unknown [122.171.179.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1955620716;
 Thu,  3 Sep 2020 10:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599129170;
 bh=YFlDB95nKM1SZdLZ0MVDpqJ2y3FZn9MeGhr5mbp3gf0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qwh8y8ytLoTAHVmF7uqlnAd3WyC269LWUxpGiMxKRwYJWWf5B3/YBRg8rJJ167vIy
 bQCvE1vwI+T+En1RkkDNq6+HsGL75r8dpgvUqumsasX1gtdbWGy7w34rjOpUwrMTtH
 PBHMX3GCv/oh9OCQ71h97poKERTrnnVJU/4bSeXA=
Date: Thu, 3 Sep 2020 16:02:45 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v4 0/3] ASoC: soundwire: fix port_ready[] dynamic
 allocation
Message-ID: <20200903103245.GO2639@vkoul-mobl>
References: <20200831134318.11443-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831134318.11443-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

On 31-08-20, 21:43, Bard Liao wrote:
> The existing code allocates memory for the total number of ports.
> This only works if the ports are contiguous, but will break if e.g. a
> Devices uses port0, 1, and 14. The port_ready[] array would contain 3
> elements, which would lead to an out-of-bounds access. Conversely in
> other cases, the wrong port index would be used leading to timeouts on
> prepare.
> 
> This can be fixed by allocating for the worst-case of 15
> ports (DP0..DP14). In addition since the number is now fixed, we can
> use an array instead of a dynamic allocation.

Applied all, thanks
-- 
~Vinod
