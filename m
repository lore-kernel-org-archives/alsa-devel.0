From: "Thibault Le Meur" <Thibault.LeMeur@supelec.fr>
Subject: RE :  [PATCH 1/2] M-Audio USB
Date: Fri, 15 Dec 2006 09:55:05 +0100
Message-ID: <030101c72026$ba173e40$161ce4a0@supelec.fr>
References: <45821828.6070708@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45821828.6070708@rogers.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: 'Pavel Polischouk' <pavelp@rogers.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



> -----Message d'origine-----
> De : alsa-devel-bounces@lists.sourceforge.net =

> [mailto:alsa-devel-bounces@lists.sourceforge.net] De la part =

> de Pavel Polischouk
> Envoy=E9 : vendredi 15 d=E9cembre 2006 04:36
> =C0 : alsa-devel@lists.sourceforge.net
> Objet : Re: [Alsa-devel] [PATCH 1/2] M-Audio USB
> =

> =

> Thibault Le Meur wrote:
> > However, it does not correct the corrupted initialization =

> state that =

> > occur when the device is turned on before the snd-usb-audio =

> module is =

> > initialized with a valid device_setup parameter (see below).
> >   =

> There are 2 reasons for this:
> 1. The default setting "0" will immediately make the device =

> stuck in a =

> weird semi-working mode. Avoid. I'll add a check to the next patch =

> revision that will REFUSE to load the driver for M-Audio =

> unless a valid =

> setup parameter is specified.

This would break backward compatibility!
I know several current users of M-Audio devices that are happy with the
current behaviour of the driver (without any device_setup param): mainly
because they are using the SPDIF interface which doesn't have the issues we
are dealing with here.
If we do this, the driver upgrade won't be transparent for them! =


> Another approach would be to =

> use a mixer =

> control to select available configuration (with the default =

> of NONE).

This sounds better, but may require more work.

> 2. If you're using a daemon that loads USB drivers =

> automatically, it =

> will always load using "default" setting. If a valid device_setup =

> parameter is added to /etc/modprobe.conf, it will be possible =

> to turn on =

> the device before initializing the driver.

Sure, that's what I do, but I wanted to do the tests from a clean system
that would reflect most users' setup.

> > As far as the documentation is concerned, shouldn't it be better to =

> > keep an Audiophile-USB.txt file with only the following =

> sentence: "Updated
> > documentation on  this device can now be found in the M-Audio.txt  =

> > file" ?
> >   =

> Agreed.

Great.

> Also, I will update the JACK info. Current version can work natively =

> with 24bit big-endian interfaces, and also works fine with  =

> Quattro in =

> 4-channel input mode.
>

Interresting, I wasn't able to have this setup wokring for the Audiophile.
Are you using the 4-channel input at the same time as a playback interface
(in Full-Duplex) ? Because I think there was a patch to be applied to Alsa
to enable Full-Duplex mode with Multi interfaces... Or has it been included
in current ALSA release ?

> Another problem that I found with Quattro. The driver works fine in =

> 24/96k mode, no underruns. But in 44k/48k modes, it's always =

> giving me =

> JACK xruns, or just skips in arecord, even with the most =

> forgiving JACK =

> settings (high realtime priority and big buffers).

Very strange, I don't think I've seen such issue with teh audiophile usb
device.
I'll try to test this.

> This looks =

> counter-intuitive, that the slower mode performs worse than =

> faster one. =

> Could it be that the driver reserves not enough USB bandwidth from =

> hardware, or something similar? What settings could be =

> changed to try to =

> correct this?

No Idea... Sorry.

Thibault



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
