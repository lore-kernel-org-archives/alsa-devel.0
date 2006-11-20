From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: alsa conexant HP dv2035LA
Date: Mon, 20 Nov 2006 10:14:06 -0800
Message-ID: <1164046446.5390.234.camel@razman>
References: <4ea46bd50611201008t45951bafsf502f979a32e7bf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4ea46bd50611201008t45951bafsf502f979a32e7bf5@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Antonio Sampayo <antonio.sampayo@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I've been working to get a test mode operational in the driver, so that
users can independently toggle the speakers and headphones.  It seems
that HP DV1/2/3000 series laptops are wired differently then the
DV5/8000 series as muting works on the latter series.

I just sent out a new patch to hopefully get test mode working.  I'll
add you to my separate mailing list and send you a copy of that email.

Tobin

On Mon, 2006-11-20 at 12:08 -0600, Antonio Sampayo wrote:
> Hi I'm a new tester and I will appreciate any help whit the headphones
> problem( the  mute speakers issue)
> 
> 
> This is my /proc/asound/card0/codec#0
> 
> Codec: Conexant CXT5047
> Address: 0
> Vendor Id: 0x14f15047
> Subsystem Id: 0x103c30b2
> Revision Id: 0x100000
> Default PCM: rates 0x040, bits 0x02, types 0x1
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> Node 0x10 [Audio Output] wcaps 0x41d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x0c 0x0c]
>   PCM: rates 0x040, bits 0x02, types 0x1
>   Power: 0x0
> Node 0x11 [Audio Output] wcaps 0x611: Stereo Digital
>   PCM: rates 0x040, bits 0x02, types 0x1
>   Power: 0x0
> Node 0x12 [Audio Input] wcaps 0x100d1b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=1
>   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
> 0x80] [0x80 0x80]
>   PCM: rates 0x040, bits 0x02, types 0x1
>   Power: 0x0
>   Connection: 6
>      0x19 0x14 0x15 0x1a* 0x16 0x10
> Node 0x13 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x1e 0x1e]
>   Pincap 0x081001c: OUT HP EAPD Detect
>   Pin Default 0x0221101f: [Jack] HP Out at Ext Front
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x40: OUT
>   Power: 0x0
>   Connection: 3
>      0x19* 0x10 0x16
> Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x1f 0x1f]
>   Pincap 0x0833c: IN OUT HP Detect
>   Pin Default 0x02a1102e: [Jack] Mic at Ext Front
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x20: IN
>   Power: 0x0
>   Connection: 2
>      0x19* 0x16
> Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x1f 0x1f]
>   Pincap 0x0833c: IN OUT HP Detect
>   Pin Default 0x40000180: [N/A] Line Out at Ext N/A
>     Conn = Unknown, Color = Unknown
>   Pin-ctls: 0x21: IN
>   Power: 0x0
>   Connection: 3
>      0x1c 0x19* 0x16
> Node 0x16 [Pin Complex] wcaps 0x400401: Stereo
>   Pincap 0x0860: IN
>   Pin Default 0x94330121: [Fixed] CD at Int Right
>     Conn = ATAPI, Color = Unknown
>   Pin-ctls: 0x20: IN
>   Power: 0x0
> Node 0x17 [Pin Complex] wcaps 0x400481: Stereo
>   Pincap 0x08324: IN Detect
>   Pin Default 0x95a70122: [Fixed] Mic at Int Top
>     Conn = Analog, Color = Unknown
>   Pin-ctls: 0x21: IN
>   Power: 0x0
> Node 0x18 [Pin Complex] wcaps 0x400701: Stereo Digital
>   Pincap 0x0810: OUT
>   Pin Default 0x04440131: [Jack] SPDIF Out at Ext Right
>     Conn = RCA, Color = Unknown
>   Pin-ctls: 0x00:
>   Power: 0x0
>   Connection: 1
>      0x11
> Node 0x19 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
>   Amp-In caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1
>   Amp-In vals:  [0x17 0x17] [0x80 0x80] [0x88 0x88] [0x17 0x17]
>   Power: 0x0
>   Connection: 4
>      0x10 0x1b 0x1a 0x16
> Node 0x1a [Audio Selector] wcaps 0x30050d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x1f, mute=0
>   Amp-Out vals:  [0x03 0x03]
>   Power: 0x0
>   Connection: 3
>      0x15 0x14 0x17*
> Node 0x1b [Audio Selector] wcaps 0x300501: Stereo
>   Power: 0x0
>   Connection: 2
>      0x14* 0x15
> Node 0x1c [Audio Output] wcaps 0x41d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   PCM: rates 0x040, bits 0x02, types 0x1
>   Power: 0x0
> Node 0x1d [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x1f 0x1f]
>   Pincap 0x08314: OUT Detect
>   Pin Default 0x92170110: [Fixed] Speaker at Int Front
>     Conn = Analog, Color = Unknown
>   Pin-ctls: 0x40: OUT
>   Power: 0x0
>   Connection: 3
>      0x1c 0x19* 0x16
> Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono
> 
> -- 
>  --------------
> < Debian Rules >
>  --------------
>         \   ^__^
>          \  (oo)\_______
>             (__)\       )\/\
>                 ||----w |
>                 ||     ||
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
