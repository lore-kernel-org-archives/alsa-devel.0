From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: au88x0 - arecord, aoss
Date: Wed, 30 Mar 2005 04:11:30 -0400
Message-ID: <1112170290.3207.15.camel@localhost>
References: <424988D4.2070805@netvigator.com>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <424988D4.2070805@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, 2005-03-30 at 00:56 +0800, Raymond wrote:
> Although au88x0 support hardware mixing, there is only one pair of
> AC97 input CODECIN(0), CODECIN(1) for capturing stereo sound using hw:0,0

Yes, you just get the same stuff recorded from different PCM's. In
theory, if ALSA would support it, we could record from the codec, and
other sources  like SPDIF, serial interfaces, etc. at the same time, but
ALSA currently lacks a generic mechanism to route individual PCM's, I
mean, some how to tell the PCM, "use that specific source".
By the way, the same applies for playback, with different audio outputs,
where we currently just use different PCM's, in order to implicitly tell
ALSA what audio output we want.

> # more /proc/asound/au8830/pcm0c/info
> card: 0
> device: 0
> subdevice: 0
> stream: CAPTURE
> id: AU88x0 ADB
> name: adb
> subname: subdevice #0
> class: 0
> subclass: 0
> subdevices_count: 32
> subdevices_avail: 32
> 
> 
> It seem that multiple instances of arecord can be run at the same time.
> 1) Is this a bug ?

If the result does not cause your PC to blow up... i guess not.
The 32 ADB DMA streams are shared between all presently working PCM's
(since the WT DMA streams are not working). They are assigned
dinamically, thanks to the au88x0 resource manager (tm). If some
requested resource (DMA, samplerate converter, mixer, or whatever) is
not available, then you just get a error (AFAIK, device busy). If your
retry and some got available, then it proceeds.

> 2) Do we need to define snd_vortex_capture_hw_adb to prevent multiple
> programs perform recording while allowing multiple playback for ALSA and
> OSS emulation ?

Again, if it really does not bother anyone, why bother changing it ?
Adding uneeded constraints, would limit the users creativity. I used
this features once to setup a multitap delayorama, just using multiple
XMMS, arecord and aplay. That was really cool ;)

Best Regards,
-- 
Manuel Jander
Dipl.-Ing. Fachrichtung Elektronik



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
