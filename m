From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Dreamcast AICA sound support added to linux-sh cvs
Date: Sun, 04 Jun 2006 13:49:05 +0100
Message-ID: <1149425346.9084.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751248AbWFDMtP@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sh <linuxsh-dev@lists.sourceforge.net>, Paul Mundt <lethal@linux-sh.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Alsa-devel <alsa-devel@lists.sourceforge.net>, Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The linux-sh cvs mailing list still appears to be down, so this is to
notify you all that I have added the Dreamcast sound support to the
linux-sh cvs.

Unfortunately I cannot post the patch directly to lkml as it contains
some text the majordomo automatically rejects. but those who want to see
the code can look here:
http://linuxsh.cvs.sourceforge.net/linuxsh/linux/

I appreciate this really needs to get added to mainline via ALSA but I
wanted to store it all somewhere safer than my home network and I have
developer access to linux-sh, so that was the obvious place.

However, please note that it requires a patch to the linux-sh dma to
work. Paul has said he will add the patch but if he has it isn't yet
visible in the anon cvs. So the cvs code may not work at the moment.
