From: "Peer Chen" <pchen@nvidia.com>
Subject: Re: [Patch] Audio: Add nvidia HD Audio controllers
	of	MCP67 support to hda_intel.c
Date: Mon, 20 Nov 2006 10:02:38 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0CEB970A@hkemmail01.nvidia.com>
References: <s5hy7qas5u8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
In-Reply-To: <s5hy7qas5u8.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, alsa-devel@lists.sourceforge.net, jgarzik@pobox.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for your explanation.

BRs
Peer Chen

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Friday, November 17, 2006 6:53 PM
To: Peer Chen
Cc: Randy Dunlap; jgarzik@pobox.com; alsa-devel@lists.sourceforge.net;
linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] [Patch] Audio: Add nvidia HD Audio controllers
of MCP67 support to hda_intel.c

At Fri, 17 Nov 2006 16:46:00 +0800,
Peer Chen wrote:
> 
> Takashi:
> When this patch will be included into the -mm tree?

Yes, it is already included, at least in 2.6.19-rc5-mm2.

> Is it possible to be
> included in kernel source before final release of  kernel 2.6.19.

No, we had no enough time for testing this in 2.6.19 cycle.
It'll be merged to 2.6.20 unless we get bug reports regarding this.


Takashi

> 
> BRs
> Peer Chen
> 
> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Wednesday, November 01, 2006 12:02 AM
> To: Randy Dunlap
> Cc: Peer Chen; alsa-devel@lists.sourceforge.net;
> linux-kernel@vger.kernel.org; Andy Currid; Brian Lazara;
> jgarzik@pobox.com; Emily Jiang
> Subject: Re: [Alsa-devel] [Patch] Audio: Add nvidia HD Audio
controllers
> of MCP67 support to hda_intel.c
> 
> At Tue, 31 Oct 2006 07:43:45 -0800,
> Randy Dunlap wrote:
> > 
> > On Tue, 31 Oct 2006 15:42:54 +0100 Takashi Iwai wrote:
> > 
> > > At Tue, 31 Oct 2006 15:33:58 +0800,
> > > Peer Chen wrote:
> > > > 
> > > > Add the support for HD audio controllers of
> MCP51,MCP55,MCP61,MCP65 & MCP67.
> > > > The following hda_intel.c patch is based on kernel 2.6.18.
> > > > 
> > > > Signed-off by: Peer Chen <pchen@nvidia.com>
> > > 
> > > Applied to ALSA tree.  But I didn't add it to push-to-2.6.19-tree
> > > because apparently no one has tested the patch well yet.
> > > 
> > > (BTW, your patch attached there was broken, so I had to apply it
> > > manually.  At the next time, please either inline the patch in a
> text
> > > mail, or attach a plain text patch if inlining is not possible
with
> > > your MUA/MTA.)
> > 
> > Patches should also be sent made to apply to a current kernel
> > tree, like 2.6.19-rc3, 2.6.19-rc4, 2.6.19-rc3-git8,
> > Linus's git tree, or Andrew's -mm tree if that is the only
> > place where the patch fits, or even to a subsystem tree (e.g.,
ALSA).
> 
> Since I already applied it to ALSA tree, the next mm tree will include
> it (automatically taken it from alsa.git#mm branch).
> 
> 
> Takashi
>
------------------------------------------------------------------------
-----------
> This email message is for the sole use of the intended recipient(s)
and may contain
> confidential information.  Any unauthorized review, use, disclosure or
distribution
> is prohibited.  If you are not the intended recipient, please contact
the sender by
> reply email and destroy all copies of the original message.
>
------------------------------------------------------------------------
-----------
> 
>
------------------------------------------------------------------------
-
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to
share your
> opinions on IT & business topics through brief surveys - and earn cash
>
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
