From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: No support for 128kHz sample rate ?
Date: Thu, 14 Aug 2003 18:09:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <34183.193.253.230.179.1060877395.squirrel@www.undata.org>
References: <34050.193.253.230.179.1060874341.squirrel@www.undata.org>
        <s5hbrusfcur.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrusfcur.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: thomas@undata.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> At Thu, 14 Aug 2003 17:19:01 +0200 (CEST),
> Thomas Charbonnel wrote:
>>
>> Hi,
>>
>> I'm currently working on the hdsp 9632 driver. This card supports
>> sample rates up to 192kHz, including 128kHz and 176.4kHz. The problem
>> is 128kHz sample rate seems to have been omited in <sound/pcm.h>. How
>> am I supposed to deal with this ?
>
> there are two ways:
>
> 1. define a new bit for 128k, and add to your rates field.
>    easy one but will affect others.
>
> 2. define your own hw_constraints.
>    add something like the following:
>
> 	static unsigned int xxx_rates[] =
> 		{ 32000, 44100, ....., 128000, 176400, 192000 };
> 	static snd_pcm_hw_constraint_list_t xxx_hw_const_rates = {
> 		.count = ARRAY_SIZE(xxx_rates),
> 		.list = xxx_rates,
> 	};
>
>   and in the open callback of pcm:
>
> 	static int snd_xxx_pcm_open(snd_pcm_substream_t *substream)
> 	{
> 		....
>
> 		snd_pcm_hw_constraint_list(substream->runtime, 0,
> 					   SNDRV_PCM_HW_PARAM_RATE,
> 					   &xxx_hw_const_rates);
> 		....
> 	}
>
>   then add SNDRV_PCM_RATE_KNOT to rates field, which indicates the
> unconventional rates are supported.
>
>
>
> well, i would take the latter :)
>
>

Thanks,
I reported this because I thought 128kHz was somehow conventional, but I'm
ok with the hw_constraints method.

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
