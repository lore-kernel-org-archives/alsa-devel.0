From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>
Subject: Band-aid solution for Dell Latitude E6410/E6510 microphone
Date: Wed, 29 Sep 2010 04:09:00 +0200
Message-ID: <1285726141-26448-1-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm sending out a patch that I didn't write (and thus most likely requi=
re
David's Signed-Off), but which I think might be a good idea to at least
have accessible to search.

As David already pointed out to me, the proper fix for the issue is
Takashi's commit 75e0eb24ee3ec3549c2e53707dcc87e5f7a2c791, but that has=
n't
made it into .36 RCs and thus seem unlikely to come to users anytime so=
on.

David's patch is a "band aid" solution; it solves most of the problem b=
y
adding one more special case to the sigmatel patches; on the other hand=
 it
makes the internal microphone to work fine on my laptop, which is a goo=
d
thing, right?

Anyway, if this can be considered for .36 or for some stable branch (*l=
ooks
toward Greg hoping for pity*), it would probably make me (and other own=
ers
of such laptops) probably very happy. Especially given that we have eno=
ugh
trouble with a non-working SDHCI and a not-yet-supported Alps
touchpad/trackpoint combination.

Thanks in advance, whatever the outcome,

--=20
Diego Elio Petten=C3=B2
