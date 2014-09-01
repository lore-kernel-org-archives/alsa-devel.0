From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [RFC][PATCH] ASoC: simple-card: Merge single and
 muti DAI link code.
Date: Mon, 1 Sep 2014 02:57:05 +0000
Message-ID: <1330150cda9f47eb88497fc10fb2b045@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1409294797-21948-1-git-send-email-Li.Xiubo@freescale.com>
 <20140831182725.3135db4f@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 by alsa0.perex.cz (Postfix) with ESMTP id 59D6D261B2D
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 04:57:08 +0200 (CEST)
In-Reply-To: <20140831182725.3135db4f@armhf>
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
To: Jean-Francois Moine <moinejf@free.fr>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jyri Sarha <jsarha@ti.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

> > ---
> >
> > Hi,
> >
> > This patch will break the old DT, so i just send one RFC version, and
> > will add the old DT patches in next version if this patch can work
> > well.
> >
> > Any comments and advices are welcome.
> 
> Hi Xiubo,
> 
> My DT is
> 
> 	sound {
> 		compatible = "simple-audio-card";
> 		simple-audio-card,name = "Cubox Audio";
> 
> 		simple-audio-card,dai-link@0 {		/* I2S - HDMI */
> 			format = "i2s";
> 			cpu {
> 				sound-dai = <&audio1 0>;
> 			};
> 			codec {
> 				sound-dai = <&hdmi 0>;
> 			};
> 		};
> 	...
> 
> I was getting 0x1001 as the format (codec clk & FRM master and i2s').
> 
> With your patch, I get 0x4000 (clk master & frame slave and no format).
> 

Well, yes, If your DAI link's bit clock & frame using the CODEC as master,
You should specify it in your DAI link node like:

> 	sound {
> 		compatible = "simple-audio-card";
> 		simple-audio-card,name = "Cubox Audio";
> 
> 		simple-audio-card,dai-link@0 {		/* I2S - HDMI */
> 			format = "i2s";
> 			cpu {
> 				sound-dai = <&audio1 0>;
> 			};
> 			codec {
> 				sound-dai = <&hdmi 0>;
> 			};

			bitclock-master;
			frame-master;
> 		};
> 	...

And the reason for cannot parsing the "i2s" format is that there is one bug
in this patch and I will fix it in next version.

Thanks very much for your comment.

BRs
Xiubo
