From: David Henningsson <david.henningsson@canonical.com>
Subject: Automated test suite for HDA codecs,
 now up and running for daily builds
Date: Tue, 14 Aug 2012 12:44:08 +0200
Message-ID: <502A2BF8.4050705@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E31D265E5C
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 12:14:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ubuntu-audio-dev@lists.launchpad.net
Cc: Takashi Iwai <tiwai@suse.de>, Daniel Manrique <daniel.manrique@canonical.com>, brad.figg@canonical.com, Jeremy Kerr <jk@ozlabs.org>, Chris Van Hoof <vanhoof@canonical.com>
List-Id: alsa-devel@alsa-project.org

As some of you know, I've been working on extending hda-emu to become an 
automated test suite.

A little status report follows:

  * Daniel Manrique provided me with alsa-info from ~110 machines that 
Canonical have certified. These alsa-infos are now upstreamed (except 
for a few which were marked confidential or never reached the market), 
and distributed with hda-emu [1].

  * The test suite (which also is a part of hda-emu) loops over all 
these codecs, and sends a few commands to hda-emu for each one of them. 
E g, it tries setting volume controls and verifies that the value read 
back is the same it tried to set. It also looks for errors from hda-emu 
after each command sent.

  * I already run daily imports of Takashi's sound tarballs to provide 
automatic DKMS-based builds. What's new is that this import script [3] 
now also runs the test suite on that code. It uses the summary of this 
test run as commit message, which is then imported into Launchpad [2], 
and sent out by email (to anyone subscribed to that branch).

I've just set this up, so maybe there will be some bumps before the 
import script runs correctly, but hopefully everything will run smoothly 
soon, and that we'll catch some regressions before they affect anyone. :-)


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[1] 
http://git.kernel.org/?p=linux/kernel/git/tiwai/hda-emu.git;a=commit;h=fb3b3a7654452bdba188166ef9815baa15042e6f

[2] https://code.launchpad.net/~ubuntu-audio-dev/alsa-driver/tiwai-trunk2

[3] 
https://code.launchpad.net/~ubuntu-audio-dev/alsa-driver/filter-sound-script
