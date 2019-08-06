From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 0/5] Add support for new SAI IP version
Date: Tue,  6 Aug 2019 18:12:09 +0300
Message-ID: <20190806151214.6783-1-daniel.baluta@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: l.stach@pengutronix.de, mihai.serban@gmail.com, alsa-devel@alsa-project.org, timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca, tiwai@suse.com, nicoleotsuka@gmail.com, linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

So far SAI IPs integrated with imx6 only supported one data line.
Starting with imx7 and imx8 SAI integration support up to 8 data
lines. First patch introduce register definition to support this.

New SAI IP version introduces two new registers (Version and Parmeter
registers) which are placed at the beginning of register address space.
For this reason we need to fix the register's address. Support for
this is introduced in patch 3.

Changes since v2:
	- removed patches regarding data line mask because I need to
	find a better way to describe to model data lines. Perhaps,we
	only need to specify how many datalines a specific SAI instance
	supports and then let SAI driver to activate datalines based on
	the number of channels. Will open the discussion on this on a
	separate thread.
	- fixed devicetree documentation as per Nicolin comments and
	will send a separate patch to convert it to yaml.

Changes since v1:
        - removed patches from Lucas as they were already accepted
        - addressed comments from Lucas and Nicolin regarding
        device tree property naming
        - removed comment saying that "datalines" must be always
        consecutively enabled (this is not true, checked with IP owner)
        - added new patch to document newly introduced compatbile
          strings
        - removed patch introducing combined mode as I will still need
        some time to figure out how to properly allow users to set it.

Daniel Baluta (5):
  ASoC: fsl_sai: Add registers definition for multiple datalines
  ASoC: fsl_sai: Update Tx/Rx channel enable mask
  ASoC: fsl_sai: Add support for SAI new version
  ASoC: fsl_sai: Add support for imx7ulp/imx8mq
  ASoC: dt-bindings: Introduce compatible strings for 7ULP and 8MQ

 .../devicetree/bindings/sound/fsl-sai.txt     |   3 +-
 sound/soc/fsl/fsl_sai.c                       | 320 ++++++++++++------
 sound/soc/fsl/fsl_sai.h                       |  78 +++--
 3 files changed, 273 insertions(+), 128 deletions(-)

-- 
2.17.1
