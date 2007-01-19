From: Felix Hammer <f.hammer@web.de>
Subject: cmipci patch
Date: Fri, 19 Jan 2007 11:22:05 +0100
Message-ID: <200701191122.05134.f.hammer@web.de>
Reply-To: f.hammer@web.de
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_NvJsFoplHBdG/GB"
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
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_NvJsFoplHBdG/GB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi

according to this bug --> 
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2491
i attached the diff for commit.

regards
felix
_______________________________________
http://www.lehrsaiten.de
http://sourceforge.net/projects/pokerth

--Boundary-00=_NvJsFoplHBdG/GB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cmipci.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cmipci.diff"

--- alsa-driver-hg20070119/alsa-kernel/pci/cmipci.c	2006-12-21 02:00:15.000000000 +0100
+++ cmipci.c	2007-01-19 10:46:37.000000000 +0100
@@ -2779,6 +2779,13 @@
 	struct snd_opl3 *opl3;
 	int err;
 
+ 
+ 	if ( fm_port == 0 ) {
+ 		snd_cmipci_clear_bit(cm, CM_REG_MISC_CTRL, CM_FM_EN);
+ 		return 0;
+ 	}
+ 
+
 	/* first try FM regs in PCI port range */
 	iosynth = cm->iobase + CM_REG_FM_PCI;
 	err = snd_opl3_create(cm->card, iosynth, iosynth + 2,

--Boundary-00=_NvJsFoplHBdG/GB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_NvJsFoplHBdG/GB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_NvJsFoplHBdG/GB--
