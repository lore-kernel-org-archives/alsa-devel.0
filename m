From: Hui Wang <hui.wang@canonical.com>
Subject: Re: A problem about two microphones
Date: Thu, 6 Jul 2017 15:48:23 +0800
Message-ID: <14186ada-5386-376b-67a1-a950780edb80@canonical.com>
References: <deb2b0a4-3411-2fea-a75a-d6134845ad99@canonical.com>
 <s5h8tk2au99.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C445F266AF7
 for <alsa-devel@alsa-project.org>; Thu,  6 Jul 2017 09:48:29 +0200 (CEST)
In-Reply-To: <s5h8tk2au99.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 07/06/2017 03:40 PM, Takashi Iwai wrote:
> On Thu, 06 Jul 2017 04:09:07 +0200,
> Hui Wang wrote:
>> Recently we met a problem, on a lenovo machine, it has two
>> microphones(one is microphone, the other is headset-mic), and both of
>> them are located in the front panel.
>>
>> When the driver assigns names for them (via the function
>> hda_get_autocfg_input_label()), they are assigned the same name "Mic"
>> since they have the same location. So there are two "Mic", but the
>> pulseaudio can't handle two "Mic", in the pulseaudio, it can only
>> handle multiple inputs/microphones with different names, like "Mic"
>> and "Front Mic". If two microphones have the same name, we can only
>> see one of them through pulseaudio.
>>
>> I don't know how to solve this problem, the simplest way to workaround
>> it I can figure out is to change one of the microphone's location, let
>> them have differnt location, then they have differnet names.
>> Pin Default 0x02a19040: [Jack] Mic at Ext Front
>> Changed to:
>> Pin Default 0x04a19040: [Jack] Mic at Ext Right
>>
>> Do you have any ideas to solve this problem?
> As you noticed, an easy fix would be to fake the front mic by
> adjusting the pin config.  It's more or less acceptable, IMO.
> It'd be OK by adding a proper comment explaining the situation.
>
> Another option would be to rename the kctls later as you like.
> If PA works no matter which string prefix is, it's also an acceptable
> workaround, but I guess this would be come bigger changes than the
> above although it achieves an almost same result.
>
> Or fix PA, it's a better one for kernel side ;)
OK, got it. Since there is only one machine having this problem, let us 
use the simplest way to workaround it. And I guess it is very rare that 
machines have multiple Front Mic or Rear Mic in reality. If we have more 
machines having this problem, let us start to try a general solution then.

Thanks,
Hui.

>
> thanks,
>
> Takashi
>
