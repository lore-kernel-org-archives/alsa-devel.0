From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: Re: [Alsa-devel] Quality resampling code for libasound
Date: Thu, 22 Mar 2007 00:39:44 +1100
Message-ID: <460135A0.20903@usherbrooke.ca>
References: <45D92131.50601@usherbrooke.ca>	<s5hirdy72ue.wl%tiwai@suse.de>	<45D99DF7.90204@usherbrooke.ca>	<s5hhcti70pa.wl%tiwai@suse.de>	<45D9A848.9040803@usherbrooke.ca>	<s5h7iue6yyi.wl%tiwai@suse.de>	<45DA8CD2.1040606@usherbrooke.ca>	<s5hps85rtsr.wl%tiwai@suse.de>	<45DAE188.6010405@usherbrooke.ca>	<s5hfy91rprn.wl%tiwai@suse.de>	<45DAEBB8.70808@usherbrooke.ca>	<45DB713F.9090804@superbug.co.uk>	<45DC0E52.1060805@usherbrooke.ca>	<s5hodnm7774.wl%tiwai@suse.de>	<45DD8329.6080809@usherbrooke.ca>	<s5hlkiq75up.wl%tiwai@suse.de>	<45E4E4A5.6020405@usherbrooke.ca>	<s5hhcswbsj4.wl%tiwai@suse.de>	<45EF5FE1.5080407@usherbrooke.ca>	<s5hy7m6h01e.wl%tiwai@suse.de>	<45FFE014.1080100@usherbrooke.ca>	<s5hodmoc99l.wl%tiwai@suse.de>	<45FFEAA9.4040606@usherbrooke.ca>	<s5hlkhsc812.wl%tiwai@suse.de>	<4600539A.2070804@usherbrooke.ca>	<s5hslbyc02f.wl%tiwai@suse.de>	<46012E39.3020201@usherbrooke.ca>
	<s5hmz26buws.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from idefix.homelinux.org (142.163.233.220.exetel.com.au
	[220.233.163.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A4922437C
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2007 14:39:46 +0100 (CET)
In-Reply-To: <s5hmz26buws.wl%tiwai@suse.de>
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

> Yeah, this is an interesting question.  We often see similar conflicts
> in the maintenance of linux kernel tree, too.  The unified coding
> style gives clearly better readability of the whole tree.  OTOH, if a
> code chunk is derived from another tree, it requires more additional
> backport effort.

I think the main question is: do you plan on making many alsa-specific
changes to that code? resampler.c is pretty much as close as you get to
pure signal processing code (no "system" stuff), so I don't think many
people will actually want to mess with it and any improvements might as
well be merged in Speex first to be tested for a while. Of course, if
the coding rules are simple, an other approach could be to automatically
re-indent the code when syncing. Of course, it still means you need to
keep the same code as Speex has. In any case, I'd recommend not forking
that code too early because some of the planned improvements (e.g. SSE
optimisations) could be a pain to backport.

> In the ideal situation, we may link to speex resampler as a dynamic
> library -- e.g. adding a configure option to let user choose the
> built-in or system-wide library resampler code.  Does libspeex provide
> this code snip as exported?

Not sure I understand what you mean here. If you're asking whether the
symbols for the resampler are exported in the shared library, then the
answer is yes -- though the resampler is only in the svn version of
Speex for now. The first release to include it will be 1.2beta2, which
I'm planning to release in a few weeks.

	Jean-Marc
