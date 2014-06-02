From: Alex Fedora <alexander.fedora@gmail.com>
Subject: Re: PROBLEM: [Lenovo ThinkPad X61s] Speaker volume
 mutes itself in random intervals after upgrading from 3.11 to 3.15.
Date: Mon, 02 Jun 2014 01:55:16 -0700
Message-ID: <538C3BF4.2000706@gmail.com>
References: <538ACE22.9020306@gmail.com> <s5h8upflouw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 4886A2610AB
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 10:55:25 +0200 (CEST)
Received: by mail-pd0-f180.google.com with SMTP id y13so3181914pdi.25
 for <alsa-devel@alsa-project.org>; Mon, 02 Jun 2014 01:55:23 -0700 (PDT)
In-Reply-To: <s5h8upflouw.wl%tiwai@suse.de>
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

On 06/02/2014 01:03 AM, Takashi Iwai wrote:
> At Sat, 31 May 2014 23:54:26 -0700,
> Alex Fedora wrote:
>> Hi,
>>
>> Please see problem description below. I've captured alsa info output for
>> the latest kernel. Kernel just before the regression. And info from the
>> kernel with the offending commit. But I had to calculate diff from first
>> one to fit to 100K limit. If you want, I can send all 3 files as an
>> attachments. Also the latest version of the kernel was took from
>> http://kernel.ubuntu.com/~kernel-ppa/mainline/daily/current/linux-image-3.15.0-999-generic_3.15.0-999.201405310205_amd64.deb
>> .
>>
>> Thank you,
>> Alex
>>
>> [1.] One line summary of the problem: [Lenovo ThinkPad X61s] Speaker
>> volume mutes itself in random intervals after upgrade to latest kernel
>> [2.] Full description of the problem/report:
>>
>> Speaker mutes itself in random intervals. Headphones are working fine at
>> that moment. I can see what volume of the Speaker drops to 0% and then
>> back to 100% using alsamixer. It seems like Internal Mic Boost also
>> jumps from 100% to 0% and back. It is regression from
>> 5ccc618fee67f0f0b2122dd4b32a02fd2b6a1569 (ALSA: hda - Remove static
>> quirks for AD1884/1984 & variants). I've tested previous commit
>> aa95d61b43e0fcb0b2ce68e5efa37174fd9e5cd3 (ALSA: hda - Remove static
>> quirks for AD1882) and audio works as expected.
>>
>> New kernel shows two controls "Headphone Playback Volume" and "Speaker
>> Playback Volume". But old one shows single control "PCM Playback
>> Volume". "Speaker Playback Volume" is the one which gets muted randomly.
> Are you using PulseAudio?  If yes, does the problem happen without PA?
> This kind of random mute/unmute tends to be an issue of bogus
> headphone or mic jack detection.
>
>
> Takashi
>
Hi Takashi,

Yes, I'm using  PulseAudio. I've removed it and issue gone away. It 
returned back after reinstalling it. This is still driver bug, right?

Thank you,
Alex
