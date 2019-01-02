From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v5 08/11] ASoC: Intel: atom: Make PCI
 dependency explicit
Date: Wed, 2 Jan 2019 14:33:06 -0600
Message-ID: <57ed1d94-7f89-20e8-3289-7ef7efd18c20@linux.intel.com>
References: <20190102181038.4418-1-okaya@kernel.org>
 <20190102181038.4418-9-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------41396966F0FB1F9C35E77E1D"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190102181038.4418-9-okaya@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>, linux-next@vger.kernel.org
Cc: "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------41396966F0FB1F9C35E77E1D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I have three opens with this ACPI/PCI change

1. the baseline change fails on my cross-compilation checks, see below 
the result of the attached script (simplification of the one I use to 
avoid 0day reports).

2. there are different patterns to express the dependency on PCI e.g.

  config MMC_SDHCI_ACPI
      tristate "SDHCI support for ACPI enumerated SDHCI controllers"
      depends on MMC_SDHCI && ACPI
-    select IOSF_MBI if X86
+    select IOSF_MBI if (X86 && PCI)

but

config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
      tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
      default ACPI
-    depends on X86 && ACPI
+    depends on X86 && ACPI && PCI
      select SND_SST_IPC_ACPI
      select SND_SST_ATOM_HIFI2_PLATFORM
      select SND_SOC_ACPI_INTEL_MATCH

IOSF is only needed for Baytrail-CR detection, and the code will compile 
fine without it, so maybe it'd be a better model if you used the 
following diff?

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 2fd1b61e8331..68af0ea5c96c 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -95,7 +95,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
         select SND_SST_IPC_ACPI
         select SND_SST_ATOM_HIFI2_PLATFORM
         select SND_SOC_ACPI_INTEL_MATCH
-       select IOSF_MBI
+       select IOSF_MBI if PCI

3. All the Intel machine drivers depend on X86_INTEL_LPSS which depends 
on PCI. But for Baytrail/Haswell/Broadwell we have only a dependency on 
ACPI, so we expose drivers that can be selected but fail on probe since 
there are no machine drivers. I am not sure if we want to be strict and 
only expose meaningful configurations, or allow for more compilations 
tests and corner cases?

-Pierre


cross-compilation issue:

git checkout next-20190102

make CROSS_COMPILE=/opt/gcc-8.1.0-nolibc/ia64-linux/bin/ia64-linux- 
--jobs=16 allmodconfig ARCH=ia64
   HOSTCC  scripts/basic/fixdep
   HOSTCC  scripts/kconfig/conf.o
   YACC    scripts/kconfig/zconf.tab.c
   LEX     scripts/kconfig/zconf.lex.c
   HOSTCC  scripts/kconfig/confdata.o
   HOSTCC  scripts/kconfig/expr.o
   HOSTCC  scripts/kconfig/symbol.o
   YACC    scripts/kconfig/zconf.tab.h
   HOSTCC  scripts/kconfig/preprocess.o
   HOSTCC  scripts/kconfig/zconf.tab.o
   HOSTCC  scripts/kconfig/zconf.lex.o
   HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --allmodconfig Kconfig
arch/ia64/Kconfig:128:error: recursive dependency detected!
arch/ia64/Kconfig:128:    choice <choice> contains symbol IA64_HP_SIM
arch/ia64/Kconfig:202:    symbol IA64_HP_SIM is part of choice PM
kernel/power/Kconfig:144:    symbol PM is selected by PM_SLEEP
kernel/power/Kconfig:104:    symbol PM_SLEEP depends on HIBERNATE_CALLBACKS
kernel/power/Kconfig:31:    symbol HIBERNATE_CALLBACKS is selected by 
HIBERNATION
kernel/power/Kconfig:34:    symbol HIBERNATION depends on SWAP
init/Kconfig:250:    symbol SWAP depends on BLOCK
block/Kconfig:5:    symbol BLOCK is selected by UBIFS_FS
fs/ubifs/Kconfig:1:    symbol UBIFS_FS depends on MISC_FILESYSTEMS
fs/Kconfig:227:    symbol MISC_FILESYSTEMS is selected by ACPI_APEI
drivers/acpi/apei/Kconfig:8:    symbol ACPI_APEI depends on ACPI
drivers/acpi/Kconfig:9:    symbol ACPI depends on ARCH_SUPPORTS_ACPI
drivers/acpi/Kconfig:6:    symbol ARCH_SUPPORTS_ACPI is selected by 
IA64_HP_SIM
arch/ia64/Kconfig:202:    symbol IA64_HP_SIM is part of choice <choice>
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"


