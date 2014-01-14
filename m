From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Prevent speaker from entering automute on
 some AIO models
Date: Tue, 14 Jan 2014 13:50:21 +0800
Message-ID: <52D4D01D.5010203@canonical.com>
References: <1389595947-15038-1-git-send-email-hui.wang@canonical.com> <s5h38ksw68l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5h38ksw68l.wl%tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, david.henningsson@canonical.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 01/13/2014 06:01 PM, Takashi Iwai wrote:
> At Mon, 13 Jan 2014 14:52:27 +0800,
> Hui Wang wrote:
>> On some AIO (All In One) models with the codec alc668
>> (Vendor ID: 0x10ec0668) on it, when we plug a headphone into the jack,
>> the system will switch the output to headphone and set the speaker to
>> automute as well as change the speaker Pin-ctls from 0x40 to 0x00,
>> this will bring loud noise to the headphone.
>>
>> I tried to disable the corresponding EAPD, but it did not help to
>> eliminate the noise.
>>
>> So far, the only way to eliminate the noise is preventing the speaker
>> from entering automute.
>>
>> BugLink: https://bugs.launchpad.net/bugs/1268468
>> Cc: David Henningsson <david.henningsson@canonical.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> What about to use auto_mute_via_amp flag instead like the patch below?
>
>
>
Test has been done on the three AIO models, auto_mute_via_amp flag can 
eliminate the noise and fix the problem.

I am going to send a v2 patch to use auto_mute_via_amp to replace 
suppress_auto_mute.


Thanks,
Hui.
