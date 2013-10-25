From: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Fri, 25 Oct 2013 18:54:52 +0200
Message-ID: <20131025165452.GA89428@deflower.internal>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <s5hli1imfsi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f44.google.com (mail-ee0-f44.google.com [74.125.83.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A4E1261675
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 18:54:58 +0200 (CEST)
Received: by mail-ee0-f44.google.com with SMTP id c4so1664163eek.3
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 09:54:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hli1imfsi.wl%tiwai@suse.de>
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
Cc: Anssi Hannula <anssi.hannula@iki.fi>, alsa-devel@alsa-project.org, Peter =?iso-8859-1?Q?Fr=FChberger?= <fritsch@xbmc.org>, Olivier Langlois <olivier@trillion01.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 25, 2013 at 01:04:45AM +0200, Takashi Iwai wrote:
> At Thu, 24 Oct 2013 21:10:33 +0300,
> Anssi Hannula wrote:
> > 
> > Hi all!
> > 
> > Here's another revision of the ATI/AMD multichannel+HBR patchset.
> > 
> > Changes:
> > - added customizable callbacks instead of polluting generic code
> > - fixed wrong codec id in rev3+ check (as previously noted)
> > - cosmetics
> > 
> > I've only tested this on NVIDIA/Intel, but I'd guess at least Peter
> > should be able to test this on AMD in a few days or so. The earlier
> > revisions were tested to fully work.
> > 
> > Combined patch can be found at: http://onse.fi/files/atihdmi5.patch
> > However, this patchset is on top recent sound-next commits so it does not
> > directly apply on older kernels.
> > 
> > Olivier, I hope you will be able to test this at some point as well
> > (same things as last time), even though it will be a bit more work :)
> 
> I applied all patches now.  You can try sound git tree either master
> or for-next branch.

Takashi,

with today's Linus' master and your master branch merged in I get:
ERROR: "gen_pool_free" [sound/core/snd-page-alloc.ko] undefined!

my .config had CONFIG_HAS_DMA=y but no CONFIG_GENERIC_ALLOCATOR, is
there a select missing?


Anssi,

I gave this a quick test, and it works on my 6850! Nice work!
The HDMI output is connected to a Onkyo receiver from the future ;) :
	EDID for output HDMI-0
	Manufacturer: ONK  Model: 1  Serial#: 16777216
	Year: 2245  Week: 255
	EDID Version: 1.3
	EDID (in hex):
		00ffffffffffff003dcb010000000001
		ffff0103800000780a0dc9a057479827
		12484c00000001010101010101010101
		010101010101011d8018711c1620582c
		2500c48e2100009e011d007251d01e20
		6e285500c48e2100001e000000fc0054
		582d53523637342020202020000000fd
		00313d0f2e08000a202020202020019b
		02032f724f8504030f0e07069413121e
		1d1615012f097f070f1f071707503707
		503f07c0834f000066030c00ffff808c
		0ad08a20e02d10103e9600c48e210000
		18011d80d0721c1620102c2580c48e21
		00009e011d00bc52d01e20b8285540c4
		8e2100001e8c0ad090204031200c4055
		00c48e210000180000000000000000a8

No DTS-HD/TrueHD support, but all 5.1 channels are working correctly.

cat /proc/asound/card0/codec\#0
	Codec: ATI R6xx HDMI
	Address: 0
	AFG Function Id: 0x1 (unsol 0)
	Vendor Id: 0x1002aa01
	Subsystem Id: 0x00aa0100
	Revision Id: 0x100200
	No Modem Function Group found
	Default PCM:
		rates [0x70]: 32000 44100 48000
		bits [0x2]: 16
		formats [0x1]: PCM
	Default Amp-In caps: N/A
	Default Amp-Out caps: N/A
	State of AFG node 0x01:
	  Power states:  D0 D3
	  Power: setting=D0, actual=D0
	GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
	Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
	  Device: name="HDMI 0", type="HDMI", device=3
	  Converter: stream=1, channel=0
	  Digital: Enabled GenLevel
	  Digital category: 0x2
	  IEC Coding Type: 0x0
	Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
	  Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
	  Control: name="IEC958 Playback Con Mask", index=0, device=0
	  Control: name="IEC958 Playback Pro Mask", index=0, device=0
	  Control: name="IEC958 Playback Default", index=0, device=0
	  Control: name="IEC958 Playback Switch", index=0, device=0
	  Control: name="ELD", index=0, device=3
	  Pincap 0x00000094: OUT Detect HDMI
	  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
		Conn = Digital, Color = Unknown
		DefAssociation = 0x1, Sequence = 0x0
	  Pin-ctls: 0x40: OUT
	  Unsolicited: tag=01, enabled=1
	  Connection: 1
		 0x02

cat /proc/asound/card0/eld\#0.0
	monitor_present		1
	eld_valid		0

Regards,
Andre
