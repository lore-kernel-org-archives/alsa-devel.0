From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 2/2] davinci: da850evm: enable mcasp ping-pong
	bufs and evq's
Date: Wed, 18 May 2011 09:27:46 -0400
Message-ID: <f02f2bda26f87fff2bb9e958baa12672cae7e362.1305723716.git.bengardiner@nanometrics.ca>
References: <cover.1305723716.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 6562C24408
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 15:27:55 +0200 (CEST)
Received: by mail-gw0-f46.google.com with SMTP id a18so526989gwa.19
	for <alsa-devel@alsa-project.org>; Wed, 18 May 2011 06:27:53 -0700 (PDT)
In-Reply-To: <cover.1305723716.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
Cc: Subhasish Ghosh <subhasish@mistralsolutions.com>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

The davinci-mcasp driver will copy the platform data specified sram sizes and
eventq's.

Set the event queues and sram sizes for da850. 8K SRAM buffers are selected
because it is the minimum that resulted in the same period size when testing
48KHz S16_LE stereo. Event queues 0 and 1 are assigned to match those 
specified by Troy Kisky in his introduction of ping-pong buffers for dm644x.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 arch/arm/mach-davinci/board-da850-evm.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index a7b41bf..2ee1a6f 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -722,10 +722,13 @@ static struct snd_platform_data da850_evm_snd_data = {
 	.num_serializer	= ARRAY_SIZE(da850_iis_serializer_direction),
 	.tdm_slots	= 2,
 	.serial_dir	= da850_iis_serializer_direction,
-	.asp_chan_q	= EVENTQ_1,
+	.asp_chan_q	= EVENTQ_0,
+	.ram_chan_q	= EVENTQ_1,
 	.version	= MCASP_VERSION_2,
 	.txnumevt	= 1,
 	.rxnumevt	= 1,
+	.sram_size_playback = SZ_8K,
+	.sram_size_capture = SZ_8K,
 };
 
 static const short da850_evm_mcasp_pins[] __initconst = {
-- 
1.7.4.1
