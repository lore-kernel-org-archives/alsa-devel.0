From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: Re: [Alsa-devel] Quality resampling code for libasound
Date: Thu, 22 Mar 2007 01:19:18 +1100
Message-ID: <46013EE6.4080006@usherbrooke.ca>
References: <45D92131.50601@usherbrooke.ca>	<s5hirdy72ue.wl%tiwai@suse.de>	<45D99DF7.90204@usherbrooke.ca>	<s5hhcti70pa.wl%tiwai@suse.de>	<45D9A848.9040803@usherbrooke.ca>	<s5h7iue6yyi.wl%tiwai@suse.de>	<45DA8CD2.1040606@usherbrooke.ca>	<s5hps85rtsr.wl%tiwai@suse.de>	<45DAE188.6010405@usherbrooke.ca>	<s5hfy91rprn.wl%tiwai@suse.de>	<45DAEBB8.70808@usherbrooke.ca>	<45DB713F.9090804@superbug.co.uk>	<45DC0E52.1060805@usherbrooke.ca>	<s5hodnm7774.wl%tiwai@suse.de>	<45DD8329.6080809@usherbrooke.ca>	<s5hlkiq75up.wl%tiwai@suse.de>	<45E4E4A5.6020405@usherbrooke.ca>	<s5hhcswbsj4.wl%tiwai@suse.de>	<45EF5FE1.5080407@usherbrooke.ca>	<s5hy7m6h01e.wl%tiwai@suse.de>	<45FFE014.1080100@usherbrooke.ca>	<s5hodmoc99l.wl%tiwai@suse.de>	<45FFEAA9.4040606@usherbrooke.ca>	<s5hlkhsc812.wl%tiwai@suse.de>	<4600539A.2070804@usherbrooke.ca>	<s5hslbyc02f.wl%tiwai@suse.de>	<46012E39.3020201@usherbrooke.ca>	<s5hmz26buws
 .wl%tiwai@suse.de>	<460135A0.20903@usherbrooke.ca>
	<s5hhcsebsua.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from idefix.homelinux.org (142.163.233.220.exetel.com.au
	[220.233.163.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 3528D243F2
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2007 15:19:20 +0100 (CET)
In-Reply-To: <s5hhcsebsua.wl%tiwai@suse.de>
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

> Yes (not alsa-specific but less speex-specific), 

Outside of the spx_int* types, what are the speex-specific bits that
bother you?

> once if it's merged
> to alsa-lib tree.  (The code can't be applied to the tree as it is,
> BTW, because it must be LGPL, as we discussed...)

Is a COPYING file OK or do you need headers (in which case, what's the
smallest header that can be added?)?

> Yes, but if the code is in another tree, it's actually a fork.
> Having codes that may be frequently changed in multiple places is
> already a risky action from the maintenance POV, regardless of the
> coding style.  That's what I'd like to avoid.

Then the solution would be to just copy from the Speex tree once in a
while and get the fixes there first. You can always have an automated
formatting tool that you run after importing a new version. Overall, I
really see no reason why you'd want to modify the resampler in the first
place -- other than fixing bugs, which should go in the Speex tree anyway.

	Jean-Marc
