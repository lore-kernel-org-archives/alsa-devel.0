From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 4/4 v6] ASoC: simple-card: add Device Tree
 support
Date: Wed, 20 Feb 2013 11:02:40 -0700
Message-ID: <51250FC0.4030209@wwwdotorg.org>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <20130129014808.GC4748@opensource.wolfsonmicro.com>
 <87sj5k3f83.wl%kuninori.morimoto.gx@renesas.com>
 <87obg8z4u4.wl%kuninori.morimoto.gx@renesas.com>
 <5107FF97.1070601@wwwdotorg.org>
 <87halz82bm.wl%kuninori.morimoto.gx@renesas.com>
 <51097F0F.2030501@wwwdotorg.org>
 <87halw7sij.wl%kuninori.morimoto.gx@renesas.com>
 <5110349D.3050308@wwwdotorg.org>
 <87ehgvrs1h.wl%kuninori.morimoto.gx@renesas.com>
 <87bobzrry6.wl%kuninori.morimoto.gx@renesas.com>
 <511963F8.5020107@wwwdotorg.org>
 <87bobqf5yq.wl%kuninori.morimoto.gx@renesas.com>
 <511C22E2.60701@wwwdotorg.org>
 <87obfnofsx.wl%kuninori.morimoto.gx@renesas.com>
 <511C6A1B.9000507@wwwdotorg.org>
 <874nhfv5mb.wl%kuninori.morimoto.gx@renesas.com>
 <8738wzuu9g.wl%kuninori.morimoto.gx@renesas.com>
 <87wqubtfi3.wl%kuninori.morimoto.gx@renesas.com>
 <5123A0F5.2030001@metafoo.de>
 <87r4kb95f3.wl%kuninori.morimoto.gx@renesas.com>
 <5124BEF5.4040703@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5124BEF5.4040703-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 02/20/2013 05:17 AM, Lars-Peter Clausen wrote:
> On 02/20/2013 01:48 AM, Kuninori Morimoto wrote:
>>
>> Hi Lars
>>
>> Thank you for checking patch
>>
>>>> +- simple-audio,dev			: phandle and port for CPU/CODEC
>>>> +- simple-audio,frame-master		: frame master
>>>> +- simple-audio,bitclock-master		: bitclock master
>>>> +#sound-dai-cells integer is required on simple-audio,dev phandle's node
>>>
>>> Shouldn't the names of '#sound-dai-cells' and 'simple-audio,dev' kind of
>>> match? E.g. '#sound-dai-cells' and 'sound-dai'. Maybe drop the sound, since
>>> the a in dai kind of implies this.
>>
>> Thank you, but I would like to keep "simple-audio" name for it too.
>> So, can I use
>> simple-audio-dai
>> #simple-audio-dai-cells
> 
> The requirement to be able to find the DAI via devicetree is not specific to
> the simple-audio driver. I'd prefer if we could come up with a common
> binding which can be used by multiple drivers. Since you also add the xlate
> (or match) function to the sound core it makes sense - in my option - to
> also have a generic phandle -> DAI look-up method in the core.

I agree here; the whole reason I've been pushing on creating a
standardized of_xlate_dai_name function and a standardized
#sound-dai-cells property is to allow the exact same property name and
function to be used for any audio-related DT binding.
