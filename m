From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH 1/3] ALSA: hda - Remove dependency on
 bus->pci in hda_beep.c
Date: Thu, 27 Feb 2014 09:32:21 -0800
Message-ID: <CAEUnVG4hXF46TCbRGgj13_cEBEXKsZEYxWb=RyV682++mi4pTA@mail.gmail.com>
References: <1392455855-10594-1-git-send-email-tiwai@suse.de>
 <s5hfvnkzq4y.wl%tiwai@suse.de> <5303A0A3.6050206@wwwdotorg.org>
 <s5hob23y01o.wl%tiwai@suse.de>
 <CAEUnVG4y+14Y8ManPPGVvcQjqpdyzBebLWcq7Sa6xQ3SwFRK+Q@mail.gmail.com>
 <s5hob1swyn0.wl%tiwai@suse.de>
 <CAEUnVG7B6B7wD0xDSi87vZj=WKJdY8ZokQ1zUKz_vknL9e=UkQ@mail.gmail.com>
 <s5h1tyowl16.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f181.google.com (mail-qc0-f181.google.com
 [209.85.216.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B08B26589B
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 18:32:42 +0100 (CET)
Received: by mail-qc0-f181.google.com with SMTP id c9so3639629qcz.12
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 09:32:41 -0800 (PST)
In-Reply-To: <s5h1tyowl16.wl%tiwai@suse.de>
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

On Thu, Feb 27, 2014 at 8:57 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 27 Feb 2014 08:44:48 -0800,
> Dylan Reid wrote:
>>
>> On Thu, Feb 27, 2014 at 4:03 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Wed, 19 Feb 2014 07:16:38 -0800,
>> > Dylan Reid wrote:
>> >>
>> >> On Wed, Feb 19, 2014 at 12:33 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> > At Tue, 18 Feb 2014 11:04:19 -0700,
>> >> > Stephen Warren wrote:
>> >> >>
>> >> >> On 02/15/2014 02:22 AM, Takashi Iwai wrote:
>> >> >> > At Sat, 15 Feb 2014 10:17:33 +0100,
>> >> >> > Takashi Iwai wrote:
>> >> >> >>
>> >> >> >> The default parent device can be obtained directly via card object, so
>> >> >> >> we don't need to rely on pci->dev.parent.  Since there is no access to
>> >> >> >> pci_dev, we can reduce the inclusion of linux/pci.h, too.
>> >> >> >>
>> >> >> >> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> >> >> >
>> >> >> > I forgot the cover page: these tree patches are trivial cleanups of
>> >> >> > hda-codec drivers (not the controller) to work without PCI device
>> >> >> > assignment. The idea was triggered by Dylan's question.
>> >> >>
>> >> >> The series seems fine to me, so briefly,
>> >> >> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>> >> >
>> >> > Thanks.  Any chance to work on / submit other changes for Tegra
>> >> > HD-audio support?
>> >>
>> >> That's the plan, hopefully I'll be able to find time to throw together
>> >> an RFC by the end of the week.
>> >
>> > Since there was no patch appearing yet, I merged my latest development
>> > branch to for-next branch, which includes lots of changes in
>> > hda_intel.c and hda_codec.c.  If any, please rebase your patches to
>> > it.
>>
>> Thanks for the heads up.  I've got a series that is almost ready, I'm
>> still trying to tease part of the build out from under CONFIG_PCI in
>> the hda makefile.
>
> I don't think we have a dependency on CONFIG_PCI in Makefile.  Kconfig
> has a dependency, but it can be easily reduced by a patch like below.

Sounds good.  I was looking at re-using some of the config options
(HDMI codec and power save) for the platform driver as well.  Maybe
something like the following.  SND_HDA would build the helper module
and hda-codec that are used by both hda_intel and a platform driver.

>
> Of course, it'd be better to move the whole hda directory out of pci,
> but we can do it later at any time once via git.

I can add that to the end of the series or it can move it whenever is
convenient, not sure how many pending patch sets it would disrupt.

Thanks!

Dylan

>
>>  I'll try to button that up and get a the whole lot
>> rebased on top of the for-next branch.
>
> Thanks!
>
>
> Takashi
>
> ---
> diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
> index 8756c8e32922..56d93bf45025 100644
> --- a/sound/pci/Kconfig
> +++ b/sound/pci/Kconfig
> @@ -578,8 +578,6 @@ config SND_FM801_TEA575X_BOOL
>           FM801 chip with a TEA5757 tuner (MediaForte SF256-PCS, SF256-PCP and
>           SF64-PCR) into the snd-fm801 driver.
>
> -source "sound/pci/hda/Kconfig"
> -
>  config SND_HDSP
>         tristate "RME Hammerfall DSP Audio"
>         select FW_LOADER
> @@ -889,3 +887,5 @@ config SND_YMFPCI
>           will be called snd-ymfpci.
>
>  endif  # SND_PCI
> +
> +source "sound/pci/hda/Kconfig"
> diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
> index f2032dd7e35e..6fc769da6949 100644
> --- a/sound/pci/hda/Kconfig
> +++ b/sound/pci/hda/Kconfig
> @@ -1,5 +1,6 @@
>  menuconfig SND_HDA_INTEL
>         tristate "Intel HD Audio"
> +       depends on (PCI || SOMETHING_YOU_WANT)
>         select SND_PCM
>         select SND_VMASTER
>         select SND_KCTL_JACK

---
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 8756c8e..56d93bf 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -578,8 +578,6 @@ config SND_FM801_TEA575X_BOOL
          FM801 chip with a TEA5757 tuner (MediaForte SF256-PCS, SF256-PCP and
          SF64-PCR) into the snd-fm801 driver.

-source "sound/pci/hda/Kconfig"
-
 config SND_HDSP
        tristate "RME Hammerfall DSP Audio"
        select FW_LOADER
@@ -889,3 +887,5 @@ config SND_YMFPCI
          will be called snd-ymfpci.

 endif  # SND_PCI
+
+source "sound/pci/hda/Kconfig"
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 0e53634..d983d24 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -1,5 +1,5 @@
-menuconfig SND_HDA_INTEL
-       tristate "Intel HD Audio"
+menuconfig SND_HDA
+       tristate "HD Audio"
        select SND_PCM
        select SND_VMASTER
        select SND_KCTL_JACK
@@ -10,9 +10,55 @@ menuconfig SND_HDA_INTEL
          This option enables the HD-audio controller.  Don't forget
          to choose the appropriate codec options below.

+config SND_HDA_INTEL
+       tristate "Intel HD Audio"
+       depends on SND_PCI
+       select SND_HDA
+       help
+         Say Y here to support standard PC HDA over PCI
+
+         This options enables support for HD Audio via PCI present on
+         most PCs.
+
          To compile this driver as a module, choose M here: the module
          will be called snd-hda-intel.

+config SND_HDA_TEGRA
+       tristate "Tegra HD Audio"
+       select SND_HDA
+       help
+         Say Y here to support the HDA controller present in Nvidia
+         Tegra SoCs
+
+         This options enables support for the HD Audio controller
+         present in some Nvidia Tegra SoCs, used to communicate audio
+         to the HDMI output.
+
+         To compile this driver as a module, choose M here: the module
+         will be called snd-hda-tegra.
+
+if SND_HDA_INTEL || SND_HDA_TEGRA
+
+config SND_HDA_CODEC_HDMI
+       tristate "Build HDMI/DisplayPort HD-audio codec support"
+       help
+         Say Y or M here to include HDMI and DisplayPort HD-audio codec
+         support in snd-hda-intel or tegra driver.  This includes all
+         AMD/ATI, Intel and Nvidia HDMI/DisplayPort codecs.
+
+comment "Set to Y if you want auto-loading the codec driver"
+       depends on SND_HDA_INTEL=y && SND_HDA_CODEC_HDMI=m
+
+config SND_HDA_POWER_SAVE_DEFAULT
+       int "Default time-out for HD-audio power-save mode"
+       depends on PM
+       default 0
+       help
+         The default time-out value in seconds for HD-audio automatic
+         power-save mode.  0 means to disable the power-save mode.
+
+endif
+
 if SND_HDA_INTEL

 config SND_HDA_DSP_LOADER
@@ -126,16 +172,6 @@ config SND_HDA_CODEC_VIA
 comment "Set to Y if you want auto-loading the codec driver"
        depends on SND_HDA_INTEL=y && SND_HDA_CODEC_VIA=m

-config SND_HDA_CODEC_HDMI
-       tristate "Build HDMI/DisplayPort HD-audio codec support"
-       help
-         Say Y or M here to include HDMI and DisplayPort HD-audio codec
-         support in snd-hda-intel driver.  This includes all AMD/ATI,
-         Intel and Nvidia HDMI/DisplayPort codecs.
-
-comment "Set to Y if you want auto-loading the codec driver"
-       depends on SND_HDA_INTEL=y && SND_HDA_CODEC_HDMI=m
-
 config SND_HDA_I915
        bool
        default y
@@ -220,12 +256,4 @@ config SND_HDA_GENERIC
 comment "Set to Y if you want auto-loading the codec driver"
        depends on SND_HDA_INTEL=y && SND_HDA_GENERIC=m

-config SND_HDA_POWER_SAVE_DEFAULT
-       int "Default time-out for HD-audio power-save mode"
-       depends on PM
-       default 0
-       help
-         The default time-out value in seconds for HD-audio automatic
-         power-save mode.  0 means to disable the power-save mode.
-
 endif
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index c5fa8e7..a964b6e 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -1,4 +1,6 @@
-snd-hda-intel-objs := hda_shared.o hda_intel.o
+snd-hda-intel-objs := hda_intel.o
+snd-hda-shared-objs := hda_shared.o
+snd-hda-tegra-objs := hda_tegra.o
 # for haswell power well
 snd-hda-intel-$(CONFIG_SND_HDA_I915) +=        hda_i915.o

@@ -25,7 +27,8 @@ snd-hda-codec-via-objs :=     patch_via.o
 snd-hda-codec-hdmi-objs :=     patch_hdmi.o hda_eld.o

 # common driver
-obj-$(CONFIG_SND_HDA_INTEL) := snd-hda-codec.o
+obj-$(CONFIG_SND_HDA) := snd-hda-codec.o
+obj-$(CONFIG_SND_HDA) += snd-hda-shared.o

 # codec drivers
 obj-$(CONFIG_SND_HDA_GENERIC) += snd-hda-codec-generic.o
@@ -45,3 +48,4 @@ obj-$(CONFIG_SND_HDA_CODEC_HDMI) += snd-hda-codec-hdmi.o
 # otherwise the codec patches won't be hooked before the PCI probe
 # when built in kernel
 obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-intel.o
+obj-$(CONFIG_SND_HDA_TEGRA) += snd-hda-tegra.o
