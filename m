From: Adam Williamson <awilliam@redhat.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Tue, 09 Jul 2013 11:53:47 -0700
Message-ID: <46b0590bfa4ffc836dde180f8ffe3c97@www.happyassassin.net>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
 <51D5FCFC.8010506@gmail.com> <s5hip0pwp49.wl%tiwai@suse.de>
 <51D6B56D.8050909@gmail.com> <s5h1u7dchqh.wl%tiwai@suse.de>
 <020e0ad5107eb4c2bb333468be58d7d3@www.happyassassin.net>
 <51D9F543.2070605@gmail.com>
 <c2cbc2323ce3a8e0df5f52de3ecb276c@www.happyassassin.net>
 <s5hvc4luem4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id DF88F26559A
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2013 20:53:49 +0200 (CEST)
In-Reply-To: <s5hvc4luem4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Tormen <my.nl.abos@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 2013-07-08 10:48, Takashi Iwai wrote:

>> Ah, yes, I'd forgotten about that little wrinkle. I don't pretend to 
>> be
>> following the exact details of the planned fix here, but just as a
>> high-level remark, this 'extra mic jack' seems very much like an
>> implementation detail for the noise cancellation which Linux does not 
>> do
>> in any case (AFAIK). It wouldn't make sense to me to expose it as a
>> 'normal' mic jack, exactly. It's not like you can plug an actual
>> microphone into this 'mic jack' and use it. How will it be exposed
>> exactly after the patch, tiwai?
> 
> Well, Tormen's description sounds like it being a mic for a headset,
> no?

No, at least IIRC - the special headphones that come with the system 
aren't for voice calling or whatever, they're active noise cancelling 
earphones. 
http://forum.notebookreview.com/sony/501220-sony-noise-cancelling-ear-phones-came-vaio-z-3.html is a thread about them, for e.g.

> If so, it's not for a noise canceling, and we can expose the jack
> and the control of the secondary mic simply as "Headset Mic".
> In anyway, this will be a separate fix.

-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | identi.ca: adamwfedora
http://www.happyassassin.net
