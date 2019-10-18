Return-Path: <SRS0=bEgE=YL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B80BCA9EA0
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 19:36:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A11D20820
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 19:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bvByGsD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A11D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA8384E;
	Fri, 18 Oct 2019 21:35:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA8384E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571427364;
	bh=+o4+G2ImVPgUqp41amrVhREkfonS+6Y0qCagCiwwT14=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bvByGsD2/u6udn45bnUWIBb4vkM0BSNV7b4k5XW12lomqGOZQw8MYokCRgqAdIaH7
	 Q3LJ4YN+s22Gdldb8egVPAhKwY5Opzl4lYJgLzDTiQ4Nr8eccp4JuaK5MkgfcELyMy
	 fnwY/wTo3v1jJyMtfSJB2gGS3wLa0ob9L2/38GOw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 099D8F80323;
	Fri, 18 Oct 2019 21:35:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1878AF80362; Fri, 18 Oct 2019 21:35:11 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B39DF800D0
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 21:35:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B39DF800D0
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Oct 2019 12:35:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,312,1566889200"; d="scan'208";a="396726571"
Received: from linux.intel.com ([10.54.29.200])
 by fmsmga005.fm.intel.com with ESMTP; 18 Oct 2019 12:35:01 -0700
Received: from pbossart-mac01.local (unknown [10.251.14.235])
 by linux.intel.com (Postfix) with ESMTP id EA4BF580107;
 Fri, 18 Oct 2019 12:35:00 -0700 (PDT)
To: sathya.prakash.m.r@intel.com, alsa-devel@alsa-project.org
References: <1569430624-30505-1-git-send-email-sathya.prakash.m.r@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <42d2eda2-b87d-ada5-122e-cf39c9d22f03@linux.intel.com>
Date: Fri, 18 Oct 2019 14:35:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1569430624-30505-1-git-send-email-sathya.prakash.m.r@intel.com>
Content-Language: en-US
Cc: tiwai@suse.de, naveen.m@intel.com, broonie@kernel.org
Subject: Re: [alsa-devel] [PATCH v4 0/2] Add CML M/C for RT5682 and RT1011
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 9/25/19 11:57 AM, sathya.prakash.m.r@intel.com wrote:
> From: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
> 
> The series adds CML m/c driver with RT5682 on SSP0 and
> RT1011 on SSP1.
> The RT1011 is smart AMP which supports 2 Whoofers and
> 2 tweeter support.
> RT5682 is headset codec supporting playback and record.
> The m/c supports HDMI playback and DMIC record.
> 
> Naveen Manohar (2):
>    ASoC: Intel: boards: Add CML m/c using RT1011 and RT5682
>    ASoC: Intel: Add acpi match for rt1011 based m/c driver
> 
>   sound/soc/intel/boards/Kconfig                    |  18 +
>   sound/soc/intel/boards/Makefile                   |   2 +
>   sound/soc/intel/boards/cml_rt1011_rt5682.c        | 473 ++++++++++++++++++++++
>   sound/soc/intel/common/soc-acpi-intel-cnl-match.c |   7 +
>   4 files changed, 500 insertions(+)
>   create mode 100644 sound/soc/intel/boards/cml_rt1011_rt5682.c
> 
> --
> V3 Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Mark, I noticed this morning while rebasing SOF on your tree that those 
two patches have not been merged.
Not sure if they were missed (the 4 versions were confusing), if you 
didn't see my Acked-by tag or if there was an objection?
No real urgency except for likely conflicts with Kai's work on the HDMI 
side if we delay, and I think Morimoto-san is also preparing additional 
nice simplifications for codec-dais.
Thanks and have a nice weekend.


> Changes from V3: repost with more recipients and edits to commit messages
> Changes from V2: re ordered match table
> to ensure non i2c device matches are at the end
> Changes from V1:
> Addressed comments on
> ASoC: Intel: boards: Add CML m/c using RT1011 and RT5682
> 1.9.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
