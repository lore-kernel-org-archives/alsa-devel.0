From: Adrian Bunk <bunk@stusta.de>
Subject: [patch] 2.6.9-rc4-mm1: ALSA compile error with KMOD=n
Date: Mon, 11 Oct 2004 22:15:33 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041011201533.GB1892__10142.2552638271$1097527692$gmane$org@stusta.de>
References: <20041011032502.299dc88d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 40B2D2B9
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2004 22:16:08 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>, perex@suse.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 11, 2004 at 03:25:02AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.9-rc3-mm3:
>...
>  bk-alsa.patch
>...


This causes the following compile error with CONFIG_KMOD=n:


<--  snip  -->

...
  CC      sound/core/seq/seq_device.o
sound/core/seq/seq_device.c: In function `snd_seq_device_register_driver':
sound/core/seq/seq_device.c:332: warning: implicit declaration of function `snd_seq_autoload_lock'
sound/core/seq/seq_device.c:335: warning: implicit declaration of function `snd_seq_autoload_unlock'
...
  LD      .tmp_vmlinux1
sound/built-in.o(.text+0xc9ae1): In function `snd_seq_device_register_driver':
: undefined reference to `snd_seq_autoload_lock'
sound/built-in.o(.text+0xc9af7): In function `snd_seq_device_register_driver':
: undefined reference to `snd_seq_autoload_unlock'
sound/built-in.o(.text+0xc9b27): In function `snd_seq_device_register_driver':
: undefined reference to `snd_seq_autoload_unlock'
sound/built-in.o(.text+0xc9b9e): In function `snd_seq_device_register_driver':
: undefined reference to `snd_seq_autoload_unlock'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The fix is simple:


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-rc4-mm1-full/sound/core/seq/seq_device.c.old	2004-10-11 21:40:10.000000000 +0200
+++ linux-2.6.9-rc4-mm1-full/sound/core/seq/seq_device.c	2004-10-11 21:40:38.000000000 +0200
@@ -41,6 +41,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/seq_device.h>
+#include <sound/seq_kernel.h>
 #include <sound/initval.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
