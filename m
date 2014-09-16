From: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
Subject: [PATCH v3 0/4] Add Phytec pbab01 audio support
Date: Tue, 16 Sep 2014 11:08:19 +0300
Message-ID: <1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shawn.guo@freescale.com, kernel@pengutronix.de, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, perex@perex.cz, tiwai@suse.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

New phyFLEX board audio patchset version.

Defines from dt-bindings/sound/fsl-imx-audmux.h are now used in audmux
configuration instead of hardcoded register values.

Also patchset is now based on branch for-next from
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git which
means:

- removed #sound-dai-cells in ssi2 node since it was already moved to
  imx6qdl.dtsi;
- patch for imx_v6_v7_defconfig now enables only
  CONFIG_SND_SOC_TLV320AIC3X since CONFIG_SND_SIMPLE_CARD also was
  already enabled.
