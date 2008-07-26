From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc.h macros
Date: Sat, 26 Jul 2008 11:52:31 +0100
Message-ID: <20080726105227.GB3215@sirena.org.uk>
References: <9e4733910807252126q4c4a045bp146452d9789fa8de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A703D245F9
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jul 2008 12:52:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807252126q4c4a045bp146452d9789fa8de@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 26, 2008 at 12:26:13AM -0400, Jon Smirl wrote:
> Can you help me document these macros?

Have you seen Documentation/sound/alsa/soc/codec.txt (not that it's
complete)?

> For example what does TLV stand for? I know it supplies a decibel range.

Don't know for sure, sorry - this is just a straight pass-through of the
generic ALSA API of the same name.

> R really mean two registers.

Yes, it expands to register.  Note that it only ever occurs for things
that are already a SOC_DOUBLE of some description so is neater than it
seems if you just try to document the convention.

> What does EXT do?

EXT expands to external - it adds per control read and write operations
so the machinery can be used for things not the primary CODEC (eg, an
external amplifier like you'll see in the OpenMoko or the jack controls
on the Zaurus machines).

Once we support multiple CODECs there will be less need for this, it's
partly a bodge due to not being able to have more than one CODEC driver
in the system.

> How about S8?

Signed 8 bit - the 8 bit part of it is just due to the bitmasking, there
shouldn't be any other need for it.

> SOC_ENUM("3D Function", wm8753_enum[5]),
> SOC_ENUM seems really inefficient tracking those enum numbers.

The use of indexes into an array is mostly in older ASoC drivers - I
believe it is a result of mechanical conversion from older, pre-ASoC
drivers.  It's not nice and there's no actual need for it but it's never
been worth fixing.  More modern drivers use variables with names, though
some do end up with the big array due to templating off older drivers.

> Could you declare the enum in place?

For the enum control itself then providing the compiler is happy I can't
see any immediate reason why not.  For the text it's quite useful to be
able to specify the text separately since that means that multiple
instances of the same set of enumerated values don't need to have the
text written out again.

> #define SOC_ENUM_SINGLE(xname, xreg, xshift, xmax, xtexts) \
> {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,\
> 	.info = snd_soc_info_enum_double, \
> 	.get = snd_soc_get_enum_double, .put = snd_soc_put_enum_double, \
> 	.private_value = (unsigned long) &(struct soc_enum) \
> 	.reg = xreg, .shift_l = xshift, .shift_r = xshift, \
> 	.max = xmax, .texts = xtexts }

> Is it possible to turn all of these macros into inline functions? Can
> an inline initialize a structure? Making them inlines would get us
> syntax checking without expansion.

You can't do anything at compile time outside of the preprocessor,
unfortunately.
