From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: Auto detection of sound cards.
Date: Mon, 11 Feb 2002 14:32:02 -0000
Message-ID: <NGBBLNODKDFPBFMBBFAFCEELCAAA.James@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <200202111357.IAA28135@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@Op.Net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >Hello
> >Most sound cards now are Plug-n-Play either ISA or PCI.
> >So at boot up, one should be able to determine which devices are
> installed
> >and automatically load the correct driver based on the PnP info.
> >
> >I think this would be very useful to have, because then people would not
> >have to know which sound card module they should be loading is.
> >E.g. That the "nVidia nForce sound" should use the intel8x0 driver.
> >The linux kernel with alsa should have already known this and
> selected the
> >correct driver automatically in much the same way windows 98 does.
>
> this is OK if there is only one audio interface in the machine. how do
> you propose to get this to work if there are multiple interfaces? what
> happens if the user has a preferred order?
>
> under windows (and macos), it appears to me that people always end up
> seeing the names of various audio interfaces in the applications they
> use. ALSA applications rarely present these names because it is
> entirely possible to be using a PCM device that is either a subset or
> a merger of multiple devices. We therefore leave the naming to
> whatever sets up ~/.asoundrc (or its system-wide equivalent). For this
> to work, there needs to be a set of well-defined names and/or
> installation order for each module that is loaded.
>
> remember: this is the *advanced* linux sound architecture, and we want
> to be able to handle multi-card systems just as well as the common
> case with just one.
>
> --p
>
It should be easy enough with multiple interfaces.
The auto-detection code would run at start up, and find that we have 2 audio
cards.
It will first check modules.conf to see if two audio cards are already
mentioned and see if they are the correct ones.
If the alias info is already in modules.conf, don't touch it. If the info is
not in modules.conf, add it.
As long as all the card specific modules are listed in the modules.conf
file, it does not matter which sound-slot-X they are aliased with.
The auto-detection code is not there to set the order of the cards, it is
just to automatically add lines in modules.conf if the card specific alias
lines are not present.

It is then up to the user to go into modules.conf and reverse the order of
the alias commands if they wish, and the auto-detection code will leave it
as it is.

I would like this to happen for alsa sound cards, as well as hisax isdn
cards.
I am sure that there are many other devices in linux where an auto-detection
program would be handy to add the correct info in modules.conf.
I think "kudzu" does something, but I don't know what exactly it does.

Cheers
James


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
