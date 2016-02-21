From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v7 0/2] ASoC: Add SPDIF support for Allwinner SoCs
Date: Sun, 21 Feb 2016 12:13:36 +0100
Message-ID: <1456053218-16325-1-git-send-email-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBZNXU23AKGQEKWBBSUI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

For now just the SPDIF transmitter has been tested on a Mele A2000(A10)
and a Itead Ibox(A20).

In order for this patch set to be functional we require an audio clock patch
which will be delivered separately. For those that are interested I've pushed
the patches here with all the required changes to get SPDIF audio out of the
device.

https://github.com/codekipper/linux-sunxi/commits/spdif_delivery

Thanks in advance,
CK

---
Changes since v6:
- removed legacy dapm components that are no longer needed.
- changed dt-bindings patch subject styling to match that of the sound subsystem

Changes since v5:
- fixed warning that had sneaked in.

Changes since v4:
- corrected indentation issues
- removed old macros
- removed unnecessary enabling of apb clock

Changes since v3:
- removed code required for spdif capture
- added disable/enable of apb clk to suspend/resume.
- removed unnecessary dt checks in probe
- fixed error conditions in probe/resume
- modified pm_runtime functionality and confirmed that driver worked when PM was disabled.
- removed .owner from platform driver
- renamed bindings file

Changes since v2:
- removed sunxi-machine-spdif and replaced with simple audio card
- removed untested compatibilities from device tree documentation
- added pm_runtime and remove shutdown
- removed pll2 as it's the parent of the spdif clock
- rename clk to spdif_clk
- removed enabling of mclk output
- removed interrupts status being cleared as it's not being used
- use default fifo settings for now
- fixed alignments for wrapped lines

Changes since v1:
- Moved sunxi-machine-spdif.c to separate patch
- replaced sunxi in naming scheme with sun4i in the sun4i-spdif driver.
- split tx controller into separate enable/disable functions
- moved setclk and setfmt functionality into hw params
- added support for mono signals.
- cleaned up probe clock set up.
- removed all writes to transmit status registers.
- removed of_id
- removed power management code.
- Added support for more rates.

Marcus Cooper (2):
  ASoC: sunxi :add sun4i SPDIF dt bindings
  ASoC: sunxi: Add support for the SPDIF block

 .../bindings/sound/sunxi,sun4i-spdif.txt           |  39 ++
 sound/soc/sunxi/Kconfig                            |   8 +
 sound/soc/sunxi/Makefile                           |   1 +
 sound/soc/sunxi/sun4i-spdif.c                      | 542 +++++++++++++++++++++
 4 files changed, 590 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
 create mode 100644 sound/soc/sunxi/sun4i-spdif.c

-- 
2.7.1
