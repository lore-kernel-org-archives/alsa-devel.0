From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] rcar: src: skip disabled-SRC nodes
Date: Thu, 12 May 2016 22:30:22 +0300
Message-ID: <bd8df260-b5b7-f237-0d90-42d2781cf3a4@cogentembedded.com>
References: <2350728.BUGJNqvVzR@wasted.cogentembedded.com>
 <874ma4nme6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <874ma4nme6.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello.

    I'm now seeing I have unintended dash between words in the subject. Should 
I resend?

On 05/12/2016 03:41 AM, Kuninori Morimoto wrote:

>> The current device tree representation of the R-Car Sample Rate Converters
>> (SRC) assumes that they are numbered consecutively, starting from 0. Alas,
>> this  is not  the case with the R8A7794 SoC where SRC0 isn't present.  In
>> order to keep the existing  device trees working, I'm suggesting to use a
>> disabled node for SRC0.  Teach the SRC probe  to just skip disabled nodes.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>
> Maybe best solution is caring DT's @ number (src@0, src@1, ...) somehow

    Thought about it too... as well as adding an optional "reg" property.

> but, it makes rsnd_src_probe() and other src related function complex code.
> This can keep simple code.
>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

    Thank you.

MBR, Sergei
