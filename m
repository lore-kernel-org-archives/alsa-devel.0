From: Martin Langer <martin-langer@gmx.de>
Subject: Re: usx2y dependencies
Date: Tue, 27 Jan 2004 00:07:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040126230743.GA681@tuba.home>
References: <20040124002328.GA1946@tuba.home> <s5hy8rvui3n.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hy8rvui3n.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, annabellesgarden@yahoo.de
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 26, 2004 at 11:20:12AM +0100, Takashi Iwai wrote:
> At Sat, 24 Jan 2004 01:23:28 +0100,
> Martin Langer wrote:
> > 
> > usx2y build by "./configure --with-cards=usb-usx2y" has a dependency problem:
> > 
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.23/kernel/sound/usb/usx2y/snd-usb-usx2y.o
> > depmod:         snd_usbmidi_disconnect_Rc1a56322
> > depmod:         snd_hack_usb_set_interface_R5b6905b8
> > depmod:         snd_usb_create_midi_interface_R5a5eff3a
> > 
> > ./configure --with-cards=usb-usx2y,usb-audio fix this problem, but OTOH it
> > looks fine in /alsa-driver/utils/Modules.dep -- usx2y depends there on 
> > snd-usb-audio and that seems to be ok.
> > 
> > Any hints?
> 
> try the attached patch.
> 

It's perfect :) Please commit it.

martin


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
