From: Ross Miller <miller@penguinstation.net>
Subject: Re: AudioTrak Optoplay...
Date: Fri, 6 Jun 2003 00:34:53 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306060034.53324.miller@penguinstation.net>
References: <200306021418.26840.miller@penguinstation.net> <s5hisrmm2kx.wl@alsa2.suse.de>
Reply-To: miller@penguinstation.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hisrmm2kx.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 04 June 2003 06:47, Takashi Iwai wrote:

> a possible reason is that either we set up the interface correctly, or
> we pass too many packets for the requested status.
> i added nrpacks module option in usbaudio driver.  please set
> nrpacks=3D2 to reduce the max number of URB packets.
>
> the changes were committed to cvs now, so please give a try.
>
The changes you made allowed me to play sound through the device, but I=20
still get those usb-check-bandwidth messages, regardless of whether or no=
t=20
I used the "nrpacks=3D2" option for the snd-usb-audio module.  Is there=20
anything else we can try?  The driver is usable as-is, but all those=20
messages fill up the syslog pretty quick.

Also, although a volume control shows up in alsamixer (and that's all tha=
t=20
shows up in alsamixer) it doesn't seem to affect the sound coming out of=20
the optical port; it only controls sound coming out of the analog=20
headphone jack.  I don't know if this is a limitation of the hardware, or=
=20
if something in the software isn't getting set correctly.  It'd be nice t=
o=20
have a software volume control for the optical out, though.

Thanks,
-Ross



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
