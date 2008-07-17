From: Neil Schemenauer <nas@arctrix.com>
Subject: Weirdness with on-board CM6501 USB
Date: Thu, 17 Jul 2008 21:39:50 +0000 (UTC)
Message-ID: <g5oe76$vfj$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E839103803
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 01:45:04 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KJd9i-00019P-JW
	for alsa-devel@alsa-project.org; Thu, 17 Jul 2008 23:45:02 +0000
Received: from s0106001ee5441427.ss.shawcable.net ([70.64.10.242])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2008 23:45:02 +0000
Received: from nas by s0106001ee5441427.ss.shawcable.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2008 23:45:02 +0000
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

Hi,

I have a Asus M2N-E SLI board with a CM6501 sound on-board.  I asked
some months ago if anyone had any advice for how to get it working:

    http://article.gmane.org/gmane.linux.alsa.user/29626

Apparently there are still people having problems with this card.
Today I spend some more time tinkering with it and have finally got
some noise out of it.  The magic is a .asoundrc file as follows:

    pcm.!default {
            type plug
            slave.pcm "surround51:CARD=1"
            slave.channels 6
            route_policy duplicate
    }

    ctl.!default {
            type hw
            card 1
    }

Note that it's card "1" because I have a second PCI sound card.  I
have my stereo speakers connected to the gray plug (side speaker out
according to the manual).  The lime plug is supposed to be for front
speakers but no signal is present.  The volume is turned up on all
mixer controls.

Anyone have ideas on why no sound comes out of the front speaker
plug?

Regards,

  Neil
