From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] sound drivers select'ing ISAPNP must depend on PNP && ISA
Date: Tue, 19 Jul 2005 18:36:40 +0200
Message-ID: <20050719163640.GK5031__12476.286190986$1121793826$gmane$org@stusta.de>
References: <Pine.LNX.4.58.0507171702030.12446@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 93845168
	for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2005 18:36:46 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507171702030.12446@be1.lrz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bodo Eggert <7eggert@gmx.de>, perex@suse.cz
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 17, 2005 at 05:07:48PM +0200, Bodo Eggert wrote:

> In sound/isa/Kconfig, select ISAPNP and depend on ISAPNP are intermixed, 
> resulting in funny behaviour. (Soundcarts get selectable if other 
> soundcards are selected).
> 
> This patch changes the "depend on ISAPNP"s to select.
>...

I like the idea of this patch, but it brings to more drivers to a 
violation of the "if you select something, you have to ensure that the 
dependencies of what you select are fulfilled" rule causing link errors 
with invalid .config's.

This patch (on top of your patch) fixes this problem.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/isa/Kconfig |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

--- linux-2.6.13-rc3-mm1-full/sound/isa/Kconfig.old	2005-07-19 18:27:21.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/sound/isa/Kconfig	2005-07-19 18:28:44.000000000 +0200
@@ -15,7 +15,7 @@
 
 config SND_AD1816A
 	tristate "Analog Devices SoundPort AD1816A"
-	depends on SND
+	depends on SND && PNP && ISA
 	select ISAPNP
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
@@ -81,7 +81,7 @@
 
 config SND_ES968
 	tristate "Generic ESS ES968 driver"
-	depends on SND
+	depends on SND && PNP && ISA
 	select ISAPNP
 	select SND_MPU401_UART
 	select SND_PCM
@@ -162,7 +162,7 @@
 
 config SND_INTERWAVE
 	tristate "AMD InterWave, Gravis UltraSound PnP"
-	depends on SND
+	depends on SND && PNP && ISA
 	select SND_RAWMIDI
 	select SND_CS4231_LIB
 	select SND_GUS_SYNTH
@@ -177,7 +177,7 @@
 
 config SND_INTERWAVE_STB
 	tristate "AMD InterWave + TEA6330T (UltraSound 32-Pro)"
-	depends on SND
+	depends on SND && PNP && ISA
 	select SND_RAWMIDI
 	select SND_CS4231_LIB
 	select SND_GUS_SYNTH
@@ -293,7 +293,7 @@
 
 config SND_ALS100
 	tristate "Avance Logic ALS100/ALS120"
-	depends on SND
+	depends on SND && PNP && ISA
 	select ISAPNP
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
@@ -307,7 +307,7 @@
 
 config SND_AZT2320
 	tristate "Aztech Systems AZT2320"
-	depends on SND
+	depends on SND && PNP && ISA
 	select ISAPNP
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
@@ -332,7 +332,7 @@
 
 config SND_DT019X
 	tristate "Diamond Technologies DT-019X, Avance Logic ALS-007"
-	depends on SND
+	depends on SND && PNP && ISA
 	select ISAPNP
 	select SND_OPL3_LIB
 	select SND_MPU401_UART



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
