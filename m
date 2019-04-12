From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/2] soundwire: fix Kconfig select/depend issues
Date: Fri, 12 Apr 2019 11:06:10 +0100
Message-ID: <189ee558-766c-0e94-9570-3bf283681795@linaro.org>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com
List-Id: alsa-devel@alsa-project.org



On 11/04/2019 20:28, Pierre-Louis Bossart wrote:
> 0-day/Kbuild starts complaining about missed module dependencies and
> compilation issues. Since codecs and soc drivers need to be compilable
> independently, let's fix this using the following model:
> 
> SOUNDWIRE_INTEL ---- select -----------
>                                        |
> 				      v
> REGMAP_SOUNDWIRE --- select ---> SOUNDWIRE_BUS
> 

Last time when I looked at this, Kconfig symbols SOUNDWIRE_BUS and 
SOUNDWIRE looked totally redundant and bit over done.

Removing SOUNDWIRE_BUS Kconfig did clean it up and made it bit more 
align with others.
regarding REGMAP_SOUNDWIRE, It should be selected by the codec/soundwire 
slave drivers isn't it?


------------------------------><-----------------------------------
diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 6ad5ef48b61e..8cd2ac650b50 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -44,7 +44,7 @@ config REGMAP_IRQ

  config REGMAP_SOUNDWIRE
  	tristate
-	depends on SOUNDWIRE_BUS
+	depends on SOUNDWIRE

  config REGMAP_SCCB
  	tristate
diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 5c8677e20b49..bcee4b101c8a 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -3,7 +3,7 @@
  #

  menuconfig SOUNDWIRE
-	bool "SoundWire support"
+	tristate "SoundWire support"
  	---help---
  	  SoundWire is a 2-Pin interface with data and clock line ratified
  	  by the MIPI Alliance. SoundWire is used for transporting data
@@ -16,17 +16,12 @@ if SOUNDWIRE

  comment "SoundWire Devices"

-config SOUNDWIRE_BUS
-	tristate
-	select REGMAP_SOUNDWIRE
-
  config SOUNDWIRE_CADENCE
  	tristate

  config SOUNDWIRE_INTEL
  	tristate "Intel SoundWire Master driver"
  	select SOUNDWIRE_CADENCE
-	select SOUNDWIRE_BUS
  	depends on X86 && ACPI && SND_SOC
  	---help---
  	  SoundWire Intel Master driver.
diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index f6fbb21d4e84..9d70d20ca3ce 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -1,10 +1,11 @@
  #
  # Makefile for soundwire core
  #

  #Bus Objs
-soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
-obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
+soundwire-objs= bus_type.o bus.o slave.o mipi_disco.o stream.o
+obj-$(CONFIG_SOUNDWIRE) += soundwire.o

  #Cadence Objs
  soundwire-cadence-objs := cadence_master.o
------------------------------><-----------------------------------

--srini
> 
> Pierre-Louis Bossart (2):
>    regmap: soundwire: fix Kconfig select/depend issue
>    soundwire: fix SOUNDWIRE_BUS option
> 
>   drivers/base/regmap/Kconfig | 3 ++-
>   drivers/soundwire/Kconfig   | 1 -
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
