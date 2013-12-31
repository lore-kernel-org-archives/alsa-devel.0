From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH] ASoC: simple-card: cleanup
 asoc_simple_card_parse_of() code
Date: Tue, 31 Dec 2013 01:35:39 +0000
Message-ID: <73b462c3a3b14a47a95142694ed5c8cc@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1388114078-24517-1-git-send-email-Li.Xiubo@freescale.com>
 <20131230121113.GQ31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0187.outbound.protection.outlook.com [207.46.163.187])
 by alsa0.perex.cz (Postfix) with ESMTP id B3EAB264EAA
 for <alsa-devel@alsa-project.org>; Tue, 31 Dec 2013 02:35:43 +0100 (CET)
In-Reply-To: <20131230121113.GQ31886@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark and all,

Merry Christmas.


> Subject: Re: [PATCH] ASoC: simple-card: cleanup asoc_simple_card_parse_of()
> code
> 
> On Fri, Dec 27, 2013 at 11:14:38AM +0800, Xiubo Li wrote:
> > Since there is only one common format via "simple-audio-card,format"
> > for simple card driver(CPU & CODEC DAI), there is no need to do the
> > INV mask.
> 
> I don't understand this change, how is the fact that the CPU and CODEC
> DAI share a common format related to using the inversion?  The inversion
> specifies the format relative to the spec rather than relative to the
> other end of the link and for any DAI link the two devices should be
> using the same format.

Sorry, sorry for confusion.

>From the "Documentation/devicetree/bindings/sound/simple-card.txt":
------
 Optional properties:
 
 - simple-audio-card,format     : CPU/CODEC common audio format.
                                  "i2s", "right_j", "left_j" , "dsp_a"
                                  "dsp_b", "ac97", "pdm", "msb", "lsb"
------
There is only one common daifmt properties in simple-card parent dt node, and
its bits mask is SND_SOC_DAIFMT_FORMAT_MASK.

And also in the same binding documents:
------
Optional CPU/CODEC subnodes properties:

- format                  : CPU/CODEC specific audio format if needed.
                            see simple-audio-card,format
- frame-master            : bool property. add this if subnode is frame master
- bitclock-master         : bool property. add this if subnode is bitclock master
- bitclock-inversion      : bool property. add this if subnode has clock inversion
- frame-inversion         : bool property. add this if subnode has frame inversion
- clocks / system-clock-frequency
			       : specify subnode's clock if needed.
                            it can be specified via "clocks" if system has
                            clock node (= common clock), or "system-clock-frequency"
                            (if system doens't support common clock)
------

And in "sound/soc/generic/simple-card.c", function : asoc_simple_card_parse_of()
-----
	......

        /* get CPU/CODEC common format via simple-audio-card,format */
        info->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
                (SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);

	......

		ret = asoc_simple_card_sub_parse_of(cpu, ...);

		...

		ret = asoc_simple_card_sub_parse_of(codec, ...);

	......
-----
The SND_SOC_DAIFMT_INV_MASK bits mask should be for "bitclock-master" and
"frame-inversion" in subnodes' daifmt parsing if need, or why shouldn't
SND_SOC_DAIFMT_CLOCK_MASK be here like SND_SOC_DAIFMT_INV_MASK ?

IMO, the SND_SOC_DAIFMT_INV_MASK bits mask here maybe a little confused.

Certainly, these two and other subnode properties can also be common properties
like "[prefix]format" for other drivers.

It's the limitation of snd_soc_of_parse_daifmt() that the simple-card driver must
do the mask(except SND_SOC_DAIFMT_MASTER_MASK, because it default value is not zero)
operation. 

Or should we change "bitclock-master" and "frame-master" as one string property
like "[prefix]master = XXX", and set the default value as zero like others. And then
we can remove all the bits mask operations in simple-card and other drivers.
If need, I will send this patch of this.
         

Thanks,

--
Best Regards,
Xiubo
