From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: Re: [Alsa-devel] Quality resampling code for libasound
Date: Thu, 22 Mar 2007 00:08:09 +1100
Message-ID: <46012E39.3020201@usherbrooke.ca>
References: <45D92131.50601@usherbrooke.ca>	<s5hirdy72ue.wl%tiwai@suse.de>	<45D99DF7.90204@usherbrooke.ca>	<s5hhcti70pa.wl%tiwai@suse.de>	<45D9A848.9040803@usherbrooke.ca>	<s5h7iue6yyi.wl%tiwai@suse.de>	<45DA8CD2.1040606@usherbrooke.ca>	<s5hps85rtsr.wl%tiwai@suse.de>	<45DAE188.6010405@usherbrooke.ca>	<s5hfy91rprn.wl%tiwai@suse.de>	<45DAEBB8.70808@usherbrooke.ca>	<45DB713F.9090804@superbug.co.uk>	<45DC0E52.1060805@usherbrooke.ca>	<s5hodnm7774.wl%tiwai@suse.de>	<45DD8329.6080809@usherbrooke.ca>	<s5hlkiq75up.wl%tiwai@suse.de>	<45E4E4A5.6020405@usherbrooke.ca>	<s5hhcswbsj4.wl%tiwai@suse.de>	<45EF5FE1.5080407@usherbrooke.ca>	<s5hy7m6h01e.wl%tiwai@suse.de>	<45FFE014.1080100@usherbrooke.ca>	<s5hodmoc99l.wl%tiwai@suse.de>	<45FFEAA9.4040606@usherbrooke.ca>	<s5hlkhsc812.wl%tiwai@suse.de>	<4600539A.2070804@usherbrooke.ca>
	<s5hslbyc02f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from idefix.homelinux.org (142.163.233.220.exetel.com.au
	[220.233.163.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 168C2243DD
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2007 14:08:12 +0100 (CET)
In-Reply-To: <s5hslbyc02f.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

> OK, as long as it's in alsa-plugins repository, I basically don't
> care.  But, for merging it to alsa-lib, I'd like to change the code
> very much (including coding-style unification).

Well, it's ultimately your call. For rate_speexrate.c, it really doesn't
matter what happens because that's the only place it's used. When it
comes to the resampler code itself, it depends on how you want to
maintain it. I'll be maintaining it from the Speex tree, so it you want
to change the style, you'll have to either "backport" improvements/fixes
(e.g. optimisations) or do the style change again every time you sync.
That is, unless you plan to do an alsa-specific fork of it. (I
personally think the simplest way would be not modify the core resampler
(resample.c and corresponding header files) and just sync with Speex
once in a while.

> Anyway, I applied your latest codes to HG tree now (with the removal
> of samplerate.h).  Thanks!

Thanks.

	Jean-Marc
