From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: [PATCHv4 0/4] ALSA: Add Freescale SAI driver
Date: Fri, 20 Dec 2013 01:59:22 +0000
Message-ID: <be7389c0f2eb414dbd7f28ac27515640@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 by alsa0.perex.cz (Postfix) with ESMTP id CE2F5265506
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 02:59:26 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

This patch series is mostly Freescale's SAI SoC Digital Audio Interface

driver implementation. And the implementation is only compatible with

device tree definition.



This patch series is based on linux-next and has been tested on Vybrid

VF610 Tower board using device tree.



Changed in v4:

- Remove the uneeded function fsl_sai_dai_remove().

- Use snd_soc_dai_init_dma_data().

- Adjust the Konfig file.



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
