From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: ASoC: new ac97 bus and codec clock
Date: Sun, 17 Jun 2018 22:03:54 +0200
Message-ID: <87lgbdqixh.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr
 [80.12.242.127])
 by alsa0.perex.cz (Postfix) with ESMTP id B5A8B267196
 for <alsa-devel@alsa-project.org>; Sun, 17 Jun 2018 22:03:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

The new ac97 is working well in a platform data build. But in the device tree
case, there is an issue, triggered by our review in [1].

The main issue is the lack of one clock.

The device hierarchy is :
 - platform device sound@40500000 (the AC97 controller)
   \-> ac97 device sound@40500000:0 (the discovered ac97 IP for a wm9713)

Now the issue is here :
 - sound/ac97/bus.c:419, function ac97_get_enable_clk()
 - the clk_get() fails

The sound@40500000:0 device was automatically created by the AC97 bus code, but
I don't see any way to provide this device the "ac97_clk" ... How do you think
this is supposed to work, and how can my devicetree description provide this
clock ?

-- 
Robert

[1] Discussion reference
https://groups.google.com/forum/#!msg/linux.kernel/6_zIXK_maA4/RMYsmLlRMgAJ
Look for "You probably mean the BITCLK clock."

[2] Device tree extract
ac97: sound@40500000 {
      	compatible = "marvell,pxa270-ac97";
	reg = < 0x40500000 0x1000 >;
	interrupts = <14>;
	reset-gpios = <&gpio 95 GPIO_ACTIVE_HIGH>;
	#sound-dai-cells = <1>;
	pinctrl-names = "default";
	pinctrl-0 = < &pinctrl_ac97_default >;
	clocks = <&clks CLK_AC97>, <&clks CLK_AC97CONF>;
	clock-names = "AC97CLK", "AC97CONFCLK";
};
