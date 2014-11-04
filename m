From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCHv4] ASoC: simple-card: binding: update
 binding to support the new style.
Date: Tue, 4 Nov 2014 02:52:22 +0000
Message-ID: <cb7728f31d70442ebc0dbb4628e06af1@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1410322062-35077-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0135.outbound.protection.outlook.com [157.56.111.135])
 by alsa0.perex.cz (Postfix) with ESMTP id B994726058C
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 03:52:25 +0100 (CET)
In-Reply-To: <1410322062-35077-1-git-send-email-Li.Xiubo@freescale.com>
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
To: "broonie@linaro.org" <broonie@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I'd like to know the status of this patch, if this won't be applied, I will
abandon this from our local SDK repository too.  

Thanks very much,

BRs
Xiubo




> -----Original Message-----
> From: Xiubo Li [mailto:Li.Xiubo@freescale.com]
> Sent: Wednesday, September 10, 2014 12:08 PM
> To: broonie@linaro.org; galak@codeaurora.org; moinejf@free.fr; andrew@lunn.ch;
> kuninori.morimoto.gx@renesas.com; devicetree@vger.kernel.org; alsa-devel@alsa-
> project.org; jsarha@ti.com
> Cc: linux-kernel@vger.kernel.org; robh+dt@kernel.org; pawel.moll@arm.com;
> mark.rutland@arm.com; ijc+devicetree@hellion.org.uk; Xiubo Li-B47053
> Subject: [PATCHv4] ASoC: simple-card: binding: update binding to support the
> new style.
> 
> This patch will split the DT binding into old style and new style, the
> new style will be easier to add many DAI links from old single DAI link
> DTs.
> 
> This patch will maintian compatibility with the old DTs.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
> 
> 
> Changes in v4:
> - Follow Jyri's advice.
> - Fix some small words or sentences errors.
> - Fix discription of the commit commnet.
> - Apply against the current code.
> - Add Notes.
> 
> 
>  .../devicetree/bindings/sound/simple-card.txt      | 215 ++++++++++++++-------
>  1 file changed, 148 insertions(+), 67 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt
> b/Documentation/devicetree/bindings/sound/simple-card.txt
> index c2e9841..5fe0796 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.txt
> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
> @@ -1,15 +1,19 @@
> -Simple-Card:
> +Device-Tree bindings for Simple Card
> 
>  Simple-Card specifies audio DAI connections of SoC <-> codec.
> 
> -Required properties:
> +=== Top level's properties and subnodes ===
> 
> +*** Required properties ***
>  - compatible				: "simple-audio-card"
> 
> -Optional properties:
> -
> +*** Optional properties ***
>  - simple-audio-card,name		: User specified audio sound card name, one
> string
>  					  property.
> +- simple-audio-card,format		: CPU/CODEC common audio format.
> +					  "i2s", "right_j", "left_j" , "dsp_a"
> +					  "dsp_b", "ac97", "pdm", "msb", "lsb"
> +					  (This is used for single DAI link & old
> style.)
>  - simple-audio-card,widgets		: Please refer to widgets.txt.
>  - simple-audio-card,routing		: A list of the connections between audio
> components.
>  					  Each entry is a pair of strings, the first
> being the
> @@ -17,63 +21,99 @@ Optional properties:
>  					  source.
>  - simple-audio-card,mclk-fs             : Multiplication factor between stream
> rate and codec
>    					  mclk.
> -
> -Optional subnodes:
> -
> -- simple-audio-card,dai-link		: Container for dai-link level
> -					  properties and the CPU and CODEC
> -					  sub-nodes. This container may be
> -					  omitted when the card has only one
> -					  DAI link. See the examples and the
> -					  section bellow.
> -
> -Dai-link subnode properties and subnodes:
> -
> -If dai-link subnode is omitted and the subnode properties are directly
> -under "sound"-node the subnode property and subnode names have to be
> -prefixed with "simple-audio-card,"-prefix.
> -
> -Required dai-link subnodes:
> -
> -- cpu					: CPU   sub-node
> -- codec					: CODEC sub-node
> -
> -Optional dai-link subnode properties:
> -
> +- simple-audio-card,frame-master	: Indicates DAI link frame master. One
> phandle to a
> +					  CODEC DAI node.
> +					  (This is used for single DAI link & old
> style.)
> +- simple-audio-card,bitclock-master	: Indicates DAI link bit clock master.
> One phandle to
> +					  a CODEC DAI node.
> +					  (This is used for single DAI link & old
> style.)
> +
> +*** Optional subnodes ***
> +- simple-audio-card,dai-link		: Container for DAI link level properties
> and the CPU
> +					  and CODEC nodes. This container may be
> omitted
> +					  when the card has only one DAI link and using
> the old
> +					  style. See the examples and the section
> bellow.
> +- simple-audio-card,cpu			: CPU DAI node.
> +					  (This is used for single DAI link & old
> style.)
> +- simple-audio-card,codec		: CODEC DAI node.
> +					  (This is used for single DAI link & old
> style.)
> +
> +=== DAI link node's properties and its subnodes ===
> +
> +*** Required subnodes ***
> +- cpu					: CPU DAI node.
> +- codec					: CODEC DAI node.
> +
> +*** Optional properties ***
>  - format				: CPU/CODEC common audio format.
>  					  "i2s", "right_j", "left_j" , "dsp_a"
>  					  "dsp_b", "ac97", "pdm", "msb", "lsb"
> -- frame-master				: Indicates dai-link frame master.
> -					  phandle to a cpu or codec subnode.
> -- bitclock-master			: Indicates dai-link bit clock master.
> -					  phandle to a cpu or codec subnode.
> -- bitclock-inversion			: bool property. Add this if the
> -					  dai-link uses bit clock inversion.
> -- frame-inversion			: bool property. Add this if the
> -					  dai-link uses frame clock inversion.
> -
> -For backward compatibility the frame-master and bitclock-master
> -properties can be used as booleans in codec subnode to indicate if the
> -codec is the dai-link frame or bit clock master. In this case there
> -should be no dai-link node, the same properties should not be present
> -at sound-node level, and the bitclock-inversion and frame-inversion
> -properties should also be placed in the codec node if needed.
> -
> -Required CPU/CODEC subnodes properties:
> -
> -- sound-dai				: phandle and port of CPU/CODEC
> -
> -Optional CPU/CODEC subnodes properties:
> -
> +- frame-master				: Indicates DAI link frame master. One
> phandle to a
> +					  CODEC DAI node.
> +					  (This is One boolean property for old style.)
> +- bitclock-master			: Indicates DAI link bit clock master. One
> phandle to
> +					  a CODEC DAI node.
> +					  (This is one boolean property for old style.)
> +
> +For backward compatibility, the frame-master and bitclock-master
> +can be used as boolean properties in CPU/CODEC DAI node indicating
> +that the CODEC DAI is the DAI link frame master and bit clock master.
> +In this case there should be no DAI link level nodes or boolean
> +properties of them.
> +
> +For all the properties in DAI link level will be applied to both
> +CPU and CODEC DAIs.
> +
> +=== CPU/CODEC DAI node's properties and its subnodes ===
> +
> +*** Required properties ***
> +- sound-dai				: One phandle and port of CPU/CODEC DAI device
> node.
> +
> +*** Optional properties ***
> +- bitclock-inversion			: Boolean property. Add this if the DAI
> device uses bit
> +					  clock inversion.
> +- frame-inversion			: Boolean property. Add this if the DAI device
> uses frame
> +					  clock inversion.
> +- frame-master				: Boolean property. Add this if the CODEC
> DAI device is
> +					  frame master.
> +					  (This is used for single DAI link & old
> style.)
> +- bitclock-master			: Boolean property. Add this if the CODEC DAI
> device is
> +					  bit clock master.
> +					  (This is used for single DAI link & old
> style.)
>  - dai-tdm-slot-num			: Please refer to tdm-slot.txt.
>  - dai-tdm-slot-width			: Please refer to tdm-slot.txt.
> -- clocks / system-clock-frequency	: specify subnode's clock if needed.
> -					  it can be specified via "clocks" if system
> has
> -					  clock node (= common clock), or "system-
> clock-frequency"
> -					  (if system doens't support common clock)
> +- clocks / system-clock-frequency	: Specify CPU/CODEC DAI's clock if needed.
> It can
> +					  be specified via "clocks" if system has clock
> node
> +					  (= common clock), or "system-clock-
> frequency"(if system
> +					  doens't support common clock)
> +
> +=== Notes ===
> +*** DAI hardware clock masters ***
> +For [prefix]frame-master and [prefix]bitclock-master, which prefix
> +is "simple-audio-card,", are both wrt the CODEC DAI. If the CODEC DAI
> +is bit clock and frame master then the CPU DAI will be bit clock and
> +frame slave, and vice versa.
> +
> +=== Examples ===
> +*** CPU & CODEC DAI DT nodes ***
> +&i2c0 {
> +	ak4648: ak4648@12 {
> +		#sound-dai-cells = <0>;
> +		compatible = "asahi-kasei,ak4648";
> +		reg = <0x12>;
> +	};
> +};
> 
> -Example 1 - single DAI link:
> +sh_fsi2: sh_fsi2@ec230000 {
> +	#sound-dai-cells = <1>;
> +	compatible = "renesas,sh_fsi2";
> +	reg = <0xec230000 0x400>;
> +	interrupt-parent = <&gic>;
> +	interrupts = <0 146 0x4>;
> +};
> 
> +Example 1 - single DAI link & old style:
> +bitclock-master and frame-master as phandles.
>  sound {
>  	compatible = "simple-audio-card";
>  	simple-audio-card,name = "VF610-Tower-Sound-Card";
> @@ -91,6 +131,7 @@ sound {
> 
>  	simple-audio-card,cpu {
>  		sound-dai = <&sh_fsi2 0>;
> +		bitclock-inversion;
>  	};
> 
>  	dailink0_master: simple-audio-card,codec {
> @@ -99,24 +140,64 @@ sound {
>  	};
>  };
> 
> -&i2c0 {
> -	ak4648: ak4648@12 {
> -		#sound-dai-cells = <0>;
> -		compatible = "asahi-kasei,ak4648";
> -		reg = <0x12>;
> +Example 2 - single DAI link & old style:
> +bitclock-master and frame-master as boolean properties.
> +sound {
> +	compatible = "simple-audio-card";
> +	simple-audio-card,name = "VF610-Tower-Sound-Card";
> +	simple-audio-card,format = "left_j";
> +	simple-audio-card,widgets =
> +		"Microphone", "Microphone Jack",
> +		"Headphone", "Headphone Jack",
> +		"Speaker", "External Speaker";
> +	simple-audio-card,routing =
> +		"MIC_IN", "Microphone Jack",
> +		"Headphone Jack", "HP_OUT",
> +		"External Speaker", "LINE_OUT";
> +
> +	simple-audio-card,cpu {
> +		sound-dai = <&sh_fsi2 0>;
>  	};
> -};
> 
> -sh_fsi2: sh_fsi2@ec230000 {
> -	#sound-dai-cells = <1>;
> -	compatible = "renesas,sh_fsi2";
> -	reg = <0xec230000 0x400>;
> -	interrupt-parent = <&gic>;
> -	interrupts = <0 146 0x4>;
> +	simple-audio-card,codec {
> +		sound-dai = <&ak4648>;
> +		clocks = <&osc>;
> +		bitclock-master;
> +		frame-master;
> +		bitclock-inversion;
> +	};
>  };
> 
> -Example 2 - many DAI links:
> +Example 3 - single DAI link & new style:
> +sound {
> +	compatible = "simple-audio-card";
> +	simple-audio-card,name = "VF610-Tower-Sound-Card";
> +	simple-audio-card,widgets =
> +		"Microphone", "Microphone Jack",
> +		"Headphone", "Headphone Jack",
> +		"Speaker", "External Speaker";
> +	simple-audio-card,routing =
> +		"MIC_IN", "Microphone Jack",
> +		"Headphone Jack", "HP_OUT",
> +		"External Speaker", "LINE_OUT";
> +
> +	simple-audio-card,dai-link {
> +		format = "i2s";
> +		bitclock-master = <&dailink0_master>;
> +		frame-master = <&dailink0_master>;
> +		cpu {
> +			sound-dai = <&sh_fsi2 0>;
> +			frame-inversion;
> +		};
> +		dailink0_master: codec {
> +			sound-dai = <&ak4648>;
> +			clocks = <&osc>;
> +			frame-inversion;
> +		};
> +	};
> +};
> 
> +Example 4 - many DAI links:
>  sound {
>  	compatible = "simple-audio-card";
>  	simple-audio-card,name = "Cubox Audio";
> --
> 2.1.0.27.g96db324
