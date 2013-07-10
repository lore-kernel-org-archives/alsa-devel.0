From: Tormen <my.nl.abos@gmail.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Wed, 10 Jul 2013 23:42:18 +0200
Message-ID: <51DDD53A.8040502@gmail.com>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
 <51D5FCFC.8010506@gmail.com> <s5hip0pwp49.wl%tiwai@suse.de>
 <51D6B56D.8050909@gmail.com> <s5h1u7dchqh.wl%tiwai@suse.de>
 <020e0ad5107eb4c2bb333468be58d7d3@www.happyassassin.net>
 <51D9F543.2070605@gmail.com>
 <c2cbc2323ce3a8e0df5f52de3ecb276c@www.happyassassin.net>
 <s5hvc4luem4.wl%tiwai@suse.de>
 <46b0590bfa4ffc836dde180f8ffe3c97@www.happyassassin.net>
 <s5hwqoycu0y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
 [74.125.82.176])
 by alsa0.perex.cz (Postfix) with ESMTP id D1FB32656F1
 for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2013 23:42:25 +0200 (CEST)
Received: by mail-we0-f176.google.com with SMTP id t56so6239563wes.21
 for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2013 14:42:25 -0700 (PDT)
In-Reply-To: <s5hwqoycu0y.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Adam Williamson <awilliam@redhat.com>
List-Id: alsa-devel@alsa-project.org

On 10/07/13 17:30, Takashi Iwai wrote:
> At Tue, 09 Jul 2013 11:53:47 -0700,
> Adam Williamson wrote:
>> On 2013-07-08 10:48, Takashi Iwai wrote:
>>
>>>> Ah, yes, I'd forgotten about that little wrinkle. I don't pretend to
>>>> be
>>>> following the exact details of the planned fix here, but just as a
>>>> high-level remark, this 'extra mic jack' seems very much like an
>>>> implementation detail for the noise cancellation which Linux does not
>>>> do
>>>> in any case (AFAIK). It wouldn't make sense to me to expose it as a
>>>> 'normal' mic jack, exactly. It's not like you can plug an actual
>>>> microphone into this 'mic jack' and use it. How will it be exposed
>>>> exactly after the patch, tiwai?
>>> Well, Tormen's description sounds like it being a mic for a headset,
>>> no?
I did mention though:
 >     (a) the Notebook came with Noise-cancelling headsets, but they 
are small in-ear plugs so there is no place for noise-cancelling logic 
in the plugs ...

>> No, at least IIRC - the special headphones that come with the system 
>> aren't for voice calling or whatever, they're active noise cancelling 
>> earphones. 
>> http://forum.notebookreview.com/sony/501220-sony-noise-cancelling-ear-phones-came-vaio-z-3.html 
>> is a thread about them, for e.g. 
> OK, then it's not suitable to handle it as a headset.
> I expected it being rather a standard TRRS connector.
OK, I looked into that and here are my findings:

People reported about two different models of noise cancelling 
headphones in the context of Sony VAIO VPCZ Notebooks.
Both are 5-conductor jacks.

You can see them both here:
http://attachment.imp3.net/forum/month_1103/11030618490735852e6e2772f8.jpg
The right side version is better seen here with it's extra "notch" 
adding the 5th conductor to an otherwise 4.5mm 4-conductor TRRS jack (3 
black rings + notch)
     http://pic.yupoo.com/melly/C8LBXQYf/LBWc6.jpg
The left side version is a 3.5 mm 5-conductor TRRS phone connector (4 
black rings)
http://img03.taobaocdn.com/bao/uploaded/i3/T1xd9qXcNbXXaS84UV_020744.jpg

I do have the LEFT side version (the one with 4 black rings)

Important:
  * This TRRS headset jack works just fine when you plug a stereo 
headphones (3-conductor version).
  * And It seems to also work fine with a 4-conductor version (headphone 
+ mic smartphone headset) - see about "Mic 1" below.

More details about the wiring (from an alsamixer viewpoint in (debian) 
kernel 3.9.6):

+++ "Mic 1" refers to the earplug Stereo mic channel.
The "Microphone Boost 1" controls nicely this "Mic 1".
When capturing from "Mic 1" in alsamixer (with 3.9.6 debian kernel 
without any new patch):

     * plugging a standard 4-conductor TRRS (headset + MONO microphone 
combination like common for smartphones these days with 3 black rings)
     -> the microphone comes through on the right microphone channel
     Unfortunately I don't have a headset + STEREO microphone 
combination at hand :/

     * plugging the 5-conductor TRRS original noise cancelling headset 
(model Sony "mdr-nc021")
     -> the microphone in the /left/ earplug (it says "L" on the plug) 
comes through on the LEFT microphone channel
     +  the microphone in the /right/ earplug (it says "R" on the plug) 
comes through on the RIGHT microphone channel

+++ "Mic" refers to the Mic TRRS standard Stereo jack which is beside 
the headset TRRS jack.
The "Microphone Boost" controls nicely the "Mic" capture channel.

+++ "Internal" refers to the built in Stereo Microphone

+++ The "Digital" channel seems to have the exact same effect than the 
"Capture" channel (controlling the degree of amplification of the 
currently active capture source)
There is certainly a deeper sense in the distinguishing both of them, 
but I don't get it :)

So this does make all perfect sense to me (especially "Mic 1") and I 
like the idea to further expose this quite /real/ stereo microphone 
channel "Mic 1".

Here is a small test recording I did using the (model Sony "mdr-nc021") 
headset:
https://docs.google.com/file/d/0B9I6C680kzS1RFBOdWtaZXNIY00/edit?usp=sharing

(( maybe rename "Mic" to "Mic jack" and "Mic 1" to "Headphone Mic" ))


Knuth
