From: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/4] ASoC davinci/tlv320aic3x updates, fixes & DT support
Date: Thu, 31 Jan 2013 16:53:09 +0530
Message-ID: <1359631394-9511-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
List-Id: alsa-devel@alsa-project.org

1. Convert tlv320aic3x mic bias to a supply widget and related machine driver
2. Add DT support for Davinci machine platform
3. remove __dev* attributes

This patch-set is tested on Davinci platform (DA850 EVM). This series applies on
top of tag next-20130128 git tree
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

These patches cannot be tested directly on mainline kernel (DT based).
This is because dma is not yet completely ported to Davinci ASoC. I had to add
few hacks to get Audio working on Davinci DA850 platform.

For reference, I have placed the entire working tree @ 
Tree :  https://github.com/ghebbar/linux.git
Branch : dev_next-20130128_davinci_asoc_dt_v3

changes in v3
	- drop mcasp pinctrl handler patch from seried as it is now handled
	  centrally.
	- Convert tlv320aic3x mic bias to a supply widget and related machine
	  driver
	- remove __dev* attributes

Changes in V2
	 - Remove reference to Linux & software details from DT binding

Hebbar Gururaja (3):
  ASoC: tlv320aic3x: Convert mic bias to a supply widget
  ASoC: davinci: update machine driver dapm routes
  ASoC: davinci: remove __dev* attributes

Hebbar, Gururaja (1):
  ASoC: davinci: machine: Add device tree binding

 .../bindings/sound/davinci-evm-audio.txt           |   53 ++++++
 .../devicetree/bindings/sound/tlv320aic3x.txt      |    6 +
 include/sound/tlv320aic3x.h                        |   10 ++
 sound/soc/codecs/tlv320aic3x.c                     |   83 ++++++++-
 sound/soc/codecs/tlv320aic3x.h                     |    4 +
 sound/soc/davinci/davinci-evm.c                    |  185 +++++++++++++++++---
 6 files changed, 312 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt

-- 
1.7.9.5
