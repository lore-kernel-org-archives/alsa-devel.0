From: =?ISO-8859-1?Q?Andr=E9e_=27Glaucous=27?= <glakke1@gmail.com>
Subject: HDMI LPCM (7.1) with AMD/FGLRX
Date: Sun, 7 Aug 2011 21:17:46 +0200
Message-ID: <CAD=fgeJpR6xJbHxmp3EfWa1SOn_dx6ibQ4ffBTdf492UYrR06w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C67B71037EA
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Aug 2011 21:17:50 +0200 (CEST)
Received: by vws20 with SMTP id 20so2803924vws.38
	for <alsa-devel@alsa-project.org>; Sun, 07 Aug 2011 12:17:46 -0700 (PDT)
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

Hello.

I'm wondering if there's any ongoing development on multichannel sound
support for HDMI - LPCM/5.1/7.1, not bitstreamed audio such as DTS/AC3
(which works).
I've tried both a AMD HD 4870 and AMD HD 6870, on both 2 channel and
bitstreamed audio works with ALSA, but not LPCM. LPCM works perfectly (5.1,
7.1) on Windows.

According to the mailing list there seem to have been some activity in this
area (January or so), but no success. I'd gladly try out patches.

My setup is:
Arch Linux 64 bit
fglrx 11.7
alsa 1.0.24
HD 6870 -> HDMI -> Denon AVR-1909 (Receiver) -> HDTV

--
aplay -L

hdmi:CARD=Generic,DEV=0
    HD-Audio Generic, HDMI 0
    HDMI Audio Output
--
speaker-test -D hw:2,3 -c 6

speaker-test 1.0.24.2

Playback device is hw:2,3
Stream parameters are 48000Hz, S16_LE, 6 channels
Using 16 octaves of pink noise
Channels count (6) not available for playbacks: Invalid argument
Setting of hwparams failed: Invalid argument
--
speaker-test -D hw:2,3 -c 8

speaker-test 1.0.24.2

Playback device is hw:2,3
Stream parameters are 48000Hz, S16_LE, 8 channels
Using 16 octaves of pink noise
Channels count (8) not available for playbacks: Invalid argument
Setting of hwparams failed: Invalid argument
--
