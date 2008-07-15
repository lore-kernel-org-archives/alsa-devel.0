From: Hans-Frieder Vogt <hfvogt@gmx.net>
Subject: Re: 1.0.16->1.0.17 regression for some HDA NVidia's
Date: Tue, 15 Jul 2008 22:54:51 +0200
Message-ID: <200807152254.51098.hfvogt@gmx.net>
References: <4870F039.8020207@pardus.org.tr>
	<200807130845.55733.hfvogt@gmx.net> <s5hhcar8lww.wl%tiwai@suse.de>
Reply-To: hfvogt@gmx.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 4048510380F
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 22:54:58 +0200 (CEST)
In-Reply-To: <s5hhcar8lww.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, ozan@pardus.org.tr, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

with aplay things are a bit more differentiated:

bdl_pos_adj=0 and 1 are as described below

bdl_pos_adj=32
device "default" works
device "plughw:0,0" works or does not work, may be depending on the sound format. For a nonworking file, here is the output of the files /proc/asound/card0/pcm0p/sub0/*:
/proc/asound/card0/pcm0p/sub0/hw_params:
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 4096
buffer_size: 16384
/proc/asound/card0/pcm0p/sub0/info:
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: ALC883 Analog
name: ALC883 Analog
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0
/proc/asound/card0/pcm0p/sub0/prealloc:
64
/proc/asound/card0/pcm0p/sub0/prealloc_max:
1024
/proc/asound/card0/pcm0p/sub0/status:
state: RUNNING
trigger_time: 2795.506618360
tstamp      : 2797.052537640
delay       : 16384
avail       : 0
avail_max   : 818
-----
hw_ptr      : 818
appl_ptr    : 17202
/proc/asound/card0/pcm0p/sub0/sw_params:
tstamp_mode: NONE
period_step: 1
avail_min: 4096
start_threshold: 16384
stop_threshold: 16384
silence_threshold: 0
silence_size: 0
boundary: 4611686018427387904

the same file played with mmap (aplay -D plughw:0,0 --mmap soundfile) also gives no sound. 
/proc/asound/card0/pcm0p/sub0/hw_params:
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 4096
buffer_size: 16384
/proc/asound/card0/pcm0p/sub0/info:
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: ALC883 Analog
name: ALC883 Analog
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0
/proc/asound/card0/pcm0p/sub0/prealloc:
64
/proc/asound/card0/pcm0p/sub0/prealloc_max:
1024
/proc/asound/card0/pcm0p/sub0/status:
state: RUNNING
trigger_time: 2948.343350480
tstamp      : 2949.758334160
delay       : 16384
avail       : 0
avail_max   : 0
-----
hw_ptr      : 0
appl_ptr    : 16384
/proc/asound/card0/pcm0p/sub0/sw_params:
tstamp_mode: NONE
period_step: 1
avail_min: 4096
start_threshold: 16384
stop_threshold: 16384
silence_threshold: 0
silence_size: 0
boundary: 4611686018427387904

Your patch really solves this problem for bdl_pos_adj=32 (for bdl_pos_adj=0 and 1 unchanged). Thanks!

Cheers,
Hans-Frieder

Am Dienstag, 15. Juli 2008 schrieb Takashi Iwai:
> At Sun, 13 Jul 2008 08:45:55 +0200,
> Hans-Frieder Vogt wrote:
> > 
> > Just a few more things to add (maybe it gets clearer):
> > On a GeForce 8200 board (MCP78S), using the pcm example program from alsa-lib-1.0.17rc2/test,
> > kernel driver version 1.0.17rc3:
> > (ignoring my general sound distortion problem which I will address again in another post)
> > 
> > bdl_pos_adj=0
> > both devices "default" and "plughw:0,0" work, i.e. give continuous sound
> > 
> > bdl_pos_adj=1
> > bdl_pos_adj=2
> > bdl_pos_adj=8
> > no sound, pcm seems to gets stuck (example program does not return)
> > 
> > bdl_pos_adj=16
> > bdl_pos_adj=32
> > bdl_pos_adj=64
> > bdl_pos_adj=128
> > bdl_pos_adj=256
> > bdl_pos_adj=512
> > bdl_pos_adj=1024
> > bdl_pos_adj=2048
> > default device: works, i.e. sound
> > plughw:0,0: no sound, pcm gets stuck
> > 
> > bdl_pos_adj=4096
> > bdl_pos_adj=8192
> > ALSA /home/haef/Treiber/alsa-driver-1.0.17rc3/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1056: Too big adjustment 4096
> > default device: works, i.e. sound
> > plughw:0,0: just one beep (approx. 0.5s of sound), then pcm gets stuck
> > 
> > Any ideas?
> 
> Thanks, that's really good to know.  Does this happen with aplay, too? 
> 
> Now you don't need to play so many bdl_pos_adj values any more.
> Checking 1 and 32 should suffice.
> 
> Could you check /proc/asound/card0/pcm0p/sub0/* at non-working time
> with bdl_pos_adj=32?
> 
> Also, try the patch below.  If my guess is right, the problem is
> unaligned period size.
> 
> 
> Takashi
> 
> ---
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 16715a6..ef9f072 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1047,9 +1047,13 @@ static int azx_setup_periods(struct azx *chip,
>  	pos_adj = bdl_pos_adj[chip->dev_index];
>  	if (pos_adj > 0) {
>  		struct snd_pcm_runtime *runtime = substream->runtime;
> +		int pos_align = pos_adj;
>  		pos_adj = (pos_adj * runtime->rate + 47999) / 48000;
>  		if (!pos_adj)
> -			pos_adj = 1;
> +			pos_adj = pos_align;
> +		else
> +			pos_adj = ((pos_adj + pos_align - 1) / pos_align) *
> +				pos_align;
>  		pos_adj = frames_to_bytes(runtime, pos_adj);
>  		if (pos_adj >= period_bytes) {
>  			snd_printk(KERN_WARNING "Too big adjustment %d\n",
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 



-- 
--
Hans-Frieder Vogt                 e-mail: hfvogt <at> gmx .dot. net
