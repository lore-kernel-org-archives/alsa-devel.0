From: Steven Wawryk <stevenw@acres.com.au>
Subject: Re: Adding channels on multicodec soundcard
Date: Fri, 15 Jan 2016 18:59:41 +1030
Message-ID: <5698ADF5.2090005@acres.com.au>
References: <5698894D.2030002@acres.com.au> <56989099.3050404@acres.com.au>
 <CAG5mAdyAkzy+HCOM1J=rJqf5rqTtbEYdAM9FFdCBqwsmgbkAAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.acres.com.au (mail.acres.com.au [150.101.238.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CDDE726057A
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 09:29:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by loki.acres.com.au (Postfix) with ESMTP id 76F0AC2CB3
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 18:59:48 +1030 (CST)
Received: from mail.acres.com.au ([127.0.0.1])
 by localhost (loki.acres.com.au [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fFpFLeOldCyV for <alsa-devel@alsa-project.org>;
 Fri, 15 Jan 2016 18:59:41 +1030 (CST)
Received: from [192.0.2.164] (krill.acres.com.au [192.0.2.164])
 by loki.acres.com.au (Postfix) with ESMTP id 59538C0D33
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 18:59:41 +1030 (CST)
In-Reply-To: <CAG5mAdyAkzy+HCOM1J=rJqf5rqTtbEYdAM9FFdCBqwsmgbkAAA@mail.gmail.com>
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


Thanks Caleb,

Fortunately with 4 different (physical) TDM link pairs I don't have to 
get the codecs to play together gracefully on a single link. From what 
you've said it sounds like my first method with 4 snd_soc_dai_link's, 
representing 4 physical links is probably the better approach.

So I guess my question boils down to basically the same as yours - how 
to get multiple devices acting as, and routing through, a single device?

Steve


On 15/01/16 17:44, ccrome wrote:
> On Thu, Jan 14, 2016 at 10:24 PM, Steven Wawryk <stevenw@acres.com.au> wrote:
>> I should have added that there is a pair (capture + playback) of serial
>> "I2S" links (actually TDM) between the Zynq and *each* codec.
>>
>>
>>
>> On 15/01/16 16:23, Steven Wawryk wrote:
>>>
>>> Hi,
>>>
>>> I'm trying to write an ALSA soundcard driver module for an embedded
>>> Zynq-based system with 4 Cirrus CS42448 codecs.  Each codec has 6 analog
>>> output channels and I'd like the "soundcard" to have 24 channels (6 to each
>>> codec).  I've been having trouble getting it to do this.  The hw_params for
>>> the codec, card and "I2S" IP core drivers all get the same parameters,
>>> including number of channels.
>>>
>>> When I define 4 snd_soc_dai_link's, each with 1 codec, then 4 "devices"
>>> are set up for the card and I can access 6 channels on 1 codec (1 "device")
>>> at a time.  When I define 1 snd_soc_dai_link with 4 codecs then 1 "device"
>>> is set up and I can still only access 6 channels, but it appears to use all
>>> 4 codecs (somehow - I haven't yet worked out the channel allocation).  I
>>> can't seem to get 24 channels to the card, splitting into 6 channels to each
>>> of the codecs.
>>>
> Heh, I just composed, but didn't send an almost identical question --
> in my case I want 2 or 3 freescale SSI ports to behave as one device,
> all in perfect synchrony.  I'd love to hear the answer from somebody
> that really understands the code better than I.
>
> To get multiple codecs on one DAI link gracefully, you need a set of
> patches, the last of which was roughly "[PATCH] ASoC: dapm: Don't add
> prefix to widget stream name", See arnaud/nicolin/liam helping me back
> here: http://mailman.alsa-project.org/pipermail/alsa-devel/2015-September/097564.html.
> The first time I see this patch is in 4.2.  3.17 might be a challenge.
>
> I sure suspect that having multiple cpu-side ports on the link isn't
> supported.
> Looking in soc.h
> (http://lxr.free-electrons.com/source/include/sound/soc.h#L952), I see
> several places where there are arrays of codecs, but never an array of
> cpu-side ports inside one device.
>
> So, I can share my work on how to get multiple codecs on a single TDM
> bus, but I'm not sure how to get multiple interfaces to appear as one
> device.
>
> -Caleb
>
>
>>> Can anyone suggest how I should be going about this?
>>>
>>> The linux kernel is 3.17 from PetaLinux (Xilinx).
>>>
>>> Cheers,
>>> Steve
>>>
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
