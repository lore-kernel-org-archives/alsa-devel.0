Return-Path: <SRS0=4Ztp=5E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B28C4332D
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:44:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8ACD20775
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qu4ENETY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8ACD20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 468091764;
	Thu, 19 Mar 2020 16:43:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 468091764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584632645;
	bh=4AMqcLUNCFM5j8TcYnZ2lKKFs6jDr9kdfcBrrbuP0Hw=;
	h=From:To:Subject:In-Reply-To:References:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qu4ENETYy2pT+89orWtXyPvjHjn3OHi2T741kukWUlJUbNRdoetJVF1VaEvNU0x3F
	 NSsuFXmsrDdZX5EoSzikpxA0wU/XrbruHvAB9gtnj25PDfEZoKRGSwq+q3M2SOu+OM
	 8TSO233g9yg8AyAxm+EyIwZLfbERTAgV2WnNScG4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A697DF8012F;
	Thu, 19 Mar 2020 16:43:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2EE49F8015B; Mon, 16 Mar 2020 16:33:17 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35DD5F80058
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2020 16:33:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35DD5F80058
IronPort-SDR: XcdEwQ0RzZVQ5A9KCCcOALEOgof/fduJSqHNqqPMMT0x/y71xVOQUceaYivsjLHAtxE75bE2mM
 YB8rPVZzF6yA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2020 08:33:06 -0700
IronPort-SDR: iITveEGsB4PM/qGADp4pXTOILr3PlYoZBRaDxL2M2sonmhpy4W1Khrjrb5ebjKAGrgLHTJLQlO
 4S+ARju9YjGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,560,1574150400"; d="scan'208";a="417177457"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
 by orsmga005.jf.intel.com with ESMTP; 16 Mar 2020 08:33:02 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] x86: Easy way of detecting MS Surface 3
In-Reply-To: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
References: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
Date: Mon, 16 Mar 2020 17:33:02 +0200
Message-ID: <871rps9uxd.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 19 Mar 2020 16:43:13 +0100
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 alexander.shishkin@linux.intel.com, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> While working on RTC regression, I noticed that we are using the same DMI check
> over and over in the drivers for MS Surface 3 platform. This series dedicated
> for making it easier in the same way how it's done for Apple machines.

[...]

>   x86/quirks: Introduce hpet_dev_print_force_hpet_address() helper
>   x86/quirks: Join string literals back

These two don't seem to be related to the Surface 3 cause of the rest of
the patchset, or am I missing something?

Regards,
--
Alex
