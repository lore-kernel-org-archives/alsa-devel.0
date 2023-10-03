Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A694E7AD78
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Oct 2023 16:25:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86EBA84A;
	Tue,  3 Oct 2023 18:24:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86EBA84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696350324;
	bh=TNU9ipzGbwPhcDS9xrUC4LpxTUdjs0JhjZFYvHpGT0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GKpY313PrNrdwVQW1b9A3u3RTdFBAQc7UeuMuHWQm2StAtP1XOk+vnj+zRvh0Vvqb
	 edKnHA69a8CN4+1XiYLjK2eYPMWu0W5K41o2Y8cX8CF/rfLzyFp5h6DDFJTPsCVCUC
	 P4fPdq/NY3GM20VFnS+eE8c/R8XvlmDc/qIUD+rg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2DDA3F80558; Tue,  3 Oct 2023 18:23:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C97B9F801EB;
	Tue,  3 Oct 2023 18:23:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29BA7F8047D; Tue,  3 Oct 2023 18:23:52 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A0904F80130
	for <alsa-devel@alsa-project.org>; Tue,  3 Oct 2023 18:23:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0904F80130
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4S0NRf3F6Lz1sB7V;
	Tue,  3 Oct 2023 18:23:40 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4S0NRb4yb1z1qqlS;
	Tue,  3 Oct 2023 18:23:39 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id aP66i6RqkI-7; Tue,  3 Oct 2023 18:23:37 +0200 (CEST)
X-Auth-Info: DEcWQ3O3Q8oqxyW+2oC9tHdwulLSJUIRdEt3IUmb5jjP2Lci+dS0J9Uj4ULe5Ygi
Received: from igel.home (aftr-62-216-205-214.dynamic.mnet-online.de
 [62.216.205.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue,  3 Oct 2023 18:23:37 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 690602C0052; Tue,  3 Oct 2023 18:23:37 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Ding, Shenghao" <shenghao-ding@ti.com>,  "broonie@kernel.org"
 <broonie@kernel.org>,  "robh+dt@kernel.org" <robh+dt@kernel.org>,
  "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
  "lgirdwood@gmail.com" <lgirdwood@gmail.com>,  "perex@perex.cz"
 <perex@perex.cz>,  "pierre-louis.bossart@linux.intel.com"
 <pierre-louis.bossart@linux.intel.com>,  "Lu, Kevin" <kevin-lu@ti.com>,
  "13916275206@139.com" <13916275206@139.com>,
  "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
  "mengdong.lin@intel.com" <mengdong.lin@intel.com>,  "Xu, Baojun"
 <baojun.xu@ti.com>,  "thomas.gfeller@q-drop.com"
 <thomas.gfeller@q-drop.com>,  "Gupta, Peeyush" <peeyush@ti.com>,  "Navada
 Kanyana, Mukund" <navada@ti.com>,  "tiwai@suse.de" <tiwai@suse.de>,  Arnd
 Bergmann <arnd@arndb.de>,  linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [EXTERNAL] Re: [PATCH v1] ASoC: tas2781: fixed compiling issue
 in m68k
In-Reply-To: 
 <CAMuHMdXRGxnGpVHiB+Zvxq+G4K-BL8JsJGbG+7CNtJiqGwHOsQ@mail.gmail.com>
	(Geert Uytterhoeven's message of "Tue, 3 Oct 2023 14:15:36 +0200")
References: <20231002090434.1896-1-shenghao-ding@ti.com>
	<CAMuHMdXr5oRgkFqYZnPe3Xdyq_QjtzhfL8Wa_e9JA0S1XhEhWw@mail.gmail.com>
	<79c4d534ad20452c992d8ace138e4384@ti.com>
	<CAMuHMdXRGxnGpVHiB+Zvxq+G4K-BL8JsJGbG+7CNtJiqGwHOsQ@mail.gmail.com>
X-Yow: I am covered with pure vegetable oil and I am writing a best seller!
Date: Tue, 03 Oct 2023 18:23:37 +0200
Message-ID: <87v8bn3cae.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Message-ID-Hash: 5NSWRR7VX63RSRXBWWH2ECWXATD76QYK
X-Message-ID-Hash: 5NSWRR7VX63RSRXBWWH2ECWXATD76QYK
X-MailFrom: whitebox@nefkom.net
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5NSWRR7VX63RSRXBWWH2ECWXATD76QYK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Okt 03 2023, Geert Uytterhoeven wrote:

> Looks like the compiler is sharing the jump table at L95 for two
> different switch() statements, but the PC-relative offset to refer to
> the table is too large when using -m68000.  It works fine with -m68020.

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104028

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
