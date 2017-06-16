From: olivier moysan <olivier.moysan@st.com>
Subject: [PATCH 0/2] ASoC: stm32: add SPDIFRX driver
Date: Fri, 16 Jun 2017 15:57:30 +0200
Message-ID: <1497621452-615-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

This patch-set handles the SPDIFRX on STM32 platforms.

The SPDIFRX peripheral, is designed to receive an S/PDIF flow compliant with
IEC-60958 and IEC-61937 standards.

SPDIFRX uses two DMA channels:
- one DMA channel for S/PDIF data stream.
- one DMA channel for control flow (channel status and user data bits).

DMA is used for control flow instead of interrupts to get better performances,
as channel status and user data are retrieved byte per byte.

Note: This patch-set depends on "change SAI configuration flag" patch,
which introduces a change on Kconfig file.

olivier moysan (2):
  dt-bindings: Document the STM32 SPDIFRX interface
  ASoC: stm32: Add SPDIFRX support

 .../devicetree/bindings/sound/st,stm32-spdifrx.txt |  56 ++
 sound/soc/stm/Kconfig                              |  10 +
 sound/soc/stm/Makefile                             |   4 +
 sound/soc/stm/stm32_spdifrx.c                      | 998 +++++++++++++++++++++
 sound/soc/stm/stm32_spdifrx.h                      | 224 +++++
 5 files changed, 1292 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
 create mode 100644 sound/soc/stm/stm32_spdifrx.c
 create mode 100644 sound/soc/stm/stm32_spdifrx.h

-- 
1.9.1
