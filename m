From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 00/15 v4] OXFW driver,
	a succesor to firewire-speakers
Date: Sun, 26 Oct 2014 23:15:24 +0900
Message-ID: <544D01FC.6000408@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
 <20141026130032.593f268a@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AC032606AB
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 15:15:30 +0100 (CET)
In-Reply-To: <20141026130032.593f268a@kant>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>, alsa-devel@alsa-project.org
Cc: clemens@ladisch.de, linux1394-devel@lists.sourceforge.net, fenlason@redhat.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Stefan,

On Oct 26 2014 21:00, Stefan Richter wrote:
> Conclusion:
> -----------
> 
> In my tests, the patch set does not regress with LaCie FireWire Speakers,
> does not regress with Griffin FireWave + Jack, and it fixes FireWave for
> stereo playback through ALSA client applications.  Therefore and for the
> much extended device support and features (which I could not test myself
> due to lack of hardware), I would be glad if these patches were to be
> queued up for mainline merge and am offering a
> 
> Tested-by: Stefan Richter <stefanr@s5r6.in-berlin.de> (Speakers, FireWave)
> 
> tag. Thank you,

Thanks for your test and report. And I'm sorry to notice your message
after I posted my patches to alsa-devel...

[alsa-devel] [PATCH 00/29 v2] ALSA: Enhancement for existed FireWire drivers
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-October/082844.html


> Stock, i.e. snd-firewire-speakers:     Patched, i.e. snd-oxfw:
>     Card: FireWire Speakers                Card: FWSpeakers
>     Chip: OXFW970                          Chip: FWSpeakers
...
> Alsamixer displays different chip names.
> Stock, i.e. snd-firewire-speakers:     Patched, i.e. snd-oxfw:
>     Card: FireWave                         Card: FireWave
>     Chip: OXFW970                          Chip: FireWave

This is due to second parameter for snd_pcm_new().

[alsa-devel] [PATCH 18/29] ALSA: oxfw: Split PCM functionality to a new file
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-October/082857.html

In my patchset, the parameter refers to 'struct snd_card.driver'. For
these two models, this member refers to 'struct device_info.driver_name'
and it's hard-coded. This may be a bit meddling.

>     There is distortion on channel 2 (R) channel.  The type of
>     distortion depends on the audio which is played back.  It can be
>     pops, buzzing, or a high continuous hissing tone (I guess a 22.05
>     kHz tone).

I heard it.

I understand it's due to the difference of stream format.
$ cat /proc/asound/FireWave/firewire/formation
Input Stream to device:
	Rate	PCM	MIDI
 	48000	6	0
 	32000	6	0
 	44100	6	0
 	96000	6	0
 	32000	2	0
*	44100	2	0
 	48000	2	0

Old snd-firewire-speakers just change sampling rate without changing
stream format. If the device wait for 6ch PCM samples in a data block of
AMDTP packet but the driver transfer 2ch PCM samples in a data block of
AMDTP packet (or vice versa), the device handles the samples badly and
sounds hiss noise.

>     This is the same behavior as I remember it from the time when
>     snd-firewire-speakers was merged into the mainline in 2.6.39.

If so, you and Clemens should have mentioned about it anywhere (maybe in
commit message). It brings a new device to my home ;)

Anyway, thanks for your and Clemens' work. Enjoy playing music!


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
