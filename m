From: Jean-Marc Desprez <jean-marc.desprez@wanadoo.fr>
Subject: intel8x0
Date: Tue, 16 Dec 2003 22:21:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FDF776A.8030403@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080702080609020806010106"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080702080609020806010106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

hi,

I have a Dell computer with an onboard sound chip that is controled by 
intel8x0.c, and I noticed that the mixer main volume was ineffective, 
whereas the phone volume seemed to control the main volume.
with a couple of printk, I added a new entry to the quirk table to fix 
the main volume problem (see patch), but I am far from sure it can 
address all the problems

I hope the patch may help ...

regards

--------------080702080609020806010106
Content-Type: text/plain;
 name="intel8x0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="intel8x0.patch"

diff -Naur old/intel8x0.c new/intel8x0.c
--- old/intel8x0.c	2003-12-16 10:22:52.000000000 +0100
+++ new/intel8x0.c	2003-12-16 10:19:26.000000000 +0100
@@ -1690,6 +1690,12 @@
 		.name = "Hewlett-Packard onboard",
 		.type = AC97_TUNE_HP_ONLY
 	},
+	{
+		.vendor = 0x1028, 
+		.device = 0x0151, 
+		.name = "Intel i810 82801EB", 
+		.type = AC97_TUNE_SWAP_HP
+	},
 	{ } /* terminator */
 };
 

--------------080702080609020806010106--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
