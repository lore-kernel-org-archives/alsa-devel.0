From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: BUG: possible deadlock detected! (sound) [Was:
	2.6.17-rc5-mm1]
Date: Tue, 30 May 2006 14:59:06 +0200
Message-ID: <1148993947.3636.61.camel@laptopd505.fenrus.org>
References: <20060530022925.8a67b613.akpm@osdl.org>
	<447C22CE.2060402@gmail.com>
	<1148987188.3636.52.camel@laptopd505.fenrus.org>
	<s5h3berd6ne.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from laptopd505.fenrus.org (a222036.upc-a.chello.nl [62.163.222.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 29BC914F
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 14:59:10 +0200 (MEST)
In-Reply-To: <s5h3berd6ne.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, Jiri Slaby <jirislaby@gmail.com>, James@superbug.demon.co.uk, linux-kernel@vger.kernel.org, emu10k1-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-05-30 at 14:44 +0200, Takashi Iwai wrote:
> This ops is a unique object assigned to a different "id" string.
> 
> The first snd_seq_device_register_driver() called from emu10k1_synth.c
> is the registration for the id "snd-synth-emu10k1".
> Then in init_device(), the corresponding devices are initialized, and
> one callback registers again another device for OSS sequencer with a
> different id "snd-seq-oss" via snd_seq_device_new() inside the lock.
> Now it hits the lock-detector but the lock should belong to a
> different ops object in practice.
> 
> This nested lock may happen only in two drivers, emu10k1-synth and
> opl3, and only together with OSS emulation.  Since the OSS emulation
> layer don't do active registration from itself, no deadlock should
> happen (in theory -- I may oversee something :)

ok fair enough

Jiri, can you test the patch below? (I don't have this hardware)

The ops structure has complex locking rules, where not all ops are
equal, some are subordinate on others for some complex sound cards. This
requires for lockdep checking that each individual reg_mutex is
considered in separation for its locking rules.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 sound/core/seq/seq_device.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc4-mm3-lockdep/sound/core/seq/seq_device.c
===================================================================
--- linux-2.6.17-rc4-mm3-lockdep.orig/sound/core/seq/seq_device.c
+++ linux-2.6.17-rc4-mm3-lockdep/sound/core/seq/seq_device.c
@@ -46,6 +46,7 @@
 #include <linux/kmod.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
+#include <linux/lockdep.h>
 
 MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("ALSA sequencer device management");
@@ -73,6 +74,8 @@ struct ops_list {
 	struct mutex reg_mutex;
 
 	struct list_head list;	/* next driver */
+
+	struct lockdep_type_key reg_mutex_key;
 };
 
 
@@ -379,7 +382,7 @@ static struct ops_list * create_driver(c
 
 	/* set up driver entry */
 	strlcpy(ops->id, id, sizeof(ops->id));
-	mutex_init(&ops->reg_mutex);
+	mutex_init_key(&ops->reg_mutex, id, &ops->reg_mutex_key);
 	ops->driver = DRIVER_EMPTY;
 	INIT_LIST_HEAD(&ops->dev_list);
 	/* lock this instance */
