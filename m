From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: hda problem on Gigabyte GA-Z87X-UD3H motherboard
Date: Thu, 2 Jan 2014 16:10:12 +0800
Message-ID: <CAN8cciYaQaYCzT4NPnfE3OC4Fk78kndEPOmnOuhPBG4K9_MTGQ@mail.gmail.com>
References: <52B838F4.3030701@desclaux.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
 [209.85.213.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 070A0261641
 for <alsa-devel@alsa-project.org>; Thu,  2 Jan 2014 09:10:13 +0100 (CET)
Received: by mail-ig0-f177.google.com with SMTP id uy17so33107077igb.4
 for <alsa-devel@alsa-project.org>; Thu, 02 Jan 2014 00:10:12 -0800 (PST)
In-Reply-To: <52B838F4.3030701@desclaux.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guillaume Desclaux <guillaume@desclaux.fr>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> I've reported an issue with snd-hda-intel with my Gigabyte GA-Z87X-UD3H
> motherboard on Launchpad but it seems not the best place to that
>
> See :https://bugs.launchpad.net/bugs/1248116
>
> In "Volume control PulseAudio", I can see pulseaudio changing the audio
> output "Internal Audio Analogic Stereo". The port switch rapidly from
> "Analogic output" to "Analogic headphones" making a jerky sound.
>
> You can find the trace.log file here :
>
> https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+
> bug/1248116/+attachment/3934401/+files/trace.log
>
> It seems that there are many hda_power_count
>
> 1/ This problem appears with the front connector on the motherboard
> connected to a HDA front panel on the case (I've double-checked the
> connection)
> 2/ The problem still appears when the front connector on the motherboard
> is not connected at all to the case !
> 3/ This bug seems quite common with Gigabyte motherboard : If you search
> with Google "Gigabyte Z87X hda" you will find other descriptions of this
> same strange behavior :
>
> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1242302
> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1067434
>
>
> If I disable jack detection by specifying a hint for early patching
> (jack_detect = no), the sound is cristal clear !
>
>
https://launchpadlibrarian.net/160462582/trace.log

it is strange that hda_power_count = 2 only occur when pulseaudio

 alsa-sink-ALC89-2776  [005] ....   334.305170: hda_power_count: [0:2]
power_count=1, power_on=1, power_transition=0
 alsa-sink-ALC89-2776  [005] ....   334.305171: hda_power_count: [0:2]
power_count=0, power_on=1, power_transition=0
 alsa-sink-ALC89-2776  [005] ....   334.305185: hda_power_count: [0:2]
power_count=1, power_on=1, power_transition=0
 alsa-sink-ALC89-2776  [005] ....   334.305186: hda_power_count: [0:2]
power_count=2, power_on=1, power_transition=0

seem bug in snd_hda_power_up() and snd_hda_power_down()
