From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [alsa-devel] ca0132 audio in Ubuntu 19.04 only after Windows 10
 started, missing ctefx-r3di.bin
Date: Fri, 28 Jun 2019 17:29:54 +0800
Message-ID: <4E6239D9-3A70-4D66-9F88-453EB268DA2A@canonical.com>
References: <156097935391.32250.14918304155094222078.malonedeb@chaenomeles.canonical.com>
 <156113479576.29306.8491703251507627705.malone@gac.canonical.com>
 <B0FDD5B2-EA6F-4ABC-8BF5-6231AA31EB70@canonical.com>
 <s5hh88a6pig.wl-tiwai@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hh88a6pig.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: conmanx360@gmail.com, alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

at 17:13, Takashi Iwai <tiwai@suse.de> wrote:

> On Fri, 28 Jun 2019 08:35:51 +0200,
> Kai-Heng Feng wrote:
>> Hi Connor,
>>
>> The bug was filed at Launchpad [1], I think the most notable error is
>> [    3.768667] snd_hda_intel 0000:00:1f.3: Direct firmware load for
>> ctefx-r3di.bin failed with error -2
>>
>> The firmware is indeed listed in patch_ca0132.c, but looks like
>> there’s no  corresponding file in linux-firmware.
>
> FYI, the firmware is found in alsa-firmware git repo for now.

Got it, thanks for the info. Didn’t know there’s alsa-firmware repo.

Kai-Heng

>
>
> Takashi
