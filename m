From: Trent Piepho <xyzzy@speakeasy.org>
Subject: how to handle bt848 audio driver
Date: Thu, 25 Oct 2007 09:31:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0710250407410.16052@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.sea5.speakeasy.net (mail3.sea5.speakeasy.net
	[69.17.117.5]) by alsa0.perex.cz (Postfix) with ESMTP id 95B812432F
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Oct 2007 18:31:15 +0200 (CEST)
Received: from shell4.sea5.speakeasy.net ([69.17.116.5])
	(envelope-sender <xyzzy@speakeasy.org>)
	by mail3.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted
	SMTP for <alsa-devel@alsa-project.org>; 25 Oct 2007 16:31:10 -0000
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
Cc: Takashi Iwai <tiwai@suse.de>, Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: alsa-devel@alsa-project.org

I've made some more patches for the ALSA bt87x audio driver to support more
features of the Osprey 440 card.

In order to support certain features, the ALSA driver needs access to the
bt878's GPIO lines and I2C bus.  These are controlled by PCI function 0, which
is driven by the V4L driver.  The bt878 DVB driver (which drives PCI function
1 just like the ALSA driver) needs to do the same thing and there is already
some code to handle it.

So, the ALSA driver (snd-bt87x) needs to use functions from the V4L driver
(bttv).  As it is now, the two drivers are completely separate and don't share
any code and can be loaded individually.

The DVB driver in the same tree as bttv, so this isn't a problem.  But the
snd-bt87x is in another tree, so it's somewhat harder, and I'm not sure what
to do about it.

The driver will need some header files from the bttv directory.  I guess this
can be handled by adding a -I flag in the Makefile, though that seems a little
ugly.

The bigger problem is that changes to snd-bt87x will depend on changes to
bttv.  How can the ALSA build system handle this?

For instance, my patch to add a digital volume control to snd-bt87x requires a
new function to be exported from bttv.  How will ALSA build snd-bt87x if the
kernel source doesn't yet have this function?
