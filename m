From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Conversion to int16_t and resolution loss with
 rate converter plugins
Date: Fri, 6 Apr 2018 08:32:53 +0200
Message-ID: <dea3c23d-7499-83cf-226b-1da44ff1d380@ivitera.com>
References: <MWHPR21MB0478EFE0FDB4BD2A0A7293D0D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
 <3a7d4f82-07af-cffb-a757-a258242b0199@ivitera.com>
 <MWHPR21MB047829F84F3DCDAD597F6B71D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 62F302673EF
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 08:32:58 +0200 (CEST)
In-Reply-To: <MWHPR21MB047829F84F3DCDAD597F6B71D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
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
To: Flavio Protasio Ribeiro <flaviopr@microsoft.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 5.4.2018 v 23:21 Flavio Protasio Ribeiro napsal(a):
> Hi Pavel,
> 
> Thanks for the reference to your previous discussion and the patches.
> They were super helpful. As you can see from my reply to Takashi, I'm
> proposing adding a convert_s32 method that doesn't impose dependency
> on a HW FPU on alsa-lib. The convert_s32 method would operate on an
> array of int32's.
> 
> From the point of view of the plugin developer, the change from
> convert_s16 to convert_s32 is pretty trivial. The plugins that I
> personally care about operate internally with floats. The plugin
> would remain responsible for converting between int32 and float.

Sounds much better than my attempt at float API.
> 
> I agree that a libsoxr plugin would be great. Getting higher quality
> real-time resampling is my ultimate goal :)

If you make it work, you will be praised by countless users :-)

But the existing rate API will have to be modified since libsoxr behaves 
a bit different to speex or libresample - see the library author 
discussing the issues 
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-September/066764.html

Thanks,

Pavel.
