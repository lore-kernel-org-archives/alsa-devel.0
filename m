From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: Re: Tascam US-224 progress report (was:      USB224_usbsnoop1.log captured  on WinXP)
Date: Tue, 6 Apr 2004 14:53:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404061453.59766.annabellesgarden@yahoo.de>
References: <200404021434.26528.annabellesgarden@yahoo.de> <32796.192.168.1.5.1081210215.squirrel@www.rncbc.org> <200404061252.16279.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200404061252.16279.annabellesgarden@yahoo.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Dienstag 06 April 2004 12:52 schrieb Karsten Wiese:
> Am Dienstag 06 April 2004 02:10 schrieb Rui Nuno Capela:
> > Now comes the weird part. No, I couldn't get it to work unless I set
> > --with-debug=full on configure line. And I've tested several times,
> > believe me.
> >
> > FYI, I'm stick with 2.6 kernel tree, and already tested with 2.6.4 and
> > latest 2.6.5.
> >
> > My way of building the kernel modules is from stock tarball, and is
> > pretty canonical, as literally as follows (all as root):
> >
> >   tar -jxf alsa-driver-1.0.4.tar.bz2
> >   cd alsa-driver-1.0.4
> >   gzip -dc ../alsa-driver-1.0.4p1.patch.gz	# see attachment
> >   ./configure --with-isapnp=no --with-sequencer=yes --with-oss=yes
> > --with-cards=all --with-debug=full
> >   make
> >   make install
> >
> > As stated, the INPUT MONITOR LED does not get lit if I take out the
> > clause --with-debug=full.
> >
> > How come?
>
> You don't use --with-kernel option.
> Are you shure ALSA build sees the correct linux-kernel source?
> What distro are you using?
> On some (i.e. fc1) you'd have to specify a special gcc like
> 	export CC=gcc32
> befure ./configure.
> I'm building a no debug ALSA here with a 2.6.5-aa1 kernel.
> maybe I'll find something.....
Yes, same odd behavior here: built without --with-debug=full, 
nothing is sent from us428control to the us428. So your build process is 
propably ok.

Cheers,
Karsten


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
