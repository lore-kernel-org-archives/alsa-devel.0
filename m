From: Pap Peti <roachkiller44@gmail.com>
Subject: Re: M-audio Audiophile Firewire
Date: Thu, 27 Oct 2016 16:10:06 +0200
Message-ID: <80a6876e-6ced-7daa-7268-1277850c8270@gmail.com>
References: <CAPzTivG=yDAbFZo+u5qauE_LdpqhUM5fT9MT9+hrmi3gTsTGqw@mail.gmail.com>
 <1f6dd683-f550-651b-93d2-87560dd298ff@sakamocchi.jp>
 <fd56b817-96b3-1784-725c-21a5bef7497a@sakamocchi.jp>
 <CAPzTivEubUhef5LR_p3y0_4TZtbwoLimvzU-tx=xmUhBnT+T0g@mail.gmail.com>
 <CAPzTivHypNMZvBVBks=wpx1XakELyeWsBVD9mpq-risb_DtH=Q@mail.gmail.com>
 <7f5bc2fc-7e45-2577-9286-be0e2ff74228@sakamocchi.jp>
 <CAPzTivHqY1aBH2hqHetmd7-hdZsPbPsC8e1iMjgL=2myH91fbg@mail.gmail.com>
 <a2d308f4-1982-8418-40ec-e783065f7a96@sakamocchi.jp>
 <CAPzTivFtjdmpEOYJo=a=B12_Zf9UVV+SjRUKA9hNWLop3w5nbg@mail.gmail.com>
 <CAPzTivEPwnerkvH-Y5j9bvGzsM5GhLKvF69zFAkVHpDt-8g1Lw@mail.gmail.com>
 <20161023224350.GB12315@marvin.atrad.com.au>
 <5951c05f-3fe4-a2fc-aab2-407fddf8a817@gmail.com>
 <6f6374d3-f616-0d9d-31ac-2d463573f889@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id B2E0C2673EC
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 16:10:10 +0200 (CEST)
Received: by mail-wm0-f49.google.com with SMTP id n67so45363673wme.1
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 07:10:10 -0700 (PDT)
In-Reply-To: <6f6374d3-f616-0d9d-31ac-2d463573f889@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Jonathan Woithe <jwoithe@just42.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

My controller:


*-firewire
                    description: FireWire (IEEE 1394)
                    product: XIO2200A IEEE-1394a-2000 Controller (PHY/Link)
                    vendor: Texas Instruments
                    physical id: 0
                    bus info: pci@0000:06:00.0
                    version: 01
                    width: 32 bits
                    clock: 66MHz
                    capabilities: ohci bus_master cap_list
                    configuration: driver=firewire_ohci latency=32 
maxlatency=4 mingnt=2
                    resources: irq:19 memory:f1c04000-f1c047ff 
memory:f1c00000-f1c03fff


...summerize:

- If the system work with ALSA driver, the latency minimum 5ms. (and 
where/how can I check the current/real value?)

Anyway I cant use the Sakamoto's utils, I downloaded and installed from 
a package, but not any manual with that. I dont know how can I start 
that stuff and configure in terminal. So only the Jack controller 
remember my settings (and save)?


Regards



On 2016-10-27 01:47, Takashi Sakamoto wrote:
> On Oct 27 2016 04:25, Pap Peti wrote:
>> I think my things still belongs to the 'alsa-devel' topic, because I use
>> the 'ffado-mixer' only to 'turn on' my audio input(s)/output(s)
>>
>> I added my username to the "audio" anyway, and already I wont noticed
>> noise (but sometimes the audio 'stream(?)' stuck a ~half second when I
>> listen music and e.g.: meanwhile run a long file copy, or come some
>> sound from the browser. I think its a 'multi-threaded' problem, and/or
>> different audio sampling rate in same time.
>>
>> So I use to make live records, and do some electric tracks too, but I
>> dont feel I need Jack, because ALSA also can work with low latency (at
>> least in the Tracktion). And - strange - but I feel on this platform the
>> sound quality better than on Windows (with Win10 and the latest Win7
>> 64bit drivers).
> If you need "sham" latency value, using libffado stuff is suitable to
> your aim.
>
> In a point of packet streaming protocol for IEC 61883-1/6 and interrupt
> interval of OHCI 1394 context, ALSA bebob driver has minimum value for
> PCM frames in one buffer period. Currently tt's 5msec. In detail, see
> comment of corresponding code:
> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/firewire/amdtp-stream.c#n140
>
> Jackd with firewire backend just displays value convenient to users,
> although it's not reasonable in a technical point.
>
>
> Well, about the noise you heard, I can't re-generate the issue. So we
> could judge it depending on environment. Do you explain more details?
> Which application you use? What OHCI 1394 controller you use? And so on.
>
>> My main problem already only;
>>
>> After when I turn off the soundcard and/or the laptop, I need to start
>> again the ffado-mixer to turning on the channels (default: every channel
>> muted, or inactive). I'd appreciate some stuff that resolves the basic
>> settings, I only need the 1/2 sreaming out and 1/2 analog input. Thats all.
>>
>> (sometimes when I restart the system and the soundcard still on power
>> (external ps) the settings are retained)
> This is not supported in ALSA bebob driver because it can be implemented
> in user land. Please use ffado-dbus-server/ffado-mixer or
> libhinawa/hinawa-utils.
>
>
> Regards
>
> Takashi Sakamoto
