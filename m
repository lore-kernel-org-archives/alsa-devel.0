From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ALSA:ATMEL: common arch for audio via
	ssc(patch	3/3: adding directories)
Date: Fri, 26 Sep 2008 15:16:48 +0100
Message-ID: <20080926141646.GE15493@sirena.org.uk>
References: <48DCAA3A.8030209@atmel.com> <20080926125035.GB15493@sirena.org.uk>
	<48DCDC32.8060207@atmel.com> <20080926131528.GC15493@sirena.org.uk>
	<s5hmyhvav3r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6524D24343
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 16:16:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hmyhvav3r.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, Geoffrey Wossum <geoffrey@pager.net>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 26, 2008 at 03:35:04PM +0200, Takashi Iwai wrote:

> To be noted, git can handle renames well.  So, one commit should
> include both removal of at*/ and addition atmel/, instead of
> separating them, which breaks the history.

Yeah - I didn't mention this since I fear that it's going to break the
history anyway due to the merge, unfortunately.  There's quite a lot of
textual differences between the code for the two architectures that are
being merged, though mostly insubstantial ones.

If you do post everything as a single patch please use git format-patch
-M which will hopefully produce a much more legible patch for review.
If you're not using git to generate the patch then it might be best to
stick with submitting separately for ease of review.  In that case I
guess either myself or Takashi could squash the patches together in git
to try to preserve as much of the history as we can.
