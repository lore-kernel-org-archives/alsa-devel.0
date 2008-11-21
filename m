From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [RFC][PATCH] ELD routines and proc interface
Date: Fri, 21 Nov 2008 09:36:55 +0800
Message-ID: <20081121013655.GA8992@localhost>
References: <1226542918.126598.6912@de> <20081119071135.GA17733@csy.ca>
	<20081119071757.GA32376@localhost> <20081119075545.GA19833@csy.ca>
	<20081119080800.GA522@localhost> <20081119093940.GA17245@localhost>
	<20081119200201.GA23246@csy.ca> <20081120010204.GA25454@localhost>
	<20081120200606.GA4164@csy.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xorg-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20081120200606.GA4164@csy.ca>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: Shane W <shane-intel@csy.ca>
Cc: alsa-devel <alsa-devel@alsa-project.org>, "Ma, Ling" <ling.ma@intel.com>, intel-gfx@lists.freedesktop.org, Takashi Iwai <tiwai@suse.de>, xorg@lists.freedesktop.org, "Fu, Michael" <michael.fu@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Shane,

On Thu, Nov 20, 2008 at 12:06:06PM -0800, Shane W wrote:
> Hi,
> 
> Ok, it appears to be the kernel I was using.  Going to a
> 2.6.27 kernel rather than 2.6.28-rc fixed the segfault.  So
> now I get ELD data though 5.1 PCM isn't quite there yet. 
> Here's the ELD info.

Thanks.

> HDMI intrinsic event: PD=1 ELDV=1
> detected monitor Haier TV*** at connection type HDMI
> supports coding type LPCM: channels = 2, rates = 44100
> 48000 88200 176400 192000 384000, bits =
> supports coding type LPCM: channels = 8, rates = 44100
> 48000 88200 176400 192000 384000, bits =

It reveals bugs in showing the bits field. Will fix it in a following
email.

> supports coding type AC-3: channels = 6, rates = 44100
> 48000 88200, max bitrate = 640000
> supports coding type DTS: channels = 7, rates = 44100 48000
> 88200 176400 192000, max bitrate = 1536000
> supports coding type DSD (One Bit Audio): channels = 6,
> rates = 48000

It's weird that DTS supports 7 channels while DSD supports 6.
DTS is simple the compressed form of DSD.

> set status page addr 0x08360000
> [drm:i915_getparam] *ERROR* Unknown parameter 5
> 
> shane@chintoka:~$ cat /proc/asound/Intel/eld#3
> monitor name            Haier TV***
> connection_type         HDMI
> eld_version             [0x2] CEA-861D or below
> edid_version            [0x1] CEA-861
> manufacture_id          0x4148
> product_id              0xb01
> port_id                 0x0
> support_hdcp            0
> support_ai              0
> audio_sync_delay        0
> speakers                [0x0]
> sad_count               8
> sad0_coding_type        [0x1] LPCM
> sad0_channels           2
> sad0_rates              [0x1ee0] 44100 48000 88200 176400
> 192000 384000
> sad0_bits               [0xe0000]
> sad1_coding_type        [0x1] LPCM
> sad1_channels           8
> sad1_rates              [0x1ee0] 44100 48000 88200 176400
> 192000 384000
> sad1_bits               [0xe0000]
> sad2_coding_type        [0x2] AC-3
> sad2_channels           6
> sad2_rates              [0xe0] 44100 48000 88200
> sad2_max_bitrate        640000
> sad3_coding_type        [0x7] DTS
> sad3_channels           7
> sad3_rates              [0x6e0] 44100 48000 88200 176400
> 192000
> sad3_max_bitrate        1536000
> sad4_coding_type        [0x9] DSD (One Bit Audio)
> sad4_channels           6
> sad4_rates              [0x40] 48000

