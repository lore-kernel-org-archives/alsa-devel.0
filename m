From: Ross Miller <miller@penguinstation.net>
Subject: Re: AudioTrak Optoplay...
Date: Fri, 13 Jun 2003 00:22:45 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306130022.45973.miller@penguinstation.net>
References: <200306021418.26840.miller@penguinstation.net> <200306060034.53324.miller@penguinstation.net> <s5h3cinli1g.wl@alsa2.suse.de>
Reply-To: miller@penguinstation.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cinli1g.wl@alsa2.suse.de>
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

On Friday 06 June 2003 02:35, Takashi Iwai wrote:
> > > the changes were committed to cvs now, so please give a try.
> >
> > The changes you made allowed me to play sound through the device, but
> > I still get those usb-check-bandwidth messages, regardless of whether
> > or not I used the "nrpacks=3D2" option for the snd-usb-audio module. =
 Is
> > there anything else we can try?  The driver is usable as-is, but all
> > those messages fill up the syslog pretty quick.
>
> to be sure, please check /proc/asound/card0/stream0 while playback
> and how much URB packets are being used.
>

Sorry for the delay in getting back to you; work very rudely intruded on =
my=20
life last week..;)   Regarding your request, the relevant line from=20
stream0 looks like:
    URBs =3D 5 [ 2 2 2 2 2 ]

Without the nrpacks=3D2 option, the URB line looks like:
    URBs =3D 5 [ 4 4 4 4 4 ]

I should point out that things have apparently changed some in the last=20
week.  Using the code I checked out of CVS just a few hours ago, I no=20
longer get continuous messages in the syslog.  Instead I seem to get a fe=
w=20
lines of those usb-check-bandwidth messages each time a new song is loade=
d=20
by xmms.  Then, while the song is playing, I will get occasional breaks i=
n=20
the sound accompanied by a few messages in the syslog similar to the=20
following:

Jun 12 23:36:58 snoopy kernel: usb.c: usb-check-bandwidth would have=20
FAILED: was 912, would be 1140, bustime =3D 228 us
Jun 12 23:36:59 snoopy last message repeated 715 times
Jun 12 23:36:59 snoopy kernel: usb-uhci.c: iso_find_start: gap in seamles=
s=20
isochronous scheduling
Jun 12 23:36:59 snoopy kernel: usb.c: usb-check-bandwidth would have=20
FAILED: was 912, would be 1140, bustime =3D 228 us
Jun 12 23:37:19 snoopy last message repeated 10003 times
Jun 12 23:37:19 snoopy kernel: usb-uhci.c: iso_find_start: gap in seamles=
s=20
isochronous scheduling
Jun 12 23:37:19 snoopy kernel: usb.c: usb-check-bandwidth would have=20
FAILED: was 912, would be 1140, bustime =3D 228 us

Also, a dialog box will sometimes pop up saying "snd_pcm_wait: Input/outp=
ut=20
error"

-Ross



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