--------------41396966F0FB1F9C35E77E1D
Content-Type: text/plain; charset=UTF-8;
 name="cross-check._sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cross-check._sh"

IyEvYmluL2Jhc2gKCnNldCAtZQoKdGVzdF9mYXN0KCkgewoKICAgIFBMQVRGT1JNPSIkMSIK
ICAgIG1ha2UgbXJwcm9wZXIKICAgIC4uL21ha2UuY3Jvc3MgYWxsbW9kY29uZmlnIEFSQ0g9
JFBMQVRGT1JNCiAgICAuLi9tYWtlLmNyb3NzIG9sZGRlZmNvbmZpZyBBUkNIPSRQTEFURk9S
TSAgICAKICAgIC4uL21ha2UuY3Jvc3MgQVJDSD0kUExBVEZPUk0gbW9kdWxlc19wcmVwYXJl
Cn0KCnRlc3RfY29tcGlsZSgpIHsKCiAgICBQTEFURk9STT0iJDEiCiAgICBtYWtlIG1ycHJv
cGVyCiAgICAKICAgIG1ha2UgZGVmY29uZmlnIEFSQ0g9JFBMQVRGT1JNCiAgICAKICAgIGVj
aG8gIm1vZHVsZXMgZmlyc3QiCiAgICAuLi9tYWtlLmNyb3NzIEFSQ0g9JFBMQVRGT1JNCiAg
ICBpZiBbICIkUExBVEZPUk0iID0gIng4Nl82NCIgXTsgdGhlbgoJLi4vbWFrZS5jcm9zcyBi
aW5kZWItcGtnIEFSQ0g9JFBMQVRGT1JNCiAgICBmaQoKCiAgICBlY2hvICJhbGwgeWVzIHNl
Y29uZCIKICAgIHBlcmwgLXBpLmJhayAtZSAncy89bS89eS9nJyAuY29uZmlnCiAgICAuLi9t
YWtlLmNyb3NzIG9sZGRlZmNvbmZpZyBBUkNIPSRQTEFURk9STQogICAgLi4vbWFrZS5jcm9z
cyBBUkNIPSRQTEFURk9STQogICAgaWYgWyAiJFBMQVRGT1JNIiA9ICJ4ODZfNjQiIF07IHRo
ZW4KCS4uL21ha2UuY3Jvc3MgYmluZGViLXBrZyBBUkNIPSRQTEFURk9STQogICAgZmkKCn0K
CnRlc3RfcGxhdGZvcm0oKSB7CgogICAgUExBVEZPUk09IiQxIgogICAgICAgCiAgICB0ZXN0
X2Zhc3QgICAgJFBMQVRGT1JNCiMgICAgdGVzdF9jb21waWxlICRQTEFURk9STQp9Cgp0ZXN0
X3BsYXRmb3JtIHg4Nl82NAp0ZXN0X3BsYXRmb3JtIGkzODYKdGVzdF9wbGF0Zm9ybSBpYTY0
CnRlc3RfcGxhdGZvcm0gYXJtCnRlc3RfcGxhdGZvcm0gYXJtNjQKdGVzdF9wbGF0Zm9ybSBz
aAp0ZXN0X3BsYXRmb3JtIG1pcHMKdGVzdF9wbGF0Zm9ybSBzMzkwCnRlc3RfcGxhdGZvcm0g
b3BlbnJpc2MKdGVzdF9wbGF0Zm9ybSBzcGFyYwp0ZXN0X3BsYXRmb3JtIHNwYXJjNjQKdGVz
dF9wbGF0Zm9ybSBtNjhrCgplY2hvICJYLWNvbXBpbGF0aW9uIGNoZWNrIFBBU1MiCg==
--------------41396966F0FB1F9C35E77E1D--
