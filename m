Return-Path: <SRS0=cEba=4V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4556FC3F2CE
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 17:18:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C625C24654
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 17:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jfYODVLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C625C24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15428836;
	Wed,  4 Mar 2020 18:17:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15428836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583342321;
	bh=oYWQ4UIvnBD6Qb/COEUptjY6uiJLmBC6B5sMcgo83Os=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jfYODVLPH1nq/HevWZXdIJrFW8UfrbvJjIjA/wxJpEa3/x37w1PD7rgeuYXp75f6U
	 fy1MYWSKR16g1+6/I+3O5O5QSZKCpYueOSL89kXRLlR8wqatLdBMpqnzSKzn6IhbTM
	 5APSz1nZuok1/godrYcXPceGHleZft38PmDjjHzQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B8D6F801EC;
	Wed,  4 Mar 2020 18:17:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D20DBF801ED; Wed,  4 Mar 2020 18:17:49 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 787ACF8011C
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2020 18:17:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 787ACF8011C
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Mar 2020 09:17:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; d="scan'208";a="387225105"
Received: from hhartana-mobl3.amr.corp.intel.com (HELO [10.251.140.18])
 ([10.251.140.18])
 by orsmga004.jf.intel.com with ESMTP; 04 Mar 2020 09:17:41 -0800
Subject: Re: 5.5.y - apply "ASoC: intel/skl/hda - export number of digital
 microphones via control components"
To: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>
References: <147efa37-eb57-7f17-b9eb-84a9fe5ad475@perex.cz>
 <20200304154450.GB5646@sirena.org.uk>
 <a6d57c14-0794-77d0-5c6f-c0c897d254b5@perex.cz>
 <20200304160916.GC5646@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <44cf4ff8-120f-79fd-8801-47807b03f912@linux.intel.com>
Date: Wed, 4 Mar 2020 11:17:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304160916.GC5646@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Sasha Levin <sashal@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>, stable@vger.kernel.org
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


>>> This looks more like a new feature than a bug fix and I've been trying
>>> to get the stable people to calm down with the backports, there's been
>>> *far* too many regressions introduced recently in just the x86 stuff
>>> found after the fact.  Does this fix systems that used to work?
> 
>> The released ALSA UCM does not work correctly for some platforms without
>> this information (the number of digital microphones is not identified
>> correctly).
> 
> That's not the question I asked - have these platforms ever worked with
> older kernel versions?

Yes in that digital microphones have been enabled for a very long time 
(5.2 if I am not mistaken).

No in that the automatic selection of the SOF driver was only enabled 
for v5.5. In other words before 5.5 the user or distro needed to 
blacklist the legacy snd-hda-intel HDAudio driver to get DMICs to work.

This patch also removes the need for userspace configuration, pulseaudio 
now directly receives the information on the number of microphones. It 
was provided days after the merge window was opened, but the intent was 
that v5.5 was the first release where users don't need to muck with 
configuration files.

>> The regression probability is really low for this one and we're using it in
>> Fedora kernels for months without issues (in this code).
> 
> It's partly the principle of the thing, if it were just patches that
> had individually been identified as being good for stable by someone
> with some understanding of the code (like this one :/ ) that were being
> backported I'd be a lot less concerned but the automated selections are
> missing dependencies or other context and people are reporting problems
> with them so I'm inclined to push back on things.

You are correct that the process can appear confusing, mainly since the 
initial patch was contributed after the merge window on November 26.

Looking back at the emails, I didn't see any objections but somehow the 
patch never landed in 5.5 updates. Jaroslav's intentions and work are 
not without merit, we really appreciate his ucm2 work, and I support 
this integration on v5.5-y to make the life of downstream distros simpler.

Would it help if we provide a Tested-by tag with 5.5-y + this patch applied?

Thanks
-Pierre
