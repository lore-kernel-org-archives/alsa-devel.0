From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: end of playback ... design question
Date: Wed, 31 Jul 2013 15:42:39 +0200
Message-ID: <51F9144F.9080807@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 50E1426158C
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 15:42:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Kai Vehmanen <kvehmanen@nosignal.fi>
List-Id: alsa-devel@alsa-project.org

Hi everybody!

Although I looked at quite a bit of source code and documentation I have
to admit that I am confused about one question:

How should alsa playback be stopped in a way that _guarantees_ that no
artifacts remaining in the drivers ringbuffer are played back again?

Let=B4s assume we play stereo 16bit audio data using the rme96 driver, peri=
od size set to 0x800 frames.

At the end of the penultimate frame playing will not be stopped even if the=
re is only one frame
of audio data remaining. Obviously that means 0x7ff frames of already playe=
d data is played again
after that one valid frame, plus possibly a few that are played during the =
short time from interrupt request to
the real stop of the playback hardware (about 5 frames on an old Pentium-M =
1.2GHz).

Now that could be fixed in different ways:

A: Always ensure that there is a bit of silence (at least hardware buffer s=
ize plus a few frames) at the end of all audio data.

      Easy for the user , but only a workaround.

B: At the rme96 driver level that condition can be detected and the relevan=
t part of the buffer
      can be filled with zeros.

      I did that in an experimental change. It does work, but it=B4s defini=
tely only a hack as it fixes
      the problem for only one device.

C: The application playing audio data could pad all audio data to the perio=
d size with zeros.

     That would prevent playback of that max 0x7ff frames of garbage, but t=
he few samples that are played
      during the time from interrupt request to the execution of the stop t=
rigger do escape

D: Don=B4t try to drain the buffer but pad with zeros and set a stop thresh=
old.

      Workaround for applications  should also work with older kernels.

E: The alsa core could detect that condition and solve it equivalent to sol=
ution D

      I think that=B4s the proper solution.

Did I miss something or do you agree?

cu,
  Knut
