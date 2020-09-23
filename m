Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C8FC4727E
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:18:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D3121D43
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nR7uuuu4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC+g5ZOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D3121D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E74D1716;
	Wed, 23 Sep 2020 19:17:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E74D1716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600881500;
	bh=pXl4rjwGVd/9QMBbU5gSvpTosiJr0W1zBefEyZObaBw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nR7uuuu4H88W+5hn/bRFtc+H8XpmGiQZZN06w/a5Hv1WIhC6Fay06iA/rOefbAzqb
	 JeKUSsV5XJevYhanZcFaDVfJZrEeN+gEkoHq3ZTaQDClJ4K+WhrVEYam/CtW2XYArS
	 1uTo6x8jW7dsA8FFo5Gb2smgm3+ksPaIT0Iz2rSY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 822C1F80162;
	Wed, 23 Sep 2020 19:17:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 568EDF80171; Wed, 23 Sep 2020 19:17:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D08BEF800B4
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 19:17:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D08BEF800B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZC+g5ZOc"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7DE5F21BE5;
 Wed, 23 Sep 2020 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600881433;
 bh=pXl4rjwGVd/9QMBbU5gSvpTosiJr0W1zBefEyZObaBw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZC+g5ZOcQDl/IZIC9BEzy/fK/mefGhNKQR27oSf7+6o7e/WhSZzndyAJyOJ36jcz5
 vC31TlW6x9GK9OUsp/jtpAdheiCCIzWW327itTqV5WUijKpTypX30GL0ZN+UHPmJ66
 YNhulFiY5crOvzRT5snH1DaE8KBkO0qZM1TSuw5w=
Date: Wed, 23 Sep 2020 19:17:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v8 09/14] ASoC: Intel: catpt: Simple sysfs attributes
Message-ID: <20200923171731.GB3732240@kroah.com>
References: <20200923122508.3360-1-cezary.rojewski@intel.com>
 <20200923122508.3360-10-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923122508.3360-10-cezary.rojewski@intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 andriy.shevchenko@linux.intel.com, filip.kaczmarski@intel.com,
 harshapriya.n@intel.com, marcin.barlik@intel.com, zwisler@google.com,
 lgirdwood@gmail.com, tiwai@suse.com, filip.proborszcz@intel.com,
 broonie@kernel.org, amadeuszx.slawinski@linux.intel.com,
 michal.wasko@intel.com, cujomalainey@chromium.org,
 krzysztof.hejmowski@intel.com, ppapierkowski@habana.ai,
 vamshi.krishna.gopal@intel.com
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

On Wed, Sep 23, 2020 at 02:25:03PM +0200, Cezary Rojewski wrote:
> Add sysfs entries for displaying version of FW currently in use as well
> as dumping full FW information including build and log-providers hashes.
> 
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>

Much nicer:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
