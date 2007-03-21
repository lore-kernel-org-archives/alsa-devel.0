From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: Re: [Alsa-devel] Quality resampling code for libasound
Date: Thu, 22 Mar 2007 02:34:31 +1100
Message-ID: <46015087.6090003@usherbrooke.ca>
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
	<s5hmz26buws.wl%tiwai@suse.de> <46014EDE.6090700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from idefix.homelinux.org (142.163.233.220.exetel.com.au
	[220.233.163.142])
	by alsa0.perex.cz (Postfix) with ESMTP id CC31E243C7
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2007 16:34:32 +0100 (CET)
In-Reply-To: <46014EDE.6090700@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel@alsa-project.org, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

> Users of these distributions would then have to be fairly familiar with
> alsa to know they could improve sound by recompiling alsa-lib against
> the speex libraries, but given that it's (also) dirt cheap soundcards
> that need the resampling, their users aren't too likely to _be_ fairly
> familiar. They'd just observe (still) that their sound is "much better
> on windows".

Oh, I meant using a copy of the pph code in the mean time, not the
current linear interpolation resampler.

> If the standard code is as lousy as I've read in this thread, keeping it
> as default is probably not the best thing.

It's worse than you think :-) Try playing an 8 kHz file to a soundcard
that only does 44.1/48. It's just horrible.

	Jean-Marc
