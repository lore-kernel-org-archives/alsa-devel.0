From: Nikita Yushchenko <nikita.yoush-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2] ASoC: simple-card: add support for aux devices
Date: Sat, 24 Sep 2016 09:04:05 +0300
Message-ID: <caa911e0-9684-f3fb-529c-f722d487c5be@cogentembedded.com>
References: <1474614673-12350-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20160923222541.GA25693@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160923222541.GA25693@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, =?UTF-8?B?T3R0byBLZWvDpGzDpGluZW4=?= <otto-Gh1NM5ZPXYb1KXRcyAk9cg@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Mengdong Lin <mengdong.lin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Healy <cphealy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

>> Changes from v1:
>> - moved example usage from commit message to Documentation/, as
>>   suggested by Kuninori Morimoto,
>> - fixed typo in example usage.
> 
> Ah, one more property to the "simple" card. At what point in adding 
> properties is it not simple?

AFAIU, idea is to have a pure-device-tree-controlled audio device (i.e.
without dedicated machine driver).

Perhaps it should be just renamed at some point.

>> +- simple-audio-card,aux-devs		: List of phandles pointing to auxiliary devices, such
>> +					  as amplifiers, to be added to the sound card.
> 
> I think the property should be specific as to the type of device. What 
> if you have 2 amps? Maybe simple-card can't have 2 outputs. What if you 
> have a chain of devices and need to know the order of them?

snd_soc_card has unordered list of aux devices. Things you mention are
controlled are configured via routing.

Nikita
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
