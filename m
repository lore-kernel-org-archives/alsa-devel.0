From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: :  ALC260 (Re:  ALSA 1.0.13rc2 release)
Date: Mon, 25 Sep 2006 10:58:21 +0930 (CST)
Message-ID: <200609250128.k8P1SLth010255@auster.physics.adelaide.edu.au>
References: <mailman.23633.1159108348.16222.alsa-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <mailman.23633.1159108348.16222.alsa-devel@lists.sourceforge.net>
	from "alsa-devel-request@lists.sourceforge.net" at Sep 24,
	2006 07:32:28 AM
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
Cc: tiwai@suse.de, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Andrea

> I'm sorry to bother you again but every time I try to set an option on
> snd-hda-intel I get this in syslog:
> 
> Sep 23 22:31:33 stariez kernel:
> ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/../../alsa-kernel/pci/hda/patch_realtek.c:4059: hda_codec: Unknown model for ALC260, trying auto-probe from BIOS...
> Sep 23 22:31:33 stariez kernel:
> ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2150:
> autoconfig: line_outs=1 (0xf/0x0/0x0/0x0/0x0)
> Sep 23 22:31:33 stariez kernel:
> ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2154:
> speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> Sep 23 22:31:33 stariez kernel:
> ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2156:
> hp=0x0, dig_out=0x18, din_in=0x0
> Sep 23 22:31:33 stariez kernel:
> ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2164:
> inputs: mic=0x12, fmic=0x0, line=0x14, fline=0x0, cd=0x16, aux=0x0
> 
> Is it normal?

Which options are you trying?  What command line(s) are you using?  If
you're trying to use the "model=test" option to modprobe, have you first
configured ALSA with the "--enable-debug" option and recompiled/reinstalled?
If testing alsa from within a standard kernel tree there's a similarly named
configuration option in the alsa section of "make menuconfig".

As Takashi said, the "test" model is only available if debugging has been
enabled.

Regards
  jonathan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
