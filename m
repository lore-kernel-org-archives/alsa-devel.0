From: "Matt Hirsch" <matthew.hirsch@gmail.com>
Subject: Fwd: surround51 lfe/center/front channel cross-talk
	with intel8x0 board
Date: Mon, 14 Jan 2008 16:11:58 -0500
Message-ID: <975d09800801141311v14debf13g79e83e6aa2d0c95@mail.gmail.com>
References: <975d09800801042220v5efde614g8ccc18a5f59b0e82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by alsa0.perex.cz (Postfix) with ESMTP id B66582464B
	for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2008 22:12:00 +0100 (CET)
Received: by wx-out-0506.google.com with SMTP id t11so1578362wxc.23
	for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2008 13:11:59 -0800 (PST)
In-Reply-To: <975d09800801042220v5efde614g8ccc18a5f59b0e82@mail.gmail.com>
Content-Disposition: inline
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

I sent this to alsa-users and didn't get any response. I'd be grateful
if someone had some suggestions for getting around the problem
described below.

Thanks very much,
Matt


---------- Forwarded message ----------
From: Matt Hirsch <matthew.hirsch@gmail.com>
Date: Jan 5, 2008 1:20 AM
Subject: surround51 lfe/center/front channel cross-talk with intel8x0 board
To: alsa-user@lists.sourceforge.net


I have an AC'97 based onboard sound card in my system (snd_intel8x0
driver). I'm using it in 6ch mode to drive two front speakers, two
rear speakers and a subwoofer and center channel. Using speaker-test
with the surround51 plug (or any other alsa program with that plug) to
send audio to channel 5 (center in alsamixer) produces an attenuated
signal on channel 2 (right front in alsamixer) and likewise, sending
audio to channel 6 (lfe in alsamixer) produces an attenuated signal on
channel 1 (left front in alsamixer).

In summary:
speaker-test -tsine -f200 -Dsurround51 -c6 -s1
    tone on left front speaker only
speaker-test -tsine -f200 -Dsurround51 -c6 -s2
    tone on right front speaker only
speaker-test -tsine -f200 -Dsurround51 -c6 -s3
    tone on left rear speaker only
speaker-test -tsine -f200 -Dsurround51 -c6 -s4
    tone on right rear speaker only
speaker-test -tsine -f200 -Dsurround51 -c6 -s5
    tone on center speaker, and quieter tone on right front speaker
speaker-test -tsine -f200 -Dsurround51 -c6 -s6
    tone on lfe, and quieter tone on left front speaker

Any help or suggestions as to getting rid of this crosstalk would be
greatly appreciated!

Here's what I've tried so far:
If I don't use the surround51 plug, and use default (hw:0) instead,
the channels are all in a different order, but the same effect occurs
(crosstalk between two channels).

I tried sequentially setting and un-setting all of the modes and
buttons in the alsa mixer, such as high-pass filter (on/off), surround
jack mode (shared/independent), line jack sense (on/off), exchanging
front/surround, etc. Nothing seemed to have any effect. When I
exchange the front and surround speakers, the cross talk is also
exchanged (i.e. it shows up on the rear speakers rather than the front
speakers).

I'm running fedora 8, so I started with the latest fedora 8 alsa rpms
(1.15). When this didn't work I compiled a recent CVS snapshot
(12/25/07) against my kernel and installed it. Same results as above.

My hardware shows up in lspci as:
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
AC'97 Sound Controller (rev a0)

My kernel is 2.6.23.9-85.fc8

Thanks,
Matt
