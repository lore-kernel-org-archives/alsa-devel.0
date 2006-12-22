From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Update to Audioscience asihpi driver
Date: Fri, 22 Dec 2006 17:09:32 +1300
Message-ID: <200612221709.32864.linux@audioscience.com>
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Greetings,

Before 2006 is finished, heres an update...

Patch against alsa-driver hg revision 3207: (197K)
http://audioscience.com/internet/download/beta/alsa-driver-hg3207_asihpi30506.tar.bz2

Replacement contents for alsa-firmware/asihpi (1.3M)
http://audioscience.com/internet/download/beta/alsa-firmware_asihpi30506.tar.bz2

Based on 
http://audioscience.com/internet/download/hpklinux-3.05.06.tar.bz2

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Summary of changes: (see drvnotes_rc.txt included with the patch for full 
details)
* Update from hpklinux version 3.00 to 3.05.06
* Support 64 bit kernel
* Add ASI6600 PCI express, ASI6500 PCI cards
* Update ASI87xx for MPEG layer 2/3 record, Add PAL tv
* Add StreamRead/WriteBuf API,
* Fix error in ALSA capture parameters

regards

--
Eliot Blennerhassett
AudioScience Inc.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
