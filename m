From: "Ronny V. Vindenes" <s864@ii.uib.no>
Subject: Re: [Alsa-user] Re: ALSA 1.0.0pre3 release
Date: Wed, 26 Nov 2003 15:30:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1069857039.3235.19.camel@localhost.localdomain>
References: <s5h7k1oz2v0.wl@alsa2.suse.de>
	 <1069805467.3525.11.camel@localhost.localdomain>
	 <s5hr7zvxvcf.wl@alsa2.suse.de>
	 <1069848611.3235.13.camel@localhost.localdomain>
	 <s5hn0ajxqd7.wl@alsa2.suse.de>
	 <1069855806.3235.17.camel@localhost.localdomain>
	 <s5hekvvxlkk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-mBgPA3nv+VMKsJoq1Trm"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hekvvxlkk.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-mBgPA3nv+VMKsJoq1Trm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-11-26 at 15:15, Takashi Iwai wrote:
> At Wed, 26 Nov 2003 15:10:06 +0100,
> Ronny V. Vindenes wrote:
> > 
> > On Wed, 2003-11-26 at 13:32, Takashi Iwai wrote:
> > > At Wed, 26 Nov 2003 13:10:11 +0100,
> > > Ronny V. Vindenes wrote:
> > > > 
> > > > On Wed, 2003-11-26 at 11:44, Takashi Iwai wrote: 
> > > > > At Wed, 26 Nov 2003 01:11:07 +0100,
> > > > > Ronny V. Vindenes wrote:
> > > > > > 
> > > > > > On Tue, 2003-11-25 at 20:04, Takashi Iwai wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > right now the ALSA 1.0.0pre3 packages are released.
> > > > > > > 
> > > > > > > In this version, alsa-tools package was divided to two several ones,
> > > > > > > alsa-tools and alsa-firmware.  The latter contains only the firmware
> > > > > > > binary files required by loader programs in alsa-tools package.
> > > > > > > Please test them if you have a board requiring the loader (hdsp,
> > > > > > > mixart, vx, usx2y).
> > > > > > > 
> > > > > > > Especially, HDSP users, please test and report whether it works, since
> > > > > > > the hdsploader was modified to load the files dynamically.
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > > mmap'ed sound with the cs46xx driver seems to be broken, every other
> > > > > > half second the sound is muted. Non-mmap'ed sound plays normally. This
> > > > > > is under 2.6.0-test9-mm5. The version included in test9-mm5 works as
> > > > > > expected (there was some patches in mm5 against ALSA, but applying those
> > > > > > to 1.0.0pre3 made no difference for this particular problem).
> > > > > 
> > > > > there is no big change in cs46xx driver itself, so the change is
> > > > > either in kernel core or in the config.
> > > > > do you use CONFIG_SND_CS46XX_NEW_DSP ?
> > > > 
> > > > Yes.
> > > > 
> > > > I've tested it with 2.6.0-test10 too now, and I've narrowed it down a
> > > > bit: native alsa mmap'ed or not works, but oss emulation only works
> > > > correctly when not using mmap.
> > > > 
> > > > Things like wine, quake3, Enemy Territory all sound awful. Plain
> > > > 2.6.0-test10 works fine in all cases.
> > > 
> > > to be sure, try to set direct mode for oss-emulation via writing to
> > > the proc file.  see alsa-kernel/Documentation/OSS-Emulation.txt.
> > 
> > Setting direct mode made no difference.
> > 
> > > 
> > > also, please check /proc/asound/card0/pcm0p/sub0/* files in both
> > > cases.
> > 
> > I've attached cat /proc/asound/card0/pcm0p/sub0/* for both cases
> 
> sorry, i meant the ALSA 1.0.0pre3 and the 2.6.0-test10 (oss-emu with
> mmap).  it's known that the mmap support of this chip is not perfect.
> but i still suspect that the base oss-emu code change affected this.
> 
> 
> Takashi
> 

ok, here's from plain test10

-- 
Ronny V. Vindenes <s864@ii.uib.no>

--=-mBgPA3nv+VMKsJoq1Trm
Content-Disposition: attachment; filename=2.6.0-test10
Content-Type: text/plain; name=2.6.0-test10; charset=UTF-8
Content-Transfer-Encoding: 7bit

access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 22050 (22050/1)
period_size: 512
buffer_size: 16384
tick_time: 1000
OSS format: S16_LE
OSS channels: 2
OSS rate: 22050
OSS period bytes: 2048
OSS periods: 32
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: CS46xx
name: CS46xx
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 31
subdevices_avail: 30
64
state: RUNNING
trigger_time: 1069856885.000853207
tstamp      : 1069856889.000718741
delay       : 16144
avail       : 240
avail_max   : 33200
-----
hw_ptr      : 85232
appl_ptr    : 101376
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 512
xfer_align: 1
start_threshold: 1
stop_threshold: 1073741824
silence_threshold: 528
silence_size: 528
boundary: 1073741824

--=-mBgPA3nv+VMKsJoq1Trm--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
