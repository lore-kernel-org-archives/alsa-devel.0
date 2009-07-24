From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: multi-channel playback regression
Date: Fri, 24 Jul 2009 13:29:24 +0800
Message-ID: <20090724052924.GA1550@localhost>
References: <20090723065345.GA1884@localhost> <s5hskgnx4qm.wl%tiwai@suse.de>
	<20090723072253.GA15878@localhost> <s5hprbrx3dd.wl%tiwai@suse.de>
	<20090723075620.GA21405@localhost> <s5hiqhjx1a8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 82C9D103A41
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 07:29:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hiqhjx1a8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 23, 2009 at 04:15:59PM +0800, Takashi Iwai wrote:
> At Thu, 23 Jul 2009 15:56:20 +0800,
> Wu Fengguang wrote:
> > 
> > On Thu, Jul 23, 2009 at 03:30:54PM +0800, Takashi Iwai wrote:
> > > At Thu, 23 Jul 2009 15:22:53 +0800,
> > > Wu Fengguang wrote:
> > > > 
> > > > On Thu, Jul 23, 2009 at 03:01:21PM +0800, Takashi Iwai wrote:
> > > > > At Thu, 23 Jul 2009 14:53:45 +0800,
> > > > > Wu Fengguang wrote:
> > > > > > 
> > > > > > Hi Takashi,
> > > > > > 
> > > > > > When doing multi-channel playback tests on IbexPeak, I found that the
> > > > > > following patch makes the playback enter an infinite loop, repeatedly
> > > > > > playing a range of ~0.5s audio content. (Seems that some buffer
> > > > > > pointer can never advance.)
> > > > > 
> > > > > Could you set 1 to /proc/asound/card0/pcm0p/xrun_debug and give the
> > > > > messages?  Also, please show /proc/.../pcm0p/sub0/hw_params, too.
> > > > > 
> > > > > The change affects only the code path for the problematic hardware
> > > > > that reports wrong DMA position.  So, if this change regresses, it
> > > > > means that the device has been already problematic from the
> > > > > beginning...
> > > > 
> > > > I caught some messages:
> > > 
> > > Is this with the patched (as is on sound git tree) kernel?
> > 
> > Yes, it's unmodified latest git tree.
> > 
> > > What if changing from #if 1 to #if 0?
> > 
> > This makes 8-channel playback work again.
> 
> OK, then could you apply the patch below, and do
> "echo 9 > /proc/../xrun_debug", then gather the messages with both
> #if 1 and #if 0?  This will record the each snd_pcm_period_elpased()
> so beware that you may get flood of messages.

#if 1:

[  153.528838] ALSA sound/pci/hda/hda_intel.c:1572: azx_pcm_prepare: bufsize=0x10000, format=0x17
[  153.539220] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x6
[  153.547079] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x10
[  153.553516] ALSA sound/pci/hda/hda_codec.c:1080: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x17
[  153.561866] ALSA sound/pci/hda/hda_codec.c:1080: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=2, format=0x17
[  153.577811] ALSA sound/pci/hda/hda_codec.c:1080: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=4, format=0x17
[  153.589784] ALSA sound/pci/hda/hda_codec.c:1080: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=6, format=0x17
[  153.642717] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x424/0x400/0x1000, hwptr=0x30, hw_base=0x0, hw_intr=0x0
[  153.663835] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x81c/0x400/0x1000, hwptr=0x504, hw_base=0x0, hw_intr=0x400
[  153.685037] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc18/0x400/0x1000, hwptr=0x900, hw_base=0x0, hw_intr=0x800
[  153.706074] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  153.711340] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=12, intr_ptr=4096)
[  153.727194] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x401/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  153.732021] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=1025, intr_ptr=4096)
[  153.749226] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x828/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  153.755063] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=2088, intr_ptr=4096)
[  153.770180] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc18/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  153.776051] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=3096, intr_ptr=4096)
[  153.791216] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  153.796843] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=12, intr_ptr=4096)
[  153.812335] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x401/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  153.817645] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=1025, intr_ptr=4096)
[  153.834368] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x828/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  153.839568] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=2088, intr_ptr=4096)
[  153.855571] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc24/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  153.860594] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=3108, intr_ptr=4096)
[  153.876607] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x18/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  153.882398] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=24, intr_ptr=4096)
[  153.897726] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x410/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  153.903329] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=1040, intr_ptr=4096)
[  153.918929] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x80c/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  153.940132] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc08/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  153.961334] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x1/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  153.983117] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x41c/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  154.004320] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x818/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  154.025357] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc0c/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  154.046476] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x1/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  154.068509] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x428/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  154.089628] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x820/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  154.110747] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc18/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  154.131784] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  154.152904] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x401/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  154.174854] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x824/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  154.196056] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc20/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  154.217175] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x18/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  154.238378] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x414/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  154.259581] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x810/0x400/0x1000, hwptr=0xd20, hw_base=0x0, hw_intr=0xc00
[  154.276638] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x2
[  154.280154] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x3
[  154.283272] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x4
[  154.286708] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x5

