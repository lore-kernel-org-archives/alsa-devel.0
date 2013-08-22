From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v10 2/2] ASoC: fsl: Add S/PDIF machine
	driver
Date: Thu, 22 Aug 2013 13:56:32 -0600
Message-ID: <52166CF0.9080402@wwwdotorg.org>
References: <cover.1377054540.git.b42378@freescale.com>
 <e9cf5e37f858dea78319720f007f66c8c063885f.1377054540.git.b42378@freescale.com>
 <52150763.8020707@wwwdotorg.org> <20130822114027.GA4258@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id B9BDB2608E9
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 21:56:38 +0200 (CEST)
In-Reply-To: <20130822114027.GA4258@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, festevam@gmail.com, s.hauer@pengutronix.de, timur@tabi.org, rob.herring@calxeda.com, tomasz.figa@gmail.com, broonie@kernel.org, p.zabel@pengutronix.de, R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 08/22/2013 05:40 AM, Nicolin Chen wrote:
> Hi Stephen,
> 
> On Wed, Aug 21, 2013 at 12:30:59PM -0600, Stephen Warren wrote:
>> I still don't think those two properties are correct.
>>
>> Exactly what node will those phandles point at?
>>
>> There definitely should not be a DT node for any "dummy CODEC",
>> irrespective of whether this binding calls the other node a "CODEC" or a
>> "dummy CODEC".
>>
>> If these properties are to contain phandles, it would be acceptable for
>> the referenced node to be:
>>
>> * A node representing the physical connector/jack on the board.
>>
>> * A node representing some other IP block on the board, such as an HDMI
>> encoder/display-controller
>>
>> I think those options are unlikely in general, so I think instead these
>> properties should just be Boolean indicating that "something" is
>> connector to the S/PDIF RX/TX, without specifying what that "something"
>> is. It doesn't matter what at least in the connector/jack case, although
>> perhaps it does in the HDMI encoder/display-controller?
> 
> Documentation/devicetree/bindings/sound/spdif-receiver.txt
> If I understand correctly, this doc for the dummy codec should be invalid?

Yes, I'm not convinced that binding is a good idea; it describes
something that often doesn't actually exist in HW. (Sometimes there's a
real S/PDIF receiving device on board, but sometimes there's nothing
except a jack/connector).

It'd be useful if other DT binding maintainers could weigh in on this to
confirm/deny my thoughts.

> But this patch, the spdif machine driver, is based on this codec driver,
> pls check the following code:
> 
> 164 +       codec_rx_np = of_parse_phandle(np, "spdif-receiver", 0);
> 165 +       if (codec_rx_np) {
> 169 +               data->dai[num_links].codec_of_node = codec_rx_np;
> 173 +       }
> 
> Accordingly, the binding I planned to add in DT:
> 
> 27 +       spdif_rx_codec: spdif-receiver {
> 28 +               compatible = "linux,spdif-dir";
> 29 +       };
> 30 +
> 31 +       sound-spdif {
> 32 +               compatible = "fsl,imx-audio-spdif",
> 33 +                          "fsl,imx-sabreauto-spdif";
> 34 +               model = "imx-spdif";
> 35 +               spdif-controller = <&spdif>;
> 37 +               spdif-receiver = <&spdif_rx_codec>;
> 38 +       };
> 
> So if the DT can't allow me to include this codec node, how could I
> handle it in the current baseline.

I would expect the machine driver's probe routine to create the dummy
S/PDIF receiver object itself, and register it by calling
snd_soc_register_codec(). That way, only the machine driver code need
know it (dummy CODEC) exists.
