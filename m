Return-Path: <SRS0=BIVw=Y7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D70C5DF61
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:55:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F111521882
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tgpWFHQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F111521882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB5101667;
	Thu,  7 Nov 2019 12:54:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB5101667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573127711;
	bh=3c/5VuFOHpAoHZwcjvXxYWoJZYQkftxbYZ5Ldxwcd3c=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tgpWFHQQQdLajkOQdCzOEPGCtFlKHvdSzygRB+E1I7A+yD9lvajzl6KBmj8oAGpbx
	 zo+6HF5xGBPYHu54MskXMMxRrIZ1v7w5Hz0d7KCIzlXE2uSw3EQpUw31NM0/A4x3tz
	 kmm6gGVKEpLczE5L7FteuTY8H0h1lGHBDp/jffQQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 392EEF80446;
	Thu,  7 Nov 2019 12:54:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D6A1F8049B; Thu,  7 Nov 2019 12:54:19 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B80DF800F3
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2019 12:54:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B80DF800F3
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Nov 2019 03:54:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; d="scan'208";a="227805570"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by fmsmga004.fm.intel.com with ESMTP; 07 Nov 2019 03:54:10 -0800
Date: Thu, 7 Nov 2019 13:54:10 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <c53c36a7-bb55-abca-0e4f-9574d8fe3660@perex.cz>
Message-ID: <alpine.DEB.2.21.1911071326410.16459@zeliteleevi>
References: <6dcc3e0d-0df5-90cf-220f-59253d3b5c7c@perex.cz>
 <60c63704-44ce-d80b-ccbd-b23d748b009b@intel.com>
 <c53c36a7-bb55-abca-0e4f-9574d8fe3660@perex.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, Cezary Rojewski <cezary.rojewski@intel.com>,
 Mark Brown <broonie@kernel.org>,
 ALSA development <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [alsa-devel] UCM extensions
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

Hi,

On Thu, 7 Nov 2019, Jaroslav Kysela wrote:

> Dne 07. 11. 19 v 11:18 Cezary Rojewski napsal(a):
> > On 2019-11-05 20:36, Jaroslav Kysela wrote:
> > However, I have some concerns here. First, could you elaborate on "we
> > require for the SOF kernel driver"?
> 
> Please, look here:
> 
> https://github.com/alsa-project/alsa-ucm-conf/commit/a8253465aef2df494ccd5b1103412b0318be582e#diff-a2ba34aee1a55c2fd664d78624477173L37
> 
> The HDA driver sometimes manages different JackControl names depending on the 
> used codec and it would be the real maintenance mess to use the DMI info (long 
> card name) for all possible configurations.
> 
> Also, if you look to the current configs, many duplications can be removed 
> with the If evaluations.

yes, I agree with Jaroslav here. There's definitely the risk of making 
UCM files too complex, but pragmatically, we really need something between 
the current boolean choice between a generic UCM picked by card 
shortname and per-product tailored UCM'es picked up by card longname.

There's some variation in HDA codec controls that is more
convenient to hide in if-else logic in the generic UCM. Same goes 
for addition of controls to the kernel. Without conditional logic, using 
a newer UCM file with an older kernel simply breaks -- even if the change
is incremental only.

There was a discussion in the summer on the list about adding versions in 
kernel and using that to help pick the right UCM profile. This isn't an 
easy path either -- there are many components contributing to the 
overall card interface on kernel side, and you still need to pick (or 
compile at runtime) a single UCM file. It would seem with Jaroslav's 
current proposal, you could cover majority types of minor variations
and thus significantly limit the number of UCM files that need to be 
maintained.

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