#if 0:

[  134.711304] ALSA sound/pci/hda/hda_intel.c:1572: azx_pcm_prepare: bufsize=0x10000, format=0x17
[  134.715334] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x6
[  134.718908] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x10
[  134.722513] ALSA sound/pci/hda/hda_codec.c:1080: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x17
[  134.735110] ALSA sound/pci/hda/hda_codec.c:1080: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=2, format=0x17
[  134.747054] ALSA sound/pci/hda/hda_codec.c:1080: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=4, format=0x17
[  134.759029] ALSA sound/pci/hda/hda_codec.c:1080: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=6, format=0x17
[  134.828646] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x424/0x400/0x1000, hwptr=0x30, hw_base=0x0, hw_intr=0x0
[  134.849746] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x81c/0x400/0x1000, hwptr=0x530, hw_base=0x0, hw_intr=0x400
[  134.870949] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc18/0x400/0x1000, hwptr=0x900, hw_base=0x0, hw_intr=0x800
[  134.892068] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x10/0x400/0x1000, hwptr=0xcf8, hw_base=0x0, hw_intr=0xc00
[  134.897113] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=16, intr_ptr=4096)
[  134.913271] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x40c/0x400/0x1000, hwptr=0x11d0, hw_base=0x1000, hw_intr=0x1000
[  134.934390] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x801/0x400/0x1000, hwptr=0x1518, hw_base=0x1000, hw_intr=0x1400
[  134.956256] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc20/0x400/0x1000, hwptr=0x1908, hw_base=0x1000, hw_intr=0x1800
[  134.977374] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x18/0x400/0x1000, hwptr=0x1d00, hw_base=0x1000, hw_intr=0x1c00
[  134.982350] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=24, intr_ptr=8192)
[  134.998413] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x40c/0x400/0x1000, hwptr=0x21fc, hw_base=0x2000, hw_intr=0x2000
[  135.019532] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x801/0x400/0x1000, hwptr=0x2518, hw_base=0x2000, hw_intr=0x2400
[  135.041481] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc24/0x400/0x1000, hwptr=0x28e0, hw_base=0x2000, hw_intr=0x2800
[  135.062683] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x20/0x400/0x1000, hwptr=0x2d08, hw_base=0x2000, hw_intr=0x2c00
[  135.068446] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=32, intr_ptr=12288)
[  135.083720] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x414/0x400/0x1000, hwptr=0x3204, hw_base=0x3000, hw_intr=0x3000
[  135.104839] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x80c/0x400/0x1000, hwptr=0x3520, hw_base=0x3000, hw_intr=0x3400
[  135.126624] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc24/0x400/0x1000, hwptr=0x390c, hw_base=0x3000, hw_intr=0x3800
[  135.147826] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x20/0x400/0x1000, hwptr=0x3d08, hw_base=0x3000, hw_intr=0x3c00
[  135.152970] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=32, intr_ptr=16384)
[  135.168780] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x410/0x400/0x1000, hwptr=0x4200, hw_base=0x4000, hw_intr=0x4000
[  135.189899] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x808/0x400/0x1000, hwptr=0x44f0, hw_base=0x4000, hw_intr=0x4400
[  135.211102] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc01/0x400/0x1000, hwptr=0x4918, hw_base=0x4000, hw_intr=0x4800
[  135.233133] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x28/0x400/0x1000, hwptr=0x4d10, hw_base=0x4000, hw_intr=0x4c00
[  135.238880] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=40, intr_ptr=20480)
[  135.254171] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x41c/0x400/0x1000, hwptr=0x520c, hw_base=0x5000, hw_intr=0x5000
[  135.275290] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x814/0x400/0x1000, hwptr=0x5528, hw_base=0x5000, hw_intr=0x5400
[  135.296492] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc10/0x400/0x1000, hwptr=0x58f8, hw_base=0x5000, hw_intr=0x5800
[  135.317612] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x8/0x400/0x1000, hwptr=0x5cf0, hw_base=0x5000, hw_intr=0x5c00
[  135.323218] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=8, intr_ptr=24576)
[  135.338815] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x401/0x400/0x1000, hwptr=0x61c8, hw_base=0x6000, hw_intr=0x6000
[  135.360764] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x824/0x400/0x1000, hwptr=0x64e0, hw_base=0x6000, hw_intr=0x6400
[  135.381884] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc1c/0x400/0x1000, hwptr=0x6930, hw_base=0x6000, hw_intr=0x6800
[  135.402920] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x10/0x400/0x1000, hwptr=0x6d24, hw_base=0x6000, hw_intr=0x6c00
[  135.408153] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=16, intr_ptr=28672)
[  135.424122] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x40c/0x400/0x1000, hwptr=0x71d0, hw_base=0x7000, hw_intr=0x7000
[  135.445242] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x801/0x400/0x1000, hwptr=0x7518, hw_base=0x7000, hw_intr=0x7400
[  135.467275] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc28/0x400/0x1000, hwptr=0x7910, hw_base=0x7000, hw_intr=0x7800
[  135.488394] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x20/0x400/0x1000, hwptr=0x7d34, hw_base=0x7000, hw_intr=0x7c00
[  135.494543] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=32, intr_ptr=32768)
[  135.509514] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x418/0x400/0x1000, hwptr=0x8208, hw_base=0x8000, hw_intr=0x8000
[  135.530715] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x814/0x400/0x1000, hwptr=0x8528, hw_base=0x8000, hw_intr=0x8400
[  135.552500] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc2c/0x400/0x1000, hwptr=0x8914, hw_base=0x8000, hw_intr=0x8800
[  135.573702] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x28/0x400/0x1000, hwptr=0x8d10, hw_base=0x8000, hw_intr=0x8c00
[  135.579475] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=40, intr_ptr=36864)
[  135.594741] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x41c/0x400/0x1000, hwptr=0x920c, hw_base=0x9000, hw_intr=0x9000
[  135.615859] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x814/0x400/0x1000, hwptr=0x9528, hw_base=0x9000, hw_intr=0x9400
[  135.636979] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc0c/0x400/0x1000, hwptr=0x98c8, hw_base=0x9000, hw_intr=0x9800
[  135.658181] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x8/0x400/0x1000, hwptr=0x9cf0, hw_base=0x9000, hw_intr=0x9c00
[  135.663829] ALSA sound/core/pcm_lib.c:266: PCM: Unexpected hw_pointer value (stream=0, pos=8, intr_ptr=40960)
[  135.679383] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x401/0x400/0x1000, hwptr=0xa1c8, hw_base=0xa000, hw_intr=0xa000
[  135.701083] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x818/0x400/0x1000, hwptr=0xa500, hw_base=0xa000, hw_intr=0xa400
[  135.722038] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc08/0x400/0x1000, hwptr=0xa91c, hw_base=0xa000, hw_intr=0xa800
[  135.744070] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x2c/0x400/0x1000, hwptr=0xace8, hw_base=0xa000, hw_intr=0xac00
[  135.765273] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x428/0x400/0x1000, hwptr=0xb110, hw_base=0xb000, hw_intr=0xb000
[  135.786143] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x814/0x400/0x1000, hwptr=0xb528, hw_base=0xb000, hw_intr=0xb400
[  135.807344] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc10/0x400/0x1000, hwptr=0xb8f8, hw_base=0xb000, hw_intr=0xb800
[  135.828548] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc/0x400/0x1000, hwptr=0xbd20, hw_base=0xb000, hw_intr=0xbc00
[  135.849750] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x408/0x400/0x1000, hwptr=0xc0f0, hw_base=0xc000, hw_intr=0xc000
[  135.871783] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x82c/0x400/0x1000, hwptr=0xc4e8, hw_base=0xc000, hw_intr=0xc400
[  135.892904] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc24/0x400/0x1000, hwptr=0xc938, hw_base=0xc000, hw_intr=0xc800
[  135.914105] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x20/0x400/0x1000, hwptr=0xcd34, hw_base=0xc000, hw_intr=0xcc00
[  135.935308] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x41c/0x400/0x1000, hwptr=0xd130, hw_base=0xd000, hw_intr=0xd000
[  135.956510] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x818/0x400/0x1000, hwptr=0xd500, hw_base=0xd000, hw_intr=0xd400
[  135.977630] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc10/0x400/0x1000, hwptr=0xd8f8, hw_base=0xd000, hw_intr=0xd800
[  135.998749] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x8/0x400/0x1000, hwptr=0xdd1c, hw_base=0xd000, hw_intr=0xdc00
[  136.019952] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x401/0x400/0x1000, hwptr=0xe118, hw_base=0xe000, hw_intr=0xe000
[  136.041901] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x824/0x400/0x1000, hwptr=0xe50c, hw_base=0xe000, hw_intr=0xe400
[  136.063103] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc20/0x400/0x1000, hwptr=0xe908, hw_base=0xe000, hw_intr=0xe800
[  136.084223] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x18/0x400/0x1000, hwptr=0xed00, hw_base=0xe000, hw_intr=0xec00
[  136.105343] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x410/0x400/0x1000, hwptr=0xf150, hw_base=0xf000, hw_intr=0xf000
[  136.126462] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x808/0x400/0x1000, hwptr=0xf4f0, hw_base=0xf000, hw_intr=0xf400
[  136.147665] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0xc01/0x400/0x1000, hwptr=0xf808, hw_base=0xf000, hw_intr=0xf800
[  136.169615] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x24/0x400/0x1000, hwptr=0xfd0c, hw_base=0xf000, hw_intr=0xfc00
[  136.190817] ALSA sound/core/pcm_lib.c:246: period_update: pcmC0D0p:0: pos=0x420/0x400/0x1000, hwptr=0x10000, hw_base=0x10000, hw_intr=0x10000
[  136.204346] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x2
[  136.208197] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x3
[  136.211853] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x4
[  136.214855] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x5
root@hp ~#

