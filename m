From: "Stephen Hassard" <steve@hassard.net>
Subject: Adding MSI RS482M4 motherboard to Intel HDA driver
Date: Mon, 12 Mar 2007 11:16:29 -0700
Message-ID: <e4fbff80703121116x2119bcccp829c9acd5c61f341@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Hi there,

I have an MSI RS482M4-ILD motherboard, using the ATI RS482 chipset and
SB450 southbridge. Alsa version 1.0.14rc3 doesn't properly detect the
on-board HDA. The motherboard is using the Realtek ALC880 chipset for
audio.

The 'lspci -v' dump is as follows:
-----
00:14.2 Audio device: ATI Technologies Inc SB450 HDA Audio (rev 01)
        Subsystem: Micro-Star International Co., Ltd. Unknown device 7191
        Flags: slow devsel, IRQ 18
        Memory at fe9e8000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0
Enable-
-----

Thanks,
Steve Hassard

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
