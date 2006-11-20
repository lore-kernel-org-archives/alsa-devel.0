From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: [Patch] Audio: Add nvidia HD Audio controllers
	of	MCP67 support to hda_intel.c
Date: Mon, 20 Nov 2006 10:16:37 -0800
Message-ID: <1164046597.5390.238.camel@razman>
References: <a6f0b350611191811k695c8df5xb0015c45b895ed65@mail.gmail.com>
	<15F501D1A78BD343BE8F4D8DB854566B0CEB9754@hkemmail01.nvidia.com>
	<a6f0b350611200954h38366a32s4b6f8737f45caee7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <a6f0b350611200954h38366a32s4b6f8737f45caee7@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: enigma_0Z <enigma.0za@gmail.com>
Cc: Peer Chen <pchen@nvidia.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Could you refresh my memory a bit here?  Is this system using the
Conexant audio codec, or is this a different system?  If it's the
Conexant, I need to know where the latest patch (test10) stands and
which codec version (5045 or 5047) it is.

Tobin

On Mon, 2006-11-20 at 12:54 -0500, enigma_0Z wrote:
> (I am cc'ing this to alsa-devel because some of us (well mostly tobin)
> were trying to get it working)
> 
> Several users of laptop-based nvidia sound hardware (MCP51 mostly)
> have issues with their sound cards, mine included. The problem is that
> there is either:
> 
> 1. No headphone output
> 2. No speaker output
> 3. No headphone/speaker controls
> 4. Plugging/unplugging headphones does not automute speakers.
> 
> In 1.0.11 and 1.0.12, there are no controls, and only one output is
> on, no matter what is plugged in. In 1.0.13, the option disable_msi=1
> has to be included, or there is an endless loop of the first second or
> so of the audio. By patching 1.0.12 or 1.0.13, we can get speaker
> controls, but not all the time. For me, I have to reboot the system
> once, and then after it comes up warm, all controls exist. On patched
> versions of 1.0.12 and 13, automatically muting speakers/headphones
> does not work.
> 
> Thanks.
> 
> On 11/19/06, Peer Chen <pchen@nvidia.com> wrote:
> > Do you mean alsa 1.0.12 & 1.0.13 can not work fine on all nvidia
> > platform?
> > How about 1.0.11?
> >
> > BRs
> > Peer Chen
> >
> > -----Original Message-----
> > From: enigma_0Z [mailto:enigma.0za@gmail.com]
> > Sent: Monday, November 20, 2006 10:12 AM
> > To: Peer Chen
> > Subject: Re: [Alsa-devel] [Patch] Audio: Add nvidia HD Audio controllers
> > of MCP67 support to hda_intel.c
> >
> > Peer,
> >
> > The patch you provided simply identifies the chips, the existing
> > nvidia code in alsa 12 or 13 does not communicate with the audio
> > hardware properly. Is it possible for you or the guys at nvidia to
> > write a complete driver?
> >
> > On 11/19/06, Peer Chen <pchen@nvidia.com> wrote:
> > > Thanks for your explanation.
> > >
> > > BRs
> > > Peer Chen
> > >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Friday, November 17, 2006 6:53 PM
> > > To: Peer Chen
> > > Cc: Randy Dunlap; jgarzik@pobox.com; alsa-devel@lists.sourceforge.net;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [Alsa-devel] [Patch] Audio: Add nvidia HD Audio
> > controllers
> > > of MCP67 support to hda_intel.c
> > >
> > > At Fri, 17 Nov 2006 16:46:00 +0800,
> > > Peer Chen wrote:
> > > >
> > > > Takashi:
> > > > When this patch will be included into the -mm tree?
> > >
> > > Yes, it is already included, at least in 2.6.19-rc5-mm2.
> > >
> > > > Is it possible to be
> > > > included in kernel source before final release of  kernel 2.6.19.
> > >
> > > No, we had no enough time for testing this in 2.6.19 cycle.
> > > It'll be merged to 2.6.20 unless we get bug reports regarding this.
> > >
> > >
> > > Takashi
> > >
> > > >
> > > > BRs
> > > > Peer Chen
> > > >
> > > > -----Original Message-----
> > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > Sent: Wednesday, November 01, 2006 12:02 AM
> > > > To: Randy Dunlap
> > > > Cc: Peer Chen; alsa-devel@lists.sourceforge.net;
> > > > linux-kernel@vger.kernel.org; Andy Currid; Brian Lazara;
> > > > jgarzik@pobox.com; Emily Jiang
> > > > Subject: Re: [Alsa-devel] [Patch] Audio: Add nvidia HD Audio
> > > controllers
> > > > of MCP67 support to hda_intel.c
> > > >
> > > > At Tue, 31 Oct 2006 07:43:45 -0800,
> > > > Randy Dunlap wrote:
> > > > >
> > > > > On Tue, 31 Oct 2006 15:42:54 +0100 Takashi Iwai wrote:
> > > > >
> > > > > > At Tue, 31 Oct 2006 15:33:58 +0800,
> > > > > > Peer Chen wrote:
> > > > > > >
> > > > > > > Add the support for HD audio controllers of
> > > > MCP51,MCP55,MCP61,MCP65 & MCP67.
> > > > > > > The following hda_intel.c patch is based on kernel 2.6.18.
> > > > > > >
> > > > > > > Signed-off by: Peer Chen <pchen@nvidia.com>
> > > > > >
> > > > > > Applied to ALSA tree.  But I didn't add it to
> > push-to-2.6.19-tree
> > > > > > because apparently no one has tested the patch well yet.
> > > > > >
> > > > > > (BTW, your patch attached there was broken, so I had to apply it
> > > > > > manually.  At the next time, please either inline the patch in a
> > > > text
> > > > > > mail, or attach a plain text patch if inlining is not possible
> > > with
> > > > > > your MUA/MTA.)
> > > > >
> > > > > Patches should also be sent made to apply to a current kernel
> > > > > tree, like 2.6.19-rc3, 2.6.19-rc4, 2.6.19-rc3-git8,
> > > > > Linus's git tree, or Andrew's -mm tree if that is the only
> > > > > place where the patch fits, or even to a subsystem tree (e.g.,
> > > ALSA).
> > > >
> > > > Since I already applied it to ALSA tree, the next mm tree will
> > include
> > > > it (automatically taken it from alsa.git#mm branch).
> > > >
> > > >
> > > > Takashi
> > > >
> > >
> > ------------------------------------------------------------------------
> > > -----------
> > > > This email message is for the sole use of the intended recipient(s)
> > > and may contain
> > > > confidential information.  Any unauthorized review, use, disclosure
> > or
> > > distribution
> > > > is prohibited.  If you are not the intended recipient, please
> > contact
> > > the sender by
> > > > reply email and destroy all copies of the original message.
> > > >
> > >
> > ------------------------------------------------------------------------
> > > -----------
> > > >
> > > >
> > >
> > ------------------------------------------------------------------------
> > > -
> > > > Take Surveys. Earn Cash. Influence the Future of IT
> > > > Join SourceForge.net's Techsay panel and you'll get the chance to
> > > share your
> > > > opinions on IT & business topics through brief surveys - and earn
> > cash
> > > >
> > >
> > http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
> > > V
> > > > _______________________________________________
> > > > Alsa-devel mailing list
> > > > Alsa-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> > > >
> > >
> > >
> > ------------------------------------------------------------------------
> > -
> > > Take Surveys. Earn Cash. Influence the Future of IT
> > > Join SourceForge.net's Techsay panel and you'll get the chance to
> > share your
> > > opinions on IT & business topics through brief surveys - and earn cash
> > >
> > http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
> > V
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> > >
> >
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