> sad5_coding_type        [0x0] undefined
> sad5_channels           1
> sad5_rates              [0x0]
> sad6_coding_type        [0x0] undefined
> sad6_channels           1
> sad6_rates              [0x0]
> sad7_coding_type        [0x0] undefined
> sad7_channels           1
> sad7_rates              [0x0]

I wonder why the monitor report these zero valued SADs?

> The speakers 0 line is a bit confusing, not sure if that's

Yes it's unexpected. Do you know its real speaker numbers and
allocations? Does it provide some number of line-out ports?

> what's doing it.  I am using:
> aplay 51test.wav
> 
> which I have put here:
> http://www.csy.ca/~shane/51test.wav

I hear only "front left" and "front right" in my T61 :-)

Thanks,
Fengguang
---

> 
> Shane
> On Thu, Nov 20, 2008 at 09:02:04AM +0800, Wu Fengguang wrote:
> > Thanks Shane!
> > 
> > Ma Ling: do you have a quick fix for it?  Or shall I look into it?
> > 
> > Thank you,
> > Fengguang
> > 
> > On Wed, Nov 19, 2008 at 12:02:01PM -0800, Shane W wrote:
> > > On Wed, Nov 19, 2008 at 05:39:40PM +0800, Wu Fengguang wrote:
> > > > I managed to update the last working Xorg ELD patches to the latest
> > > > git tree, and they compile flawlessly. The attached 2 patches are for 
> > > > xf86-video-intel/ and xserver/ respectively.
> > > 
> > > They do compile but I can't get them to run.  Here's the
> > > Xorg backtrace when starting.  I'm having trouble
> > > generating a core but I'll work on getting gdb output if
> > > needed.
> > > 
> > > Backtrace:
> > > 0: /opt/gfx-test/bin/Xorg(xorg_backtrace+0x26) [0x4ebbb6]
> > > 1: /opt/gfx-test/bin/Xorg(xf86SigHandler+0x39) [0x495b49]
> > > 2: /lib/libc.so.6 [0x7f2d1648bf60]
> > > 3:
> > > /opt/gfx-test/lib/xorg/modules/drivers//intel_drv.so(gen4_render_state_cleanup+0x1c)
> > > [0x7f2d14ebab9c]
> > > 4: /opt/gfx-test/lib/xorg/modules/drivers//intel_drv.so
> > > [0x7f2d14e92dfd]
> > > 5: /opt/gfx-test/bin/Xorg(AbortDDX+0x8d) [0x4690fd]
> > > 6: /opt/gfx-test/bin/Xorg(AbortServer+0x1d) [0x4f505d]
> > > 7: /opt/gfx-test/bin/Xorg(LogVMessageVerb+0) [0x4f5700]
> > > 8:
> > > /opt/gfx-test/lib/xorg/modules/drivers//intel_drv.so(i830_bind_all_memory+0x102)
> > > [0x7f2d14e99592]
> > > 9: /opt/gfx-test/lib/xorg/modules/drivers//intel_drv.so
> > > [0x7f2d14e93ad0]
> > > 10: /opt/gfx-test/lib/xorg/modules/drivers//intel_drv.so
> > > [0x7f2d14e950f8]
> > > 11: /opt/gfx-test/bin/Xorg(AddScreen+0x1c6) [0x431086]
> > > 12: /opt/gfx-test/bin/Xorg(InitOutput+0x241) [0x469ae1]
> > > 13: /opt/gfx-test/bin/Xorg(main+0x205) [0x431795]
> > > 14: /lib/libc.so.6(__libc_start_main+0xe6) [0x7f2d164781a6]
> > > 15: /opt/gfx-test/bin/Xorg [0x430dd9]
> > > 
> > > It seems to be the xserver patch that's doing it.  When they
> > > are both unapplied, X starts fine, when the Xserver patch
> > > is applied, we segfault, when the intel is applied alone,
> > > it starts fine and when both are applied the segfault
> > > returns.
> > > 
> > > Shane
