From: "" <semiyd@hotmail.com>
Subject: Problems while using mplayer based on ALSA
Date: Fri, 30 Nov 2007 06:38:15 +0000
Message-ID: <BAY117-W107B2FDEF231255CEB7B9DC0710@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc2-s7.bay0.hotmail.com (bay0-omc2-s7.bay0.hotmail.com
	[65.54.246.143]) by alsa0.perex.cz (Postfix) with ESMTP id A813B24391
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 07:38:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi All:
   Im having problems  while using mplayer 1.0 to play music based on alsa =
1.0.15.
  Im using an ARM9 system and montavista linux 2.6.18.
   Here's what the problem is and what's modified in the mplayer.conf:


***************************************************************************=
************************************

/ $ mplayer /tmp/a.wav
MPlayer 1.0rc2-4.2.0 (C) 2000-2007 MPlayer Team
CPU: ARM
115 audio & 237 video codecs
 =

Playing /tmp/a.wav.
Audio file file format detected.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening audio decoder: [pcm] Uncompressed PCM audio decoder
AUDIO: 44100 Hz, 2 ch, s16le, 1411.2 kbit/100.00% (ratio: 176400->176400)
Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[AO_ALSA] alsa-lib: conf.c:2699:(snd_config_hooks_call) Cannot open shared
library (null)
[AO_ALSA] alsa-lib: conf.c:3076:(snd_config_update_r) hooks failed,
removing configuration
[AO_ALSA] Playback open error: No such file or directory
Could not open/initialize audio device -> no sound.
Audio: no sound
Video: no video
Exiting... (End of file)
 =

 **************************************************************************=
***************************************
/etc/mplayer/mplayer.conf
##################
# audio settings #
##################
 =

# Specify default audio driver (see -ao help for a list).
ao=3Dalsa
 =

# Use SDL audio driver with the esd subdriver by default.
#ao =3D sdl:esd
 =

# Specify the mixer device.
#mixer =3D /dev/mixer
 =

# Resample the sound to 44100Hz with the lavcresample audio filter.
#af=3Dlavcresample=3D44100
***************************************************************************=
*************************************


Can anybody tell me what going wrong with this?



Thanks in advance!



semiyd

_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline
