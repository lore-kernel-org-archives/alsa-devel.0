From: Matt Flax <flatmax@flatmax.org>
Subject: Re: ASoC: CPU DAI samsung-i2s.0 not registered
Date: Thu, 14 Aug 2014 15:54:54 +1000
Message-ID: <53EC4F2E.6000602@flatmax.org>
References: <53EC1CAE.7040906@flatmax.org>
 <20140814112819.07545223@songinha-Samsung-DeskTop-System>
 <53EC3726.1020700@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [150.101.137.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BB9826563B
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 07:55:15 +0200 (CEST)
In-Reply-To: <53EC3726.1020700@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I think I have gotten around this problem using the code in the 
samsung/smdk_wm8994.c probe function :
         implant_dai.cpu_dai_name = NULL;
         implant_dai.cpu_of_node = of_parse_phandle(np, 
"samsung,i2s-controller", 0);
         implant_dai.platform_name = NULL;
         implant_dai.platform_of_node = implant_dai.cpu_of_node;

Now having problems with the codec registration :
     .codec_name    = "implant-codec",

ASoC: CODEC implant-codec not registered


I am looking for the magic here ...

Any ideas ?

Matt

On 14/08/14 14:12, Matt Flax wrote:
> Thanks for the idea ... I have set this :
>     i2s0: i2s@03830000 {
>         status = "okay";
>     };
>
> and I get the same problem.
>
> Is there anything else which is required to register the samsun-i2s.0 
> driver ?
> Can you tell me whether my codec/driver requires any code to register 
> the i2s0 ?
>
> I have the following in my driver :
> static struct snd_soc_dai_link implant_dai = {
>     .name        = "implant bva",
>     .stream_name    = "IMPLANT",
>     .cpu_dai_name = "samsung-i2s.0",
>     .codec_dai_name = "implant-pcm",
>     .platform_name = "samsung-i2s.0",
>     .codec_name    = "implant-codec",
> };
>
> thanks
> Matt
>
> On 14/08/14 12:28, Inha Song wrote:
>> Hi,
>>
>> Did you set to i2s0 status?
>>
>> -> status = "okay";
>>
>> Best regards,
>> Inha Song.
>>
>> On Thu, 14 Aug 2014 12:19:26 +1000
>> Matt Flax <flatmax@flatmax.org> wrote:
>>
>>> Hi there,
>>>
>>> Any ideas why this problem is coming up when I try to load a driver ?
>>>
>>> Here is the device tree :
>>>
>>>       i2s0: i2s@03830000 {
>>>           compatible = "samsung,i2s-v5";
>>>           reg = <0x03830000 0x100>;
>>>           dmas = <&pdma0 10
>>>               &pdma0 9
>>>               &pdma0 8>;
>>>           dma-names = "tx", "rx", "tx-sec";
>>>           clocks = <&clock_audss EXYNOS_I2S_BUS>,
>>>               <&clock_audss EXYNOS_I2S_BUS>,
>>>               <&clock_audss EXYNOS_SCLK_I2S>;
>>>           clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
>>>           samsung,supports-6ch;
>>>           samsung,supports-rstclr;
>>>           samsung,supports-secdai;
>>>           samsung,idma-addr = <0x03000000>;
>>>           pinctrl-names = "default";
>>>           pinctrl-0 = <&i2s0_bus>;
>>>       };
>>>
>>>       implant: implant@0 {
>>>               compatible = "bva,implant";
>>>       };
>>>
>>>       sound {
>>>           compatible = "bva,implant-bva";
>>>
>>>           samsung,i2s-controller = <&i2s0>;
>>>           samsung,audio-codec = <&implant>;
>>>       };
>>>
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
