From: Kevin Puetz <puetzk@iastate.edu>
Subject: Re: Re: Phase Reversal on Santa Cruz (cs46xx)
Date: Mon, 18 Nov 2002 12:46:22 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211181246.22847.puetzk@iastate.edu>
References: <200211170056.11190.puetzk@iastate.edu> <200211172241.14373.puetzk@iastate.edu> <87n0o7hrvw.fsf@amanda.mallet-assembly.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from puetzk.stures.iastate.edu (mail@puetzk.student.iastate.edu [64.113.75.18])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA20867
	for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2002 19:46:54 +0100
In-Reply-To: <87n0o7hrvw.fsf@amanda.mallet-assembly.org>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michael Alan Dorman <mdorman@debian.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 18 November 2002 08:30, Michael Alan Dorman wrote:
> Kevin Puetz <puetzk@iastate.edu> writes:
> > Now, why in the world the santa cruz would be wired in such a way that
> > software which is fine on other cards would get one channel backwards on
> > it is an excellent question. Espescially when there is older software
> > that worked on all (though not so well, I definitely like having multiple
> > apps accessing it at once).
>
> It's not just the Santa Cruz, though---my IBM T22 laptop has the exact
> same problem.

bizzarre...

okay, well for any aRts/noatun users who'd like to a) test their card or b) 
get a temporary workaround, I'll upload my cheesy effect fikter, which will 
either make your sound much better or much worse :-).

http://ophelia.student.iastate.edu/~puetzk/arts_phaseinvert-0.5.tgz

standard autoconf/automake setup for kde3, no docs :-)
After installing it into your KDE prefix noatun should show 
Synth_STEREO_PHASEINVERSION as a choice in it's effects config dialog.

> Mike.
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by: To learn the basics of securing
> your web site with SSL, click here to get a FREE TRIAL of a Thawte
> Server Certificate: http://www.gothawte.com/rd524.html
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
