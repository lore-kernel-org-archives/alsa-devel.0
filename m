From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH - AAF PCM plugin 3/7] aaf: Implement
	Playback mode support
Date: Thu, 11 Oct 2018 16:45:07 +0900
Message-ID: <d1524938-2bb1-89ab-a03f-0822908c71f5@sakamocchi.jp>
References: <20181003234547.16839-1-andre.guedes@intel.com>
 <20181003234547.16839-4-andre.guedes@intel.com>
 <s5ha7nmxf80.wl-tiwai@suse.de> <1539206847.3120.20.camel@intel.com>
 <s5htvltc52e.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 33A26267737
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2018 09:45:15 +0200 (CEST)
In-Reply-To: <s5htvltc52e.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Guedes, Andre" <andre.guedes@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On Oct 11 2018 16:31, Takashi Iwai wrote:
> On Wed, 10 Oct 2018 23:27:29 +0200,
> Guedes, Andre wrote:
>>
>> On Wed, 2018-10-10 at 12:34 +0200, Takashi Iwai wrote:
>>>> +static int aaf_set_hw_constraint(snd_pcm_aaf_t *aaf)
>>>> +{
>>>> +     int res;
>>>> +     snd_pcm_ioplug_t *io = &aaf->io;
>>>> +     const unsigned int accesses[] = {
>>>> +             SND_PCM_ACCESS_RW_INTERLEAVED,
>>>> +     };
>>>> +     const unsigned int formats[] = {
>>>> +             SND_PCM_FORMAT_S16_BE,
>>>> +             SND_PCM_FORMAT_S24_3BE,
>>>> +             SND_PCM_FORMAT_S32_BE,
>>>> +             SND_PCM_FORMAT_FLOAT_BE,
>>>> +     };
>>>> +     const unsigned int rates[] = {
>>>> +             8000,
>>>> +             16000,
>>>> +             24000,
>>>> +             32000,
>>>> +             44100,
>>>> +             48000,
>>>> +             88200,
>>>> +             96000,
>>>> +             176400,
>>>> +             192000,
>>>> +     };
>>>
>>> Use static arrays for the above.
>>
>> It isn't clear to me what is the point in allocating these variables in
>> the global scope. May I ask what is the benefit in adding the 'static'
>> modifier to these local variables?
> 
> Yes.

In this case, it's not relevant to access scope.

Just with 'const' qualifier, the symbol allocates in .text section of
ELF binary. With additional 'static' qualifier, the symbol allocates in 
.rodata section.

In loading, symbol in .rodata section locates in segments of VMA with
'read-only' flag. This brings safety from several bugs such as buffer
over-run.


Regards

Takashi Sakamoto
