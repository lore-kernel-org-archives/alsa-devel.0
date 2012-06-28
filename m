From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V3 0/4] Add support for STA529 codec,
	spdif_receiver and SPEAr spdif_out controller
Date: Thu, 28 Jun 2012 12:31:36 +0530
Message-ID: <cover.1340862505.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog103.obsmtp.com (eu1sys200aog103.obsmtp.com
	[207.126.144.115])
	by alsa0.perex.cz (Postfix) with ESMTP id AB627103B49
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2012 09:01:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, perex@perex.cz
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Earlier I had circulated Patch set V2. Please find below the link for the same.

http://mailman.alsa-project.org/pipermail/alsa-devel/2012-June/052868.html.

Some of the patches got applied and for rest I am sending Version V3.

Patches that got applied(from V2 of patch set) are listed below:
1. [PATCH V2 3/9] sound:asoc: Add support for synopsys i2s controller as per ASoC framework.
2. [PATCH V2 4/9] sound:asoc: Add support for SPEAr ASoC pcm layer.
3. [PATCH V2 5/9] sound:asoc:spdif_in: Add spdif IN support

Changes since V2:
1. In-corporated review comments received on V2 

Rajeev Kumar (2):
  ASoC: STA529: Add support for STA529 Audio Codec
  ASoC: SPEAr: Add Kconfig and Makefile to support SPEAr audio driver

Vipin Kumar (2):
  ASoC: spdif_receiver: Add support for spdif in Audio Codec
  ASoC: SPEAr spdif_out: Add spdif out support

 sound/soc/codecs/Kconfig          |    4 +
 sound/soc/codecs/Makefile         |    4 +-
 sound/soc/codecs/spdif_receiver.c |   67 ++++++
 sound/soc/codecs/sta529.c         |  441 +++++++++++++++++++++++++++++++++++++
 sound/soc/spear/Kconfig           |   22 ++
 sound/soc/spear/Makefile          |    4 +
 sound/soc/spear/spdif_out.c       |  387 ++++++++++++++++++++++++++++++++
 sound/soc/spear/spdif_out_regs.h  |   79 +++++++
 8 files changed, 1007 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/codecs/spdif_receiver.c
 create mode 100644 sound/soc/codecs/sta529.c
 create mode 100644 sound/soc/spear/Kconfig
 create mode 100644 sound/soc/spear/Makefile
 create mode 100644 sound/soc/spear/spdif_out.c
 create mode 100644 sound/soc/spear/spdif_out_regs.h
