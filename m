From: olivier moysan <olivier.moysan@st.com>
Subject: [PATCH 0/2] Add STM32 SAI support
Date: Wed, 1 Feb 2017 17:16:15 +0100
Message-ID: <1485965777-22302-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CBF4267480
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2017 17:16:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com
List-Id: alsa-devel@alsa-project.org

This patch-set handles the Serial Audio Interface (SAI) IP on STM32 platforms.

The SAI IP is composed of two Sub-block A and B. (see the figure below)
Each sub-block makes use of individual and shared resources.

Shared resources:
	- Reset line. Reset common and sub-block registers.
	- Bus interface clocks. This clock is not exposed in device
	as it it managed by clock driver, according to kernel clocks gating.
	- Common register. SAI IP exhibits a common configuration register
	to manage synchronization modes. NB: These modes are not yet implemented
	in this version of the SAI driver.
	- Interrupt. Sub-blocks have their own interrupt status registers but they 
	share the same interrupt line.

Individual resources:
	- Register set
	- DMA request line.
	- Communication interface. 
	Each sub-block has its own GPIOs and associated bus lines.
	- Kernel clock. 
	Each sub-block has its own dedicated clock for its communication interface.

To reflect this architecture Sub-block A and B are handled by 2 child devices.
Sub-block A and B devices can be configured independently either as transmitter
or receiver. A PCM device is associated to each sub-block.
A sub-block has to select the appropriated parent clock at runtime, 
depending on the audio stream sampling rate.

 Interface clock  +--------------------------------+
+---------------> | SAI IP                         |
 Reset            |     +-----------------+        |
+---------------> |     |common registers |        |
                  |     +-----------------+        |
                  |                                |
                  |    +----------------------+    |
                  |    | Sub-block A          |    |
 Kernel clock A   |    |                      |    | Bus A
+--------------------> | +----------------+   +---------------->
                  |    | |A registers     |   |    |
                  |    | +----------------+   |    |
                  |    +----------------------+    |
                  |                                |
                  |    +----------------------+    |
                  |    | Sub-block B          |    |
 Kernel clock B   |    |                      |    | Bus B
+--------------------> | +----------------+   +----------------->
                  |    | |B registers     |   |    |
                  |    | +----------------+   |    |
                  |    +----------------------+    |
                  |                                |
                  +--------------------------------+

olivier moysan (2):
  ASoC: stm32: add bindings for SAI
  ASoC: stm32: add SAI driver

 .../devicetree/bindings/sound/st,stm32-sai.txt     |  79 ++
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/stm/Kconfig                              |   8 +
 sound/soc/stm/Makefile                             |   6 +
 sound/soc/stm/stm32_sai.c                          | 123 +++
 sound/soc/stm/stm32_sai.h                          | 202 +++++
 sound/soc/stm/stm32_sai_sub.c                      | 898 +++++++++++++++++++++
 8 files changed, 1318 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt
 create mode 100644 sound/soc/stm/Kconfig
 create mode 100644 sound/soc/stm/Makefile
 create mode 100644 sound/soc/stm/stm32_sai.c
 create mode 100644 sound/soc/stm/stm32_sai.h
 create mode 100644 sound/soc/stm/stm32_sai_sub.c

-- 
1.9.1
