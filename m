From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [RFC 00/19] Enable platform HDA drivers
Date: Fri, 28 Feb 2014 00:31:05 -0800
Message-ID: <CAEUnVG4SqsbNfmjrKe=PWhsaLNCJLKTu4NbQS-Ym3bcqkkFiSg@mail.gmail.com>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
 <s5h1tynmzyr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f46.google.com (mail-qg0-f46.google.com
 [209.85.192.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 04C3C264F0A
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 09:31:26 +0100 (CET)
Received: by mail-qg0-f46.google.com with SMTP id e89so1234951qgf.5
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 00:31:25 -0800 (PST)
In-Reply-To: <s5h1tynmzyr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 27, 2014 at 11:57 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 27 Feb 2014 22:35:43 -0800,
> Dylan Reid wrote:
>>
>> This series rearranges some code in the HDA driver to break
>> dependencies on PCI and allow for most of the HDA code to be reused
>> for non-PCI based HDA controllers.
>>
>> I tried to break it up to make it less scary and to keep changes away
>> from copies of code.  It is mostly copies with a few modifications to
>> make more of the code usable by both HDA drivers.  The main changes
>> were to avoid using pci to get a device pointer, and to make the bus
>> reads/writes into callbacks so that the Tegra driver could ensure
>> 32-bit access to the HDA registers.
>>
>> The final patch is a work in progress included here to provide context
>> for the preceding patches.  The Tegra HDA driver still needs some
>> cleaning up, but nothing that will affect the other changes.  The last
>> infrastructure issue is that the Tegra driver uses DT, causing it to be
>> probed before the codec patches.  I haven't determined how to fix that
>> yet.
>>
>> I didn't include the patch to move the hda directory from under pci
>> because of its size and how easy it will be to regenerate later.
>>
>> Thanks for looking.  Let me know if you think any of these should be
>> squashed or re-ordered and if the changes and breakup of code makes
>> sense.
>
> The changes look almost good as I supposed.
> Through a quick glance, some random comments:
>
> - I prefer hda_controller.c (or something like that) to hda_shared.c.
>   It's a helper module for the controller drivers, after all.
>
> - mark_pages_wc() and co can be moved back to hda_intel.c.
>   Instead, provide the page allocator in ops, something like:
>
>         int (*alloc_pages)(struct azx *chip, int size,
>                                 struct snd_dma_buffer *buf);
>         void (*free_pages)(struct azx *chip, struct snd_dma_buffer *buf);
>
>   then X86-specific hacks can be done there.
>
> - The rest x86-specific hack is mmap.  Maybe this can be also handled
>   via an ops.  For non-x86, just call snd_pcm_lib_default_mmap()
>   (which is equivalent with pcm_ops.mmap = NULL).
>
> - There are lots of workarounds in the code, and which are really
>   needed for Tegra?  For example, bdl_pos_adj can be optional, and you
>   can put a NULL check for chip->bdl_pos_adj and handle as 0 in
>   azx_setup_periods().
>
>   The buffer position check can be back to hda_intel.c, too.  Instead,
>   we may give another ops, e.g.
>         bool (*position_check)(struct azx *, struct azx_dev *dev);
>   and call it (optionally) in the irq handler.  This checks the
>   validity of the position, return true if it's OK, else queue the
>   work, etc.
>
>   irqreturn_t azx_interrupt(int irq, void *dev_id)
>   {
>         .....
>                 if (status & azx_dev->sd_int_sta_mask) {
>                         ....
>                         /* check whether this IRQ is really acceptable */
>                         if (!chip->ops->position_check)
>                                 ok = true;
>                         else
>                                 ok = chip->ops->position_check(chip, azx_dev);
>                         if (ok) {
>                                 spin_unlock(&chip->reg_lock);
>                                 snd_pcm_period_elapsed(azx_dev->substream);
>                                 spin_lock(&chip->reg_lock);
>                         }
>
>   Then we can move azx_irq_pending_work() to hda_intel.c, too.

That'll be nice.  Thanks for the suggestions, I'll take a look at
re-spinning tomorrow morning.

>
>   I'm not sure whether position_fix stuff is better in the shared code
>   or not.  Many hardware have problems regarding this, so it'd be
>   still helpful to provide workarounds in the common code for future
>   hardware, too.

Maybe put it in the intel code for now and if another platform needs
it, then it can be pulled into the common area at that point.


Thanks,

Dylan

>
>
> thanks,
>
> Takashi