> 
> 
> thanks,
> 
> Takashi
> 
> ---
> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index 3b673e2..065eaf0 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -233,6 +233,18 @@ static int snd_pcm_update_hw_ptr_interrupt(struct snd_pcm_substream *substream)
>  		xrun(substream);
>  		return -EPIPE;
>  	}
> +	if (xrun_debug(substream, 8)) {
> +		char name[16];
> +		pcm_debug_name(substream, name, sizeof(name));
> +		snd_printd("period_update: %s: pos=0x%x/0x%x/0x%x, "
> +			   "hwptr=0x%lx, hw_base=0x%lx, hw_intr=0x%lx\n",
> +			   name, pos,
> +			   (int)runtime->period_size,
> +			   (int)runtime->buffer_size,
> +			   (long)old_hw_ptr,
> +			   (long)runtime->hw_ptr_base,
> +			   (long)runtime->hw_ptr_interrupt);
> +	}
>  	hw_base = runtime->hw_ptr_base;
>  	new_hw_ptr = hw_base + pos;
>  	hw_ptr_interrupt = runtime->hw_ptr_interrupt + runtime->period_size;
> @@ -353,6 +365,19 @@ int snd_pcm_update_hw_ptr(struct snd_pcm_substream *substream)
>  		xrun(substream);
>  		return -EPIPE;
>  	}
> +	if (xrun_debug(substream, 16)) {
> +		char name[16];
> +		pcm_debug_name(substream, name, sizeof(name));
> +		snd_printd("hw_update: %s: pos=0x%x/0x%x/0x%x, "
> +			   "hwptr=0x%lx, hw_base=0x%lx, hw_intr=0x%lx\n",
> +			   name, pos,
> +			   (int)runtime->period_size,
> +			   (int)runtime->buffer_size,
> +			   (long)old_hw_ptr,
> +			   (long)runtime->hw_ptr_base,
> +			   (long)runtime->hw_ptr_interrupt);
> +	}
> +
>  	hw_base = runtime->hw_ptr_base;
>  	new_hw_ptr = hw_base + pos;
>  
