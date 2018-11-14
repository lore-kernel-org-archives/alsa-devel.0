From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: cs35l36: Add device tree
 documentation for CS35L36
Date: Wed, 14 Nov 2018 09:31:11 +0000
Message-ID: <20181114093111.GX16508@imbe.wolfsonmicro.main>
References: <1542134957-2395-1-git-send-email-james.schulman@cirrus.com>
 <1542134957-2395-2-git-send-email-james.schulman@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EE53267839
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 10:31:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1542134957-2395-2-git-send-email-james.schulman@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Schulman <james.schulman@cirrus.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com, robh+dt@kernel.org, charles.keepax@cirrus.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 13, 2018 at 12:49:17PM -0600, James Schulman wrote:
> Add device tree documentation for Cirrus Logic CS35L36
> speaker amplifier
> 
> Signed-off-by: James Schulman <james.schulman@cirrus.com>
> ---
> +Optional properties:
> +  - cirrus,sclk-force-output : Audio serial port SCLK force
> +  output control. Forces the SCLK to continue to drive even
> +  if no ASP_TXn channels are enabled.
> +
> +  - cirrus,lrclk-force-output : Audio serial port LRCLK force
> +  output control. Forces the LRCLK to continue to drive even
> +  if no ASP_TXn channels are enabled.
> +

Would it be best to use SND_SOC_DAIFMT_CONT/GATED for these?
Unless I have misunderstood their purpose, although presently that
doesn't give you individual control over sclk and lrclk.

> +Example:
> +
> +cs35l36: cs35l36@40 {
> +	compatible = "cirrus,cs35l36";
> +	reg = <0x40>;
> +	VA-supply = <&dummy_vreg>;
> +	VP-supply = <&dummy_vreg>;
> +	reset-gpios = <&gpio0 54 0>;
> +	interrupt-parent = <&gpio8>;
> +	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +
> +	cirrus,boost-ind-nanohenry = <1000>;
> +	cirrus,boost-ctl-millivolt = <10000>;
> +	cirrus,boost-ctl-select = <0x00>;
> +	cirrus,boost-peak-milliamp = <4500>;
> +	cirrus,amp-gain-zc;
> +	cirrus,ldm-mode-select = <0x01>;
> +	cirrus,pdm-ldm-exit;
> +	cirrus,pdm-ldm-enter;
> +	cirrus,weak-fet-delay = <0x04>;
> +	cirrus,weak-fet-thld = <0x01>;
> +	cirrus,temp-warn-threshold = <0x01>;
> +	cirrus,multi-amp-mode;
> +
> +	cirrus,vpbr-config {
> +		cirrus,vpbr-en = <0x00>;
> +		cirrus,vpbr-thld = <0x05>;
> +		cirrus,vpbr-atk-rate = <0x02>;
> +		cirrus,vpbr-atk-vol = <0x01>;
> +		cirrus,vpbr-max-attn = <0x09>;
> +		cirrus,vpbr-wait = <0x01>;
> +		cirrus,vpbr-rel-rate = <0x05>;
> +		cirrus,vpbr-mute-en = <0x00>;
> +	};
> +
> +	cirrus,irq-config {
> +		cirrus,irq-drive-select = <0x01>;
> +		cirrus,irq-polarity = <0x00>;
> +		cirrus,irq-gpio-select = <0x01>;
> +		cirrus,irq-output-enable = <0x01>;
> +		cirrus,irq-src-select = <0x01>;
> +	};

This block is not documented in the rest of the document and
looks like things that should really be controlled through other
means. Presuming this is legacy and just needs removed?

Thanks,
Charles
