From: Flavio Protasio Ribeiro <flaviopr@microsoft.com>
Subject: Re: Conversion to int16_t and resolution loss with
 rate converter plugins
Date: Thu, 5 Apr 2018 21:21:29 +0000
Message-ID: <MWHPR21MB047829F84F3DCDAD597F6B71D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
References: <MWHPR21MB0478EFE0FDB4BD2A0A7293D0D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
 <3a7d4f82-07af-cffb-a757-a258242b0199@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0111.outbound.protection.outlook.com [104.47.42.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BF9C826732A
 for <alsa-devel@alsa-project.org>; Thu,  5 Apr 2018 23:21:32 +0200 (CEST)
In-Reply-To: <3a7d4f82-07af-cffb-a757-a258242b0199@ivitera.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Pavel,

Thanks for the reference to your previous discussion and the patches. They were super helpful. As you can see from my reply to Takashi, I'm proposing adding a convert_s32 method that doesn't impose dependency on a HW FPU on alsa-lib. The convert_s32 method would operate on an array of int32's.

>From the point of view of the plugin developer, the change from convert_s16 to convert_s32 is pretty trivial. The plugins that I personally care about operate internally with floats. The plugin would remain responsible for converting between int32 and float.

I agree that a libsoxr plugin would be great. Getting higher quality real-time resampling is my ultimate goal :)

Thanks,
Flavio

-----Original Message-----
From: Pavel Hofman <pavel.hofman@ivitera.com> 
Sent: Wednesday, April 4, 2018 11:17 PM
To: Flavio Protasio Ribeiro <flaviopr@microsoft.com>; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Conversion to int16_t and resolution loss with rate converter plugins



Dne 5.4.2018 v 05:05 Flavio Protasio Ribeiro napsal(a):
> Hi Folks,
> 
> 
> 
> The libsamplerate and speex rate converter plugins only implement the
> convert_s16 callback from snd_pcm_rate_ops_t. This has ALSA convert 
> the buffer to int16_t before handing it over to the plugin for 
> resampling. On devices with more than 16 effective bits, this implies 
> words gets truncated and bits are lost.
> 
> 
> 
> Specifically for libsamplerate, the resampling is internally 
> implemented with floats, so truncating to 16 bits does not offer a 
> computational benefit.
> 
> 
> 
> I get why only convert_s16 is implemented for plugins that aren't part 
> of the main alsa-lib package. The more generic convert callback comes 
> with the burden having the plugin support conversion from/to any of 
> the ALSA data types (or alternatively, having the plugin source 
> include plugin_ops.h and its dependencies). So here's what I
> propose: replace convert_s16 with a convert_s32 callback which uses 
> int32_t instead of int16_t. This would preserve all bits from the 
> device and keep the plugin interface simple. Of course this means 
> plugins have to be updated to use convert_s32 and rebuilt.
> 
> 

Hi,

Many years ago I tried to extend the rate API to float, the native formats of libsamplerate and speex.

I go stuck on float support of all platforms, perhaps you can get something from the discussion and patches.

https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fmailman.alsa-project.org%2Fpipermail%2Falsa-devel%2F2011-June%2F041059.html&data=02%7C01%7Cflaviopr%40microsoft.com%7C1a39272ef41948b9e0e508d59abce88d%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C1%7C636585058520946316&sdata=y3iBvFGetAKtrkVO%2FUlHUUHSKpXSyko8pJme6NSlpQA%3D&reserved=0

https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fmailman.alsa-project.org%2Fpipermail%2Falsa-devel%2F2011-July%2F041503.html&data=02%7C01%7Cflaviopr%40microsoft.com%7C1a39272ef41948b9e0e508d59abce88d%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C1%7C636585058520946316&sdata=4%2F%2BIryERoT4btWN%2FGzYQmLH2Q86IPGr7odNuSAxJIVM%3D&reserved=0

If we succeed in adding >16 bit API to the rate plugin, perhaps supporting libsoxr would be the next step which would bring great value (performance vs. CPU load) to alsa-lib. Unfortunately that is not just about conversion, there are other quirks to iron out...

Anyway, thanks a lot and good luck to your very useful endeavour.

Best regards,

Pavel.
