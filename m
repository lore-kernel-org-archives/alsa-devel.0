From: Andrew Reyes <dsreyes1014@gmail.com>
Subject: Re: Behringer Uphoria UMC204 usb audio capture only
 pops and clicks
Date: Wed, 23 Apr 2014 09:40:07 -0500
Message-ID: <CAEYsuVMhzhY8oHUn6DmXeDHLDL3xrmQo8P+xhBrvwhZaBfiegw@mail.gmail.com>
References: <CAEYsuVOBOGMwqhzx8ZROJ8+vbmfD6Ty=fnAtzccMqkFUGKPM4A@mail.gmail.com>
 <53551C5B.5010002@zonque.org>
 <CAEYsuVP1pr87v0y5SuKL87bCRr5RpfgLiSfjsZb4mis1yE_w1g@mail.gmail.com>
 <CAEYsuVML1ZFGGP35KB=3im_JTgNSCoNfPg1aMnzT6mjR=u1cJA@mail.gmail.com>
 <5355431F.3000501@zonque.org>
 <CAEYsuVNvr3WE+RCgCHKZHrBKybAc8muhx3nMu1NgfRgVbj9z1g@mail.gmail.com>
 <53555A0F.4080406@zonque.org>
 <CAEYsuVOmTuJ7dHu8mvOF0currhfgwC9WO3hitbKEAgKRBj9eoQ@mail.gmail.com>
 <5355655B.3050705@zonque.org>
 <CAEYsuVNw11e1Lzkbiwoeiz=wiXVUpwJnO51UaBy0eohL9eReEg@mail.gmail.com>
 <CAEYsuVN2Z=7oa_VB1660JpiKihoA=DxMn+Vgv-R5upoRpyhxiQ@mail.gmail.com>
 <53556961.5060600@zonque.org>
 <CAEYsuVOb=Ai=qd2F05JuoE5Xrb3gSDDuxCPHW=vLM-dcuQzdkA@mail.gmail.com>
 <CAEYsuVP2w8rQYxVReYm9jaxM40Yyta+P9OJWzEYbwcSJ7BVDRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f50.google.com (mail-qg0-f50.google.com
 [209.85.192.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B6A32610B0
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 16:40:08 +0200 (CEST)
Received: by mail-qg0-f50.google.com with SMTP id 63so993698qgz.23
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 07:40:07 -0700 (PDT)
In-Reply-To: <CAEYsuVP2w8rQYxVReYm9jaxM40Yyta+P9OJWzEYbwcSJ7BVDRQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Is there something else I could do to get to the problem?


On Mon, Apr 21, 2014 at 3:33 PM, Andrew Reyes <dsreyes1014@gmail.com> wrote:

> Ok I did playback on a 48khz song and no pops and clicks.  So it's just on
> the capture side only.  What could cause that on the capture side of things?
>
>
> On Mon, Apr 21, 2014 at 1:56 PM, Andrew Reyes <dsreyes1014@gmail.com>wrote:
>
>> > Generate some sine wav files in various rates with something like
>> > audacity and play them. FWIW, a 192k file can be found here:
>>
>>   > http://zonque.org/sine-192khz.wav (~22 MB)
>>
>> Ok I will try that now.  I should let you know that I just tried the
>> arecord command for that same device at 48000 and it pops and clicks just
>> as in JACK.
>>
>>
>> On Mon, Apr 21, 2014 at 1:54 PM, Daniel Mack <daniel@zonque.org> wrote:
>>
>>> On 04/21/2014 08:49 PM, Andrew Reyes wrote:
>>> >>> Ok, in this case, please use "plughw" instead of "hw".
>>> >
>>> >> Ok that worked. It plays fine at 44100 but when I try to set
>>> > `--period-size=48000` it still defaults to 44100.
>>> >
>>> > I'm sorry I meant to `--rate=48000`.
>>>
>>> Generate some sine wav files in various rates with something like
>>> audacity and play them. FWIW, a 192k file can be found here:
>>>
>>>   http://zonque.org/sine-192khz.wav (~22 MB)
>>>
>>>
>>> Daniel
>>>
>>>
>>
>
