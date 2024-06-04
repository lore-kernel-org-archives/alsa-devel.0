Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58C7C25B7E
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:10:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF061F52;
	Tue,  4 Jun 2024 11:10:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF061F52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1717492216;
	bh=sXjcCXgajbmAQt94Pk6QUfbkIjNpIdTaExdj0T/v6uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dFikLdOuq9a/xEdwblmhtR7wCD4GNmekd+yl2b/A7U2KSXodpCRubi/ls7b7f84Zd
	 FSVdPbEvkNCUGAXs0NmLAUJpHMHJAX4jB2UFWpo3RhzIsqT6ZcqBSQ29Kue0t/hQzQ
	 qLQ0psZRB13gpOtLr5aPD3lpOC31zjf1cclqVVfE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3EB4F80579; Tue,  4 Jun 2024 11:09:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 16AA7F80496;
	Tue,  4 Jun 2024 11:09:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 34528F802DB; Tue,  4 Jun 2024 11:09:40 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DC201F800FA
	for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2024 11:09:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC201F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=vJDlTvKS
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 06409CE0E89;
	Tue,  4 Jun 2024 09:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8FBC2BBFC;
	Tue,  4 Jun 2024 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717492170;
	bh=sXjcCXgajbmAQt94Pk6QUfbkIjNpIdTaExdj0T/v6uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJDlTvKSauNIbvDf9s6JtDlHi3NoB/8aBQHU9/OhhCPlqwVjCgI39n8NnwaHP9A6L
	 ndD6YJixI1eYvW/qmKyvtWaCnijdx/5v2lJta7oBqhD6O7ZLjzMz72OtDKO9IYkYlI
	 z1cDwYtlxs1T4lYBfdmuj8sFekNfss1bRSGDHoxY70eDQZBRTvmqn81DMqaBfiW7z9
	 5sR0InPCMm7Vk9DhisV3yGvlAWMHbgOTuotFo7wfwKWxGC30j3n17IeEjf4Wo+m0hx
	 QYWUIodZJh1iwITuSwuBYqVoTdEIxT6xgoIYJGuiauYSufxhxt/sFaDeMbMaHT0ye+
	 aQpx97sZXj6Ww==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sEQAa-000000001Q2-2Ido;
	Tue, 04 Jun 2024 11:09:29 +0200
Date: Tue, 4 Jun 2024 11:09:28 +0200
From: Johan Hovold <johan@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] soundwire: bus: suppress probe deferral errors
Message-ID: <Zl7ZyEkmm8kHeRvL@hovoldconsulting.com>
References: <20240604075213.20815-1-johan+linaro@kernel.org>
 <20240604075213.20815-2-johan+linaro@kernel.org>
 <c5ecc0cd-c2ba-4f71-ac2a-9a81793a8f0c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ecc0cd-c2ba-4f71-ac2a-9a81793a8f0c@linux.intel.com>
Message-ID-Hash: 2TKQM2K5NQMJ2O4GP6ADPFTIHIJJJ67V
X-Message-ID-Hash: 2TKQM2K5NQMJ2O4GP6ADPFTIHIJJJ67V
X-MailFrom: johan@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2TKQM2K5NQMJ2O4GP6ADPFTIHIJJJ67V/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Jun 04, 2024 at 10:30:21AM +0200, Pierre-Louis Bossart wrote:
> On 6/4/24 02:52, Johan Hovold wrote:
> > Soundwire driver probe errors are currently being logged both by the bus
> > code and driver core:
> > 
> > 	wsa884x-codec sdw:4:0:0217:0204:00:0: Probe of wsa884x-codec failed: -12
> > 	wsa884x-codec sdw:4:0:0217:0204:00:0: probe with driver wsa884x-codec failed with error -12
> > 
> > Drop the redundant bus error message, which is also incorrectly being
> > logged on probe deferral:
> 
> It's only redundant in the QCOM case... This would remove all error logs
> for other codecs, e.g. see
> 
> rt711_sdca_sdw_probe
> cs35l56_sdw_probe
> wcd9390_probe
> 
> Looks like the wsa884x-codec is the chatty driver, others are just fine
> with the existing code.

I believe you misunderstood this patch. The error messages above are not
printed by the wsa884x-codec driver, but by the soundwire bus code and
driver core, so the redundant error message will be printed for all
codecs on probe failures.

And specifically, driver core will still log probe failures after this
change.

Johan
