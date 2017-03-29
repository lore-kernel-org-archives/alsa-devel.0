From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: [pulseaudio-discuss] pulseaudio fails to start
 with kernel 4.11, caused by new snd_hdmi_lpe_audio module)
Date: Wed, 29 Mar 2017 16:14:19 +0300
Message-ID: <1490793259.2239.5.camel@iki.fi>
References: <2549c113-f06b-f22e-d36e-f59fc2969bcb@redhat.com>
 <s5h8to0w4fs.wl-tiwai@suse.de>
 <6754b5cd-f6d0-e2e3-0f01-992946ec1b92@linux.intel.com>
 <s5hk27jjigd.wl-tiwai@suse.de>
 <1490082870.1321124.918129488.4F3143F8@webmail.messagingengine.com>
 <bba100b1-5e74-093a-7625-a7feaba1a065@redhat.com>
 <b693d927-229e-e00a-ada5-29d12154547b@linux.intel.com>
 <s5hvar0fjzf.wl-tiwai@suse.de> <1490379539.24554.2.camel@iki.fi>
 <30b18b96-eaa4-70e0-522d-dc8237d25642@redhat.com>
 <1490731828.2698.4.camel@iki.fi> <s5hy3vok68j.wl-tiwai@suse.de>
 <1490792385.2239.3.camel@iki.fi> <s5ho9wkjkqm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9BAE0266F2E
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 15:14:22 +0200 (CEST)
In-Reply-To: <s5ho9wkjkqm.wl-tiwai@suse.de>
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
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Arun Raghavan <arun@arunraghavan.net>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2017-03-29 at 15:06 +0200, Takashi Iwai wrote:
> On Wed, 29 Mar 2017 14:59:45 +0200,
> Tanu Kaskinen wrote:
> > 
> > On Wed, 2017-03-29 at 07:21 +0200, Takashi Iwai wrote:
> > > On Tue, 28 Mar 2017 22:10:28 +0200,
> > > Tanu Kaskinen wrote:
> > > > 
> > > > On Fri, 2017-03-24 at 23:01 +0100, Hans de Goede wrote:
> > > > > Hi,
> > > > > 
> > > > > On 03/24/2017 07:18 PM, Tanu Kaskinen wrote:
> > > > > > On Thu, 2017-03-23 at 09:57 +0100, Takashi Iwai wrote:
> > > > > > > On Thu, 23 Mar 2017 04:16:52 +0100,
> > > > > > > Pierre-Louis Bossart wrote:
> > > > > > > > 
> > > > > > > > On 3/21/17 2:56 AM, Hans de Goede wrote:
> > > > > > > > > I: [pulseaudio] alsa-sink.c: Using 1.0 fragments of size 352832 bytes
> > > > > > > > > (2000.18ms), buffer size is 352832 bytes (2000.18ms)
> > > > > > > > > I: [pulseaudio] alsa-sink.c: Time scheduling watermark is 20.00ms
> > > > > > > > > I: [pulseaudio] alsa-sink.c: Driver does not support hardware volume
> > > > > > > > > control, falling back to software volume control.
> > > > > > > > > I: [pulseaudio] alsa-sink.c: Driver does not support hardware mute
> > > > > > > > > control, falling back to software mute control.
> > > > > > > > > I: [alsa-sink-HdmiLpeAudio] core-util.c: Successfully enabled SCHED_RR
> > > > > > > > > scheduling for thread, with priority 5.
> > > > > > > > > I: [alsa-sink-HdmiLpeAudio] alsa-sink.c: Starting playback.
> > > > > > > > > I: [alsa-sink-HdmiLpeAudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HWSYNC
> > > > > > > > > failed (-32)
> > > > > > > > 
> > > > > > > > Humm, single period and hw_sync failed, this could be testing the
> > > > > > > > robustness of the single-period code and its mapping on multiple DMA
> > > > > > > > descriptors? I haven't looked at the alsa module in eons but can't the
> > > > > > > > number of periods be forced to two with module parameters while
> > > > > > > > keeping the timer-based schedulng?
> > > > > > 
> > > > > > I think the code doesn't currently support this.
> > > > > > 
> > > > > > > It's -EPIPE and this is supposed to be the intentional error code from
> > > > > > > HDMI LPE audio driver.  The streaming doesn't work when the gfx is
> > > > > > > disconnected or the monitor audio is off.  It accepts the open, but it
> > > > > > > returns -EPIPE for further accesses.
> > > > > > > 
> > > > > > > Maybe -EPIPE is no sensible choice, but the problem is that the driver
> > > > > > > can't use the PCM DISCONNECT state because PA interprets it being the
> > > > > > > complete disconnection of the card object instead of a temporary
> > > > > > > disablement of PCM.
> > > > > > 
> > > > > > So is this a PulseAudio bug?
> > > > > > 
> > > > > > I: [alsa-sink-HdmiLpeAudio] alsa-sink.c: Starting playback.
> > > > > > I: [alsa-sink-HdmiLpeAudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HWSYNC failed (-32)
> > > > > > 
> > > > > > The "Starting playback" message is printed just before the
> > > > > > snd_pcm_start() call. PulseAudio doesn't check the return value of
> > > > > > snd_pcm_start(), but maybe it should? Does the HWSYNC happen in
> > > > > > snd_pcm_start()?
> > > > > > 
> > > > > > Can this EPIPE thing happen also during playback, not just when
> > > > > > starting?
> > > > > 
> > > > > So is this the likely cause of the RT code killing pa, or do you
> > > > > still need me to gather perf output ?
> > > > 
> > > > The perf output would be interesting.
> > > > 
> > > > It's still unclear to me if the hwsync thing is a bug in alsa, or
> > > > something that pulseaudio should deal with. If there's no further input
> > > > from the alsa developers, would you be able to test a pulseaudio patch
> > > > if I write one? First I'd like to check whether the hwsync error
> > > > happens inside snd_pcm_start(), and if so, does the error get reported
> > > > in the snd_pcm_start() return value. If snd_pcm_start() returns an
> > > > error, pulseaudio should probably react to it, although I'm not sure
> > > > how. It would be easy to just remove the sink if there's an error, but
> > > > I understood Takashi's comment so that it might be an intermittent
> > > > error that depends on the graphics state, and if that's the case,
> > > > pulseaudio would have to retry when the graphics state changes, but I
> > > > don't know what kind of event could be used to get a notification about
> > > > the state change.
> > > 
> > > Does PA really need to start streaming at its invocation time?
> > > The crash happens when PA gets started via desktop autostart, and at
> > > this moment, the HDMI graphics state is possible disconnected before
> > > xrandr setup.  The HDMI connection state should have been informed /
> > > notified to PA via the jack interface, so it should be possible to
> > > judge beforehand.
> > > 
> > > Or it might be something wrong in the driver side regarding the jack
> > > state processing?
> > 
> > I had a closer look at the PA log that was posted earlier. It looks
> > like the device numbering is non-standard. Trying to open any of the
> > hdmi:1,x devices fails. hw:1 can be opened, and pulseaudio assumes that
> > it's an analog stereo device. Jack detection isn't going to work in
> > this situation, because pulseaudio doesn't know that it should be
> > looking at the hdmi jacks.
> > 
> > Can the driver be fixed to use the standard HDMI device numbers?
> 
> Hmm, it might be the missing hdmi PCM definition?
> 
> The latest alsa-lib git already contains the card config for HDMI LPE
> audio, and this might help.  (Though, I thought I still saw the same
> PA problem even with the card config.  Unfortunately I can't access
> the box with the DP audio right now, so others may help more quickly
> than me...)
> 
> Can anyone confirm that you have the latest alsa-lib git installed and
> whether the PA issue is fixed or not?

If the alsa-lib configuration just maps hdmi:1,0 to hw:1,0, then I
would expect this problem to persist. If hw:1,0 can be opened,
pulseaudio will think that there's an analog stereo output. If hdmi:1,0
works too, then pulseaudio will think that there are two separate
outputs, and if the hdmi jack state says that hdmi is not available,
pulseaudio will use what it thinks is an analog output.

If it's not possible to change the device numbering in the driver, this
will have to be worked around in pulseaudio somehow (pulseaudio
shouldn't try to use hw:1,0 on this hardware).

-- 
Tanu

https://www.patreon.com/tanuk
