From: Paulo Fidalgo <paulo.fidalgo.pt@gmail.com>
Subject: Re: Mic detection on Mackbook Pro 12,1 (CS4208)
Date: Thu, 17 Nov 2016 10:30:15 +0000
Message-ID: <CAKbjie6=fGzG=aO29SVkHj1memCGqzk-kk4GXoOagBVasmaZtw@mail.gmail.com>
References: <CAKbjie4D=iSKs_+HNpspZufF1GpB6BZATsS=2=9XhyCEe09PSw@mail.gmail.com>
 <s5h1syhg3h9.wl-tiwai@suse.de>
 <CAKbjie6aTCYCuf+328kaBUCH2CcHrd4QeUYE4zBq4E8GBLqJYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
 [209.85.161.196])
 by alsa0.perex.cz (Postfix) with ESMTP id AE6DA266834
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2016 11:30:17 +0100 (CET)
Received: by mail-yw0-f196.google.com with SMTP id b66so18124156ywh.2
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2016 02:30:17 -0800 (PST)
In-Reply-To: <CAKbjie6aTCYCuf+328kaBUCH2CcHrd4QeUYE4zBq4E8GBLqJYw@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

@Takashi, can you confirm if the possible values we can set are the
same the hdajackretask program uses on overrides?

On 14 November 2016 at 22:21, Paulo Fidalgo <paulo.fidalgo.pt@gmail.com> wrote:
> Thanks Takashi for point out, but that document is overwhelming.
> I understand that developing drivers for unknown hardware should be
> like running in the woods with our eyes covered, but I don't feel I
> have the enough knowledge and time to be able to do it.
>
> If helps, when I connect the headset running hda-analyzer tool in
> monitor mode I only have events related to the OUTPUT:
>
> Watching 2 cards
> ======================================
> Diff for codec 1/0 (0x10134208):
> ---
> +++
> @@ -7,17 +7,17 @@
>  No Modem Function Group found
>  Default PCM:
>      rates [0x0]:
>      bits [0x0]:
>      formats [0x0]:
>  Default Amp-In caps: N/A
>  Default Amp-Out caps: N/A
>  GPIO: io=6, o=2, i=0, unsolicited=1, wake=1
> -  IO[0]: enable=1, dir=1, wake=0, sticky=0, data=1, unsol=0
> +  IO[0]: enable=1, dir=1, wake=0, sticky=0, data=0, unsol=0
>    IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>    IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>    IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>    IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>    IO[5]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>  Node 0x02 [Audio Output] wcaps 0xd043d: Stereo Amp-Out Stripe
>    Control: name="Headphone Playback Volume", index=0, device=0
>      ControlAmp: chs=3, dir=1, idx=0, ofs=0
> @@ -225,26 +225,24 @@
>    Power: setting=D3, actual=D3
>    Connection: 1
>       0x02
>  Node 0x12 [Pin Complex] wcaps 0x400501: Stereo
>    Pincap 0x00000050: OUT Balance
>    Pin Default 0x90170011: [Fixed] Speaker at Int N/A
>      Conn = Analog, Color = Unknown
>      DefAssociation = 0x1, Sequence = 0x1
> -  Pin-ctls: 0x40: OUT
>    Power: setting=D3, actual=D3
>    Connection: 1
>       0x03
>  Node 0x13 [Pin Complex] wcaps 0x400501: Stereo
>    Pincap 0x00000050: OUT Balance
>    Pin Default 0x90170012: [Fixed] Speaker at Int N/A
>      Conn = Analog, Color = Unknown
>      DefAssociation = 0x1, Sequence = 0x2
> -  Pin-ctls: 0x40: OUT
>    Power: setting=D3, actual=D3
>    Connection: 1
>       0x04
>  Node 0x14 [Pin Complex] wcaps 0x400501: Stereo
>    Pincap 0x00000050: OUT Balance
>    Pin Default 0x90170014: [Fixed] Speaker at Int N/A
>      Conn = Analog, Color = Unknown
>      DefAssociation = 0x1, Sequence = 0x4
>
>
> Is there any other info I can provide to help?
>
> Kind regards,
>
> Paulo Fidalgo
>
> On 11 November 2016 at 20:34, Takashi Iwai <tiwai@suse.de> wrote:
>> On Thu, 10 Nov 2016 22:52:52 +0100,
>> Paulo Fidalgo wrote:
>>>
>>> Hi,
>>>
>>> After reporting the issue on bugzilla
>>> (https://bugzilla.kernel.org/show_bug.cgi?id=155601) I felt I could do
>>> more in order to try to get a patch to fix the issue.
>>>
>>> Basically when I plug an headset(mic+headphone), it only detects the
>>> headphone not the mic.
>>>
>>> Since I assumed the "memory address" of the 0x18 pin is wrong, I've
>>> tried to change some values in order to get it working.
>>
>> The value you're referring to isn't a "memory address" at all.
>> It's a "pin configuration" value, containing the information like
>> the location, purpose, sequence number of the given pin, and it's
>> encoded in 32bit integer.  Basically it's merely a hint for drivers to
>> configure the system properly.
>>
>> Refer to the HD-audio specification document for more details.
>>
>>
>> Takashi
