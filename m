From: Takashi Sakamoto <mocchi.sakamoto113@gmail.com>
Subject: Re: [PATCH] ALSA: doc: Brush up the old
	writing-an-alsa-driver
Date: Thu, 18 Oct 2018 17:15:31 +0900 (JST)
Message-ID: <alpine.DEB.2.21.1810181712590.15898@laptop>
References: <20181017145742.4903-1-tiwai@suse.de>
 <adee5200-19a3-381f-b9e2-174133014375@sakamocchi.jp>
 <s5hva5zr8sf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1018476176-1539850537=:15898"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 36A46267546
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2018 10:15:40 +0200 (CEST)
Received: by mail-pf1-f196.google.com with SMTP id c25-v6so14526892pfe.6
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2018 01:15:40 -0700 (PDT)
In-Reply-To: <s5hva5zr8sf.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1018476176-1539850537=:15898
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 18 Oct 2018, Takashi Iwai wrote:
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH v2] ALSA: doc: Brush up the old writing-an-alsa-driver
>
> Slightly brushing up and throw the old dust away from my ancient
> writing-an-alsa-driver document.  The contents aren't changed so much
> but the obsoleted parts are dropped.
>
> Also, remove the date and the version number.  It's useless.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> v1->v2: Fix the added note section with a proper indentation
>
> .../kernel-api/writing-an-alsa-driver.rst     | 307 +++++++++---------
> 1 file changed, 149 insertions(+), 158 deletions(-)

Diff between v1/v2 looks good to me.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Regards

Takashi Sakamoto

> diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
> index a0b268466cb1..b37234afdfa1 100644
> --- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
> +++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
> @@ -3,8 +3,6 @@ Writing an ALSA Driver
> ======================
>
> :Author: Takashi Iwai <tiwai@suse.de>
> -:Date:   Oct 15, 2007
> -:Edition: 0.3.7
>
> Preface
> =======
> @@ -21,11 +19,6 @@ explain the general topic of linux kernel coding and doesn't cover
> low-level driver implementation details. It only describes the standard
> way to write a PCI sound driver on ALSA.
>
> -If you are already familiar with the older ALSA ver.0.5.x API, you can
> -check the drivers such as ``sound/pci/es1938.c`` or
> -``sound/pci/maestro3.c`` which have also almost the same code-base in
> -the ALSA 0.5.x tree, so you can compare the differences.
> -
> This document is still a draft version. Any feedback and corrections,
> please!!
>
> @@ -35,24 +28,7 @@ File Tree Structure
> General
> -------
>
> -The ALSA drivers are provided in two ways.
> -
> -One is the trees provided as a tarball or via cvs from the ALSA's ftp
> -site, and another is the 2.6 (or later) Linux kernel tree. To
> -synchronize both, the ALSA driver tree is split into two different
> -trees: alsa-kernel and alsa-driver. The former contains purely the
> -source code for the Linux 2.6 (or later) tree. This tree is designed
> -only for compilation on 2.6 or later environment. The latter,
> -alsa-driver, contains many subtle files for compiling ALSA drivers
> -outside of the Linux kernel tree, wrapper functions for older 2.2 and
> -2.4 kernels, to adapt the latest kernel API, and additional drivers
> -which are still in development or in tests. The drivers in alsa-driver
> -tree will be moved to alsa-kernel (and eventually to the 2.6 kernel
> -tree) when they are finished and confirmed to work fine.
> -
> -The file tree structure of ALSA driver is depicted below. Both
> -alsa-kernel and alsa-driver have almost the same file structure, except
> -for “core” directory. It's named as “acore” in alsa-driver tree.
> +The file tree structure of ALSA driver is depicted below.
>
> ::
>
> @@ -61,14 +37,11 @@ for “core” directory. It's named as “acore” in alsa-driver tree.
>                             /oss
>                             /seq
>                                     /oss
> -                                    /instr
> -                    /ioctl32
>                     /include
>                     /drivers
>                             /mpu401
>                             /opl3
>                     /i2c
> -                            /l3
>                     /synth
>                             /emux
>                     /pci
> @@ -80,6 +53,7 @@ for “core” directory. It's named as “acore” in alsa-driver tree.
>                     /sparc
>                     /usb
>                     /pcmcia /(cards)
> +                    /soc
>                     /oss
>
>
> @@ -99,13 +73,6 @@ directory. The rawmidi OSS emulation is included in the ALSA rawmidi
> code since it's quite small. The sequencer code is stored in
> ``core/seq/oss`` directory (see `below <#core-seq-oss>`__).
>
> -core/ioctl32
> -~~~~~~~~~~~~
> -
> -This directory contains the 32bit-ioctl wrappers for 64bit architectures
> -such like x86-64, ppc64 and sparc64. For 32bit and alpha architectures,
> -these are not compiled.
> -
> core/seq
> ~~~~~~~~
>
> @@ -119,11 +86,6 @@ core/seq/oss
>
> This contains the OSS sequencer emulation codes.
>
> -core/seq/instr
> -~~~~~~~~~~~~~~
> -
> -This directory contains the modules for the sequencer instrument layer.
> -
> include directory
> -----------------
>
> @@ -161,11 +123,6 @@ Although there is a standard i2c layer on Linux, ALSA has its own i2c
> code for some cards, because the soundcard needs only a simple operation
> and the standard i2c API is too complicated for such a purpose.
>
> -i2c/l3
> -~~~~~~
> -
> -This is a sub-directory for ARM L3 i2c.
> -
> synth directory
> ---------------
>
> @@ -209,11 +166,19 @@ The PCMCIA, especially PCCard drivers will go here. CardBus drivers will
> be in the pci directory, because their API is identical to that of
> standard PCI cards.
>
> +soc directory
> +-------------
> +
> +This directory contains the codes for ASoC (ALSA System on Chip)
> +layer including ASoC core, codec and machine drivers.
> +
> oss directory
> -------------
>
> -The OSS/Lite source files are stored here in Linux 2.6 (or later) tree.
> -In the ALSA driver tarball, this directory is empty, of course :)
> +Here contains OSS/Lite codes.
> +All codes have been deprecated except for dmasound on m68k as of
> +writing this.
> +
>
> Basic Flow for PCI Drivers
> ==========================
> @@ -352,10 +317,8 @@ to details explained in the following section.
>
>               /* (3) */
>               err = snd_mychip_create(card, pci, &chip);
> -              if (err < 0) {
> -                      snd_card_free(card);
> -                      return err;
> -              }
> +              if (err < 0)
> +                      goto error;
>
>               /* (4) */
>               strcpy(card->driver, "My Chip");
> @@ -368,22 +331,23 @@ to details explained in the following section.
>
>               /* (6) */
>               err = snd_card_register(card);
> -              if (err < 0) {
> -                      snd_card_free(card);
> -                      return err;
> -              }
> +              if (err < 0)
> +                      goto error;
>
>               /* (7) */
>               pci_set_drvdata(pci, card);
>               dev++;
>               return 0;
> +
> +      error:
> +              snd_card_free(card);
> +	      return err;
>       }
>
>       /* destructor -- see the "Destructor" sub-section */
>       static void snd_mychip_remove(struct pci_dev *pci)
>       {
>               snd_card_free(pci_get_drvdata(pci));
> -              pci_set_drvdata(pci, NULL);
>       }
>
>
> @@ -445,14 +409,26 @@ In this part, the PCI resources are allocated.
>   struct mychip *chip;
>   ....
>   err = snd_mychip_create(card, pci, &chip);
> -  if (err < 0) {
> -          snd_card_free(card);
> -          return err;
> -  }
> +  if (err < 0)
> +          goto error;
>
> The details will be explained in the section `PCI Resource
> Management`_.
>
> +When something goes wrong, the probe function needs to deal with the
> +error.  In this example, we have a single error handling path placed
> +at the end of the function.
> +
> +::
> +
> +  error:
> +          snd_card_free(card);
> +	  return err;
> +
> +Since each component can be properly freed, the single
> +:c:func:`snd_card_free()` call should suffice in most cases.
> +
> +
> 4) Set the driver ID and name strings.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> @@ -486,10 +462,8 @@ too.
> ::
>
>   err = snd_card_register(card);
> -  if (err < 0) {
> -          snd_card_free(card);
> -          return err;
> -  }
> +  if (err < 0)
> +          goto error;
>
> Will be explained in the section `Management of Cards and
> Components`_, too.
> @@ -513,14 +487,13 @@ The destructor, remove callback, simply releases the card instance. Then
> the ALSA middle layer will release all the attached components
> automatically.
>
> -It would be typically like the following:
> +It would be typically just :c:func:`calling snd_card_free()`:
>
> ::
>
>   static void snd_mychip_remove(struct pci_dev *pci)
>   {
>           snd_card_free(pci_get_drvdata(pci));
> -          pci_set_drvdata(pci, NULL);
>   }
>
>
> @@ -546,7 +519,7 @@ in the source file. If the code is split into several files, the files
> without module options don't need them.
>
> In addition to these headers, you'll need ``<linux/interrupt.h>`` for
> -interrupt handling, and ``<asm/io.h>`` for I/O access. If you use the
> +interrupt handling, and ``<linux/io.h>`` for I/O access. If you use the
> :c:func:`mdelay()` or :c:func:`udelay()` functions, you'll need
> to include ``<linux/delay.h>`` too.
>
> @@ -720,6 +693,13 @@ function, which will call the real destructor.
>
> where :c:func:`snd_mychip_free()` is the real destructor.
>
> +The demerit of this method is the obviously more amount of codes.
> +The merit is, however, you can trigger the own callback at registering
> +and disconnecting the card via setting in snd_device_ops.
> +About the registering and disconnecting the card, see the subsections
> +below.
> +
> +
> Registration and Release
> ------------------------
>
> @@ -905,10 +885,8 @@ Resource Allocation
> -------------------
>
> The allocation of I/O ports and irqs is done via standard kernel
> -functions. Unlike ALSA ver.0.5.x., there are no helpers for that. And
> -these resources must be released in the destructor function (see below).
> -Also, on ALSA 0.9.x, you don't need to allocate (pseudo-)DMA for PCI
> -like in ALSA 0.5.x.
> +functions.  These resources must be released in the destructor
> +function (see below).
>
> Now assume that the PCI device has an I/O port with 8 bytes and an
> interrupt. Then :c:type:`struct mychip <mychip>` will have the
> @@ -1064,7 +1042,8 @@ and the allocation would be like below:
>
> ::
>
> -  if ((err = pci_request_regions(pci, "My Chip")) < 0) {
> +  err = pci_request_regions(pci, "My Chip");
> +  if (err < 0) {
>           kfree(chip);
>           return err;
>   }
> @@ -1086,6 +1065,21 @@ and the corresponding destructor would be:
>           ....
>   }
>
> +Of course, a modern way with :c:func:`pci_iomap()` will make things a
> +bit easier, too.
> +
> +::
> +
> +  err = pci_request_regions(pci, "My Chip");
> +  if (err < 0) {
> +          kfree(chip);
> +          return err;
> +  }
> +  chip->iobase_virt = pci_iomap(pci, 0, 0);
> +
> +which is paired with :c:func:`pci_iounmap()` at destructor.
> +
> +
> PCI Entries
> -----------
>
> @@ -1154,13 +1148,6 @@ And at last, the module entries:
> Note that these module entries are tagged with ``__init`` and ``__exit``
> prefixes.
>
> -Oh, one thing was forgotten. If you have no exported symbols, you need
> -to declare it in 2.2 or 2.4 kernels (it's not necessary in 2.6 kernels).
> -
> -::
> -
> -  EXPORT_NO_SYMBOLS;
> -
> That's all!
>
> PCM Interface
> @@ -2113,6 +2100,16 @@ non-contiguous buffers. The mmap calls this callback to get the page
> address. Some examples will be explained in the later section `Buffer
> and Memory Management`_, too.
>
> +mmap calllback
> +~~~~~~~~~~~~~~
> +
> +This is another optional callback for controlling mmap behavior.
> +Once when defined, PCM core calls this callback when a page is
> +memory-mapped instead of dealing via the standard helper.
> +If you need special handling (due to some architecture or
> +device-specific issues), implement everything here as you like.
> +
> +
> PCM Interrupt Handler
> ---------------------
>
> @@ -2370,6 +2367,27 @@ to define the inverse rule:
>                       hw_rule_format_by_channels, NULL,
>                       SNDRV_PCM_HW_PARAM_CHANNELS, -1);
>
> +One typical usage of the hw constraints is to align the buffer size
> +with the period size.  As default, ALSA PCM core doesn't enforce the
> +buffer size to be aligned with the period size.  For example, it'd be
> +possible to have a combination like 256 period bytes with 999 buffer
> +bytes.
> +
> +Many device chips, however, require the buffer to be a multiple of
> +periods.  In such a case, call
> +:c:func:`snd_pcm_hw_constraint_integer()` for
> +``SNDRV_PCM_HW_PARAM_PERIODS``.
> +
> +::
> +
> +  snd_pcm_hw_constraint_integer(substream->runtime,
> +                                SNDRV_PCM_HW_PARAM_PERIODS);
> +
> +This assures that the number of periods is integer, hence the buffer
> +size is aligned with the period size.
> +
> +The hw constraint is a very much powerful mechanism to define the
> +preferred PCM configuration, and there are relevant helpers.
> I won't give more details here, rather I would like to say, “Luke, use
> the source.”
>
> @@ -3712,7 +3730,14 @@ example, for an intermediate buffer. Since the allocated pages are not
> contiguous, you need to set the ``page`` callback to obtain the physical
> address at every offset.
>
> -The implementation of ``page`` callback would be like this:
> +The easiest way to achieve it would be to use
> +:c:func:`snd_pcm_lib_alloc_vmalloc_buffer()` for allocating the buffer
> +via :c:func:`vmalloc()`, and set :c:func:`snd_pcm_sgbuf_ops_page()` to
> +the ``page`` callback.  At release, you need to call
> +:c:func:`snd_pcm_lib_free_vmalloc_buffer()`.
> +
> +If you want to implementation the ``page`` manually, it would be like
> +this:
>
> ::
>
> @@ -3848,7 +3873,9 @@ Power Management
>
> If the chip is supposed to work with suspend/resume functions, you need
> to add power-management code to the driver. The additional code for
> -power-management should be ifdef-ed with ``CONFIG_PM``.
> +power-management should be ifdef-ed with ``CONFIG_PM``, or annotated
> +with __maybe_unused attribute; otherwise the compiler will complain
> +you.
>
> If the driver *fully* supports suspend/resume that is, the device can be
> properly resumed to its state when suspend was called, you can set the
> @@ -3879,18 +3906,16 @@ the case of PCI drivers, the callbacks look like below:
>
> ::
>
> -  #ifdef CONFIG_PM
> -  static int snd_my_suspend(struct pci_dev *pci, pm_message_t state)
> +  static int __maybe_unused snd_my_suspend(struct device *dev)
>   {
>           .... /* do things for suspend */
>           return 0;
>   }
> -  static int snd_my_resume(struct pci_dev *pci)
> +  static int __maybe_unused snd_my_resume(struct device *dev)
>   {
>           .... /* do things for suspend */
>           return 0;
>   }
> -  #endif
>
> The scheme of the real suspend job is as follows.
>
> @@ -3909,18 +3934,14 @@ The scheme of the real suspend job is as follows.
>
> 6. Stop the hardware if necessary.
>
> -7. Disable the PCI device by calling
> -   :c:func:`pci_disable_device()`. Then, call
> -   :c:func:`pci_save_state()` at last.
> -
> A typical code would be like:
>
> ::
>
> -  static int mychip_suspend(struct pci_dev *pci, pm_message_t state)
> +  static int __maybe_unused mychip_suspend(struct device *dev)
>   {
>           /* (1) */
> -          struct snd_card *card = pci_get_drvdata(pci);
> +          struct snd_card *card = dev_get_drvdata(dev);
>           struct mychip *chip = card->private_data;
>           /* (2) */
>           snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
> @@ -3932,9 +3953,6 @@ A typical code would be like:
>           snd_mychip_save_registers(chip);
>           /* (6) */
>           snd_mychip_stop_hardware(chip);
> -          /* (7) */
> -          pci_disable_device(pci);
> -          pci_save_state(pci);
>           return 0;
>   }
>
> @@ -3943,44 +3961,35 @@ The scheme of the real resume job is as follows.
>
> 1. Retrieve the card and the chip data.
>
> -2. Set up PCI. First, call :c:func:`pci_restore_state()`. Then
> -   enable the pci device again by calling
> -   :c:func:`pci_enable_device()`. Call
> -   :c:func:`pci_set_master()` if necessary, too.
> +2. Re-initialize the chip.
>
> -3. Re-initialize the chip.
> +3. Restore the saved registers if necessary.
>
> -4. Restore the saved registers if necessary.
> +4. Resume the mixer, e.g. calling :c:func:`snd_ac97_resume()`.
>
> -5. Resume the mixer, e.g. calling :c:func:`snd_ac97_resume()`.
> +5. Restart the hardware (if any).
>
> -6. Restart the hardware (if any).
> -
> -7. Call :c:func:`snd_power_change_state()` with
> +6. Call :c:func:`snd_power_change_state()` with
>    ``SNDRV_CTL_POWER_D0`` to notify the processes.
>
> A typical code would be like:
>
> ::
>
> -  static int mychip_resume(struct pci_dev *pci)
> +  static int __maybe_unused mychip_resume(struct pci_dev *pci)
>   {
>           /* (1) */
> -          struct snd_card *card = pci_get_drvdata(pci);
> +          struct snd_card *card = dev_get_drvdata(dev);
>           struct mychip *chip = card->private_data;
>           /* (2) */
> -          pci_restore_state(pci);
> -          pci_enable_device(pci);
> -          pci_set_master(pci);
> -          /* (3) */
>           snd_mychip_reinit_chip(chip);
> -          /* (4) */
> +          /* (3) */
>           snd_mychip_restore_registers(chip);
> -          /* (5) */
> +          /* (4) */
>           snd_ac97_resume(chip->ac97);
> -          /* (6) */
> +          /* (5) */
>           snd_mychip_restart_chip(chip);
> -          /* (7) */
> +          /* (6) */
>           snd_power_change_state(card, SNDRV_CTL_POWER_D0);
>           return 0;
>   }
> @@ -4046,15 +4055,14 @@ And next, set suspend/resume callbacks to the pci_driver.
>
> ::
>
> +  static SIMPLE_DEV_PM_OPS(snd_my_pm_ops, mychip_suspend, mychip_resume);
> +
>   static struct pci_driver driver = {
>           .name = KBUILD_MODNAME,
>           .id_table = snd_my_ids,
>           .probe = snd_my_probe,
>           .remove = snd_my_remove,
> -  #ifdef CONFIG_PM
> -          .suspend = snd_my_suspend,
> -          .resume = snd_my_resume,
> -  #endif
> +          .driver.pm = &snd_my_pm_ops,
>   };
>
> Module Parameters
> @@ -4078,7 +4086,7 @@ variables, instead. ``enable`` option is not always necessary in this
> case, but it would be better to have a dummy option for compatibility.
>
> The module parameters must be declared with the standard
> -``module_param()()``, ``module_param_array()()`` and
> +``module_param()``, ``module_param_array()`` and
> :c:func:`MODULE_PARM_DESC()` macros.
>
> The typical coding would be like below:
> @@ -4094,15 +4102,14 @@ The typical coding would be like below:
>   module_param_array(enable, bool, NULL, 0444);
>   MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
>
> -Also, don't forget to define the module description, classes, license
> -and devices. Especially, the recent modprobe requires to define the
> +Also, don't forget to define the module description and the license.
> +Especially, the recent modprobe requires to define the
> module license as GPL, etc., otherwise the system is shown as “tainted”.
>
> ::
>
> -  MODULE_DESCRIPTION("My Chip");
> +  MODULE_DESCRIPTION("Sound driver for My Chip");
>   MODULE_LICENSE("GPL");
> -  MODULE_SUPPORTED_DEVICE("{{Vendor,My Chip Name}}");
>
>
> How To Put Your Driver Into ALSA Tree
> @@ -4117,21 +4124,17 @@ a question now: how to put my own driver into the ALSA driver tree? Here
>
> Suppose that you create a new PCI driver for the card “xyz”. The card
> module name would be snd-xyz. The new driver is usually put into the
> -alsa-driver tree, ``alsa-driver/pci`` directory in the case of PCI
> -cards. Then the driver is evaluated, audited and tested by developers
> -and users. After a certain time, the driver will go to the alsa-kernel
> -tree (to the corresponding directory, such as ``alsa-kernel/pci``) and
> -eventually will be integrated into the Linux 2.6 tree (the directory
> -would be ``linux/sound/pci``).
> +alsa-driver tree, ``sound/pci`` directory in the case of PCI
> +cards.
>
> In the following sections, the driver code is supposed to be put into
> -alsa-driver tree. The two cases are covered: a driver consisting of a
> +Linux kernel tree. The two cases are covered: a driver consisting of a
> single source file and one consisting of several source files.
>
> Driver with A Single Source File
> --------------------------------
>
> -1. Modify alsa-driver/pci/Makefile
> +1. Modify sound/pci/Makefile
>
>    Suppose you have a file xyz.c. Add the following two lines
>
> @@ -4160,52 +4163,43 @@ Driver with A Single Source File
>
>    For the details of Kconfig script, refer to the kbuild documentation.
>
> -3. Run cvscompile script to re-generate the configure script and build
> -   the whole stuff again.
> -
> Drivers with Several Source Files
> ---------------------------------
>
> Suppose that the driver snd-xyz have several source files. They are
> -located in the new subdirectory, pci/xyz.
> +located in the new subdirectory, sound/pci/xyz.
>
> -1. Add a new directory (``xyz``) in ``alsa-driver/pci/Makefile`` as
> -   below
> +1. Add a new directory (``sound/pci/xyz``) in ``sound/pci/Makefile``
> +   as below
>
> ::
>
> -  obj-$(CONFIG_SND) += xyz/
> +  obj-$(CONFIG_SND) += sound/pci/xyz/
>
>
> -2. Under the directory ``xyz``, create a Makefile
> +2. Under the directory ``sound/pci/xyz``, create a Makefile
>
> ::
>
> -         ifndef SND_TOPDIR
> -         SND_TOPDIR=../..
> -         endif
> -
> -         include $(SND_TOPDIR)/toplevel.config
> -         include $(SND_TOPDIR)/Makefile.conf
> -
>          snd-xyz-objs := xyz.o abc.o def.o
> -
>          obj-$(CONFIG_SND_XYZ) += snd-xyz.o
>
> -         include $(SND_TOPDIR)/Rules.make
> -
> 3. Create the Kconfig entry
>
>    This procedure is as same as in the last section.
>
> -4. Run cvscompile script to re-generate the configure script and build
> -   the whole stuff again.
>
> Useful Functions
> ================
>
> :c:func:`snd_printk()` and friends
> ----------------------------------------
> +----------------------------------
> +
> +.. note:: This subsection describes a few helper functions for
> +   decorating a bit more on the standard :c:func:`printk()` & co.
> +   However, in general, the use of such helpers is no longer recommended.
> +   If possible, try to stick with the standard functions like
> +   :c:func:`dev_err()` or :c:func:`pr_err()`.
>
> ALSA provides a verbose version of the :c:func:`printk()` function.
> If a kernel config ``CONFIG_SND_VERBOSE_PRINTK`` is set, this function
> @@ -4221,13 +4215,10 @@ just like :c:func:`snd_printk()`. If the ALSA is compiled without
> the debugging flag, it's ignored.
>
> :c:func:`snd_printdd()` is compiled in only when
> -``CONFIG_SND_DEBUG_VERBOSE`` is set. Please note that
> -``CONFIG_SND_DEBUG_VERBOSE`` is not set as default even if you configure
> -the alsa-driver with ``--with-debug=full`` option. You need to give
> -explicitly ``--with-debug=detect`` option instead.
> +``CONFIG_SND_DEBUG_VERBOSE`` is set.
>
> :c:func:`snd_BUG()`
> -------------------------
> +-------------------
>
> It shows the ``BUG?`` message and stack trace as well as
> :c:func:`snd_BUG_ON()` at the point. It's useful to show that a
> @@ -4236,7 +4227,7 @@ fatal error happens there.
> When no debug flag is set, this macro is ignored.
>
> :c:func:`snd_BUG_ON()`
> -----------------------------
> +----------------------
>
> :c:func:`snd_BUG_ON()` macro is similar with
> :c:func:`WARN_ON()` macro. For example, snd_BUG_ON(!pointer); or
> -- 
> 2.19.0
>
>
--8323329-1018476176-1539850537=:15898
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--8323329-1018476176-1539850537=:15898--
