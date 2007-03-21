From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: Re: [Alsa-devel] Quality resampling code for libasound
Date: Thu, 22 Mar 2007 02:17:56 +1100
Message-ID: <46014CA4.4080903@usherbrooke.ca>
References: <45D92131.50601@usherbrooke.ca>	<s5hhcti70pa.wl%tiwai@suse.de>	<45D9A848.9040803@usherbrooke.ca>	<s5h7iue6yyi.wl%tiwai@suse.de>	<45DA8CD2.1040606@usherbrooke.ca>	<s5hps85rtsr.wl%tiwai@suse.de>	<45DAE188.6010405@usherbrooke.ca>	<s5hfy91rprn.wl%tiwai@suse.de>	<45DAEBB8.70808@usherbrooke.ca>	<45DB713F.9090804@superbug.co.uk>	<45DC0E52.1060805@usherbrooke.ca>	<s5hodnm7774.wl%tiwai@suse.de>	<45DD8329.6080809@usherbrooke.ca>	<s5hlkiq75up.wl%tiwai@suse.de>	<45E4E4A5.6020405@usherbrooke.ca>	<s5hhcswbsj4.wl%tiwai@suse.de>	<45EF5FE1.5080407@usherbrooke.ca>	<s5hy7m6h01e.wl%tiwai@suse.de>	<45FFE014.1080100@usherbrooke.ca>	<s5hodmoc99l.wl%tiwai@suse.de>	<45FFEAA9.4040606@usherbrooke.ca>	<s5hlkhsc812.wl%tiwai@suse.de>	<4600539A.2070804@usherbrooke.ca>	<s5hslbyc02f.wl%tiwai@suse.de>	<46012E39.3020201@usherbrooke.ca>	<s5hmz26buws.wl%tiwai@suse.de>	<460135A0.20903@usherbrooke.ca>	<s5hhcsebsua
 .wl%tiwai@suse.de>	<46013EE6.4080006@usherbrooke.ca>
	<s5hbqimbqcn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from idefix.homelinux.org (142.163.233.220.exetel.com.au
	[220.233.163.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C8DD243FE
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2007 16:17:58 +0100 (CET)
In-Reply-To: <s5hbqimbqcn.wl%tiwai@suse.de>
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

> There are lots of macros in arch.h and speex_resampler.h, which try to
> absorb the difference from non-C99 and non-LP32 platforms.

Actually, most of the stuff in arch.h is designed to abstract the
operators so they can be defined for fixed-point or floating point (e.g.
spx_word32_t is defined either as float or as int depending on how you
compile). There's nothing about non-C99 stuff and the only non-LP32
stuff are the few spx_int* types.

> BTW, I'm not against these codes at all in general.  But, between
> speex and alsa-lib, the target is simply different.  Hence the code
> should be written in a different manner accordingly.

But is it worth increasing the maintenance overhead for code that may
never be modified directly in alsa. Note that I'm not talking about the
plugin code that uses the resampler here.

> Each file in pph/* contains the BSD headers, so we have to change them
> anyway.

Can't we just add a "Oh and BTW, you can also use it under the LGPL"
right after the BSD header. This is something I'd be willing to do in
the Speex tree. Apply a new license when syncing code seems like a bad
idea to me.

> IMO, it never worked well, looking at history.  For example, you can
> find a piece of zlib code everywhere, but they are not synchronized
> and well bugfixed (especially thinking of many security fixes in
> zlib).

Well, I can't really think of something better for now.

> The only working solution for synchronized source management is to use
> the shared library.

You could do that too, but it means you'll be forcing libspeex >
1.2beta2 onto all distributions. I don't mind because it should be quite
a good release, but maybe some will object. I'd suggest just doing a
copy in the short term and then move to the shared library when distros
have it.

	Jean-Marc
