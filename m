From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Please explain Alsa Interface MIDI numbering PLEASE!
Date: Sun, 16 Feb 2003 15:03:34 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGCEBIBHAB.mknecht@controlnet.com>
References: <200302162133.37007.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200302162133.37007.plcl@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>, Rosegarden-Devel <rosegarden-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Pedro,
   Is there any online information about how to use Midiman's firmware?
Thanks,
Mark

-----Original Message-----
From: alsa-devel-admin@lists.sourceforge.net
[mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Pedro
Lopez-Cabanillas
Sent: Sunday, February 16, 2003 12:34 PM
To: Mark Knecht
Cc: Alsa-Devel; Rosegarden-Devel; Fernando Pablo Lopez-Lezcano
Subject: Re: [Alsa-devel] Please explain Alsa Interface MIDI numbering
PLEASE!


On Sunday 16 February 2003 20:46, Mark Knecht wrote:
> Pedro,
>    I run on the PlanetCCRMA flow. My current Alsa appears to be from
> 1/21/03, or about a month ago. Was rc7 after that?
>

Yes, 0.9.0rc7 is dated 2003-01-28
PlanetCCRMA's ALSA drivers came from a CVS snapshot taken at 2003-01-21
The bug was introduced at 2003-01-10

So, you should use current CVS driver, or wait for a PlanetCCRMA update, or
use Midiman's firmware. For other USB MIDI fully compliant devices, like
Evolution's keyboards, a fixed driver is needed.

Regards,
Pedro

> On Sun, 2003-02-16 at 11:43, Pedro Lopez-Cabanillas wrote:
> > On Sunday 16 February 2003 19:53, Mark Knecht wrote:
> > > 2) In the screen shot "with_2x2.png" I've plugged in the MidiSport
2x2.
> > > New devices show up in kaconnect. However, instead of showing 2 read
> > > ports and 2 write ports, I am getting 4 read ports and no write ports.
> > > Please explain why the MidiSport is given the names
> > >
> > > 72:0 External MIDI 1
> > > 72:1 External MIDI 1
> > > 72:2 External MIDI 1
> > > 72:3 External MIDI 1
> > >
> > > Shouldn't this be just :0 and :1 for both the read and write ports?
> >
> > Yes. This was a bug in snd-usb-audio for 0.9.0rc7, fixed now in ALSA
CVS,
> > see:
> >
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg06225.htm
> >l
> >
> > Regards,
> > Pedro

--
ALSA Library Bindings for Pascal
http://alsapas.alturl.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
