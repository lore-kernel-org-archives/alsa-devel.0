From: Matthew Clarke <Matthew_Clarke@mindlink.bc.ca>
Subject: Re: problems compiling current CVS
Date: Mon, 2 Jun 2003 21:20:10 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030603042010.GB30228@ds0.van.maves.ca>
References: <200306022308.h52N8ZT20263@linuxaudiosystems.com> <20030603031534.GA27280@ds0.van.maves.ca> <20030603034728.GA29666@ds0.van.maves.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030603034728.GA29666@ds0.van.maves.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hmph.  My SMTP server is not an open relay or a spam source, even if it
is in an ADSL dynamic IP address pool, thank you very much.  <bleep>ing
spammers.

Let's try sending this to alsa-devel again ...

I wrote:

> lundi, le 2 juin, 2003, Paul Davis nous a dit ceci:
> 
> > this is with CVS as of this morning (US EST), trying to build alsa-driver
> > outside a 2.4.20 kernel using:
> > 
> >         ./cvscompile --with-oss=yes --with-sequencer=yes --with-cards=rme9652,hd
> > sp,trident
> > 
> >   [ ... ]
> > 
> > ake[2]: Entering directory `/usr/local/music/src/alsa-cvs/newer/alsa-driver/acor
> > e/ioctl32'
> > make[2]: Leaving directory `/usr/local/music/src/alsa-cvs/newer/alsa-driver/acor
> > e/ioctl32'
> > make  -C oss fastdep
> > make[2]: Entering directory `/usr/local/music/src/alsa-cvs/newer/alsa-driver/aco
> > re/oss'
> > /bin/sh: ${xtmp:0:5}: bad substitution
> 
> Hmph.  This syntax is in configure now too.
> 
> This bit:  
> 
>         ${xtmp:0:5}
> 
> is a Bash-ism.  Normal Bourne shells don't understand this.  I'm guessing
> that your system's /bin/sh isn't Bash.  You might be able to put a 
> 
>         SHELL=/bin/bash
> 
> line into alsa-driver/acore/oss/Makefile right before the include of
> $(TOPDIR)/Rules.make.  (I say "might" because I can't build ALSA right now
> due to a (real) kernel compiler / system compiler mismatch.)
> 
> Alternatively, if you have root, you could temporarily replace /bin/sh
> with a symlink to /bin/bash, build, then restore /bin/sh.
> 
> Matt.
> -- 
> For a successful technology, reality must take precedence over public
> relations, for nature cannot be fooled.
> 				-- Richard P. Feynman


-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
