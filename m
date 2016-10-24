From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/4] ASoC: rt286: rt286_mic_detect() uses
 component
Date: Mon, 24 Oct 2016 09:06:26 +0200
Message-ID: <e615912f-f6e7-a696-31f2-009c927838ec@metafoo.de>
References: <87eg3a2v32.wl%kuninori.morimoto.gx@renesas.com>
 <87d1iu2v1j.wl%kuninori.morimoto.gx@renesas.com>
 <s5hshrmnsj2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id BF0F22661A4
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 09:06:33 +0200 (CEST)
In-Reply-To: <s5hshrmnsj2.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On 10/24/2016 08:57 AM, Takashi Iwai wrote:
> On Fri, 21 Oct 2016 06:29:09 +0200,
> Kuninori Morimoto wrote:
>>
>>
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> Intel broadwell is using card->codec_dev_list, but it will be
>> replaced to component list soon. Then, it will not be able to use
>> "codec".
> 
> Can't it be deduced by a simple container_of()?

There is the snd_soc_component_to_codec() helper for this.
