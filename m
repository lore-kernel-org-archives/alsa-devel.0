From: Connor McAdams <conmanx360@gmail.com>
Subject: Re: [PATCH 00/15] Add support for Sound BlasterX AE-5
Date: Thu, 20 Sep 2018 10:15:39 -0400
Message-ID: <CAM8Agx2VAfDv5TD4W_VSo-Ln5g=3wecBicyS4Xr7SiKAwQU-Bg@mail.gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com> <s5hbm8sskco.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hbm8sskco.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Alastair Bridgewater <alastair.bridgewater@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thank you for fixing that. I was doing that previously, but this time
I was only doing it every few commits. Will make sure to go back to
the way I was doing it before. Sorry about that.

On Thu, Sep 20, 2018 at 3:23 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 18 Sep 2018 20:33:28 +0200,
> Connor McAdams wrote:
>>
>> This patch series adds support for the Sound BlasterX AE-5. I have
>> personally tested it, and had others test it as well. All outputs work,
>> front headphone, rear headphone, rear line-out, surround, digital. The
>> only issue currently is that the microphone suffers from inconsistency
>> like the Sound Blaster Z does, and Creative may be willing to help fix
>> that, but if they're not, I have a few ideas.
>>
>> I also have the ZxR working currently. That will require some more
>> complicated changes of the driver, so I have left it out and just
>> focused on the AE-5.
>>
>> Connor McAdams (15):
>>   ALSA: hda/ca0132 - Define new verbs and control params
>>   ALSA: hda/ca0132 - Add quirk for Sound BlasterX AE-5
>>   ALSA: hda/ca0132 - Add pincfg for AE-5
>>   ALSA: hda/ca0132 - Set AE-5 bools and select mixer
>>   ALSA: hda/ca0132 - Change ca0132_mmio_init for AE-5
>>   ALSA: hda/ca0132 - Add AE-5 pre-init and ca0113 functions
>>   ALSA: hda/ca0132 - Add AE-5 regular init setup
>>   ALSA: hda/ca0132 - Change firmware name and usage
>>   ALSA: hda/ca0132 - Merge post-dsp functions + cleanup
>>   ALSA: hda/ca0132 - Add DSP setup functions for AE-5
>>   ALSA: hda/ca0132 - Clean up ca0132_alt_out_select
>>   ALSA: hda/ca0132 - Add output set commands for AE-5
>>   ALSA: hda/ca0132 - Add input selection commands for AE-5
>>   ALSA: hda/ca0132 - Add AE-5 specific controls
>>   ALSA: hda/ca0132 - Add AE-5 exit function
>
> Thanks, applied now all 15 patches.
>
> One patch caused a compile warning in the middle of series due to an
> unused variable which is used in a later patch.  Since it's a trivial
> issue, I addressed it by myself locally.  But at the next time, it'd
> be helpful if you do a compile test for each commit in the series
> before submission.
>
>
> Takashi
