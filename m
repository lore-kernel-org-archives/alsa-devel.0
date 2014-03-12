From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [alsa-devel] [PATCH RFC v2 0/2] Fix simple-card *-master DT parameter
 handling
Date: Wed, 12 Mar 2014 11:27:09 +0200
Message-ID: <5320286D.6080009@ti.com>
References: <cover.1394451329.git.jsarha@ti.com>	<877g80rzgg.wl%kuninori.morimoto.gx@gmail.com>	<CAHPCO9FmL__LmUyMRhsy2mnPNAV0h--aMY=GBJjL9TBrAqWSFw@mail.gmail.com> <87wqg0q74d.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <87wqg0q74d.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Richard Lee <superlibj8301@gmail.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, peter.ujfalusi@ti.com, broonie@kernel.org, bcousson@baylibre.com
List-Id: alsa-devel@alsa-project.org

On 03/12/2014 08:11 AM, Kuninori Morimoto wrote:
>
> Hi Richard
>
>>> but anyway, if my understanding is correct,
>>>
>>>          simple-audio-card,cpu {
>>>                  ...
>>>                  bitclock-master;
>>>                  frame-master;
>>>          };
>>>
>>>          simple-audio-card,codec {
>>>                  ...
>>>                  bitclock-master;
>>>                  frame-master;
>>>          };
>>>
>>> This will be
>>> cpu   : SND_SOC_DAIFMT_CBS_CFS
>>> codec : SND_SOC_DAIFMT_CBM_CFM
>>>
>>
>> Yes, That's also what my understanding of this patches.
>
> Thank you. I understand.
> (and I need to send fixup patches :)
>
> # "codec-is-bitclock-master" seems understandable than
> # current "bitclock-master"...
>

Sounds great to me!

Best regards,
Jyri
