From: David Henningsson <david.henningsson@canonical.com>
Subject: HDA Firmware file question
Date: Thu, 17 Nov 2011 10:37:32 +0100
Message-ID: <4EC4D5DC.9090202@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 70410103A16
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 10:37:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

As seen in the "Early Patching" section of the "More notes on HD-Audio 
driver" document, you're supposed to activate it like this:

options snd-hda-intel patch=on-board-patch,hdmi-patch

But how do we know the order here? The pci bus is probed in parallel 
(right?) so could this be racy, that on every other boot, the hdmi card 
is probed first instead?

Also, since the patch file specifies a [codec] section, you could 
actually use the same patch file for almost all cases. I guess the case 
of having two card instances with the same codec at the same address is 
pretty unusual, right?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
