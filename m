From: David Jander <david.jander@protonic.nl>
Subject: ASoC audio fabric OF bindings RFC. was: Re: ASoC
 MPC5xxx PSC AC97 audio driver
Date: Fri, 9 Sep 2011 12:02:16 +0200
Message-ID: <20110909120216.263eeb54@archvile>
References: <20110908121600.267dee07@archvile>
	<CAKON4OzsMd0T6KyDK_5P_pz8R5Pax+Bd+f5+00cO5E0OMCYQpQ@mail.gmail.com>
	<20110908124529.520c1388@archvile>
	<CAKON4OwvYy6Dy-MfHT90syPyAUcTVRXqXca-qAVjk-KWkak53A@mail.gmail.com>
	<20110908163231.4b721973@archvile> <20110908184441.GD16989@siel.b>
	<20110909082844.3dbf0e72@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [213.84.116.84])
	by alsa0.perex.cz (Postfix) with ESMTP id E25F22509C
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 12:02:08 +0200 (CEST)
In-Reply-To: <20110909082844.3dbf0e72@archvile>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: torbenh <torbenh@gmx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Fri, 9 Sep 2011 08:28:44 +0200
David Jander <david.jander@protonic.nl> wrote:

>[...]
> > i am also interested in a proper fabric example.
> 
> What do you think about creating device-tree bindings for that? I tend to
> like the idea of not needing any special board support code besides the DT,
> and the audio fabric driver part is the only obstacle for that.

Ok, I actually spent a while thinking about this. What about the following
idea:

Given the following devicetree:

		...
		// PSC11 in ac97 mode
		ac97@11b00 {
/* 1 */			compatible = "fsl,mpc5121-psc-ac97", "fsl,mpc5121-psc", "alsa,cpu-dai";
			cell-index = <11>;
			reg = <0x11b00 0x100>;
			interrupts = <40 0x8>;
			fsl,mode = "ac97-slave";
			fsl,rx-fifo-size = <384>;
			fsl,tx-fifo-size = <384>;
			#address-cells = <1>;
			#size-cells = <0>;
/* 2 */			codec0: psc-ac97-analog@0 {
/* 3 */				compatible = "national,lm4550", "ac97-codec";
/* 4 */				alsa,codec-dai-name = "ac97-hifi";
			};
		};

Consider the following pseudo-code in sound/soc/soc-of.c:

static struct snd_soc_card card;
static struct snd_soc_dai_link *of_dai;

static __init int of_fabric_init(void)
{
	of_for_each_compatible_node("alsa,cpu-dai") do {
		count++;
	}

	of_dai = kzalloc(count * (sizeof struct snd_soc_dai_link));

	of_for_each_compatible_node("alsa,cpu-dai") as parent do {
		of_for_each_child(parent) as node {
			of_dai[i].name = of_get_name(parent);  /* "ac97" */
			of_dai[i].stream_name = of_fabric_dai[i].name + str(i);
			of_dai[i].cpu_dai_name = of_get_name(node); /* "psc-ac97-analog" */
			of_dai[i].codec_dai_name = of_get_property(node, "alsa,codec_dai_name");
/* 5 */			of_dai[i].codec_name = match_of_compatible_with_registered_codec_list(node);
			of_dai[i].platform_name = of_soc_name + "-pcm-audio";
			i++;
		}
	}

	card.name = "of-audio";
	card.dai_link = of_dai;
	card.num_links = i;

	pdev = platform_device_alloc("soc-audio", 1);
	platform_set_drvdata(pdev, &card);
	platform_device_add(pdev);
}

Notes in the pseudo-source above:

1: By adding compatible = "alsa,cpu-dai", this DAI is marked for binding.

2: Child nodes list all CPU DAI's and their conected codecs. Child node name
is name of the CPU DAI.

3: Many ac97 codecs are compatible with the generic codec driver "ac97-codec".

4: Don't know if this is the right way to work the codec DAI name in. See the
next note:

5: The pseudo-function match_of_compatible_with_registered_codec_list() will
search through the list of registered ALSA codecs and match the compatible
strings of this codec with one in the list. If one is found, the name is used
for of_dai[i].codec_name, otherwise the current node is discarded (no matching
codec driver registered). Maybe the corresponding "codec-dai-name" can be
extracted from the codec database? That would eliminate line /* 4 */.

Unfortunately, this way we will probably need to get back the Kconfig option
to choose which codecs should be built. Apparently this option existed before,
but was removed.

All comments are welcome.

Best regards,

-- 
David Jander
Protonic Holland.
