From: jayakumar.alsa@gmail.com
Subject: [PATCH 2.6.17-rc5 1/1] ALSA: cs5535audio trivial debug
	printk
Date: Sat, 10 Jun 2006 17:52:30 +0800
Message-ID: <200606100952.k5A9qUMd016091@localhost.localdomain>
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

Hi Takashi, Jaroslav,

Following is a trivial patch to get more info for boards where
the AC97_VENDOR_ID2 register (or others) time out.

Thanks,
Jaya Kumar

Signed-off-by: Jaya Kumar <jayakumar.alsa@gmail.com>

---
 
 cs5535audio.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

---

diff -X usbvideo.dontdiff -X linux-2.6.17-rc5/Documentation/dontdiff -uprN linux-2.6.17-rc5-ltv/sound/pci/cs5535audio/cs5535audio.c linux-2.6.17-rc5/sound/pci/cs5535audio/cs5535audio.c
--- linux-2.6.17-rc5-ltv/sound/pci/cs5535audio/cs5535audio.c	2006-05-25 19:27:33.000000000 +0800
+++ linux-2.6.17-rc5/sound/pci/cs5535audio/cs5535audio.c	2006-06-10 16:32:24.000000000 +0800
@@ -90,7 +90,8 @@ static unsigned short snd_cs5535audio_co
 		udelay(1);
 	} while (--timeout);
 	if (!timeout)
-		snd_printk(KERN_ERR "Failure reading cs5535 codec\n");
+		snd_printk(KERN_ERR "Failure reading codec reg 0x%x,"
+					"Last value=0x%x\n", reg, val);
 
 	return (unsigned short) val;
 }
