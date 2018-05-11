From: sdaau <sd@create.aau.dk>
Subject: What is the meaning of #sound-dai-cells in a device
	tree?
Date: Fri, 11 May 2018 19:08:49 +0200
Message-ID: <5AF5CE21.1010809@create.aau.dk>
Reply-To: sd@create.aau.dk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10088.outbound.protection.outlook.com [40.107.1.88])
 by alsa0.perex.cz (Postfix) with ESMTP id CB30C267281
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 19:08:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

Apologies if this isn't the right forum (my thinking was, is that it is related to sound, and thus ALSA, more) - however, if it isn't, please let me know where I could forward this query (maybe devicetree mailing list ?) 


I have tried, but I really cannot find any documentation where I can read about, what does conceptually #sound-dai-cells in a device tree mean.

Most I've found so far, is:

    linux_git$ grep -r 'sound-dai-cells' --exclude-dir='.git'
    arch/arm/boot/dts/sun7i-a20-cubietruck.dts: #sound-dai-cells = <0>;
    ...
    arch/arm/boot/dts/r8a7790.dtsi: * #sound-dai-cells is required
    arch/arm/boot/dts/r8a7790.dtsi: * Single DAI : #sound-dai-cells = <0>; <&rcar_sound>;
    arch/arm/boot/dts/r8a7790.dtsi: * Multi DAI : #sound-dai-cells = <1>; <&rcar_sound N>;
    ...
    Documentation/devicetree/bindings/sound/hisilicon,hi6210-i2s.txt:- #sound-dai-cells: Should be set to 1 (for multi-dai)
    ...

As far as I can tell:

* if it is 1, then you can refer to "ports" (?) of a soundcard node, i.e. <&rcar_sound N>; 
* if it is 0, then you cannot refer to "ports", and you can only refer to <&rcar_sound>


Also, it seems to appear only in these kernel source files:

    drivers/misc/atmel-ssc.c:	if (!of_property_read_bool(np, "#sound-dai-cells"))
    drivers/misc/atmel-ssc.c:	if (of_property_read_bool(ssc->pdev->dev.of_node, "#sound-dai-cells"))
    ...
    sound/soc/generic/simple-card.c:#define CELL	"#sound-dai-cells"
    ...
    sound/soc/generic/simple-scu-card.c:#define CELL	"#sound-dai-cells"
    ...
    sound/soc/soc-core.c:					 "#sound-dai-cells", 0, &args);
    sound/soc/soc-core.c:						"#sound-dai-cells");
    sound/soc/soc-core.c:						 "#sound-dai-cells",

... so, I guess, it only has meaning in what would be nodes under `target = <&sound>;` in a device tree - is that correct?


But then - what is sound-dai-cells actually describing? Number of entries in `static struct snd_soc_dai_driver` of a (codec?) driver, if it is defined as an array? Or a number of DAI links?

Could anyone offer a more proper conceptual description of what #sound-dai-cells is supposed to describe?


Many thanks in advance for any pointers,
s.
