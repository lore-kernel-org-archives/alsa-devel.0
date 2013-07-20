From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Garbage at end of playback: ecasound or alsa broken?
Date: Sat, 20 Jul 2013 10:39:58 +0200
Message-ID: <51EA4CDE.2010503@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout02.t-online.de (mailout02.t-online.de [194.25.134.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 96388260310
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2013 10:40:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ecasound-list@lists.sourceforge.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi everybody!

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary: A very short period (about 45ms) garbage is played at the end of e=
very playback.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Hardware
=3D=3D=3D=3D=3D=3D=3D=3D
mobo: AOpen i915GMm-hfs
cpu: Pentium-M
ram: 2GB
intel hda, realtek codec
rme digi96/pad
onboard intel hda, realtek alc880

Software
=3D=3D=3D=3D=3D=3D=3D
opensuse 12.3
linux kernel 3.10.1, 3.11-rc1
ecasound, git ab6a9c3be5440b05f2c9eb240ee0d42578379f8d


Steps to reproduce the problem:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1: generate test file
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Start audacity, generate  a 44.1 khz stereo track,
one second audio, start 400 Hz, end 4000Hz,
start amplitude 0.5, end amplitude 1.0
export to testin.wav as 16bit wav

2: playback test file and record it
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Setup soundcards and cabling, execute
"ecasound -t 2 -f:16,2,44100 -a:1 -i testin.wav -o alsahw,0,0  -a:2 -i alsa=
hw,0,0 -o testout.wav"


3:Expected result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
testout.wav should hold a proper recording of testin.wav, padded with silen=
ce at the end.

4: my result
=3D=3D=3D=3D=3D=3D=3D=3D=3D
testout.wav
1 - starts with about 90 Samples of silence (not nice, how can I avoid that=
?)
2 - continues with 1 second of properly recorded audio (expected)
3 - continues with about 1982 samples of audio (0,045s) (unexpected, severl=
y broken)
      The garbage audio is part of the original audio, starting at about 26=
xxHz, ending at about 28xx Hz
4 - continues with silence to the end of the file (expected)

Discussion
=3D=3D=3D=3D=3D=3D=3D=3D=3D
The same problem exists if I record rme96 to rme96, hda to rme96 or hda to =
hda.
So it=B4s probably not a problem of the rme96 or hda alsa drivers.

Is this problem known? Can anybody confirm the problem with different hardw=
are?
Should I blame alsa or ecasound? Any ideas?

cu,
  Knut
