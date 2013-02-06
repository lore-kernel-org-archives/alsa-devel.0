From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: 3.8-rc1 patch_cirrus 4.0 regression...
Date: Wed, 06 Feb 2013 13:10:34 +0100
Message-ID: <5112483A.7040308@canonical.com>
References: <CAMVG2suCiLak3CbeKZtEgjeJqw3=1fD3k9FMsm=tYE7h3cuVjQ@mail.gmail.com> <s5hsj5aag7z.wl%tiwai@suse.de> <CAMVG2stEPHuk-cNwZHjtnOP=PeXwF7SMxMSp=HVaOy9SzW2Dgw@mail.gmail.com> <s5hobfyafeg.wl%tiwai@suse.de> <s5hd2weacbe.wl%tiwai@suse.de> <CAMVG2ssBaD=W3mAecKjCH8+G-HiVpHqQ5iSoyA4n9_3Mgz=VWQ@mail.gmail.com> <s5h4nhp7wij.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h4nhp7wij.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel J Blueman <daniel@quora.org>, Linux Kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/06/2013 08:05 AM, Takashi Iwai wrote:
> At Wed, 6 Feb 2013 08:47:41 +0800,
> Daniel J Blueman wrote:
>>

>>> To be sure, could you try again 3.8-rc6 without reversing patches,
>>> adjust "Speaker" and "Bass Speaker" volumes properly, and retest?
>>> If it still doesn't work, please take alsa-info.sh snapshot at this
>>> state for comparing with the previous result.
>>
>> My apologies! We do now have "Bass Speaker" which affects both bass
>> speakers. It was always being restored to level 0 and works when set
>> up.
>
> OK, good to know.
>
>> There is a "Subwoofer" slider in addition to "Balance" and "Fade" in
>> the GNOME mixer UI which is greyed out; presumably this is intended as
>> the same mixer control?
>
> I have no idea about GNOME stuff... David, do you know of this?

I haven't followed this discussion closely, but what sliders are enabled 
in Gnome sound settings is related to what profile is selected for that 
card. So if you select the 2.1 profile, "Balance" and "Subwoofer" will 
be enabled (and "Fade" disabled), but in a 4.0 profile, "Balance" and 
"Fade" will be enabled (and "Subwoofer" disabled). Is that answering 
your question?

For the record, PulseAudio does not yet use the new channel mapping API.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
