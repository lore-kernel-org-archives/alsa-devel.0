From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Miditech Midistart-2 USB keyboard
Date: Mon, 09 Aug 2004 12:50:07 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0408091246300.26596-100000@studcom.urz.uni-halle.de>
References: <20040809081925.GA2203@torni>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040809081925.GA2203@torni>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ville =?iso-8859-1?Q?P=E4tsi?= <drc@gimp.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ville P=E4tsi wrote:
> These 0.8K bytes were from Clemens Ladisch,
> > Ville P=E4tsi wrote:
> > >   idVendor           0x7104
> >
> > Miditech's vendor ID is 0x4752.
>
> Well then something fishy is going on, since the keyboard is report=
ing
> that on both computers I have,

Are you sure that this is the data of the keyboard?  Aren't there any
other devices in the lsusb output?

> and the windows driver has no problems.

mstart-2.inf from the miditech.de driver package says:
%USB\VID_4752&PID_0011.DeviceDesc%=3DMIDUSB.Dev, USB\VID_4752&PID_001=
1


Regards,
Clemens





-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
