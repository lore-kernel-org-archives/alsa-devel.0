From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 4/4] ASoC: simple-card: Add DT
 documentation for multi-DAI links
Date: Mon, 17 Mar 2014 12:19:46 +0200
Message-ID: <190d334218a324f12078f81d769322ca@kapsi.fi>
References: <cover.1394883134.git.moinejf@free.fr>
 <d054780a0edf4b2338a52e48bff9144e19aa614f.1394883134.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d054780a0edf4b2338a52e48bff9144e19aa614f.1394883134.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 2014-03-15 13:30, Jean-Francois Moine wrote:
> There may be many couples of CPU/CODEC DAI links.
> The example 2 is extracted from the Cubox DT.
> 
> Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> ---
[...]

This binding forces all the dai links to share the same card level 
properties. I find it problematic in these cases:

>> - simple-audio-card,format		: CPU/CODEC common audio format.
>> 					  "i2s", "right_j", "left_j" , "dsp_a"
>> 					  "dsp_b", "ac97", "pdm", "msb", "lsb"

The code allows having the format parameter in sub nodes too, but the 
document does no mention it. Adding a mention would solve this problem 
at least partly.

Neither does the document mention that 
"simple-audio-card,bitclock-inversion" and 
"simple-audio-card,frame-inversion" are also allowed in card level. 
Currently the code uses simple bit-wise-or from card-level and dai-level 
daifmt parameters, which may lead to broken daifmt setting. However, 
this on directly related to this patch.

>> - dai-tdm-slot-num			: Please refer to tdm-slot.txt.
>> - dai-tdm-slot-width			: Please refer to tdm-slot.txt.

These properties are actually only taken from sub-nodes so the document 
is broken but the code is ok.

In general this binding would look better if another sub-node level 
would added for dai-link related properties, including the cpu and codec 
sub-nodes, but that would break the backwards compatibility.

Best regards,
Jyri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
