From: Andreas Wittmann <andreas.wittmann@aon.at>
Subject: Clevo HDA subdevice 0x0660
Date: Thu, 20 Jul 2006 14:57:30 +0200
Message-ID: <44BF7DBA.6060907@aon.at>
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
List-Id: alsa-devel@alsa-project.org

Hi Mailinglist!

I'm the owner of a Notebook with a Clevo HDA Audio Chipset with a 
subdevice-value of 0x0660.

I've tried the newest Alsa-Version 1.0.12rc1 and the Linux Kernel 
2.6.17.6 but without success so i had to do some modifications by myself.

I've added the line

	/* Clevo m665n */
         { .pci_subvendor = 0x1558, .pci_subdevice = 0x0660, .config = 
ALC880_CLEVO },

to patch_realtek.c (after the "m520G NB" entry) of the hda repository in 
the linux kernel 2.6.17.6. It's a very quick and dirty hack but it 
work's for me. Speaker, Headphone, Microphone, Line-Out work's fine.

Best regards
Andy

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
