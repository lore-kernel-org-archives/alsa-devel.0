From: Be <be.0@gmx.com>
Subject: Rane SL2/3/4 driver?
Date: Tue, 24 Mar 2015 03:33:09 -0500
Message-ID: <55112145.8010807@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
 by alsa0.perex.cz (Postfix) with ESMTP id BBC7526059C
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 09:33:12 +0100 (CET)
Received: from localhost.localdomain ([24.12.142.252]) by mail.gmx.com
 (mrgmxus002) with ESMTPSA (Nemesis) id 0MNI6h-1YXsMw1j5t-006uFS for
 <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 09:33:11 +0100
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
List-Id: alsa-devel@alsa-project.org

Hi, I recently published the first version of Crossfade GNU/Linux, a
distro for DJing from USB drives on any PC (see
http://mixxx.org/forums/viewtopic.php?f=1&t=7031 for details). I just
tried it on my friend's Macbook which he uses with a Rane SL4 USB sound
card. I realized there is no Linux driver for the current line of sound
cards sold for digital vinyl emulation with Serato DJ. These are the
Rane SL2, SL3, and SL4 (http://serato.com/hardware/all/mixers-interfaces
; the Denon DS1 was also recently announced but not available yet:
http://serato.com/latest/blog/17973/announcing-denon-ds1 ). They range
from 4 in/4 out to 10 in/10 out and all have phono preamps built in.
There appears to be support for the old and discontinued Rane SL1, which
used USB 1.1, but the SL2/3/4 use USB 2.0. Has anyone thought about
writing a driver for these?
