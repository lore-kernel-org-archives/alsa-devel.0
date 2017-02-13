From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/4] A few more extensions to LPE audio
	driver
Date: Mon, 13 Feb 2017 16:56:36 -0600
Message-ID: <af30c79f-d1ac-2dda-8691-5ee9faab6a1f@linux.intel.com>
References: <20170213143919.19543-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 99300266AB2
 for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2017 23:56:40 +0100 (CET)
In-Reply-To: <20170213143919.19543-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org



On 02/13/2017 08:39 AM, Takashi Iwai wrote:
> Hi,
>
> Linus decided to take another week for 4.11 merge window, so I could
> play a bit more, and here is the result :)
>
> The first patch is the fix for possible GPU hang, and this has been
> for a while in my local branch and tested.  This should be OK to merge
> soon.  (It's also as same as what Ian tested in the last weekend.)
>
> The next one is merely a cleanup patch, so it's fine, too.  The third
> one is a transition to use the runtime PM autosuspend, and it's a
> preliminary for the last change.
>
> The last one is the new and experimental one: it enables the keep-link
> feature.  With this patch, the device is managed as default via
> autosuspend, and the link is opened (but silenced) for the pre-given
> time (2 seconds) after the PCM close.  If the application restarts the
> stream quickly, the receiver is still warm and can resume gracefully.
>
> All these patches are found in topic/intel-lpe-audio branch.
> (BTW, I cleaned up my branches: now for-next branch tracks the latest
>   stable patches to be merged, while topic/intel-lpe-audio branch
>   tracks the experimental patches.  Beware that the latter may be
>   rebased frequently.)
I tried this topic/intel-lpe-audio branch on my Baytrail compute stick 
and CHT boards and I see a couple of problems while monkey testing.

1. PulseAudio fails to load the HDMI card on startup on the Compute 
Stick and only shows the dummy output, killing and restarting PulseAudio 
solves the problem. I had not seen this before and this doesn't happen 
on CHT devices, not sure if this a pulseaudio problem?

2. we had a set of errors in the past that are still present, i see them 
100% of the time:
E: [alsa-sink-HdmiLpeAudio] alsa-sink.c: ALSA woke us up to write new 
data to the device, but there was a
ctually nothing to write!
E: [alsa-sink-HdmiLpeAudio] alsa-sink.c: Most likely this is a bug in 
the ALSA driver 'snd_hdmi_lpe_audio
'. Please report this issue to the ALSA developers.
E: [alsa-sink-HdmiLpeAudio] alsa-sink.c: We were woken up with POLLOUT 
set -- however a subsequent snd_pc
m_avail() returned 0 or another value < min_avail.

3. the third one is new, we have something wrong with the pointer 
management. This happened only once in my tests but still, not sure how 
it was introduced.

E: [alsa-sink-HdmiLpeAudio] alsa-util.c: snd_pcm_avail() returned a 
value that is exceptionally large: 13
6128 bytes (709 ms).
E: [alsa-sink-HdmiLpeAudio] alsa-util.c: Most likely this is a bug in 
the ALSA driver 'snd_hdmi_lpe_audio
'. Please report this issue to the ALSA developers.
E: [alsa-sink-HdmiLpeAudio] alsa-util.c: snd_pcm_dump():
E: [alsa-sink-HdmiLpeAudio] alsa-util.c: Hardware PCM card 0 'Intel 
HDMI/DP LPE Audio' device 0 subdevice
  0
E: [alsa-sink-HdmiLpeAudio] alsa-util.c: Its setup is:
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   stream       : PLAYBACK
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   access       : MMAP_INTERLEAVED
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   format       : S16_LE
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   subformat    : STD
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   channels     : 2
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   rate         : 48000
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   exact rate   : 48000 (48000/1)
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   msbits       : 16
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   buffer_size  : 3840
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   period_size  : 480
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   period_time  : 10000
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   tstamp_mode  : ENABLE
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   period_step  : 1
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   avail_min    : 480
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   period_event : 1
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   start_threshold  : -1
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   stop_threshold   : 
8646911284551352320
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   silence_threshold: 0
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   silence_size : 0
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   boundary     : 
8646911284551352320
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   appl_ptr     : 301456
E: [alsa-sink-HdmiLpeAudio] alsa-util.c:   hw_ptr       : 331680

Indeed this looks like a wrap-around?

4. the keep-link thing doesn't seem to work for me. Once PulseAudio 
suspends the output, if I try to play a short notification I lose the 
first second (as in hearing only 'left' in 'front left', as in with the 
first sound I play. I even increased the threshold to 10s and still no 
joy. Could there be a higher level suspend that turns the link off?

5. if I change the display resolution while playing a sound through 
hw:0, at the ALSA level the playback stops with all sorts of bad 
descriptor errors, which is fine. If I play through PulseAudio the card 
is unloaded when the resolution is changed and the sound keeps playing 
but to the dummy output. PulseAudio needs to be killed and restarted to 
play sound again over HDMI. Wondering if this is the same problem as for 
the first case, PulseAudio not able to digest a uevent when a card is 
created?

6. if I remove the HDMI output and reinsert it, PulseAudio again fails 
to detect. I have to kill pulseaudio and restart it. I also saw this log 
during plug/unplug
W: [alsa-sink-HdmiLpeAudio] alsa-util.c: Could not recover from 
POLLERR|POLLNVAL|POLLHUP with snd_pcm_pre
pare(): No such device

7. I can't get the multichannel sound to work, anything with more that 
2ch is silent except for FR and FL. Playback keeps going but only 2 
channels are playing. Not sure if this is my receiver sending bad ELD 
information or just that the hw_params are not limited to the 
capabilities of the display.

Overall it's pretty robust though compared to the legacy patches, except 
for the pulseaudio detection issue there was never a moment where I had 
to reboot or do something drastic to recover. Thanks for all your work 
Takashi!
