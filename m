Return-Path: <SRS0=nSv5=DG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B3CC4727C
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:33:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89CB20739
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MN4VOwKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89CB20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1697F1891;
	Tue, 29 Sep 2020 16:32:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1697F1891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601389994;
	bh=814w1jG/aY0loFakmcXm75kdNgcMGtoFRLdrZOFy2XE=;
	h=Subject:From:To:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MN4VOwKocSrV2CdiB+Dw4yTcn0xf0Clhx1RHudyJp+GGyO4K2hYBVQPR/99PkoKxR
	 03y0DtyifsWSPSvC19bGl1v+mO8bCWZZa/s2S8Pz0a75Z65Gk8Q/l6Bud8mv5CHFKo
	 P3W5V26ne7YaGv792ETHYXamvrMsjmbaBPH3hMzk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5DDCF801DB;
	Tue, 29 Sep 2020 16:32:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F320CF801F5; Tue, 29 Sep 2020 16:32:21 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41FB5F80115;
 Tue, 29 Sep 2020 16:32:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41FB5F80115
IronPort-SDR: xbnV+irtWJE+rBXMYorXavsyW56hG09tXHzxQnK7zzYjYppLTB29cjB3Lm0Ki1NCbqvWe94crL
 XusZp4tWV8Ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="159531227"
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; d="scan'208";a="159531227"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2020 07:32:06 -0700
IronPort-SDR: SJLzmZHQPwrdpmKI6yUYPdPqVl5UAXro+ekMqsDxaZQxLE11AYLmYn1TJ3AlF57zwYEDeebg2G
 ffV9nl6M2sVA==
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; d="scan'208";a="491479092"
Received: from sotmazgi-mobl1.ger.corp.intel.com ([10.214.222.17])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2020 07:32:02 -0700
Message-ID: <ac84d208a5da9fc26e68b3368918ae518f1b3e9b.camel@linux.intel.com>
Subject: [ANNOUNCE] SOF v1.6-rc3 released
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
To: alsa-devel <alsa-devel@alsa-project.org>, sound-open-firmware
 <sound-open-firmware@alsa-project.org>
Date: Tue, 29 Sep 2020 15:31:56 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>, Anthony Wong <anthony.wong@canonical.com>,
 Hui Wang <hui.wang@canonical.com>, Rex Tsai <rex.tsai@canonical.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
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

The SOF developers are pleased to announce the release of our first
signed release candidate for v1.6. i.e v1.6-rc3

Binaries can be found here.

https://github.com/thesofproject/sof-bin/tree/stable-v1.6

New features are

* Support for Intel Tigerlake
* Support for Maxim Smart Amplifiers
* Beamformer Microphone support.
* DC blocker audio processing component.
* Major feature and performance improvements for ASRC, KWD and FIR/IIR.
* Numerous bug fixes and performance improvements for Intel and NXP
platforms.

In a change from the previous release process, the later release
candidates will now be signed by Intel so that users can have the
chance to test drive prior to v1.6 final. This will also give
distributions more time to integrate and resolve any issues.

Firmware issues can be reported here.

https://github.com/thesofproject/sof/issues

Thanks

Liam 

