From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus=distortion -- the
 sagacontinues (cardbus driver=culprit?) UPDATE: 99.9% sure it is	the
 cardbus driver yenta_socket
Date: Tue, 30 Mar 2004 14:10:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040330141038.5f98d8ae@laptop>
References: <20040329235823.04bacef4@laptop>
	<20040330055204.UUGL2042.smtp1.fuse.net@64BitBadass>
	<20040330090053.A3956@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id NAA12581
	for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2004 13:07:48 +0200
In-Reply-To: <20040330090053.A3956@flint.arm.linux.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-pcmcia@lists.infradead.org, A list for linux audio users <linux-audio-user@music.columbia.edu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> What needs to happen is that the card driver author needs to
> investigate what is going on, and, if it seems related to the core
> PCMCIA core or the socket driver, we need to get involved.
he pointed out that it's probably a kernel problem ...

we don't want you to solve problems of the alsa driver, but we suspect
there is a problem with the cardbus bridge...

basics:
1.) the card is a combination of 2 devices: a interface device, either a
    pci or a cardbus card, and a dsp device, either digital or analog
    audio ... no problems have ever been reported about the pci
    interface, so it's likely to be a problem with the cardbus interface
    ... although i have to admit, that there are only 3 reported systems
    that have the problems, we experience ... but these systems are
    completely different ones (p4 / amd64, different cardbus bridges)

2.) the dsp device has an internal matrix mixer, that's independant from
    the computer (this audio data isn't sent to the computer at all) ...
    in fact it's possible to set the matrix mixer and unplug the dsp
    device from the computer ...

there are three problems, that show the situation:
3.) if we start an audio application that produces interrupts on the
    hdsp device, some of the audio data that's been transfered to the
    computer will be copied or mapped to the buffer of the audio data
    that's been transfered from the computer to the corresponding
    output. this could either happen
    - inside the device itself (i doubt that, since the same driver, the
      same firmware, the same devices are working without and problems
      on other linux machines or with windows on the same machine) 
    - inside the cardbus bridge 
    - inside the kernel 

4.) if we start the audio playback, the audio playback seems to be
    distorted: 
    one block of samples will be followed by one block of samples of 0
    (zero) ... note that these block are not the blocks of data, that
    are sent to the hdsp during one interrupt. it's usually 32 samples 
    of sound followed by 32 samples of silence, the driver sends blocks
    of 64 to 8192 during one interrupt depending on user settings...
    iirc one sample is 24 bit
    on the other hand the blocks of silence aren't missing, but the alsa
    layer will adapt, so that it takes twice as long as it should to
    play back a soundfile (i'm not sure if it's because of the alsa
    soundfile player or of the driver)

5.) the reason why we (or at least i) think, that it's a problem with
    the cardbus interface, is because of jack's output ...
    jack is both an audio connection interface for different softwares
    and a very good alsa implementation... using jack as super user
    in realtime mode, it complains about latency problems:
    
    delay of xxx usecs exceeds estimated spare time of yyy; restart ...

    at the default sample rate of 48000 xxx only about 0.06 % bigger
    than yyy ... on the other hand, i only get this error on sample
    rates of more than 32000 ... although the sound at 32000 is
    distorted, as well...
    
other thoughts i had:
6.) the distortion isn't affected by the block size / the number of
    interrupts ...
    it is affected by the samplerate ... that's why i think, there are
    always 32 samples (768 bit) followed by 32 samples of silence (768
    bit zero ???)
7.) the problems occured on different cardbus bridges:	
    ENE C1410 (ico / mandrake)
    o2micro6933 (myself / gentoo)
    Texas Instruments PCI1250 (timothy / red hat)

i don't know what's the reason for the problems, the latency or the
mapping problem, or if there is something else that results this problem
... but since it's a software and not a hardware issue (works fine with
windows), i'd like to get into it, and at least try to solve it ... but
since i'm neiter a kernel hacker nor i have any idea about the hardware
internals, i'd need some help from some people, who are able to help
me... i don't want some people to solve my problems for me, but i'd
appreciate any help of people, who know what's going on inside the
computer...

cheers ... 

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac






-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
