From: Adam Rosenberg <adam@alcorn.com>
Subject: ALSA processor usage is too high
Date: Fri, 5 Nov 2010 10:12:16 -0400
Message-ID: <AANLkTik-sb1OihaDhNgptH44gQ4__E+ozxhSKpA9GdSK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BD31103975
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 15:12:38 +0100 (CET)
Received: by wyb33 with SMTP id 33so1164139wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 05 Nov 2010 07:12:38 -0700 (PDT)
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

I am trying to decode 8 MP3 files simultaneously.  Each file is 3
minutes 11 seconds long.=A0 When I just decode the files and copy the
PCM data to memory it takes 2 minutes 36 seconds.=A0 When I do the same
test after opening 8 ALSA PCM streams and while writing data to them
it takes 4 minutes 37 seconds.=A0 This is much too slow for what should
be a simple copy operation.

I need to have 8 MP3 files decoding and playing on our custom board.
I have taken the driver as far as I can on my own.  I am seeking
expert help to get this working as soon as possible.  I am sorry if
this was not the appropriate place to post such a request.  Please
contact me directly if you are interested in working on this project.

The custom board is setup as follows:

Analog Devices BF537 processor running uClinux from
svn://blackfin.uclinux.org/uclinux-dist/trunk uclinux-dist
Using alsa-lib-1.0.23 from http://www.alsa-project.org
Two Cirrus Logic CS42448 CODECs connected to BF537 SPORT0 Primary and
Secondary data lines in Multichannel mode
CS42448 configured for TDM (32 bits per channel * 8 channels =3D 256
bits per frame)
ICS661 Audio Clock at (256*48000Hz) connected to BF537 SPORT0 and Both
CS42448 CODECs for bit clocking
You can find the driver here:
http://www.alcorn.com/ftp/swap/sound_cs42448.zip

Thank you,
Adam

Adam Rosenberg
Software Engineer

Alcorn McBride Inc.
3300 South Hiawassee
Building 105
Orlando, FL 32835

(407) 296 - 5800 ext. 5490
