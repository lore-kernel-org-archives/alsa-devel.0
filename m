From: Roger E Critchlow Jr <rec@elf.org>
Subject: toshiba tecra + ymfpci doesn't work
Date: Tue, 26 Feb 2002 20:28:00 -0700
Message-ID: <15484.21056.76144.372006@elf2.elf.org>
References: <15470.43840.123238.223477@elf2.elf.org>
	<15482.38679.932097.408551@elf2.elf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from gull.prod.itd.earthlink.net (gull.mail.pas.earthlink.net [207.217.120.84])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id EAA12834
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2002 04:26:44 +0100
Received: from sdn-ar-003nmalbup023.dialsprint.net ([158.252.153.31] helo=elf6.elf.org)
	by gull.prod.itd.earthlink.net with esmtp (Exim 3.33 #1)
	id 16fujo-0003WT-00
	for alsa-devel@alsa-project.org; Tue, 26 Feb 2002 19:26:40 -0800
In-Reply-To: <15482.38679.932097.408551@elf2.elf.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Roger E Critchlow Jr <rec@elf.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Roger E Critchlow Jr writes:
 > 
 > The mixer reports itself as "Asahi Kasei (5)", is this an abbreviation
 > for the ak4545?
 > 

No, it's an Asahi Kasei codec with id=0x414b4d05 which must have come
between the AK4543 (id=0x414b4d02) and the AK4544A (id=0x414b4d06).
It isn't in the alsa-kernel/pci/ac97/ac97_codec.c table of known
codecs, so it's identified by vendor and the last byte of the id in
hex.

-- rec --
 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
