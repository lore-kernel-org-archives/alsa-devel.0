From: Kevin Puetz <puetzk@iastate.edu>
Subject: Re: Re: Phase Reversal on Santa Cruz (cs46xx)
Date: Tue, 19 Nov 2002 00:29:34 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211190029.34321.puetzk@iastate.edu>
References: <200211170056.11190.puetzk@iastate.edu> <200211181246.22847.puetzk@iastate.edu> <200211182300.16367.gte733z@prism.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from puetzk.stures.iastate.edu (mail@puetzk.student.iastate.edu [64.113.75.18])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id HAA00840
	for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2002 07:29:57 +0100
In-Reply-To: <200211182300.16367.gte733z@prism.gatech.edu>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Weijia Yang <gte733z@prism.gatech.edu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 18 November 2002 22:00, Weijia Yang wrote:
> > okay, well for any aRts/noatun users who'd like to a) test their card or
> > b) get a temporary workaround, I'll upload my cheesy effect fikter, which
> > will either make your sound much better or much worse :-).
> >
> > http://ophelia.student.iastate.edu/~puetzk/arts_phaseinvert-0.5.tgz
> >
> > standard autoconf/automake setup for kde3, no docs :-)
> > After installing it into your KDE prefix noatun should show
> > Synth_STEREO_PHASEINVERSION as a choice in it's effects config dialog.
> >
> > > Mike.
>
> I am not quite sure how to go about compiling this effects plugin.  Could
> you give me a short rundown? Thanks
>
> Weijia Yang

Alright, standard kde autoconf directions as follows :-P

you will need a recent version of autotools (automake, autoconf, autoheader, 
etc), arts and kdelibs development headers from kde 3 (or 3.1) (ie, you need 
the -dev pacakges). That should be all... then

make -f Makefile.cvs
./configure --prefix=`kde-config --prefix`
make
make install

that should be all, it built here... what problem are you having specifically? 


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
