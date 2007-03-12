From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: [ibm-acpi-devel] Adding a alsa mixer interface to
	ibm-acpi
Date: Mon, 12 Mar 2007 17:00:38 -0500
Message-ID: <a728f9f90703121500p48c6ae4dje0c1db9a5b459e6d@mail.gmail.com>
References: <20070227015024.GF8154@thunk.org> <s5hd53kaf5r.wl%tiwai@suse.de>
	<41840b750703071512o1d171dfy9d2a615382e5e635@mail.gmail.com>
	<20070307234240.GA12070@khazad-dum.debian.net>
	<1173311709.4531.30.camel@razman.gruemaster.com>
	<20070308003806.GC12070@khazad-dum.debian.net>
	<s5htzwugz22.wl%tiwai@suse.de>
	<20070310035055.GB7606@khazad-dum.debian.net>
	<s5hwt1mr7ng.wl%tiwai@suse.de>
	<20070312210037.GA25991@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070312210037.GA25991@khazad-dum.debian.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Takashi Iwai <tiwai@suse.de>, ibm-acpi-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, Theodore Tso <tytso@mit.edu>
List-Id: alsa-devel@alsa-project.org

On 3/12/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> On Mon, 12 Mar 2007, Takashi Iwai wrote:
> > The problem I state here is only the usability.  The implementation is
> > no matter at all.  When you look at KDE/GNOME, you'll find that the
> > mixer applets really suck if you have multiple devices.  It's
>
> Then, it is time for them to fix their broken-as-designed applets.  ALSA has
> supported multiple devices since way too long for mixer applets to have any
> valid excuse to not handle multiple cards sanely.
>
> > especially confusing if the outputs from two different devices are
> > identical...
>
> So no two devices with the same control set.  That makes sense, and cuts
> down the choices a bit.
>
> Anyway, I thought about the issue for quite a while, and the above point
> about the KDE/GNONE applets and no duplication of controls just gave me the
> last pieces of the puzzle:
>
> 1. It *is* separate hardware, it has nothing to do with whatever might be
> the embedded soundcard and codecs, except that it sits between them and the
> speakers and line-out jacks.
>
> 2. It controls more than just the embedded soundcard, it also controls the
> PC squeaker (independently of the embedded soundcard being able to control
> that or not), and also the firmware ACPI/APM/alarm beep generator.
>
> Therefore, it should go in a different card.  That works just fine, it
> requires no new API in ALSA, it follows the kernel standard for these things
> (if it is a separate device, export it as a separate device), and it makes a
> lot more sense from the system's point of view.
>
> A non-broken ALSA mixer applet will just let you add itself twice to the
> applet bar: once to control the thinkpad mixer, and the other to control the
> embedded soundcard.  Or it will allow you to pick your favourite set of
> controls out of those available from every card in the system.
>
> The above makes too much sense.  I must have forgotten something, it can't
> be that simple.  Would someone be so kind and point out why the above will
> just not work well in real life?
>

I agree.  I think it makes sense to have it as a separate device.

Alex

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
