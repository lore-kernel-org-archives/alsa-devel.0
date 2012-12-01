From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Preliminary driver for RME MADI FX
Date: Sat, 01 Dec 2012 22:43:31 +0100
Message-ID: <50BA7A03.2040008@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 193D7261742
 for <alsa-devel@alsa-project.org>; Sat,  1 Dec 2012 22:43:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Robert Steffens <robert.steffens@iosono-sound.com>, Cornelius Bradter <c.bradter@hff-potsdam.de>, Andre Schramm <andre.schramm@iosono-sound.com>
List-Id: alsa-devel@alsa-project.org

Hi!

I've been working on a driver for the new 390 channels RME MADI FX.

For those who are interested, I've made the source available here:

   https://github.com/adiknoth/madifx

As mentioned there, I only had remote access, so not all possible
hardware configurations have been tested. This might change next year,
until then, consider everything as "coincidentally working" ;)

Most importantly, the userspace API isn't stable, yet, since we still
have to develop new tools for metering and mixer adjustments. If we
exclude this API (the ioctls) for now, it is moderately safe to go
mainline, though we definitely lack decent test coverage.

ALSA devs: Feel free to demand any changes that are required for
mainline inclusion. The github repo is meant to serve as an incubator
from which we'll eventually derive the final kernel patch.



Cheers
