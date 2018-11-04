From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: skl: always select SND_SOC_HDAC_HDA
Date: Sun, 4 Nov 2018 10:45:17 -0600
Message-ID: <adc83eaa-b7c0-2c76-a434-f1d5872337f6@linux.intel.com>
References: <20181102112456.780127-1-arnd@arndb.de>
 <943d10e2-299c-4393-f2f5-4ac8bbe400c3@linux.intel.com>
 <CAK8P3a1FCVTuB+ydE6syMHYPWnUW0WTCFDuyMmm35VNnpTTGBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1FCVTuB+ydE6syMHYPWnUW0WTCFDuyMmm35VNnpTTGBw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Guneshwor Singh <guneshwor.o.singh@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Naveen Manohar <naveen.m@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 11/2/18 5:03 PM, Arnd Bergmann wrote:
> On 11/2/18, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
>> On 11/2/18 6:24 AM, Arnd Bergmann wrote:
>>> The skylake sound support is written to work both with or without
>>> CONFIG_SND_SOC_HDAC_HDA, and uses an #ifdef to decide whether it should
>>> link against that. However, this fails with SND_SOC_ALL_CODECS=m or
>>> SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m when the Skylake support itself
>>> is built-in, with this link error:
>>>
>>> sound/soc/intel/skylake/skl.o: In function `skl_probe':
>>> skl.c:(.text+0x56c): undefined reference to `snd_soc_hdac_hda_get_ops'
>>>
>>> Using an explicit 'select' here simplifies the logic and prevents
>>> it from happening, at the cost of always including the compile
>>> time dependency.
>> Thanks Arnd for the report. I don't quite agree with the proposal, this
>> should be similar to HDAC_HDMI which is not selected by default, and
>> there's no reason to force the support for HDAudio when the vast
>> majority of Skylake+ devices which enable this driver don't have any
>> HDaudio codec.
> Sure, feel free to treat this patch as a bug report and come up with
> a better fix.

I have to rewind my statement. Arnd is correct, the config cannot be the 
same as hdac_hdmi since there is a code dependency I completely missed.

So yes indeed we have to add a select HDAC_HDA statement under the 
SKYLAKE config - i just don't know of any other means to say "don't 
build HDAC_HDA as a module when SKYLAKE is buit-in"

That said, we can add a condition that will only select HDAC_HDA if 
required by the machine drivers selected. The patch below doesn't seem 
to have circular dependencies and compiles fine with Arnd's config. I 
thought of it while multitasking with "Home IT" work and haven't done 
any testing beyond compilation.  Arnd, can you give it a spin to see if 
this solves the issues?

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9cc4f1848c9b..91000924eb7c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -627,6 +627,14 @@ config SND_SOC_HDAC_HDA
         tristate
         select SND_HDA

+config SND_SOC_HDAC_HDA_CODEC
+       bool
+       help
+        This config is set by machine drivers who need SND_SOC_HDAC_HDA,
+        which is selected by the platform drivers (Skylake or SOF) based
+        on the value of this boolean. This indirection is required to deal
+        with a code dependency between platform driver and codec driver.
+
  config SND_SOC_ICS43432
         tristate

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 0caa1f4eb94d..25f3bca5e56d 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -107,6 +107,7 @@ config SND_SOC_INTEL_SKYLAKE_SSP_CLK
  config SND_SOC_INTEL_SKYLAKE
         tristate "SKL/BXT/KBL/GLK/CNL... Platforms"
         depends on PCI && ACPI
+       select SND_SOC_HDAC_HDA if SND_SOC_HDAC_HDA_CODEC
         select SND_HDA_EXT_CORE
         select SND_HDA_DSP_LOADER
         select SND_SOC_TOPOLOGY
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 73ca1350aa31..5e7d3f4aa3ff 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -296,7 +296,7 @@ config SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH
  config SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
         tristate "SKL/KBL/BXT/APL with HDA Codecs"
         select SND_SOC_HDAC_HDMI
-       select SND_SOC_HDAC_HDA
+       select SND_SOC_HDAC_HDA_CODEC
         help
           This adds support for ASoC machine driver for Intel platforms
           SKL/KBL/BXT/APL with iDisp, HDA audio codecs.
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 29225623b4b4..e0dda3fd689b 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -870,7 +870,7 @@ static int skl_create(struct pci_dev *pci,
         hbus = skl_to_hbus(skl);
         bus = skl_to_bus(skl);

-#if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDA)
+#if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDA_CODEC)
         ext_ops = snd_soc_hdac_hda_get_ops();
  #endif
         snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, 
ext_ops);
