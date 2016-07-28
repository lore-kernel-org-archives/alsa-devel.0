From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] Question about struct snd_soc_dai() ::
 cpu_dai->codec
Date: Thu, 28 Jul 2016 22:24:12 +0200
Message-ID: <579A69EC.9060205@metafoo.de>
References: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/26/2016 07:41 AM, Kuninori Morimoto wrote:
> 
> Hi ALSA SoC
> 
> My current headache is ALSA SoC's each modules (= Card/Codec/CPU/Platform)
> doesn't care about "unbind/rmmod".
> For example, if someone unbinded/rmmoded "Codec", Card or other modules
> doesn't know about it. Thus, user can continue to use this sound card,
> and kernel will be Oops.
> 
> So, I would like to solve this issue, and for this purpose,
> now I'm investigating about ALSA SoC structures.
> It is now super complex, and I noticed that it is having duplicated
> struct members.
> 
> If possible, I would like to cleanup this issue.
> 
> During this investigating, I noticed 1 strange operation
> 
> ${LINUX}/sound/soc/soc-core.c :: snd_soc_runtime_set_dai_fmt
> 
> int snd_soc_runtime_set_dai_fmt(xxx)
> {
> 	...
> 	/* Flip the polarity for the "CPU" end of a CODEC<->CODEC link */
> 	if (cpu_dai->codec) {
> 		...
> 	}
> 	...
> }
> 
> struct snd_soc_dai {
>        ...
> 	/* parent platform/codec */
> 	struct snd_soc_codec *codec;
> 	struct snd_soc_component *component;
> 	...
> }
> 
> According to snd_soc_dai, *codec is its "parent".
> I wonder does "cpu_dai" really can have "codec" parent ??
> I think this is not correct, and we can remove this operation ?

This is for CODEC<->CODEC links where no CPU DAI is involved and the
"CPU" side of the DAI link is actually a CODEC.

Ideally we'd make the DAI links agnostic to what is connected, e.g. it
shouldn't matter what type is connected to what side. But that does not
work since things are anti-symmetric between CPU and CODEC DAIs. On
CODEC DAIs the capture stream is output, on CPU DAIs the capture stream
is input, similar thing for playback. So we need to know whether the DAI
is a CPU DAI or a CODEC DAI.

Fixing this at this point is near to impossible since it requires
invasive changes to all existing drivers. So we need this code and can't
drop it.

The best we can do is try to come up with a generic interface that is
DAI type independent and recommend this interface for new drivers.
