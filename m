From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Auto mute mode
Date: Thu, 18 Feb 2016 08:15:47 +0100
Message-ID: <56C56FA3.30409@canonical.com>
References: <6FAB7C47BCF00940BB0999A99BE3547A17A30AE1@RTITMBSV09.realtek.com.tw>
 <s5hy4aj4qsj.wl-tiwai@suse.de> <56C470CE.4020608@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B204226067A
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 08:15:44 +0100 (CET)
In-Reply-To: <56C470CE.4020608@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hui Wang <hui.wang@canonical.com>
Cc: "(alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>, Anthony Wong <anthony.wong@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Hui,

I need to take care of a sick child today so I can't work.

The bug Kailang is talking about is https://bugs.launchpad.net/bugs/1535533

And he keeps talking about auto-mute mode, and I've tried to explain to 
him more than once that if muting the amp-out on node 0x14 does not 
cause the speaker to mute, then that's the real issue here. And that 
seems to be the case, but I can't double check because I don't have the 
hardware.

I don't understand Kailang's answers, because his English is too bad and 
contain very few words. Maybe you can talk to him in Chinese and getter 
better answers?

Thanks in advance,
   // David

On 2016-02-17 14:08, Hui Wang wrote:
> Hello Kailang,
>
> What machine do you use? I will try to find this machine in Canonical
> and investigate this issue on the machine.
>
> BTW, I did not meet this problem before.
>
> Regards,
> Hui.
>
>
> On 02/17/2016 05:41 PM, Takashi Iwai wrote:
>> On Wed, 17 Feb 2016 09:31:55 +0100,
>> Kailang wrote:
>>> Hi Takashi,
>>>
>>> I add the ALC225 for Dell headset mode supported.
>>> But it has the issue for speaker don't mute when headphone or headset
>>> was pluged.
>> Is alc_update_headset_mode() called when you plug/unplug the headphone
>> or the headset?  If yes, which value is set to new_headset_mode?
>>
>>> The issue is occur to Mic in pluged.
>>> When Mic in is pluged, auto mute mode will change to disable.
>>> But when plug headphone or headset into jack, auto mute mode still
>>> keep on disable.
>>> So, speaker will have output at the same time.
>> The same question applies.  This is a Dell machine with
>> ALC255_FIXUP_DELL1_MIC_NO_PRESENCE fix up.  The mic pin has no jack
>> detection but the detection is triggered only by the headset (HP)
>> pin.  All these imply likely that the detection of the headset mode
>> doesn't work properly.
>>
>> I haven't touched with these Dell quirks, but Canonical guys did it.
>> They should have a better clue.  Now Cc'ed.
>>
>>
>> Takashi
>>
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
