From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: BUG: possible deadlock detected! (sound) [Was:
	2.6.17-rc5-mm1]
Date: Tue, 30 May 2006 15:08:58 +0159
Message-ID: <447C4401.6070801@gmail.com>
References: <20060530022925.8a67b613.akpm@osdl.org>	
	<447C22CE.2060402@gmail.com>	
	<1148987188.3636.52.camel@laptopd505.fenrus.org>	
	<s5h3berd6ne.wl%tiwai@suse.de>
	<1148993947.3636.61.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A30E510C
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 15:09:07 +0200 (MEST)
Received: by nf-out-0910.google.com with SMTP id x29so110190nfb
	for <alsa-devel@alsa-project.org>; Tue, 30 May 2006 06:09:07 -0700 (PDT)
In-Reply-To: <1148993947.3636.61.camel@laptopd505.fenrus.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, James@superbug.demon.co.uk, linux-kernel@vger.kernel.org, emu10k1-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Arjan van de Ven napsal(a):
> On Tue, 2006-05-30 at 14:44 +0200, Takashi Iwai wrote:
>> This ops is a unique object assigned to a different "id" string.
>>
>> The first snd_seq_device_register_driver() called from emu10k1_synth.c
>> is the registration for the id "snd-synth-emu10k1".
>> Then in init_device(), the corresponding devices are initialized, and
>> one callback registers again another device for OSS sequencer with a
>> different id "snd-seq-oss" via snd_seq_device_new() inside the lock.
>> Now it hits the lock-detector but the lock should belong to a
>> different ops object in practice.
>>
>> This nested lock may happen only in two drivers, emu10k1-synth and
>> opl3, and only together with OSS emulation.  Since the OSS emulation
>> layer don't do active registration from itself, no deadlock should
>> happen (in theory -- I may oversee something :)
> 
> ok fair enough
> 
> Jiri, can you test the patch below? (I don't have this hardware)
Sure, but the day after tomorrow, I am going away from that machine now.
> 
> The ops structure has complex locking rules, where not all ops are
> equal, some are subordinate on others for some complex sound cards. This
> requires for lockdep checking that each individual reg_mutex is
> considered in separation for its locking rules.
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> 
> ---
>  sound/core/seq/seq_device.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.17-rc4-mm3-lockdep/sound/core/seq/seq_device.c
> ===================================================================
> --- linux-2.6.17-rc4-mm3-lockdep.orig/sound/core/seq/seq_device.c
> +++ linux-2.6.17-rc4-mm3-lockdep/sound/core/seq/seq_device.c
> @@ -46,6 +46,7 @@
>  #include <linux/kmod.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
> +#include <linux/lockdep.h>
>  
>  MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
>  MODULE_DESCRIPTION("ALSA sequencer device management");
> @@ -73,6 +74,8 @@ struct ops_list {
>  	struct mutex reg_mutex;
>  
>  	struct list_head list;	/* next driver */
> +
> +	struct lockdep_type_key reg_mutex_key;
>  };
>  
>  
> @@ -379,7 +382,7 @@ static struct ops_list * create_driver(c
>  
>  	/* set up driver entry */
>  	strlcpy(ops->id, id, sizeof(ops->id));
> -	mutex_init(&ops->reg_mutex);
> +	mutex_init_key(&ops->reg_mutex, id, &ops->reg_mutex_key);
>  	ops->driver = DRIVER_EMPTY;
>  	INIT_LIST_HEAD(&ops->dev_list);
>  	/* lock this instance */
> 
> 


- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEfEQAMsxVwznUen4RAkp4AJwOMUsBK4kvE54X/oxcdcIWad8oGACghO2a
mZLtPAHamNSDsiNa1gOfgoE=
=CaIp
-----END PGP SIGNATURE-----
