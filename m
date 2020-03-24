Return-Path: <SRS0=OLeW=5L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5825C2D0E7
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:59:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FDBD20772
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bOqO0mNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDBD20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B5FA167A;
	Thu, 26 Mar 2020 08:58:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B5FA167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585209587;
	bh=R6yCKKe2tnxl2UY7xaRGCIq2ItHpXfRcBTETZdnaBdY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bOqO0mNlQl1HusYaSpf6hVAHpZvV1OabMVsENccc4k8ACHg6bOFCsz5A5hVrgQUR7
	 dv5iEvFDeun3wIrGbh/tqpOxvQSFEiCvBYehIie1TYyPKZvsQCfERDYA6RbbxMihXc
	 n6TKL2vMyCvgw2nmgkxT/ewfiauFxLPfpZzZmAA0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 525D3F802BE;
	Thu, 26 Mar 2020 08:54:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 818A9F801F9; Tue, 24 Mar 2020 20:31:58 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB99FF800B9
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 20:31:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB99FF800B9
IronPort-SDR: 1oRGVV99FaKsjPR1nSIUcSahrjr776xInGryEyui0Xdyrhj+Z1wyUn3+qDOiyXeOwJKY5PCjDZ
 IvYlAG8YCW0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 12:31:47 -0700
IronPort-SDR: 8/VWxHUZ8NY4RmIqej7yewcPHcwLNpP4scEJKK1G8flVXsWoOafuGEnpmA/GWWQR4A85a5Q5RF
 SBwJJ7+F7kKw==
X-IronPort-AV: E=Sophos;i="5.72,301,1580803200"; d="scan'208";a="420008785"
Received: from agluck-desk2.sc.intel.com (HELO
 agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 12:31:46 -0700
Date: Tue, 24 Mar 2020 12:31:44 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 10/22] EDAC: Convert to new X86 CPU match macros
Message-ID: <20200324193144.GA4104@agluck-desk2.amr.corp.intel.com>
References: <20200320131345.635023594@linutronix.de>
 <20200320131509.673579000@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320131509.673579000@linutronix.de>
X-Mailman-Approved-At: Thu, 26 Mar 2020 08:54:37 +0100
Cc: Ulf Hansson <ulf.hansson@linaro.org>, x86@kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, alsa-devel@alsa-project.org,
 platform-driver-x86@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Amit Kucheria <amit.kucheria@verdurent.com>,
 Mark Gross <mgross@linux.intel.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-acpi@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, linux-pci@vger.kernel.org,
 Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>,
 Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, linux-pm@vger.kernel.org,
 linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Takashi Iwai <tiwai@suse.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>,
 linux-crypto@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Andy Shevchenko <andy@infradead.org>
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

On Fri, Mar 20, 2020 at 02:13:55PM +0100, Thomas Gleixner wrote:
> The new macro set has a consistent namespace and uses C99 initializers
> instead of the grufty C89 ones.
                 ^^^^^^

grufty? Did you mean crufty?

Though I suppose grufty may work as well here:

	gruft. Noun. (uncountable) (dialect) the particles of soil
	that are spattered up onto grass by the rain.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested the Broadwell EDAC driver. The other changes look
good too.

Acked-by: Tony Luck <tony.luck@intel.com>
