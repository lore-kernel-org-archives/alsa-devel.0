Return-Path: <SRS0=ORgw=FU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4F1C0018C
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Dec 2020 13:17:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11E0233CF
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Dec 2020 13:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11E0233CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 97A3517CB;
	Wed, 16 Dec 2020 14:16:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 97A3517CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608124638;
	bh=HrVqdE+S7SVg81znhUl0LhVQLmDXgg8J3tXiE9wsf3M=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tvP7hH2RjzI8Me3iKWO0S0GZrwiFWnYCpMCfuRAjBJlVgpoS/AYWWIng4uAGXEODq
	 hWeEdJw7+/MC8DyToE7027s1qzJ5ZW7iz+Ox4OIJrqIH6155zwdxYhPt1Hmumgh8Uo
	 RShuKOqXlX/M383uddG5q3QrjxMJ3Jgi71AXtwlo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1EC8FF80245;
	Wed, 16 Dec 2020 14:16:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3B71F80171; Wed, 16 Dec 2020 14:16:23 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7649EF8011B;
 Wed, 16 Dec 2020 14:16:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7649EF8011B
IronPort-SDR: GogjOsnGk4dTRpjPbtganjEnW+ED/+WD8d7k4pWpXyMP7xFEgwrV51I2xG1+XPrNCtlQtoAfp2
 mP4ZrA1GW1Rg==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="162805985"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; d="scan'208";a="162805985"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2020 05:16:07 -0800
IronPort-SDR: 4sUBNzqBieO5bVce0WBSsq0cZlNgga0YyZxV4aP8k0toaa7y4WrOnChucWcCpgjsv9Sg4b/7ae
 liVW68dtqsJg==
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; d="scan'208";a="338473869"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2020 05:16:04 -0800
Date: Wed, 16 Dec 2020 15:13:19 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] ASoC: SOF: Fix spelling mistake in Kconfig "ond" -> "and"
In-Reply-To: <20201216125913.16041-1-colin.king@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2012161511510.864696@eliteleevi.tm.intel.com>
References: <20201216125913.16041-1-colin.king@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 sound-open-firmware@alsa-project.org
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

Hi,

thanks Colin.

On Wed, 16 Dec 2020, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the Kconfig help text. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Br, kai
