Return-Path: <SRS0=OCx8=ZZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A16C432C0
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:33:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2752206F0
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hHBADZtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2752206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C713E1655;
	Tue,  3 Dec 2019 11:33:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C713E1655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575369234;
	bh=BDQhcTVY9jHOIDJ/Y13uyoQ9+v4QeBZGD1RPTzYkLKM=;
	h=From:To:Date:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hHBADZtqV/j7IlUkgEQUXztPUuZs1RCUNCosEiN0sYuq7/6wce21CsYMAIjFC37uL
	 g/xqYyH6IMof0NQk5efJlmSY9T8IHAOuQqWQhIumjNqZ3133mFnseaWrlDfQxiF3Lz
	 MOxwyAdTmk3rsnAzu6w5gYTbT5wYY9i12cdmwEv4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68FF2F8015A;
	Tue,  3 Dec 2019 11:33:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57C50F80229; Tue,  3 Dec 2019 11:33:03 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86784F800F0
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2019 11:32:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86784F800F0
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Dec 2019 02:32:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; d="scan'208";a="412136254"
Received: from pgsmsx107.gar.corp.intel.com ([10.221.44.105])
 by fmsmga006.fm.intel.com with ESMTP; 03 Dec 2019 02:32:54 -0800
Received: from pgsmsx110.gar.corp.intel.com (10.221.44.111) by
 PGSMSX107.gar.corp.intel.com (10.221.44.105) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Dec 2019 18:32:53 +0800
Received: from pgsmsx108.gar.corp.intel.com ([169.254.8.12]) by
 PGSMSX110.gar.corp.intel.com ([10.221.44.111]) with mapi id 14.03.0439.000;
 Tue, 3 Dec 2019 18:32:53 +0800
From: "Lu, Brent" <brent.lu@intel.com>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Thread-Topic: [PATCH] ASoC: da7219: remove SRM lock check retry
Thread-Index: AQHVqaw+ii/fH1J6I0CEgpyDBLMztaeno36AgACHg7A=
Date: Tue, 3 Dec 2019 10:32:52 +0000
Message-ID: <CF33C36214C39B4496568E5578BE70C7403CA7B2@PGSMSX108.gar.corp.intel.com>
References: <1575358265-17905-1-git-send-email-brent.lu@intel.com>
 <AM5PR1001MB0994EB497D3BC7D0F4C6FD9080420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM5PR1001MB0994EB497D3BC7D0F4C6FD9080420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWVmODk2NjMtYmIxMi00NmE2LTk1ZTQtMzFhZWZhYjJmMzk3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicDgwQ21lR04zek40bDZzcjYrSVZMQSt1M1ptZEt1Q0gyMG0xdzVWY3hnZ3NQYU1tTDRuUTJBakZkNVlydXY0ZCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
MIME-Version: 1.0
Cc: Support Opensource <Support.Opensource@diasemi.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: da7219: remove SRM lock check retry
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
> We can potentially reduce the timings here for something shorter although
> I'd need to speak with the HW team as to what, if any reduction is feasible.
> However this is not a real fix as there's potential for audible noises when you
> don't enable WCLK first. As far as I can tell the Intel platforms are capable of
> enabling clocks early, as can be seen in this board file with early SCLK enable:
> 
> https://elixir.bootlin.com/linux/latest/source/sound/soc/intel/boards/kbl_rt
> 5663_max98927.c#L99
> 
> I think there's a need to find some method to enable the WCLK signal
> otherwise there's the potential for audible artefacts when SRM finally locks
> which is not going to be pleasant.
> 

Hi Adam,

Thanks for reply. This patch is not fixing any bug. It just shorten the audio latency
on our boards. Basically we are idling there for 400ms then print a warning message
about SRM not being locked. It seems to me that 400ms is too much even for those
platforms which are able to provide WCLK before calling snd_soc_dai_set_pll()
function but it relies on your HW team to provide the number.

On KBL platform we have interface to control MCLK and I2S clocks like the link
you mentioned but WCLK seems not working on my board. I can try to ask if
someone is working on it but since we are moving to SOF. The chance is slim for
legacy firmware.


Regards,
Brent

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
