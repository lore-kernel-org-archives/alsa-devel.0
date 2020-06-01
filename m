Return-Path: <SRS0=kaWB=7O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D0C433E1
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:25:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B5720734
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S4UpTSvm";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="cZA2x+NC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B5720734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8DBF16D2;
	Mon,  1 Jun 2020 11:24:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8DBF16D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591003502;
	bh=DR2YWX2XmdBG5syKDin3tSDYWoRTYkckVRBnKSSVrZs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S4UpTSvmMZnvFajvopL+rfvXp39aZFO+9ofNZV5ng4ZCku25+Bhj0jyEz84qvtZJe
	 u4OfrorNEWoWyMqViYLuMjNhnyXypQWLbZXtIS48BqjzLlBTXMMdcIuDowMWIN8veM
	 5GatdTGGO3U2tJ+LcuKngYjjmnSEIN5TtBH+OmdY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75FA2F8013D;
	Mon,  1 Jun 2020 11:24:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A47FF801ED; Mon,  1 Jun 2020 11:24:09 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2239CF8013D
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2020 11:24:02 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 37D51A0042;
 Mon,  1 Jun 2020 11:24:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 37D51A0042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1591003440; bh=ObCprOSRPqhVQP5EtQGgP6WPu3oqMsLh1TMIhMPkgYY=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=cZA2x+NCaKpKeRuOT55h0pXEwQP3c2OAMM14tBGfpwaO4Fb0yYCHFA/fBYnw0mhOt
 1oqSkfy1sesaJwZiwOWQvCATF6PPMZDGpgLrI//6J1LHYk+fwqdoSiPP0aCR03Uy49
 pESeEpO+etVHr3tOmJLrNx2UlpX3KeZDgMeiSjKw=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  1 Jun 2020 11:23:57 +0200 (CEST)
Subject: Re: SOF 1.5 release on FTP server
To: Paul Dann <pdgiddie@gmail.com>
References: <CALZj-VpLECyDaBeHcowTnCcufLVaPyr7Xxii+PbkrwGn9kYU+w@mail.gmail.com>
 <bc8420df-3fbe-2d7c-3c3a-dcf7455eeca8@perex.cz>
 <CALZj-VoLtoNbPZ1evLYqTxEg7XaTiEjgdB+WLE7duLfxF2ohLA@mail.gmail.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <15e6517a-6be2-d5cd-c5d7-37a5122bd96e@perex.cz>
Date: Mon, 1 Jun 2020 11:23:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CALZj-VoLtoNbPZ1evLYqTxEg7XaTiEjgdB+WLE7duLfxF2ohLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Dne 01. 06. 20 v 10:14 Paul Dann napsal(a):
> On Mon, 1 Jun 2020 at 08:53, Jaroslav Kysela <perex@perex.cz> wrote:
>> I don't plan any new release on ALSA FTP. Intel releases signed firmware files
>> on github now:
>>
>> https://github.com/thesofproject/sof-bin
> 
> Hi Jaroslav; many thanks for the fast response. It does seem that the
> Github version is missing a number of files that are present in your
> FTP version. I'd just like to check this doesn't represent a loss of
> functionality?

My FTP packages also include all unsigned firmware files compiled with gcc. 
They are unusable for the most Intel platforms where only signed firmware 
files can be loaded to DSP (security).

Those files are probably good for the development platforms, but they do not 
have much value for the general Linux distros at the moment. I assume that 
developers can compile own versions.

BTW: Fixed topology files for v1.5 (generic sof hda):

https://www.alsa-project.org/files/pub/misc/sof/sof-bin-topology-1.5-dmic-20db-fix.tar.gz

Use this on top of the sof-bin repo / v1.5 branch if you like. It seems that 
the fix in sof-bin is delayed.

						Jaroslav

> 
> Many thanks again,
> Paul
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
