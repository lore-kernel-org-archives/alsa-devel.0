From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [Alsa-devel] Quality resampling code for libasound
Date: Wed, 21 Mar 2007 16:27:26 +0100
Message-ID: <46014EDE.6090700@gmail.com>
References: <45D92131.50601@usherbrooke.ca>
	<s5hirdy72ue.wl%tiwai@suse.de>	<45D99DF7.90204@usherbrooke.ca>
	<s5hhcti70pa.wl%tiwai@suse.de>	<45D9A848.9040803@usherbrooke.ca>
	<s5h7iue6yyi.wl%tiwai@suse.de>	<45DA8CD2.1040606@usherbrooke.ca>
	<s5hps85rtsr.wl%tiwai@suse.de>	<45DAE188.6010405@usherbrooke.ca>
	<s5hfy91rprn.wl%tiwai@suse.de>	<45DAEBB8.70808@usherbrooke.ca>
	<45DB713F.9090804@superbug.co.uk>	<45DC0E52.1060805@usherbrooke.ca>
	<s5hodnm7774.wl%tiwai@suse.de>	<45DD8329.6080809@usherbrooke.ca>
	<s5hlkiq75up.wl%tiwai@suse.de>	<45E4E4A5.6020405@usherbrooke.ca>
	<s5hhcswbsj4.wl%tiwai@suse.de>	<45EF5FE1.5080407@usherbrooke.ca>
	<s5hy7m6h01e.wl%tiwai@suse.de>	<45FFE014.1080100@usherbrooke.ca>
	<s5hodmoc99l.wl%tiwai@suse.de>	<45FFEAA9.4040606@usherbrooke.ca>
	<s5hlkhsc812.wl%tiwai@suse.de>	<4600539A.2070804@usherbrooke.ca>
	<s5hslbyc02f.wl%tiwai@suse.de>	<46012E39.3020201@usherbrooke.ca>
	<s5hmz26buws.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 227EC24405
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2007 16:28:26 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, James Courtier-Dutton <James@superbug.co.uk>, Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
List-Id: alsa-devel@alsa-project.org

On 03/21/2007 02:14 PM, Takashi Iwai wrote:

> In the ideal situation, we may link to speex resampler as a dynamic 
> library -- e.g. adding a configure option to let user choose the 
> built-in or system-wide library resampler code.  Does libspeex
> provide this code snip as exported?

There's one problem with that solution though; people generally don't 
compile and install alsa-lib themselves these days and since 
distributions may not be too keen on having their alsa-lib package 
dependent on their speex package they might just compile with the 
builtin code.

Users of these distributions would then have to be fairly familiar with 
alsa to know they could improve sound by recompiling alsa-lib against 
the speex libraries, but given that it's (also) dirt cheap soundcards 
that need the resampling, their users aren't too likely to _be_ fairly 
familiar. They'd just observe (still) that their sound is "much better 
on windows".

If the standard code is as lousy as I've read in this thread, keeping it 
as default is probably not the best thing.

Rene.
