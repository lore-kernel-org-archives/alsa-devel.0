Return-Path: <SRS0=P2CN=XW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06B7C4360C
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:10:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D2D2146E
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IedoB9th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D2D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A280215E4;
	Fri, 27 Sep 2019 16:10:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A280215E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569593451;
	bh=Z9Kwz+mVtpx3Rw/C4Xz5VCMzJE86j+4sL3FxPbDtg+A=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IedoB9thyBhlRtusE7XJR+/hdbVCzf4bq7xLwFOT3uzEdvRlWd12L76VijKE5NtjX
	 84TmB/TuioNNHTg5Olc8vJFIAXYNBN4uaBmPZlJTYLY2Fv/9jHoxyGLzYUem9Nrjlf
	 3GbIsSRM5mdC7MbxlLx51Tx4+2tCcNCpTSm4GdoU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29632F8044C;
	Fri, 27 Sep 2019 16:10:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4F2BF8049A; Fri, 27 Sep 2019 16:09:59 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0526F80138
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2019 16:09:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0526F80138
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Sep 2019 07:09:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,555,1559545200"; d="scan'208";a="193232600"
Received: from kekkonen.fi.intel.com ([10.237.72.156])
 by orsmga003.jf.intel.com with ESMTP; 27 Sep 2019 07:09:51 -0700
Message-ID: <1569592832.43188.21.camel@linux.intel.com>
From: Jaska Uimonen <jaska.uimonen@linux.intel.com>
To: Jaroslav Kysela <perex@perex.cz>, Pierre-Louis Bossart
 <pierre-louis.bossart@linux.intel.com>, Mark Pearson <mpearson@lenovo.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Elimar
 Riesebieter <riesebie@lxtec.de>
Date: Fri, 27 Sep 2019 17:00:32 +0300
In-Reply-To: <71636f27-3dd6-6236-f025-13dc465d06ae@perex.cz>
References: <20190919142329.35bsdnh5skuj7jl3@toy.home.lxtec.de>
 <853b3859-8c8e-1c52-becb-3807d351b8f1@linux.intel.com>
 <f11c5347d8504148a47fdbc48d920f59@lenovo.com>
 <98b99cea-9be1-f232-f62c-1f0b7a10e295@linux.intel.com>
 <38abcb71-3041-7015-e56a-43f628b2faf1@perex.cz>
 <1569578841.43188.16.camel@linux.intel.com>
 <71636f27-3dd6-6236-f025-13dc465d06ae@perex.cz>
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Subject: Re: [alsa-devel] [External] Re: alsa-lib: Add ucm support for
 whiskeylake sof-skl_hda_card audio
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

On Fri, 2019-09-27 at 12:57 +0200, Jaroslav Kysela wrote:
> Dne 27. 09. 19 v 12:07 Jaska Uimonen napsal(a):
> > On Tue, 2019-09-24 at 13:53 +0200, Jaroslav Kysela wrote:
> > > Dne 19. 09. 19 v 17:15 Pierre-Louis Bossart napsal(a):
> > > > On 9/19/19 9:54 AM, Mark Pearson wrote:
> > > > > > 
> > > > > > Indeed UCM is required for all cases where SOF and
> > > > > > PulseAudio
> > > > > > are used.
> > > > > > 
> > > > > > Our thinking was however to add this UCM file to the new
> > > > > > repository outside
> > > > > > of alsa-lib [1]. There is an on-going thread started by
> > > > > > Jaroslav to move those
> > > > > > files and relicense them as BSD-3-Clause [2]
> > > > > > 
> > > > > > [1]
> > > > > > https://mailman.alsa-project.org/pipermail/alsa-devel/2019-
> > > > > > July/153257.html
> > > > > > [2]
> > > > > > https://mailman.alsa-project.org/pipermail/alsa-devel/2019-
> > > > > > September/155246.html
> > > > > 
> > > > > Thanks Pierre.
> > > > > 
> > > > > Do we have any approximate timelines on when and how this
> > > > > will
> > > > > happen? (I'm new to this)
> > > > > 
> > > > > One of my main aims is that we have a customer using Debian
> > > > > and
> > > > > one of our platforms that require this change - I need to
> > > > > make
> > > > > sure I understand how this would roll out and what actions
> > > > > they
> > > > > need to take in the meantime if it's not going to be
> > > > > available in
> > > > > Debian.
> > > > 
> > > > I think the first order would be to have the file cleaned-up,
> > > > with
> > > > its 
> > > > Intel origin clearly stated with a signed-off-by tag.
> > > > 
> > > > Then once this is done, the Debian package creation needs to be
> > > > handled 
> > > > (using either the ALSA repo or the cloned version on SOF
> > > > GitHub).
> > > > I 
> > > > don't have any experience with Debian packages so can't really
> > > > comment 
> > > > on the effort it would take.
> > > 
> > > I did some cleanups here:
> > > 
> > > https://github.com/alsa-project/alsa-ucm-conf/commit/f796f0852a09
> > > 7e23
> > > 8fa9f5efb174e95b5ee6c8b7
> > > 
> > > Pierre, could you confirm the original source and are you ok with
> > > that?
> > 
> > Cleanup looks fine to me, we should add still UCM "PlaybackVolume"
> > and
> > "CaptureVolume" settings, because otherwise Pulseaudio will use SW
> > volume only. This will make for example HDA led quirks useless...
> > (and actually CaptureVolume and PlaybackVolume in pulseaudio ucm
> > support is still not integrated, hopefully soon). Defining Capture
> > and
> > PlaybackVolume should not do any harm currently for user space.
> > 
> > I can do that, Jaroslav you want PR against github or patches here 
> > to mailing list?
> 
> As you wish. Both ways are acceptable for me. Note that I did another
> cleanup
> for 'Bass Speaker' for Carbon X1 7th and merged 'import' branch to
> 'master'
> branch on github (so do the PR against master, if you like).
> 
> 				Thanks,
> 					Jaroslav
> 

I made now:
https://github.com/alsa-project/alsa-ucm-conf/pull/1
and
https://github.com/alsa-project/alsa-ucm-conf/pull/2

It would be good if Lenovo and Canonical folks also check these.

I'm testing this in Dell device with Ubuntu and twiddling outputs 
and volumes/mutes from UI. PR 2 is assuming Pulseaudio HW control, 
so not sure if the changes bad without it. 

br,
Jaska 



_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
