From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH 0/2] Adding support for ASoC drivers on
	SPEAr13XX platform
Date: Thu, 17 Mar 2011 16:53:34 +0530
Message-ID: <1300361016-26242-1-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog111.obsmtp.com (eu1sys200aog111.obsmtp.com
	[207.126.144.131])
	by alsa0.perex.cz (Postfix) with ESMTP id D053810398E
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 12:24:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patchset contains two patches which add support for ASoC sound
drivers on ST's SPEAr13XX platform. Details of the SPEAr13XX platforms
can be seen here:
http://www.st.com/internet/mcu/product/250658.jsp

The ARCH and PLATFORM specific code for SPEAr13XX are already
under review in Russell King's ARM mailing list.

Please review the same and consider for mainline inclusion.

Rajeev Kumar (2):
  sound: asoc: Adding support for SPEAr13XX ASoC driver
  sound: asoc: Adding support for STA529 Audio Codec

 sound/soc/Kconfig               |   20 +--
 sound/soc/Makefile              |    1 +
 sound/soc/codecs/Kconfig        |    5 +
 sound/soc/codecs/Makefile       |    2 +
 sound/soc/codecs/sta529.c       |  366 ++++++++++++++++++++++++
 sound/soc/codecs/sta529.h       |   61 ++++
 sound/soc/spear/Kconfig         |   19 ++
 sound/soc/spear/Makefile        |    6 +
 sound/soc/spear/evb_sta529.c    |  135 +++++++++
 sound/soc/spear/spear13xx-i2s.c |  598 +++++++++++++++++++++++++++++++++++++++
 sound/soc/spear/spear13xx-i2s.h |   22 ++
 sound/soc/spear/spear13xx-pcm.c |  496 ++++++++++++++++++++++++++++++++
 sound/soc/spear/spear13xx-pcm.h |   54 ++++
 13 files changed, 1767 insertions(+), 18 deletions(-)
 create mode 100644 sound/soc/codecs/sta529.c
 create mode 100644 sound/soc/codecs/sta529.h
 create mode 100644 sound/soc/spear/Kconfig
 create mode 100644 sound/soc/spear/Makefile
 create mode 100644 sound/soc/spear/evb_sta529.c
 create mode 100644 sound/soc/spear/spear13xx-i2s.c
 create mode 100644 sound/soc/spear/spear13xx-i2s.h
 create mode 100644 sound/soc/spear/spear13xx-pcm.c
 create mode 100644 sound/soc/spear/spear13xx-pcm.h
