From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 0/5] ASoC: multi-component core update
Date: Tue, 10 Aug 2010 18:02:07 +0100
Message-ID: <1281459727.3059.151.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id C579924551
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 19:02:13 +0200 (CEST)
Received: by ewy21 with SMTP id 21so3809793ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 10:02:13 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: jassisinghbrar <jassisinghbrar@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Eric Miao <eric.y.miao@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kevin Hilman <khilman@deeprootsystems.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Manuel Lauss <manuel.lauss@googlemail.com>, dg <dg@emlix.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "timur.tabi@gmail.com" <timur.tabi@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <ryan@bluewatersys.com>, Wan ZongShun <mcuos.com@gmail.com>, anemo <anemo@mba.ocn.ne.jp>, "arnaud.patard" <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

ASoC is now coming up to it's 5th birthday *tomorrow* and is beginning
to show it's age a little when it comes to supporting the next
generation of smart phones and multimedia devices with it's current
single CODEC and single DMA platform design.

Historically, ASoC is designed around an embedded sound card with a
single CODEC and a single platform DMA driver (with multiple DAIs). This
design works great for most of the current audio hardware in use now,
however we are now seeing hardware designs for the next generation of
devices that can have many CODECs, DMAs, DSPs and a host of other audio
peripherals connected to the audio subsystem.

ASoC now needs to support the new audio hardware architectures with
multiple audio CODECs, DMA engines, DSPs, DAIs etc in order to keep
Linux audio working well on SoC based devices.
 
This patch series allows an ASoC sound card to support multiple
components (CODECs, DAI and DMA) and is the first part in a series of
work (other parts coming later in the year from Mark and I) designed to
enhance ASoC for modern mobile audio hardware.

This patch series provides the following important features:-

 1) Allow sound cards to have multiple CODECs and platform DMA
controllers.
 2) Allow CODEC drivers to support more than one CODEC device.
 3) Allow all CODEC, platform DMA and DAI drivers to have platform data.

This is achieved by: -

 1) Separating the component struct driver data from the component
struct device data.
 2) Making all components kernel devices.

(A side effect of this change is that we can now store all our component
private data in struct device private data (like everyone else does) and
there is also now less pointer indirection for components.)

The multi-component changes mainly affect only the probe() and remove()
sections of component drivers, the component enumeration section of the
core and the machine driver DAI link configuration. The core also now
handles setting up the CODEC data structs too (meaning CODEC drivers now
don't have to do this). All component PCM, DAPM and Kcontrol operations
remain unchanged.


I've so far tested the new multi-component enumeration on the TI OMAP
and Marvell PXA platforms with AC97, MFD and I2C based CODECs. I do
however need ASoC platform maintainers to test on their systems (as I
only have a subset of the hardware). Some ASOC platforms do need a
little extra checking/fixups too :- 

 o i.MX platform: required work to de-couple components (Sascha is now
fixing/testing this).
 o Injenic J4740 platform: I do not have a toolchain to even build this
arch so it will also need someone to build it too. Lars ?

If you find your platform does not work then the most likely reason is
that I'm missing a platform_device registration for your CODEC, DAI,
etc. device in your arch board.c or device.c files. Please let me know
or send a patch :)

All the multi-component code is in my topic/multi-component branch
here :-

git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git

This patch series post contains the changes to ASoC core only. I'll post
the multi-component CODEC and platform changes as separate patches in
order not to flood the list (as there are about 40 patches in all). This
patch series will eventually be rebased into a single patch for upstream
so we don't break bisect. The subsequent patches for CODECs and
platforms in this series can be found in the git branch above.

The intention is to merge now for the 2.6.37 merge window opening soon.
However, some platforms may require some remedial work to get them
working correctly and we should take this work as incremental changes
over the 2.6.37 merge window period. Most of the remedial work should be
minor in nature and I mostly expect changes to the device names. By
merging now (and not waiting on further remedial changes) means we will
not blocking new code in development (something that has been happening
lately). 

I've also squashed quite a lot of fixes and updates in this series, but
the multi-component support is also brought to you (in no particular
order) by Peter, Jarkko, Timur, Ryan, Chanwoo, Joonyoug, Kyungmin,
Jassi, Seungwhan and Sascha.

Liam Girdwood (5):
  ASoC: multi-component - Core Multi-component API
  ASoC: multi-component - DAPM Core
  ASoC: multi-component - ASoC Core
  ASoC: multi-component - Jack Core
  ASoC: multi-component - Cache Core

 include/sound/soc-dai.h  |   98 ++-
 include/sound/soc-dapm.h |    8 +-
 include/sound/soc.h      |  238 ++++---
 sound/soc/soc-cache.c    |   34 +-
 sound/soc/soc-core.c     | 1665 +++++++++++++++++++++++++++-------------------
 sound/soc/soc-dapm.c     |   88 ++--
 sound/soc/soc-jack.c     |   10 +-
 7 files changed, 1273 insertions(+), 868 deletions(-)
