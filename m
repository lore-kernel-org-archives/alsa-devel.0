From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: ASoC: new ac97 bus and codec clock
Date: Wed, 20 Jun 2018 16:52:16 +0200
Message-ID: <8736xhqzmn.fsf@belgarion.home>
References: <87lgbdqixh.fsf@belgarion.home>
 <20180619150204.GF11230@sirena.org.uk>
 <CAL_JsqLn2t-zFi8xrig_63OD-SBq8d0jZctih38sZ4cAnRoe6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr
 [80.12.242.123])
 by alsa0.perex.cz (Postfix) with ESMTP id EED602673CF
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 16:52:17 +0200 (CEST)
In-Reply-To: <CAL_JsqLn2t-zFi8xrig_63OD-SBq8d0jZctih38sZ4cAnRoe6g@mail.gmail.com>
 (Rob Herring's message of "Tue, 19 Jun 2018 11:56:41 -0600")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Rob Herring <robh+dt@kernel.org> writes:

> Like PCI, USB, SDIO, etc., you need to define an AC97 bus binding
> which defines child node structure, compatible formatting (if you can
> base compatibles on something like VID/PID), and addressing (reg and
> unit-address formats). Then once you define child nodes, you can add
> whatever sideband connections you need. The AC97 core should be able
> to populate struct device_node if there are any matching child
> devices.
Ok, I thing I understand.

So the device-tree will look like :
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

        wm9713@0 {
        	reg = <0>; /* Codex index (between 0 and 3) */
                compatible = "ac97-codec";
                clocks = <&fixed_wm9713_clock>;
                clock-names = "ac97_clk";
        }
};

And the function ac97_codec_add() will :
 - scan the device-tree ac97 controller childs
 - match one if its reg equals (in our case wm9713@0)
 - set codec->dev.of_node to the matched one

> It gets a bit more complicated if you need to do things like
> enable power or de-assert resets to discover the devices. Sounds like
> that might be the next person's problem in this case. :)
Yeah ... Crossing fingers that won't be me :)

Cheers.

-- 
Robert
