From: "Sander van Leeuwen" <sandervl@xs4all.nl>
Subject: PATCH: Via82xx driver
Date: Thu, 19 Sep 2002 14:50:06 +0200 (CDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209191247.g8JClxR7031402@smtpzilla2.xs4all.nl>
References: <s5h1y7yuu0k.wl@alsa2.suse.de>
Reply-To: "Sander van Leeuwen" <sandervl@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1y7yuu0k.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

Below is a patch that fixes heap corruption in the via driver if the app uses a large nr of periods (> 128).
dev->idx_table is a snd_via_sg_table array, not an integer array.


--- via82xx.c	Fri Sep 13 13:22:46 2002
+++ via82xx.cn	Thu Sep 19 14:41:56 2002
@@ -217,7 +217,7 @@
 			return -ENOMEM;
 	}
 	if (! dev->idx_table) {
-		dev->idx_table = kmalloc(sizeof(unsigned int) * VIA_TABLE_SIZE, GFP_KERNEL);
+		dev->idx_table = kmalloc(sizeof(struct snd_via_sg_table) * VIA_TABLE_SIZE, GFP_KERNEL);
 		if (! dev->idx_table)
 			return -ENOMEM;
 	}




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
