From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 0/7] Tegra ALSA/ASoC driver
Date: Fri,  7 Jan 2011 22:36:10 -0700
Message-ID: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
References: <1294450353-25076-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3275510382C
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2011 06:36:28 +0100 (CET)
In-Reply-To: <1294450353-25076-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

(My apologies; I sent this to both linux-tegra and alsa-devel mailing lists
before, but posted from the wrong address, so it got dropped from the ALSA
list. Here's a copy, hopefully threaded back into the same conversation as
the original copy which made it to linux-tegra)

This patch series implements an ALSA/ASoC driver for Tegra, and implements
minimal machine support for the Harmony reference board.

I believe I've addressed all the feedback from Mark re: the previous patchset.

Stephen Warren (7):
  ASoC: Export debugfs root dentry
  ASoC: tegra: Add tegra-das driver
  ASoC: tegra: Add tegra-pcm driver
  ASoC: tegra: Add tegra-i2s driver
  ASoC: tegra: Machine utility code
  ASoC: tegra: Harmony machine support
  ASoC: tegra: Kconfig and Makefile

 include/sound/soc.h                |    4 +
 sound/soc/Kconfig                  |    1 +
 sound/soc/Makefile                 |    1 +
 sound/soc/soc-core.c               |   19 +-
 sound/soc/tegra/Kconfig            |   27 ++
 sound/soc/tegra/Makefile           |   14 +
 sound/soc/tegra/harmony.c          |  179 +++++++++++++
 sound/soc/tegra/tegra_asoc_utils.c |  154 +++++++++++
 sound/soc/tegra/tegra_asoc_utils.h |   31 +++
 sound/soc/tegra/tegra_das.c        |  263 +++++++++++++++++++
 sound/soc/tegra/tegra_das.h        |  135 ++++++++++
 sound/soc/tegra/tegra_i2s.c        |  502 ++++++++++++++++++++++++++++++++++++
 sound/soc/tegra/tegra_i2s.h        |  165 ++++++++++++
 sound/soc/tegra/tegra_pcm.c        |  401 ++++++++++++++++++++++++++++
 sound/soc/tegra/tegra_pcm.h        |   55 ++++
 15 files changed, 1942 insertions(+), 9 deletions(-)
 create mode 100644 sound/soc/tegra/Kconfig
 create mode 100644 sound/soc/tegra/Makefile
 create mode 100644 sound/soc/tegra/harmony.c
 create mode 100644 sound/soc/tegra/tegra_asoc_utils.c
 create mode 100644 sound/soc/tegra/tegra_asoc_utils.h
 create mode 100644 sound/soc/tegra/tegra_das.c
 create mode 100644 sound/soc/tegra/tegra_das.h
 create mode 100644 sound/soc/tegra/tegra_i2s.c
 create mode 100644 sound/soc/tegra/tegra_i2s.h
 create mode 100644 sound/soc/tegra/tegra_pcm.c
 create mode 100644 sound/soc/tegra/tegra_pcm.h
