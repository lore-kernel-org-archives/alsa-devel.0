From: Adam Thomson <Adam.Thomson@diasemi.com>
Subject: [PATCH 0/2] DA732x codec support
Date: Thu, 31 May 2012 11:19:15 +0100
Message-ID: <201205311024.q4VAO1Ai008941@sw-eng-lt-apt-vm1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay1.diasemi.com (mailrelay1.diasemi.com [82.210.246.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BC0524336
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 12:26:01 +0200 (CEST)
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
Cc: Adam Thomson <Adam.Thomson@diasemi.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Michal Hajduk <Michal.Hajduk@diasemi.com>
List-Id: alsa-devel@alsa-project.org

These patches add new controls to ASoC core and a driver
for the DA732x audio codec.

Adam Thomson (2):
  ASoC: core: Add single controls with specified range of values
  ASoC: codecs: Add DA732x codec driver

 include/sound/soc.h           |   16 +
 sound/soc/codecs/Kconfig      |    4 +
 sound/soc/codecs/Makefile     |    2 +
 sound/soc/codecs/da732x.c     | 1614 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/da732x.h     |  133 ++++
 sound/soc/codecs/da732x_reg.h |  650 +++++++++++++++++
 sound/soc/soc-core.c          |   89 +++
 7 files changed, 2508 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/da732x.c
 create mode 100644 sound/soc/codecs/da732x.h
 create mode 100644 sound/soc/codecs/da732x_reg.h
