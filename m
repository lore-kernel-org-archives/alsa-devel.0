From: Adam Williamson <awilliam@redhat.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Mon, 08 Jul 2013 09:35:10 -0700
Message-ID: <c2cbc2323ce3a8e0df5f52de3ecb276c@www.happyassassin.net>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
 <51D5FCFC.8010506@gmail.com> <s5hip0pwp49.wl%tiwai@suse.de>
 <51D6B56D.8050909@gmail.com> <s5h1u7dchqh.wl%tiwai@suse.de>
 <020e0ad5107eb4c2bb333468be58d7d3@www.happyassassin.net>
 <51D9F543.2070605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id B35F7265456
 for <alsa-devel@alsa-project.org>; Mon,  8 Jul 2013 18:35:12 +0200 (CEST)
In-Reply-To: <51D9F543.2070605@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tormen <my.nl.abos@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2013-07-07 16:09, Tormen wrote:
> On 05/07/13 23:38, Adam Williamson wrote:
>> On 2013-07-05 5:29, Takashi Iwai wrote:
>> 
>>>> This is the debian 3.9.6 kernel + alsa-compile to get "debug=2" for
>>>> snd.ko module to work as by default the CONFIG_SND_DEBUG is not set 
>>>> in
>>>> debian kernels.
>>> 
>>> OK, looking at two outputs, the difference is that the recent kernel
>>> allows the 5.1 output configuration with two mic jacks.  But, this
>>> looks rather strange as a laptop.  Does the machine have really two
>>> microphone jacks?  The BIOS sets pins 0x18 and 0x19 are mic jacks.
>> 
>> I feel like this was the issue the LAST time it stopped working, too.
>> No, the system does not have two mic jacks - at least, there is only
>> one visible and accessible to the user on the outside of the case, on
>> my model.
> Actually... there should be three mic channels:
>     The built-in (internal) microphone
>     +
>     One mic jack beside the headphone jack
>     +
>     One other hidden within the headphone jack:
>     (a) the Notebook came with Noise-cancelling headsets, but they are
> small in-ear plugs so there is no place for noise-cancelling logic in
> the plugs
>     (b) I think I remember to have read somewhere that this thingy
> actually needs the windows driver installed to be noise-cancelling!
>     (c) the PLUG of these headphones have another channel (visible
> through another ring on the jack)
> 
> This explains the 2nd mic channel :)

Ah, yes, I'd forgotten about that little wrinkle. I don't pretend to be 
following the exact details of the planned fix here, but just as a 
high-level remark, this 'extra mic jack' seems very much like an 
implementation detail for the noise cancellation which Linux does not do 
in any case (AFAIK). It wouldn't make sense to me to expose it as a 
'normal' mic jack, exactly. It's not like you can plug an actual 
microphone into this 'mic jack' and use it. How will it be exposed 
exactly after the patch, tiwai?
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | identi.ca: adamwfedora
http://www.happyassassin.net
