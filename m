From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC fixes for atmel
Date: Tue, 15 Jan 2013 00:29:44 +0000
Message-ID: <20130115002944.GA21198@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E1CD1261631
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 01:29:45 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-atmel-pinctrl

for you to fetch changes up to ea03c81521bde526570e1dec96eaa21fe5ac84a2:

  ASoC: atmel-ssc: add pinctrl selection to driver (2013-01-12 00:00:33 +0000)

----------------------------------------------------------------
ASoC: atmel: Fixes for pinctrl

Due to a series of problems with the handling of Atmel, a combination of
making changes that make other branches instantly buggy and a general
failure to deal with the resulting issues effectively, v3.8 Atmel audio
currently won't work at all for DT boards without adding pinctrl
definitions and a request for those.

----------------------------------------------------------------
Bo Shen (2):
      ARM: at91/dts: add pinctrl support for SSC peripheral
      ASoC: atmel-ssc: add pinctrl selection to driver

 arch/arm/boot/dts/at91sam9260.dtsi |   18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi |   36 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi |   36 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi |   26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |   32 +++++++++++++++++++++++++-------
 drivers/misc/atmel-ssc.c           |    8 ++++++++
 6 files changed, 149 insertions(+), 7 deletions(-)
