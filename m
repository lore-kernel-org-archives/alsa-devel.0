From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: RME MADIFX mainline inclusion
Date: Mon, 06 Apr 2015 18:24:43 +0200
Message-ID: <5522B34B.3090404@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FBCC26042B
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2015 18:24:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi!

Back in the days (late 2012 I guess), I wrote the MADIFX driver based on
the existing RME hdspm.c.

I never had physical access to this 1399 Euro audio interface, only the
OSX driver and a shell login to one of IOSONO's machines which
temporarily featured such a card.

I know there are other users like University of Washington (DXARTS) and
probably some more (the usual WFS suspects).

Long story short: I don't have such a card and since I no longer work in
Linux audio, I guess I won't have access in the foreseeable future.

That said, I think the driver should be part of the mainline kernel, so
it gets all the love the other drivers get (static code analysis, API
changes etc.)

I think I've ported everything you guys have done to hdspm: I've read
the commitlog for hdspm and applied those changes to the madifx driver.

Code is here:

    https://github.com/adiknoth/madifx/commits/tokernel


Status:

  * PCM playback/capture working (SS and DS tested, QS untested)
  * MIDI working
  * All card settings working (e.g. TX64, SMUX, AESpro, WC-Term, 
WC-singlespeed...)
  * Slave Mode/External clock selection working
  * Mirror-MADI1-to-Out2+3 maybe working (untested)
  * Redundancy mode maybe working (untested)
  * ioctls implemented (see ioctl.c)
  * Static mixer working (fixed 1:1 mapping)
  * DSP NOT working. RME doesn't intend to release any information 
regarding the DSP.
  * Adjustable mixer NOT working (needs new userspace tools)
  * Levelmetering NOT working (maybe wrong, needs new userspace tools)


I have no idea who could write the new mixer code. Apparently, demand is
low, maybe zero.

checkpatch reports four warnings of which one is a false-positive, the
other one doesn't make sense and only two are real but somewhat ugly to
fix (line over 80 with really long array indices).

In its current state, can I send you three patches (Kconfig, madifx.h,
madifx.c) that add said driver to sound/pci/rme9652?


Cheers
