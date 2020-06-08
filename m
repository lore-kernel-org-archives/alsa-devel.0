Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD334C433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:14:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352482063A
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dUlxYIU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352482063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A477715E2;
	Mon,  8 Jun 2020 18:13:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A477715E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591632845;
	bh=UXGCYA/wgHoaYGp8XiH6ZD+aiufpeWkA6t3NFGs5Soc=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dUlxYIU/5kJidXfE4GHeR07VrfqVfiizItQmrQTrkdpttjQ0Z+zAgW4+Dmkh6BaNS
	 g5/vwIPViF5VSmPYsjrBTpBuAXUrcBSmgyfc1SAaoleW+j90+ezS5/RGznXSxErNPY
	 9Q4xhhbm6alJKgdV7nmHP4Bm4OCTxKTjcRzqf9q0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B818BF80125;
	Mon,  8 Jun 2020 18:13:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8C93F8021C; Mon,  8 Jun 2020 18:13:12 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B400F80125
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 18:13:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B400F80125
IronPort-SDR: 89A3ecnEmaSJlH0pirEeGeltM2Of9eb1rxQGkmmILCFCIElTlwKPIGn46vST5EyiSdsLbI+e3u
 e/Q/dutUG5pg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2020 09:13:00 -0700
IronPort-SDR: 7HYIE2zVcBPLrCU2IXLFeSUaGEitbtp6H9liBvuvTkGsbxPnj655gAJjyFG/AY4WXevfJn4jvU
 2Oo0lDW2Uq8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; d="scan'208";a="446779802"
Received: from ravindra-mobl1.amr.corp.intel.com (HELO [10.251.13.163])
 ([10.251.13.163])
 by orsmga005.jf.intel.com with ESMTP; 08 Jun 2020 09:12:59 -0700
Subject: Re: SOF 1.5 release on FTP server
To: Paul Dann <pdgiddie@gmail.com>,
 ALSA development <alsa-devel@alsa-project.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
References: <CALZj-VpLECyDaBeHcowTnCcufLVaPyr7Xxii+PbkrwGn9kYU+w@mail.gmail.com>
 <bc8420df-3fbe-2d7c-3c3a-dcf7455eeca8@perex.cz>
 <CALZj-VoLtoNbPZ1evLYqTxEg7XaTiEjgdB+WLE7duLfxF2ohLA@mail.gmail.com>
 <15e6517a-6be2-d5cd-c5d7-37a5122bd96e@perex.cz>
 <alpine.DEB.2.21.2006011723250.3787@eliteleevi.tm.intel.com>
 <CALZj-VoJ0tMNyD6aZyLdBWYD3meWaqKjo-1wQww0wk1En2nqwQ@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3fea0c1d-9e85-2d84-d7bd-4e07a7d3496b@linux.intel.com>
Date: Mon, 8 Jun 2020 08:28:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALZj-VoJ0tMNyD6aZyLdBWYD3meWaqKjo-1wQww0wk1En2nqwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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



On 6/7/20 3:13 PM, Paul Dann wrote:
> On Mon, 1 Jun 2020 at 15:45, Kai Vehmanen <kai.vehmanen@linux.intel.com> wrote:
>> Paul, I can confirm the sof-bin is the definitive location to get
>> the SOF binaries.
> 
> Many thanks both for confirming the new source. I notice that the old
> FTP package contains the following .ri and .ldc files that are not
> present in the new Github repo:

It's a clean-up indeed.

> sof-hsw

No longer supported (and no commercial platforms known to use the DSP)

> sof-imx8

This would need to be provided by NXP. Each company is responsible for 
providing the firmware for their platforms.

> sof-jsl

Not fully supported upstream, but indeed we need to check this one. Liam?

> sof-kbl
> sof-skl

Not supported.

> sof-sue

I don't think this was ever supported outside of Intel

> I'd just like to double-check that shipping the new package without
> these files won't lead to reduced functionality?

we'll check this JSL (JasperLake) firmware but for existing platforms 
this looks fine.
