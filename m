From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V4 0/2] Add support for sta529 audio codec and
	spdif_out controller
Date: Tue, 3 Jul 2012 17:24:57 +0530
Message-ID: <cover.1341312609.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog110.obsmtp.com (eu1sys200aog110.obsmtp.com
	[207.126.144.129])
	by alsa0.perex.cz (Postfix) with ESMTP id E8F402433B
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2012 13:55:07 +0200 (CEST)
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

The patch set contains minor modification according to review comments.

Patches that got applied(from V3 of patch set) are listed below: 

http://mailman.alsa-project.org/pipermail/alsa-devel/2012-June/052868.html

1. [PATCH V3 1/4] ASoC: spdif_receiver: Add support for spdif in Audio Codec. 

Patches that got applied(from V2 of patch set) are listed below: 

http://mailman.alsa-project.org/pipermail/alsa-devel/2012-June/052868.html

1. [PATCH V2 3/9] sound:asoc: Add support for synopsys i2s controller as per ASoC framework.
2. [PATCH V2 4/9] sound:asoc: Add support for SPEAr ASoC pcm layer.
3. [PATCH V2 5/9] sound:asoc:spdif_in: Add spdif IN support


Rajeev Kumar (1):
  ASoC: STA529: Add support for STA529 Audio Codec

Vipin Kumar (1):
  ASoC: SPEAr spdif_out: Add spdif out support

 sound/soc/codecs/Kconfig         |    4 +
 sound/soc/codecs/Makefile        |    2 +
 sound/soc/codecs/sta529.c        |  440 ++++++++++++++++++++++++++++++++++++++
 sound/soc/spear/spdif_out.c      |  388 +++++++++++++++++++++++++++++++++
 sound/soc/spear/spdif_out_regs.h |   79 +++++++
 5 files changed, 913 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/sta529.c
 create mode 100644 sound/soc/spear/spdif_out.c
 create mode 100644 sound/soc/spear/spdif_out_regs.h
