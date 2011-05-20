From: David Henningsson <david.henningsson@canonical.com>
Subject: Should we really use POS_FIX_VIACOMBO for AMD/ATI
	chipsets?
Date: Fri, 20 May 2011 15:33:56 +0200
Message-ID: <4DD66DC4.4060902@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 47680103874
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 15:33:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, 741825@bugs.launchpad.net, "Xu, Andiry" <Andiry.Xu@amd.com>
List-Id: alsa-devel@alsa-project.org

I'm far from sure, but I could be on to something...

Looking at the code for azx_via_get_position, it seems that for 
recording streams, it accesses a register at position 
VIA_IN_STREAM0_FIFO_SIZE_OFFSET = 0x90. Looking at the datasheet for 
SB700, that register is not even present. This does not seem right to me.

Could it be that we should use POS_FIX_LPIB by default for AMD/ATI 
chipsets instead? It seems more reasonable to me.
In addition, I looked through some of the commits for quirking to 
POS_FIX_LPIB and the four I checked were all ATI chipsets.

So; I've tried adding:
options snd-hda-intel position_fix=1
to /etc/modprobe.d/alsa-base.conf

...to my machine with the infamous [1002:4383] controller (and 
rebooted), and the few times I've tested, recording worked successfully 
with pulseaudio. So could you please follow this up with testing on your 
machines to see if we have actually managed to solve this long-standing bug?

The only annoying thing is that I didn't realise this earlier :-/

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
