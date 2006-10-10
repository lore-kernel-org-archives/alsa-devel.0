From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Prolem with ALC260 soundcard
Date: Tue, 10 Oct 2006 10:10:33 +0930 (CST)
Message-ID: <200610100040.k9A0eX2m023146@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Some time ago I wrote:
> > and the cat /proc/asound/card0/codec#0
> > :
> > # cat /proc/asound/card0/codec#0
> > Codec: Realtek ALC260
> > Address: 0
> > Vendor Id: 0x10ec0260
> > Subsystem Id: 0x1025110d
> > Revision Id: 0x100400
> 
> Thanks for that.  This suggests a PCI subvendor of 0x1025 and a pci_subdevice
> ID of 0x110d I think.  If we need to add another model ID to patch_realtek.c
> these are the values we would use.  Note that the current "acer" ALC260 model
> has a pci_subdevice of 0x008f.

Minor correction.  The pci_subdevice ID comes from the PCI subsystem, not
the codec subsystem ID.  Thus we see from "lspci -vv":

  00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
  High Definition Audio Controller (rev 04)
    Subsystem: Acer Incorporated [ALI] Unknown device 007b

So if we do need to identify this particular variant (Acer c204) the
appropriate pci_subdevice ID should be 0x007b I think, rather than 0x110d.

Regards
  jonathan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
