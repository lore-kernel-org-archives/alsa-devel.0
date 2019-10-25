Return-Path: <SRS0=ik9t=YS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A477ECA9EA0
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:15:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F4B21872
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oC1qRGE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F4B21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1094517D6;
	Fri, 25 Oct 2019 18:14:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1094517D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572020149;
	bh=9SNLMc8fwfhR5ekR0Ouza7w4A8MehY+rUlZFSg2qDLo=;
	h=From:To:Date:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oC1qRGE4T3JACTOF6Ochwi61tPWWvxGoh3QrBcVEKUT4++6b/9ZdVIWd129Zz/rBs
	 aZ/CeCaAtmA7Kr7eATgxMD9QpVSfhKZGMj+d7NUdMa4By3gBhgIngnt70iFZiiSuv5
	 plqLAib0tghk43qXxouf8mCzInhUbEoPobRHucaY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 954CAF80368;
	Fri, 25 Oct 2019 18:14:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1AE7BF8036F; Fri, 25 Oct 2019 18:14:57 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 230ACF80112
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2019 18:14:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 230ACF80112
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 09:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; d="scan'208";a="197465732"
Received: from kmsmsx151.gar.corp.intel.com ([172.21.73.86])
 by fmsmga008.fm.intel.com with ESMTP; 25 Oct 2019 09:14:47 -0700
Received: from pgsmsx108.gar.corp.intel.com ([169.254.8.51]) by
 KMSMSX151.gar.corp.intel.com ([169.254.10.97]) with mapi id 14.03.0439.000;
 Sat, 26 Oct 2019 00:14:46 +0800
From: "Lu, Brent" <brent.lu@intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Thread-Topic: [alsa-devel] [PATCH] ASoC: eve: implement set_bias_level
 function for rt5514
Thread-Index: AQHVixSpuo5KyaaW0kmhCX7+/fo7hqdq3ikAgACJfMD//4KWAIAAhrNg
Date: Fri, 25 Oct 2019 16:14:46 +0000
Message-ID: <CF33C36214C39B4496568E5578BE70C74032096B@PGSMSX108.gar.corp.intel.com>
References: <1571994691-20199-1-git-send-email-brent.lu@intel.com>
 <3ce80285-ddb5-653d-cf60-febc9fd0bdee@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C740320822@PGSMSX108.gar.corp.intel.com>
 <219281e5-d685-d584-0d22-5dcf3ca2bec2@linux.intel.com>
In-Reply-To: <219281e5-d685-d584-0d22-5dcf3ca2bec2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmY3MWIyOGYtZTdiNi00YmU4LTlhMDQtMDZmNmU3MzFkMWNiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiU1NaSnFzZmJBRHhoMFlwdG5UaGZFSXNtNXBzYkU4VU5WbXJIMERIXC80d09yMmYrN0tMSWdkXC9LV0psKzNxb3RRIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
MIME-Version: 1.0
Cc: "Rojewski, Cezary" <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Tzung-Bi Shih <tzungbi@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Richard Fontana <rfontana@redhat.com>, Mark Brown <broonie@kernel.org>, "M,
 Naveen" <naveen.m@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: eve: implement set_bias_level
 function for rt5514
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

> 
> Can you clarify if the rt5514 needs the MCLK while it's doing the hotword
> detection?

No, running the detection does not raise the bias level so the set_bias_level 
will not be called. The mclk is only turned on then off in mixer control's handler 
(rt5514_dsp_voice_wake_up_put) when enabling the hotword detection.

> 
> My point is really that this patch uses a card-level BIAS indication, and I'd like
> to make sure this does not interfere with the audio DSP being in D3 state.

The function checks the name of dapm so it would only react when rt5514's 
bias level is changing. And also the idle_bias_off of the codec driver is true so 
it's target_bias_level should not be overwritten in the dapm_power_widgets() 
function. The behavior should be similar to the previous patch which is using 
supply widget.


Regards,
Brent
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
