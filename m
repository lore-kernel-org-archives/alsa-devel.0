From: "Ted T. Logan" <tedtheologian@gmail.com>
Subject: Can't use bluetooth headset after upgrade of
 alsa/bluez with fedora 11
Date: Sun, 14 Jun 2009 23:56:56 -0500
Message-ID: <4A35D498.2000005@gmail.com>
References: <1244976692-5189-1-git-send-email-philipp.zabel@gmail.com>	<1244976692-5189-2-git-send-email-philipp.zabel@gmail.com>	<1244976692-5189-3-git-send-email-philipp.zabel@gmail.com>	<1244976692-5189-4-git-send-email-philipp.zabel@gmail.com>	<20090614145128.GB4482@sirena.org.uk>
	<74d0deb30906141352x2503283dib19934ef9d97b13d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f217.google.com (mail-gx0-f217.google.com
	[209.85.217.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 118DF243AF
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 06:57:05 +0200 (CEST)
Received: by gxk17 with SMTP id 17so5518622gxk.8
	for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2009 21:57:04 -0700 (PDT)
In-Reply-To: <74d0deb30906141352x2503283dib19934ef9d97b13d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA lib pcm_bluetooth.c:1607:(audioservice_expect) BT_OPEN failed : 
Invalid argument(22)

** WARNING **: alsa_setup(): Unable to install hw params

I get this all the time now.  What does this error mean?



arecord -D bluetoothh550 -f S16_LE | aplay -D bluetoothh550 -f S16_LE
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:1607:(audioservice_expect) BT_OPEN failed : 
Invalid argument(22)
arecord: set_params:1041: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 125000
PERIOD_SIZE: 1000
PERIOD_BYTES: 2000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 8000
TICK_TIME: [0 0]
aplay: playback:2297: read error



and here with mplayer


Playing skypering.wav.
Audio only file format detected.
==========================================================================
Opening audio decoder: [pcm] Uncompressed PCM audio decoder
AUDIO: 16000 Hz, 2 ch, s16le, 512.0 kbit/100.00% (ratio: 64000->64000)
Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)
==========================================================================
[AO_ALSA] alsa-lib: pcm_bluetooth.c:1607:(audioservice_expect) BT_OPEN 
failed : Invalid argument(22)
[AO_ALSA] Unable to set hw-parameters: Invalid argument
Failed to initialize audio driver 'alsa:device=bluetoothh550'
Could not open/initialize audio device -> no sound.
Audio: no sound
Video: no video
