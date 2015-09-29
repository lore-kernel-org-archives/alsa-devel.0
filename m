From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Zoom R16/24 playback slient
Date: Tue, 29 Sep 2015 22:19:57 +0200
Message-ID: <alpine.DEB.2.02.1509292156390.6263@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id B0BA62605C4
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 22:19:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Panu Matilainen <pmatilai@laiskiainen.org>
List-Id: alsa-devel@alsa-project.org


Bringing up an old thread from 2014 since I've gotten access to a Zoom R16 =

and am keen on getting it to work in full duplex under Linux. Apparently =

(not yet verified here yet, rebuilding a kernel with the patch applied at =

the moment), 8 channel capture works with the quirk, but playback doesn't =

(well, it appears to work, but no sound comes out) and neither does the =

mixer.

> At Sun, 30 Nov 2014 12:08:38 +0200,
> Panu Matilainen wrote:
> > =

> > On 11/29/2014 09:39 PM, Takashi Iwai wrote:
> > > At Sat, 29 Nov 2014 21:35:04 +0200,
> > > Panu Matilainen wrote:
> > >>
> > >> This makes the midi interface and capture work out of the box with
> > >> R16 (and presumably R24 too but untested). Playback stream would also
> > >> seem to function fine except for one caveat: no sound is produced,
> > >> so it is disabled for now.
> >
> > [ ... ]
> > =

> > In the meanwhile I started looking at the mixer - this is just guessing =

> > but maybe its starting with outputs muted which could explain the =

> > playback stream running but without sound.
> > =

> > The descriptors for interface 0 are garbage but what is there would see=
m =

> > to map to logical elements by subtype and terminaltype, after those the=
> > data doesn't seem to add up (eg number of input/output channels =

> > missing/wrongly placed etc):
> > =

> > ** UNRECOGNIZED:  0b 24 01 00 01 35 00 03 01 02 03
> >     -> Header?
> > ** UNRECOGNIZED:  0c 24 02 05 01 01 00 02 03 00 00 00
> >     -> USB streaming input terminal?
> > ** UNRECOGNIZED:  09 24 03 08 01 03 00 05 00
> >     -> Speaker output terminal?
> > ** UNRECOGNIZED:  0c 24 02 09 01 02 00 08 00 00 00 00
> >     -> Microphone input terminal?
> > ** UNRECOGNIZED:  09 24 03 0c 01 01 00 09 00
> >     -> USB streaming output terminal?
> > =

> > Anything there that might ring a bell, or other ideas where to start =

> > poking at this thing?
> =

> Yeah, most of these look almost sane, so any off-by-one firmware
> issue?

Searching the archives, I could find no further posts on the subject of =

the R16. Panu, did you do any more work on this?

Where does the above output come from, and where could I find information
on what type of data is expected? I assume what's expected is something =

one would get from an USB mixer device?

In an earlier incarnation of a patch for the R16 (on the 10th of March =

2014), there's a discussion between Jason Mancine and Takashi regarding =

the .format field in the quirks table =

(http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074117.htm=
l) =

which didn't seem to reach a conclusion; the problem then seemed to be =

that even when setting the .format to SNDRV_PCM_FMTBIT_S24_3LE, ALSA still =

setup up a 32 bit transfer. However, Panu's patch also added a small delay =

in snd_usb_ctl_msg_quirk(), so that perhaps was the real solution to the =

alleged format problem? (The final patch is much smaller than in this =

particular thread, possibly due to the use of QUIRK_ANY_INTERFACE since =

kernel version >3.11 ?)

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
