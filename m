From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] sound/pci/ice1712/delta.c: make 2 functions static
Date: Mon, 13 Mar 2006 22:14:44 +0100
Message-ID: <20060313211444.GH13973__31870.8277809948$1142284643$gmane$org@stusta.de>
References: <20060312031036.3a382581.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 35EAB1CF
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2006 22:14:45 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20060312031036.3a382581.akpm@osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>, perex@suse.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 12, 2006 at 03:10:36AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc5-mm3:
>...
>  git-alsa.patch
>...
>  git trees
>...


This patch makes two needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/pci/ice1712/delta.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc6-mm1-full/sound/pci/ice1712/delta.c.old	2006-03-13 21:32:49.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/sound/pci/ice1712/delta.c	2006-03-13 21:33:25.000000000 +0100
@@ -393,7 +393,7 @@
 	snd_ice1712_delta_cs8403_spdif_write(ice, tmp);
 }
 
-int snd_ice1712_delta1010lt_wordclock_status_info(struct snd_kcontrol *kcontrol,
+static int snd_ice1712_delta1010lt_wordclock_status_info(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
@@ -403,7 +403,7 @@
 	return 0;
 }
 
-int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kcontrol,
+static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
 	char reg = 0x10; // cs8427 receiver error register



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
