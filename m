From: shivaken <shivaken@antshell.org>
Subject: Patch: for Maestro3 on SMP
Date: Fri, 25 Jul 2003 02:35:43 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307250236.05453.shivaken@antshell.org>
References: <E19fjn6-0006Fx-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19fjn6-0006Fx-00@sc8-sf-list2.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Maestro3 driver of linux-2.6.0-test1 (and may be before) has a problem with 
SMP. 
# cannot record properly and sometimes interrupted to play.

Here is a patch.
It worked fine. But I'm new for alsa.
So please test and check alsa-driver's maestro3.c

--- linux-2.6.0-test1/sound/pci/maestro3.c.orig	2003-07-14 12:34:50 +0900
+++ linux-2.6.0-test1/sound/pci/maestro3.c	2003-07-25 02:13:47 +0900
@@ -1526,9 +1526,15 @@
 snd_m3_pcm_pointer(snd_pcm_substream_t * subs)
 {
 	m3_t *chip = snd_pcm_substream_chip(subs);
+        size_t ptr;
+  
+        spin_lock(&chip->reg_lock);
 	m3_dma_t *s = (m3_dma_t*)subs->runtime->private_data;
 	snd_assert(s != NULL, return 0);
-	return bytes_to_frames(subs->runtime, snd_m3_get_pointer(chip, s, subs));
+        ptr = bytes_to_frames(subs->runtime, snd_m3_get_pointer(chip, s, 
subs));
+        spin_unlock(&chip->reg_lock);
+
+	return ptr;
 }

-- 
-- shivaken
antshell: Ant command line front end
http://www.antshell.org


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
