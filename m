From: "Peer Chen" <pchen@nvidia.com>
Subject: RE: [Alsa-devel] [Patch] Audio: Add nvidia HD Audio controllers of MCP67 support to hda_intel.c
Date: Fri, 17 Nov 2006 16:46:00 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0CEB90F8@hkemmail01.nvidia.com>
References: <s5hk62gtqxc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755561AbWKQItM@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <s5hk62gtqxc.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, jgarzik@pobox.com
List-Id: alsa-devel@alsa-project.org

Takashi:
When this patch will be included into the -mm tree? Is it possible to be
included in kernel source before final release of  kernel 2.6.19.

BRs
Peer Chen

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Wednesday, November 01, 2006 12:02 AM
To: Randy Dunlap
Cc: Peer Chen; alsa-devel@lists.sourceforge.net;
linux-kernel@vger.kernel.org; Andy Currid; Brian Lazara;
jgarzik@pobox.com; Emily Jiang
Subject: Re: [Alsa-devel] [Patch] Audio: Add nvidia HD Audio controllers
of MCP67 support to hda_intel.c

At Tue, 31 Oct 2006 07:43:45 -0800,
Randy Dunlap wrote:
> 
> On Tue, 31 Oct 2006 15:42:54 +0100 Takashi Iwai wrote:
> 
> > At Tue, 31 Oct 2006 15:33:58 +0800,
> > Peer Chen wrote:
> > > 
> > > Add the support for HD audio controllers of
MCP51,MCP55,MCP61,MCP65 & MCP67.
> > > The following hda_intel.c patch is based on kernel 2.6.18.
> > > 
> > > Signed-off by: Peer Chen <pchen@nvidia.com>
> > 
> > Applied to ALSA tree.  But I didn't add it to push-to-2.6.19-tree
> > because apparently no one has tested the patch well yet.
> > 
> > (BTW, your patch attached there was broken, so I had to apply it
> > manually.  At the next time, please either inline the patch in a
text
> > mail, or attach a plain text patch if inlining is not possible with
> > your MUA/MTA.)
> 
> Patches should also be sent made to apply to a current kernel
> tree, like 2.6.19-rc3, 2.6.19-rc4, 2.6.19-rc3-git8,
> Linus's git tree, or Andrew's -mm tree if that is the only
> place where the patch fits, or even to a subsystem tree (e.g., ALSA).

Since I already applied it to ALSA tree, the next mm tree will include
it (automatically taken it from alsa.git#mm branch).


Takashi
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
