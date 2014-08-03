From: corubba <corubba@gmx.de>
Subject: [PATCH] Asus Essence STX II
Date: Sun, 03 Aug 2014 03:45:44 +0200
Message-ID: <53DD9448.8070804@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by alsa0.perex.cz (Postfix) with ESMTP id D27352610B0
 for <alsa-devel@alsa-project.org>; Sun,  3 Aug 2014 03:46:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Today I got my new sound card, a Asus Essence STX II. After plugin it in
and booting my Linux machine, the card was recognized by lspci as audio
controller, but not listed by alsa as soundcard. Information on support
for this new card under linux are hard to find. Due to the hardware
similarities between STX and STX II, I tried to modify the existing STX
driver in order to work for the STX II too. And it seems to work quiet
well: I have sound, can change the volumes, switch between
speaker/headphone/frontpanel, enable the mic boost etc. I don't have the
H6 childboard for surround sound, so I can't test that. I tested my
patch [1] with a 3.15.8 kernel under Arch Linux.

Just wanted to share this information for others to get it quickly
working, or maybe even include it after a review from the devs.


[1] http://pastebin.com/GaGguPvt
