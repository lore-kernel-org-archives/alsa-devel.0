From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: PROBLEM: [Lenovo ThinkPad X61s] Speaker volume
 mutes itself in random intervals after upgrading from 3.11 to 3.15.
Date: Tue, 3 Jun 2014 19:38:43 +0800
Message-ID: <CAN8cciaxYYQqKBrACAuWQTq3eTXqS3qT84-3ns7NDW6S0WC8kw@mail.gmail.com>
References: <538ACE22.9020306@gmail.com> <s5h8upflouw.wl%tiwai@suse.de>
 <538C3BF4.2000706@gmail.com> <s5h1tv7lliv.wl%tiwai@suse.de>
 <538C489C.1030508@gmail.com> <s5hvbsjjz2w.wl%tiwai@suse.de>
 <538D7C3C.3040301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com
 [209.85.192.44])
 by alsa0.perex.cz (Postfix) with ESMTP id DD1E32610A3
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 13:38:44 +0200 (CEST)
Received: by mail-qg0-f44.google.com with SMTP id i50so12645554qgf.17
 for <alsa-devel@alsa-project.org>; Tue, 03 Jun 2014 04:38:43 -0700 (PDT)
In-Reply-To: <538D7C3C.3040301@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Fedora <alexander.fedora@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
>>>>>>> Hi,
>>>>>>>
>>>>>>> Please see problem description below. I've captured alsa info
output for
>>>>>>> the latest kernel. Kernel just before the regression. And info from
the
>>>>>>> kernel with the offending commit. But I had to calculate diff from
first
>>>>>>> one to fit to 100K limit. If you want, I can send all 3 files as an
>>>>>>> attachments. Also the latest version of the kernel was took from
>>>>>>>
http://kernel.ubuntu.com/~kernel-ppa/mainline/daily/current/linux-image-3.15.0-999-generic_3.15.0-999.201405310205_amd64.deb
>>>>>>> .
>>>>>>>
>>>>>>> Thank you,
>>>>>>> Alex
>>>>>>>
>>>>>>> [1.] One line summary of the problem: [Lenovo ThinkPad X61s] Speaker
>>>>>>> volume mutes itself in random intervals after upgrade to latest
kernel
>>>>>>> [2.] Full description of the problem/report:
>>>>>>>
>>>>>>> Speaker mutes itself in random intervals. Headphones are working
fine at
>>>>>>> that moment. I can see what volume of the Speaker drops to 0% and
then
>>>>>>> back to 100% using alsamixer. It seems like Internal Mic Boost also
>>>>>>> jumps from 100% to 0% and back. It is regression from
>>>>>>> 5ccc618fee67f0f0b2122dd4b32a02fd2b6a1569 (ALSA: hda - Remove static
>>>>>>> quirks for AD1884/1984 & variants). I've tested previous commit
>>>>>>> aa95d61b43e0fcb0b2ce68e5efa37174fd9e5cd3 (ALSA: hda - Remove static
>>>>>>> quirks for AD1882) and audio works as expected.
>>>>>>>
>>>>>>> New kernel shows two controls "Headphone Playback Volume" and
"Speaker
>>>>>>> Playback Volume". But old one shows single control "PCM Playback
>>>>>>> Volume". "Speaker Playback Volume" is the one which gets muted
randomly.
>>>>>>
>>>>>> Are you using PulseAudio?  If yes, does the problem happen without
PA?
>>>>>> This kind of random mute/unmute tends to be an issue of bogus
>>>>>> headphone or mic jack detection.
>>>>>>

GPIO: io=3, o=0, i=0, unsolicited=1, wake=0
- IO[0]: enable=0, dir=0, wake=0, sticky=0, data=1, unsol=0
+ IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
    IO[1]: enable=1, dir=0, wake=0, sticky=0, data=0, unsol=0
    IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0

Seem gpio are different

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_analog.c?id=5ccc618fee67f0f0b2122dd4b32a02fd2b6a1569

Those  unsolicited event of mic jacks were not enabled

You need to use hda-jack-sense-test
