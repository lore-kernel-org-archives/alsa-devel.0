From: ccrome <ccrome@gmail.com>
Subject: Re: Adding channels on multicodec soundcard
Date: Thu, 14 Jan 2016 23:14:23 -0800
Message-ID: <CAG5mAdyAkzy+HCOM1J=rJqf5rqTtbEYdAM9FFdCBqwsmgbkAAA@mail.gmail.com>
References: <5698894D.2030002@acres.com.au> <56989099.3050404@acres.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
 [209.85.213.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A89F260557
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 08:14:44 +0100 (CET)
Received: by mail-ig0-f174.google.com with SMTP id z14so5856017igp.1
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2016 23:14:44 -0800 (PST)
In-Reply-To: <56989099.3050404@acres.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Wawryk <stevenw@acres.com.au>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 14, 2016 at 10:24 PM, Steven Wawryk <stevenw@acres.com.au> wrote:
>
> I should have added that there is a pair (capture + playback) of serial
> "I2S" links (actually TDM) between the Zynq and *each* codec.
>
>
>
> On 15/01/16 16:23, Steven Wawryk wrote:
>>
>>
>> Hi,
>>
>> I'm trying to write an ALSA soundcard driver module for an embedded
>> Zynq-based system with 4 Cirrus CS42448 codecs.  Each codec has 6 analog
>> output channels and I'd like the "soundcard" to have 24 channels (6 to each
>> codec).  I've been having trouble getting it to do this.  The hw_params for
>> the codec, card and "I2S" IP core drivers all get the same parameters,
>> including number of channels.
>>
>> When I define 4 snd_soc_dai_link's, each with 1 codec, then 4 "devices"
>> are set up for the card and I can access 6 channels on 1 codec (1 "device")
>> at a time.  When I define 1 snd_soc_dai_link with 4 codecs then 1 "device"
>> is set up and I can still only access 6 channels, but it appears to use all
>> 4 codecs (somehow - I haven't yet worked out the channel allocation).  I
>> can't seem to get 24 channels to the card, splitting into 6 channels to each
>> of the codecs.
>>

Heh, I just composed, but didn't send an almost identical question --
in my case I want 2 or 3 freescale SSI ports to behave as one device,
all in perfect synchrony.  I'd love to hear the answer from somebody
that really understands the code better than I.

To get multiple codecs on one DAI link gracefully, you need a set of
patches, the last of which was roughly "[PATCH] ASoC: dapm: Don't add
prefix to widget stream name", See arnaud/nicolin/liam helping me back
here: http://mailman.alsa-project.org/pipermail/alsa-devel/2015-September/097564.html.
The first time I see this patch is in 4.2.  3.17 might be a challenge.

I sure suspect that having multiple cpu-side ports on the link isn't
supported.
Looking in soc.h
(http://lxr.free-electrons.com/source/include/sound/soc.h#L952), I see
several places where there are arrays of codecs, but never an array of
cpu-side ports inside one device.

So, I can share my work on how to get multiple codecs on a single TDM
bus, but I'm not sure how to get multiple interfaces to appear as one
device.

-Caleb


>> Can anyone suggest how I should be going about this?
>>
>> The linux kernel is 3.17 from PetaLinux (Xilinx).
>>
>> Cheers,
>> Steve
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
