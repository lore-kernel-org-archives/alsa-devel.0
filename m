From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 2/2] [RFC] da850evm: enable mcasp ping-pong
	buffers
Date: Fri, 13 May 2011 17:26:46 -0400
Message-ID: <2c7ebe78b4abdc0b9c5bf135b8b85a3770ee5502.1305321198.git.bengardiner@nanometrics.ca>
References: <cover.1305321198.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69])
	by alsa0.perex.cz (Postfix) with ESMTP id 28B7F1037FB
	for <alsa-devel@alsa-project.org>;
	Fri, 13 May 2011 23:26:53 +0200 (CEST)
Received: by mail-gy0-f173.google.com with SMTP id 4so1265197gyg.32
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2011 14:26:53 -0700 (PDT)
In-Reply-To: <cover.1305321198.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Troy Kisky <troy.kisky@boundarydevices.com>, Chaithrika U S <chaithrika@ti.com>, alsa-devel@alsa-project.org
Cc: davinci-linux-open-source@linux.davincidsp.com, Sekhar Nori <nsekhar@ti.com>
List-Id: alsa-devel@alsa-project.org

The davinci--mcasp driver will copy the platform data specified
sram_size's and eventq's.

Set the eventq's and sram size for da850 and disable CONFIG_SUSPEND
so that there is SRAM enough left for the McASP (until the patch to allocate
sram from the 128K shared RAM region, then there should be plenty to spare)

Not-signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 arch/arm/configs/da8xx_omapl_defconfig  |    1 +
 arch/arm/mach-davinci/board-da850-evm.c |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/da8xx_omapl_defconfig b/arch/arm/configs/da8xx_omapl_defconfig
index 88ccde0..d06c89b 100644
--- a/arch/arm/configs/da8xx_omapl_defconfig
+++ b/arch/arm/configs/da8xx_omapl_defconfig
@@ -34,6 +34,7 @@ CONFIG_CPU_FREQ_GOV_PERFORMANCE=m
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 CONFIG_CPU_FREQ_GOV_ONDEMAND=m
 CONFIG_CPU_IDLE=y
+# CONFIG_SUSPEND is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index a7b41bf..1566480 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -722,10 +722,12 @@ static struct snd_platform_data da850_evm_snd_data = {
 	.num_serializer	= ARRAY_SIZE(da850_iis_serializer_direction),
 	.tdm_slots	= 2,
 	.serial_dir	= da850_iis_serializer_direction,
-	.asp_chan_q	= EVENTQ_1,
+	.asp_chan_q	= EVENTQ_0,
+	.ram_chan_q	= EVENTQ_1,
 	.version	= MCASP_VERSION_2,
 	.txnumevt	= 1,
 	.rxnumevt	= 1,
+	.sram_size_playback = SZ_8K /* or SZ_4K -- same results */,
 };
 
 static const short da850_evm_mcasp_pins[] __initconst = {
-- 
1.7.4.1
