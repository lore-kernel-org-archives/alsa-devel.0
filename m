From: Jaakko =?iso-8859-1?q?Pr=E4tt=E4l=E4?=
	<Jaakko.Prattala@Helsinki.FI>
Subject: Re: still losing with hdsp (me too)
Date: Tue, 3 Jun 2003 14:13:13 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306031413.13936.Jaakko.Prattala@Helsinki.FI>
References: <50411.24.225.156.130.1054593994.squirrel@webmail.ouroboros-complex.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <50411.24.225.156.130.1054593994.squirrel@webmail.ouroboros-complex.org>
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

On Tuesday 03 June 2003 01:46, jfm3@ouroboros-complex.org wrote:

> lspci -vvv output is attached.
> I bought the hdsp and multiface recently. It might have the dreaded
> version 11 firmware.

Xilinx Corporation RME Hammerfall DSP (rev 0b)
0b hexadecimal =3D=3D 11 decimal
so, you have revision 11 firmware...

This looks like the problem I'm having that didn't go away by
downgrading the firmware. Then again, I'm using the cardbus interface.
Anyway, rev 10 firmware gets loaded and rev 11 doesn't. So
maybe try downgrading?

######## the (me too) part: ####################

Sorry to burn the devel-list bandwidth again.
I'm still wishing that somewhere I'd get a hint of what's
going on with my system. (The snd-hdsp module locks up
when I try to use it. Start aplay or pd and wind up with a module
that can't be rmmod'ed because of "device or resource busy".)
I'd try fixing the code if I could
pinpoint the bug. As for now I don't know if it's alsa, pcmcia or
pci code that hates my hardware.

David Hinds of the pcmcia-cs project tells me that I should
use the kernel pcmcia and ask you, alsa-developers,
and as I'm still stuck, here I am, asking:

1. What do you reckon that hdsploader ioctl error is?
    (iirc it comes even when the fw gets loaded...)
2. What could cause the module lock-up?

In other words:
- where should I look for the nastiness and
- what could I do to narrow down the set of possible
  places too look.

I'm using alsa from cvs (last update on 18th of May)
on a hp xe4100 laptop with all sorts of kernels,
mostly 2.4.20 with acpi patches.

--=20
Jaakko Pr=E4tt=E4l=E4
Jaakko.Prattala@Helsinki.FI



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
