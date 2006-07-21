From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001058]: CMI9880 sometimes produces
	distorted sound
Date: Fri, 21 Jul 2006 02:28:41 +0200
Message-ID: <0f319660e1808cda7171588b4b82507c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 525071AC
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Jul 2006 02:28:41 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1058> =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                ahessling
Assigned To:                =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Issue ID:                   1058
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.11.6
Resolution:                 fixed
Fixed in Version:           =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             04-16-2005 16:37 CEST
Last Modified:              07-21-2006 02:28 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    CMI9880 sometimes produces distorted sound
Description: =

I am using the CVS version of alsa-kernel from a few days and because of
the soundchip CMI9880, I have to activate Intel HDA in the kernel.
Sound is working quite fine in stereo mode, but if I want to play a DVD
with 5.1 sound, all speakers are activated but the sound is a little bit
distorted.
xine uses plug:surround51:0 as the surround device.

My asound.conf looks like this:
pcm.!default {
type plug
slave.pcm "svol"
}

pcm.svol {
type softvol
slave.pcm "hw:0,0"
control {
name "PCM Playback Volume"
}
}

I also tried the one from http://www.sabi.co.uk/Cfg/ALSA/
Again, stereo sound works fine and also dmix does its work, but this time
I only get stereo sound in xine although the same configuration of xine is
used.

I also noticed that playing some files using aplay produces the same
distortions, e.g.:

aplay /usr/share/sounds/k3b_success1.wav
Playing WAVE '/usr/share/sounds/k3b_success1.wav' : Unsigned 8 bit, Rate
8000 Hz, Mono

Seems to have to do something with sample rate.
Using the other asound.conf from the homepage above just gives an error:
Playing WAVE '/usr/share/sounds/k3b_success1.wav' : Unsigned 8 bit, Rate
8000 Hz, Mono
aplay: set_params:857: Sample format non available
 =

Is there a way to play 5.1 sound without these distortions? Maybe some
lines added to my asound.conf would do the work.

Thanks in advance!

Regards,
Andr=E9
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 komanek - 08-19-05 12:58 =

----------------------------------------------------------------------
Thank you, with the 1.0.9b alsa drivers it seems to work much better. The
sound still gets sometimes distorted, but only ocasionaly and for a moment
only.

----------------------------------------------------------------------
 rlrevell - 12-19-05 07:59 =

----------------------------------------------------------------------
Would you say this bug is fixed?

Issue History
Date Modified  Username       Field                    Change              =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
04-16-05 16:37 ahessling      New Issue                                    =

04-16-05 16:37 ahessling      Distribution              =3D> Gentoo        =
  =

04-16-05 16:37 ahessling      Kernel Version            =3D> 2.6.11.6      =
  =

04-19-05 17:47 tiwai          Note Added: 0004527                          =

04-19-05 17:47 tiwai          Category                 OTHERS =3D> PCI - hd=
a-intel
04-21-05 11:41 ahessling      Note Added: 0004550                          =

06-22-05 16:32 andersin       Note Added: 0005133                          =

06-22-05 17:49 tiwai          Note Added: 0005135                          =

08-08-05 12:26 komanek        Note Added: 0005704                          =

08-08-05 12:37 komanek        Note Added: 0005705                          =

08-11-05 14:29 tiwai          Note Added: 0005758                          =

08-19-05 12:58 komanek        Note Added: 0005869                          =

12-19-05 07:59 rlrevell       Note Added: 0007090                          =

07-21-06 02:28 Adrian Bunk    Status                   new =3D> resolved   =
  =

07-21-06 02:28 Adrian Bunk    Resolution               open =3D> fixed     =
  =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
