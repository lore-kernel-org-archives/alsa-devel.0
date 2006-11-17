From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] make
	sound/pci/hda/patch_sigmatel.c:stac92xx_dmic_labels[] static
Date: Sat, 18 Nov 2006 00:58:20 +0100
Message-ID: <20061117235820.GL31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id E9B07272
	for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2006 00:58:22 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>, perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
>  git-alsa.patch
>...
>  git trees
>...

This patch makes the needlessly global stac92xx_dmic_labels[] static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/sound/pci/hda/patch_sigmatel.c.old	2006-11-17 18:36:16.000000000 +0100
+++ linux-2.6.19-rc5-mm2/sound/pci/hda/patch_sigmatel.c	2006-11-17 18:36:26.000000000 +0100
@@ -1201,7 +1201,7 @@
 }
 
 /* labels for dmic mux inputs */
-const char *stac92xx_dmic_labels[5] = {
+static const char *stac92xx_dmic_labels[5] = {
 	"Analog Inputs", "Digital Mic 1", "Digital Mic 2",
 	"Digital Mic 3", "Digital Mic 4"
 };


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
