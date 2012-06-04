From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Analog Mono Output and Mono Input
Date: Mon, 4 Jun 2012 09:30:14 +0800
Message-ID: <CAN8ccibJxcCbakfHwo3v5UFGzGgDiPBiG7dz7Ae7SGhAw8tBfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BB2AC103B6F
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 03:30:14 +0200 (CEST)
Received: by werh12 with SMTP id h12so2506725wer.38
	for <alsa-devel@alsa-project.org>; Sun, 03 Jun 2012 18:30:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

>
>> what is the definition of "Mono Output" in pulseaudio ?
>>
>> My three other sound cards does support mono playback and mono capture
>>
>> The system setting/sound in gnome session allow me to select "mono
>> duplex" but when it does not allow me to select "mono output + mono
>> input" in unity session.
>
>
> That sounds like the known bug I was working on yesterday.
>

Although those three sound cards (au8830, emu10k1 and ymfpci) support
mono playback and capture.

None of them use the AC97 "Master Mono" pin for output.

gnome speaker-test show only one speaker

"Master Mono Playback Volume" was also removed from emu10k1 driver but
still exist in au8830 and ymfpci driver

There is no "mono" volume control for capture volume.

There are "LFE on mono" in unity settings/sound in ubuntu 12.04 for
au8830 and ymfpci which still have "Master Mono Playback Volume" but
"LFE on mono" is not exist in gnome settings/sound Fedora 17 Live CD

Also My Creative 4.1 speaker set only have green and black jacks
(Surround40) supported by emu10k1 and au8830

Can anyone explain "Analog Mono Output" and "surround41" in pulseaudio ?
