From: The Source <thesourcehim@gmail.com>
Subject: Re: snd-ctxfi
Date: Thu, 4 Jun 2009 07:48:47 +0400
Message-ID: <6d00fe310906032048m35a62a30ua6c23bcf656ea014@mail.gmail.com>
References: <4A20A683.9010102@gmail.com> <s5hr5y7hy77.wl%tiwai@suse.de>
	<4A215D56.7080601@gmail.com> <s5hmy8sfhfp.wl%tiwai@suse.de>
	<75b66ecd0906011847i7d74d878n8e734fe9e6031e4d@mail.gmail.com>
	<s5hoct7rwte.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f228.google.com (mail-ew0-f228.google.com
	[209.85.219.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AFF0103806
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 05:48:48 +0200 (CEST)
Received: by ewy28 with SMTP id 28so677023ewy.2
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 20:48:47 -0700 (PDT)
In-Reply-To: <s5hoct7rwte.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/6/2 Takashi Iwai <tiwai@suse.de>

> At Mon, 1 Jun 2009 21:47:02 -0400,
> Lee Revell wrote:
> >
> > On Mon, Jun 1, 2009 at 5:10 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > > Thanks.  So, something wrong in the mmap handling.
> > > I'll take a look later in this week.
> >
> > Looks like ct_map_audio_buffer calls ct_vm_map under spinlock;
> > ct_vm_map calls get_vm_block which calls kzalloc with GFP_KERNEL.
>
> Indeed.  Does the patch below fix the problem?
>
>
> thanks,
>
> Takashi
>
> ---
> diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
> index ead104e..1a4bb35 100644
> --- a/sound/pci/ctxfi/ctatc.c
> +++ b/sound/pci/ctxfi/ctatc.c
> @@ -119,7 +119,6 @@ atc_pcm_release_resources(struct ct_atc *atc, struct
> ct_atc_pcm *apcm);
>
>  static int ct_map_audio_buffer(struct ct_atc *atc, struct ct_atc_pcm
> *apcm)
>  {
> -       unsigned long flags;
>        struct snd_pcm_runtime *runtime;
>        struct ct_vm *vm;
>
> @@ -129,9 +128,7 @@ static int ct_map_audio_buffer(struct ct_atc *atc,
> struct ct_atc_pcm *apcm)
>        runtime = apcm->substream->runtime;
>        vm = atc->vm;
>
> -       spin_lock_irqsave(&atc->vm_lock, flags);
>        apcm->vm_block = vm->map(vm, runtime->dma_area, runtime->dma_bytes);
> -       spin_unlock_irqrestore(&atc->vm_lock, flags);
>
>        if (NULL == apcm->vm_block)
>                return -ENOENT;
> @@ -141,7 +138,6 @@ static int ct_map_audio_buffer(struct ct_atc *atc,
> struct ct_atc_pcm *apcm)
>
>  static void ct_unmap_audio_buffer(struct ct_atc *atc, struct ct_atc_pcm
> *apcm)
>  {
> -       unsigned long flags;
>        struct ct_vm *vm;
>
>        if (NULL == apcm->vm_block)
> @@ -149,9 +145,7 @@ static void ct_unmap_audio_buffer(struct ct_atc *atc,
> struct ct_atc_pcm *apcm)
>
>        vm = atc->vm;
>
> -       spin_lock_irqsave(&atc->vm_lock, flags);
>        vm->unmap(vm, apcm->vm_block);
> -       spin_unlock_irqrestore(&atc->vm_lock, flags);
>
>        apcm->vm_block = NULL;
>  }
> @@ -161,9 +155,7 @@ static unsigned long atc_get_ptp_phys(struct ct_atc
> *atc, int index)
>        struct ct_vm *vm;
>        void *kvirt_addr;
>        unsigned long phys_addr;
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&atc->vm_lock, flags);
>        vm = atc->vm;
>        kvirt_addr = vm->get_ptp_virt(vm, index);
>        if (kvirt_addr == NULL)
> @@ -171,8 +163,6 @@ static unsigned long atc_get_ptp_phys(struct ct_atc
> *atc, int index)
>        else
>                phys_addr = virt_to_phys(kvirt_addr);
>
> -       spin_unlock_irqrestore(&atc->vm_lock, flags);
> -
>        return phys_addr;
>  }
>
> @@ -1562,7 +1552,6 @@ int ct_atc_create(struct snd_card *card, struct
> pci_dev *pci,
>        atc_set_ops(atc);
>
>        spin_lock_init(&atc->atc_lock);
> -       spin_lock_init(&atc->vm_lock);
>
>        /* Find card model */
>        err = atc_identify_card(atc);
> diff --git a/sound/pci/ctxfi/ctatc.h b/sound/pci/ctxfi/ctatc.h
> index 286c993..a7b0ec2 100644
> --- a/sound/pci/ctxfi/ctatc.h
> +++ b/sound/pci/ctxfi/ctatc.h
> @@ -101,7 +101,6 @@ struct ct_atc {
>        unsigned long (*get_ptp_phys)(struct ct_atc *atc, int index);
>
>        spinlock_t atc_lock;
> -       spinlock_t vm_lock;
>
>        int (*pcm_playback_prepare)(struct ct_atc *atc,
>                                    struct ct_atc_pcm *apcm);
> diff --git a/sound/pci/ctxfi/ctvmem.c b/sound/pci/ctxfi/ctvmem.c
> index cecf77e..363b67e 100644
> --- a/sound/pci/ctxfi/ctvmem.c
> +++ b/sound/pci/ctxfi/ctvmem.c
> @@ -35,25 +35,27 @@ get_vm_block(struct ct_vm *vm, unsigned int size)
>        struct ct_vm_block *block = NULL, *entry = NULL;
>        struct list_head *pos = NULL;
>
> +       mutex_lock(&vm->lock);
>        list_for_each(pos, &vm->unused) {
>                entry = list_entry(pos, struct ct_vm_block, list);
>                if (entry->size >= size)
>                        break; /* found a block that is big enough */
>        }
>        if (pos == &vm->unused)
> -               return NULL;
> +               goto out;
>
>        if (entry->size == size) {
>                /* Move the vm node from unused list to used list directly
> */
>                list_del(&entry->list);
>                list_add(&entry->list, &vm->used);
>                vm->size -= size;
> -               return entry;
> +               block = entry;
> +               goto out;
>        }
>
>        block = kzalloc(sizeof(*block), GFP_KERNEL);
>        if (NULL == block)
> -               return NULL;
> +               goto out;
>
>        block->addr = entry->addr;
>        block->size = size;
> @@ -62,6 +64,8 @@ get_vm_block(struct ct_vm *vm, unsigned int size)
>        entry->size -= size;
>        vm->size -= size;
>
> + out:
> +       mutex_unlock(&vm->lock);
>        return block;
>  }
>
> @@ -70,6 +74,7 @@ static void put_vm_block(struct ct_vm *vm, struct
> ct_vm_block *block)
>        struct ct_vm_block *entry = NULL, *pre_ent = NULL;
>        struct list_head *pos = NULL, *pre = NULL;
>
> +       mutex_lock(&vm->lock);
>        list_del(&block->list);
>        vm->size += block->size;
>
> @@ -106,6 +111,7 @@ static void put_vm_block(struct ct_vm *vm, struct
> ct_vm_block *block)
>                pos = pre;
>                pre = pos->prev;
>        }
> +       mutex_unlock(&vm->lock);
>  }
>
>  /* Map host addr (kmalloced/vmalloced) to device logical addr. */
> @@ -191,6 +197,8 @@ int ct_vm_create(struct ct_vm **rvm)
>        if (NULL == vm)
>                return -ENOMEM;
>
> +       mutex_init(&vm->lock);
> +
>        /* Allocate page table pages */
>        for (i = 0; i < CT_PTP_NUM; i++) {
>                vm->ptp[i] = kmalloc(PAGE_SIZE, GFP_KERNEL);
> diff --git a/sound/pci/ctxfi/ctvmem.h b/sound/pci/ctxfi/ctvmem.h
> index 4eb5bdd..618952e 100644
> --- a/sound/pci/ctxfi/ctvmem.h
> +++ b/sound/pci/ctxfi/ctvmem.h
> @@ -20,7 +20,7 @@
>
>  #define CT_PTP_NUM     1       /* num of device page table pages */
>
> -#include <linux/spinlock.h>
> +#include <linux/mutex.h>
>  #include <linux/list.h>
>
>  struct ct_vm_block {
> @@ -35,6 +35,7 @@ struct ct_vm {
>        unsigned int size;              /* Available addr space in bytes */
>        struct list_head unused;        /* List of unused blocks */
>        struct list_head used;          /* List of used blocks */
> +       struct mutex lock;
>
>        /* Map host addr (kmalloced/vmalloced) to device logical addr. */
>        struct ct_vm_block *(*map)(struct ct_vm *, void *host_addr, int
> size);
>

I tried this patch (actually I downloaded the snapshot yesterday and patch
said it was already applied there), but my system can not boot at all with
this driver. It prints 'starting udev' at that's it. I removed the driver
and my system is back to normal.
