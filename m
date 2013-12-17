From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv3 0/8] ALSA: Add SAI driver and enable SGT15000
	codec
Date: Tue, 17 Dec 2013 11:24:37 +0800
Message-ID: <1387250684-23406-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 by alsa0.perex.cz (Postfix) with ESMTP id 43D5A260857
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 05:16:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, timur@tabi.org, perex@perex.cz
Cc: mark.rutland@arm.com, fabio.estevam@freescale.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, tiwai@suse.de, b42378@freescale.com, b18965@freescale.com, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, linux-doc@vger.kernel.org, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rob@landley.net, r64188@freescale.com, shawn.guo@linaro.org, oskar@scara.com, LW@KARO-electronics.de
List-Id: alsa-devel@alsa-project.org


This patch series is mostly Freescale's SAI SoC Digital Audio Interface
driver implementation. And the implementation is only compatible with
device tree definition.

This patch series is based on linux-next and has been tested on Vybrid
VF610 Tower board using device tree.

Changed in v3:
- Add big-endian mode support.
- Revise some commit comments, coding styles,etc.
- Keep header files ordered by alphabet,etc.
- Add MODULE_ALIAS("platform:fsl-sai") for SAI driver.
- Rename the files to be in a same pattern with the existed ones.
- Remove some not useful functions or code.
- Only enable the clock while the device is in active use.
- Revise one error message according to Bill.

Changed in v2:
- Use default settings for the generic dmaengine PCM driver.
- Separate receive and transmit setting in most functions, but some couldn't for the HW limitation.
- Drop some not reduntant code.
- Use devm_snd_soc_register_component() instead of snd_soc_register_component().
- Use devm_snd_soc_register_card() instead of devm_snd_soc_register_card().
- Adjust the code sentences sequence.
- Make the namespacing consistent.
- Rename CONFIG_SND_SOC_FSL_SGTL5000 to CONFIG_SND_SOC_FSL_SGTL5000_VF610.
- Drop some meaningless lines.
- Rename the binding document file.

Added in v1:
- Add SAI SoC Digital Audio Interface driver.
- Add Freescale SAI ALSA SoC Digital Audio Interface node for VF610.
- Enables SAI ALSA SoC DAI device for Vybrid VF610 TOWER board.
- Add device tree bindings for Freescale SAI.
- Revise the bugs about the sgt15000 codec.
- Add SGT15000 based audio machine driver.
- Enable SGT15000 codec based audio driver node for VF610.
- Add device tree bindings for Freescale VF610 sound.
