From: iain@psand.net
Subject: Re: Re: hdspmixer issues
Date: Wed, 22 Sep 2004 20:13:21 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409222005050.2791@tallow.psand.net>
References: <Pine.LNX.4.58.0409202101350.2974@tallow.psand.net>
 <s5hk6uoylxb.wl@alsa2.suse.de> <Pine.LNX.4.58.0409221545340.2696@tallow.psand.net>
 <s5h3c1az6db.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3c1az6db.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 22 Sep 2004, Takashi Iwai wrote:

> At Wed, 22 Sep 2004 15:46:41 +0100 (BST),
> Iain Kennedy wrote:
> >
> > On Tue, 21 Sep 2004, Takashi Iwai wrote:
> >
> > > At Mon, 20 Sep 2004 21:09:18 +0100 (BST),
> > > Iain Kennedy wrote:
> > > >
> > > > > > I"ve been messing with hdsp (again :-) and found out that my hdspmixer
> > > > > > has very oddly behaving sound meters. While the input (2nd row)
> > > > > > appears to be more or less ok (the yellow peak things kind of fly all
> > > > > > over the place and often drop off below green lines or even completely
> > > > > > dissapear), the analog outputs as well as combined monitoring output
> > > > > > (front 1/4" phono jack on the multiface) only occassionally spike with
> > > > > > a line input (usually only one channel). I am wondering why this is so
> > > > > > since the audio is definitely working ok, but the monitoring of the
> > > > > > outputs simply isn"t working (at least not visually).
> > > > >
> > > > > i"ve been experiencing similar spikes on the analog outputs as ico
> > > > > described. since we had a somehow similar problem with screwed up pci
> > > > > cycles that was caused by incorrect initialisation of the cardbus briges
> > > > > on our machines, i somehow doubt that it"s related to the problem we
> > > > > had.
> > > >
> > > > > cheers...
> > > >
> > > > I've been experiencing lack of/sporadic metering on hdspmixer too..
> > > > I'm running Debian testing with kernel 2.6.8 (same effect with 2.6.3),
> > > > with both the debian alsa packages and a locally compiled latest alsa
> > > > version...
> > > >
> > > > I had no such problem using 2.4.xx series kernels, although I was using a
> > > > pre-1.06 version of the alsa drivers..
> > >
> > > Are you using ppc?  I found a bug in hdsp driver that it doesn't
> > > handle big-endian correctly in the metering mmap.
> > > Could you try the CVS version?
> > >
> > >
> > > Takashi
> > >
> >
> > I'm using intel architecture... (Inspiron 8500 with 2GHz P4 M)
> >
> > I've tried the CVS version, and still get the same results.
>
> How about the attached patch (to cvs) ?
>
>
> Takashi
>

OK, I'm not familiar with the build process for this yet, but I did the
following:

cd alsacvs
patch -p0 < path/to/patch.txt
cd alsa-driver
make clean
make
sudo make install

Rebooted...

And excellent stuff, I now get sane (looking) mixer levels all over the
place :)

Now that I can see the levels, I notice that all 8 analogue ins are
sitting at about  3/4 of the way up (showing about -6.60 variable) with
nothin plugged in to them... no audible noise coming through.. I guess
this is not related though... I'll investigate later.

Thanks very much indeed :)

Iain


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
