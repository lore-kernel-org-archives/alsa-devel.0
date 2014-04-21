From: Andrew Reyes <dsreyes1014@gmail.com>
Subject: Re: Behringer Uphoria UMC204 usb audio capture only
 pops and clicks
Date: Mon, 21 Apr 2014 13:49:15 -0500
Message-ID: <CAEYsuVN2Z=7oa_VB1660JpiKihoA=DxMn+Vgv-R5upoRpyhxiQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f41.google.com (mail-qa0-f41.google.com
 [209.85.216.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 794EC26088F
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 20:49:16 +0200 (CEST)
Received: by mail-qa0-f41.google.com with SMTP id j5so4157435qaq.28
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 11:49:15 -0700 (PDT)
In-Reply-To: <CAEYsuVNw11e1Lzkbiwoeiz=wiXVUpwJnO51UaBy0eohL9eReEg@mail.gmail.com>
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

>> Ok, in this case, please use "plughw" instead of "hw".

> Ok that worked. It plays fine at 44100 but when I try to set
`--period-size=48000` it still defaults to 44100.

I'm sorry I meant to `--rate=48000`.


On Mon, Apr 21, 2014 at 1:44 PM, Andrew Reyes <dsreyes1014@gmail.com> wrote:

> > Ok, in this case, please use "plughw" instead of "hw".
>
> Ok that worked. It plays fine at 44100 but when I try to set
> `--period-size=48000` it still defaults to 44100.
>
>
> On Mon, Apr 21, 2014 at 1:37 PM, Daniel Mack <daniel@zonque.org> wrote:
>
>> On 04/21/2014 08:33 PM, Andrew Reyes wrote:
>> >> aplay -Dhw:xxx --buffer-size 2048 file.wav
>> >
>> >> (again, xxx is the index or short name of your audio card).
>> >
>> >> Which application do you normally use to play audio?
>> >
>> > I'm using JACK right now for recording and gigging live and pulseaudio
>> for
>> > Youtube and movies.
>>
>> Bot should of course work, but as they're built on top of ALSA, it's
>> best to debug directly on the lower level. IOW: with aplay.
>>
>> > Here is the pastebin link for the aplay command:
>> > http://pastebin.com/3nquKW12
>> >
>> > Playing WAVE 'Open The Eyes Of My Heart.wav' : Signed 16 bit Little
>> Endian, Rate 44100 Hz, Stereo
>> > aplay: set_params:1233: Sample format non available
>> > Available formats:
>> > - S32_LE
>>
>> Ok, in this case, please use "plughw" instead of "hw".
>>
>>
>> Daniel
>>
>>
>
