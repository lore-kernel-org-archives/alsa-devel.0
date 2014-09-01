From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC][PATCH] ASoC: simple-card: Merge single and muti DAI link
 code.
Date: Mon, 1 Sep 2014 12:39:10 +0300
Message-ID: <54043EBE.9020808@ti.com>
References: <1409294797-21948-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409294797-21948-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch would break the current syntax without introducing any
improvements over it (actually the opposite, see bellow). So in its
current form I don't like this patch at all.

On 08/29/2014 09:46 AM, Xiubo Li wrote:
 > This patch merge single DAI link and muti-DAI links code together,
 > and simply the simple-card driver code.
 >
 > And also do some other improvement:
 >
 > Since from the DAI format micro SND_SOC_DAIFMT_CBx_CFx, the 'CBx'
 > mean Codec's bit clock is as master/slave and the 'CFx' mean Codec's
 > frame clock is as master/slave.
 >
 > So these same DAI formats should be informed to CPU and CODE DAIs at
 > the same time. For the Codec driver will set the bit clock and frame
 > clock as the DAI formats said, but for the CPU driver, if the the
 > bit clock or frame clock is as Codec master, so it should be set CPU
 > DAI device as bit clock or frame clock as slave, and vice versa.
 >

But there is no such problem with the current code any more. The new
preferred way is to indicate bitclock and frame master with phandles
that refer to the master DAI on the link (see the examples bellow).

 > The old code will cause confusion, and we should be clear that the
 > letter 'C' here mean to Codec.
 >
 > Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
 > Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
 > Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
 > Cc: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
 > Cc: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 > ---
 >
 > Hi,
 >
 > This patch will break the old DT, so i just send one RFC version, and
 > will add the old DT patches in next version if this patch can work
 > well.

I do not object in getting rid of this simplified description for a
single dailink card:

(example 1)
sound {
	compatible = "simple-audio-card";
...
	simple-audio-card,format = "left_j";
	simple-audio-card,bitclock-master = <&dailink0_master>;
	simple-audio-card,frame-master = <&dailink0_master>;
	simple-audio-card,cpu {
		sound-dai = <&sh_fsi2 0>;
	};

	dailink0_master: simple-audio-card,codec {
		sound-dai = <&ak4648>;
		clocks = <&osc>;
	};
};

and describing the DAI-links always like this:

(example 2)
sound {
	compatible = "simple-audio-card";
...
	simple-audio-card,dai-link@0 {
		format = "i2s";
		bitclock-master = <&dailink0_master>;
		frame-master = <&dailink0_master>;
		dailink0_master: cpu {
			sound-dai = <&audio1 0>;
		};
		codec {
			sound-dai = <&tda998x 0>;
		};
	};
};

But I do object going back to the old syntax exclusively and
describing the bitclock and frame master always with simple boolean
properties, like this:

(example 3)
sound {
	compatible = "simple-audio-card";
...
	simple-audio-card,dai-link@0 {
		format = "i2s";
		dailink0_master: cpu {
			sound-dai = <&audio1 0>;
		};
		codec {
			sound-dai = <&tda998x 0>;
			bitclock-master;
			frame-master;
		};
	};
};

In my opinion we should rather get rid of this syntax than move
exclusively to it.

The syntax of example 2 is simply superior to the syntax of example
3. With the syntax on example 2 it is possible to describe TDM setups
where there is multiple codecs on a single i2s bus. The syntax of
example 3 simply can not describe that kind of setup.

If you need to have the backwards compatibility syntax describing the
clock masters to work also in the multilink mode (example 3), then do
just that (it is simple enough [1]). But please do not break the new
phandle based syntax!!!

Best regards,
Jyri

[1] To enable legacy syntax in multilink mode just apply this patch:

diff --git a/sound/soc/generic/simple-card.c 
b/sound/soc/generic/simple-card.c
index 8dd7957..aed3423 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -242,10 +242,10 @@ static int simple_card_dai_link_of(struct 
device_node *node,
         if (ret < 0)
                 goto dai_link_of_err;

-       if (strlen(prefix) && !bitclkmaster && !framemaster) {
-               /* No dai-link level and master setting was not found from
-                  sound node level, revert back to legacy DT parsing and
-                  take the settings from codec node. */
+       if (!bitclkmaster && !framemaster) {
+               /* No dai-link level master setting was found, revert
+                  back to legacy DT parsing and take the settings
+                  from the codec node boolean properties. */
                 dev_dbg(dev, "%s: Revert to legacy daifmt parsing\n",
                         __func__);
                 dai_props->cpu_dai.fmt = dai_props->codec_dai.fmt =

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
