From: Nounou Dadoun <nounou.dadoun@avigilon.com>
Subject: Porting WM8904 codec to new board - trying to get ALSA
	aplay going
Date: Mon, 16 May 2016 19:16:17 +0000
Message-ID: <8149AB08BCB1F54F92680ED6104891A0E2C758@mbx027-w1-ca-4.exch027.domain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hub027-ca-3.exch027.serverdata.net
 (hub027-ca-3.exch027.serverdata.net [64.78.52.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 831C7264F74
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 21:16:18 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Not sure whether this should go to the dev or users list (or somewhere in b=
etween) so I'll start off trying both.

I'm trying to port a wm8904 audio driver/codec to a new board and the new b=
oard uses a device tree configuration which is new to both me and our proje=
ct. The target arm board uses a linux 3-10 kernel, I have the wm8904 on the=
 i2c bus and configured the Sound in the device tree to use an i2s controll=
er. The codec and platform driver are modprobed on startup.  =


I've made a lot of progress, I (finally!) have the codec loading/modprobed =
properly and the platform driver probed and successful (up to a point), so =
I have in the serial log:
[    6.766524] snd_soc_card_avigilon sound.3:  wm8904-hifi <-> 6000a000.i2s=
 mapping ok

And at the console:
# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: AVIGILONWM8904 [AVIGILON-WM8904], device 0: WM8904-STREAM wm8904-hi=
fi-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
# ls /proc/asound/
AVIGILONWM8904  card0           cards           devices         pcm        =
     timers          version
# cat /proc/asound/cards
 0 [AVIGILONWM8904 ]: AVIGILON-WM8904 - AVIGILON-WM8904
                      AVIGILON-WM8904

But when I try to play a wave file, I get (no sound and):
# aplay -v audiocheck.net_sin_220Hz_0dBFS_10s.wav
Playing WAVE 'audiocheck.net_sin_220Hz_0dBFS_10s.wav' : Signed 16 bit Littl=
e Endian, Rate 44100 Hz, Mono
aplay: set_params:1297: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 44100
PERIOD_TIME: (46439 46440)
PERIOD_SIZE: 2048
PERIOD_BYTES: 4096
PERIODS: 11
BUFFER_TIME: (510839 510840)
BUFFER_SIZE: 22528
BUFFER_BYTES: 45056
TICK_TIME: 0
#
 =

But (encouragingly) when I try this, I get my trace statement from the plat=
form driver:
[ 3794.140675] Calling avigilon_board_startup
in the serial log.

>From the canonical/generic platform driver file, the soc_snd_probe  probe r=
outine seems to be doing a bunch of dai link configuration and other stuff =
(including reading values out of the device tree) which I'm not currently d=
oing in my equivalent probe routine. (And which I haven't been able to find=
 any documentation for.)
 =

So a few questions:

Am I correct in assuming that the " Unable to install hw params " error ind=
icates that something is missing at the board probe level?  Any suggestions=
 about what's necessary to get it going?

Is there any documentation about what the board probe should be doing to se=
t up the hardware for playback properly?

Is the board startup routine required to do anything?  (It didn't in the no=
n-device tree implementation which I'm taking it from.)

Any other useful hints or pointers?  Is there a question which I should be =
asking which I'm not?

Thanks in advance for any assistance which you might be able to provide, my=
 progress to date has involved a lot of trial and error and has been much s=
lower than I would like! ... N

Nou Dadoun
Senior Firmware Developer, Security Specialist


Office: 604.629.5182 ext 2632 =

Support: 888.281.5182 =A0|=A0 avigilon.com
Follow=A0Twitter =A0|=A0 Follow=A0LinkedIn


This email, including any files attached hereto (the "email"), contains pri=
vileged and confidential information and is only for the intended addressee=
(s). If this email has been sent to you in error, such sending does not con=
stitute waiver of privilege and we request that you kindly delete the email=
 and notify the sender. Any unauthorized use or disclosure of this email is=
 prohibited. Avigilon and certain other trade names used herein are the reg=
istered and/or unregistered trademarks of Avigilon Corporation and/or its a=
ffiliates in Canada and other jurisdictions worldwide.
