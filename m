From: Zinx Verituse <zinx@epicsol.org>
Subject: Re: CMI9739A
Date: Mon, 29 Nov 2004 20:05:25 -0600
Message-ID: <20041130020525.GA2591@bliss>
References: <20041125004649.GA21551@bliss> <s5hact5oqa6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from imf19aec.mail.bellsouth.net (imf19aec.mail.bellsouth.net [205.152.59.67])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1CCDD2DF
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2004 03:05:27 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5hact5oqa6.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 25, 2004 at 05:18:57PM +0100, Takashi Iwai wrote:
> At Wed, 24 Nov 2004 18:46:49 -0600,
> Zinx Verituse wrote:
> > 
> > I recently purchased a motherboard with an on-board CMI9739A (or so it claims)
> > 
> > the id is: 0x434d4983
> > 
> > Unfortunately, simply adding the line:
> > 
> > { 0x434d4983, 0xffffffff, "CMI9739A",           patch_cm9739,   NULL },
> > 
> > causes the card to be muted, reguardless of the mixer, because of the init
> > code in patch_cm9739 -- the init code apparently isn't compatible.
> > 
> > Removing the initialization code, but leaving the ops, gives a few more
> > functional mixer options (like "Line-In as Surround" and "Mic as Center/LFE")
> 
> According to the datasheet, CM9739A is indeed compatible with 9739
> except for pins.
> 
> Could you get the ac97 register dump of the good- and bad-running
> states (from /proc/asound/card0/codec97#0/* files) ?
> 
> I guess the GPIO initialization (for using HP) is wrong there.  Doing
> the following helps?
> 
> 	# echo 72 0001 > /proc/asound/card0/codec97#0/ac97#0-0+regs

Sorry it took so long to get back to you -- I've attached the following files:
cmi9739a-working-ac97.txt       - output from working */codec97#0/ac97#0-0
cmi9739a-working-ac97-regs.txt  - output from working */codec97#0/ac97#0-0+regs
cmi9739a-muted-ac97.txt         - output from muted */codec97#0/ac97#0-0
cmi9739a-muted-ac97-regs.txt    - output from muted */codec97#0/ac97#0-0+regs

attempting to write to ac97#0-0+regs with the following:
72 0001
0:72 0001
72=0001
72 = 0001
0:72 = 0001
met with the error:
-su: /proc/asound/card1/codec97#0/ac97#0-0+regs: No such device

-- 
Zinx Verituse                                    http://zinx.xmms.org/

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cmi9739a-working-ac97.txt"

0-0/0: C-Media Electronics CMI9739A

Revision         : 0x01
Compat. Class    : 0x03
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     :
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=2 AMAP LDAC SDAC CDAC DSA=0 DRA
Extended status  : SPCV LDAC SDAC CDAC

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cmi9739a-working-ac97-regs.txt"

0:00 = 0000
0:02 = 0101
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 801e
0:0c = 0000
0:0e = 9f1f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 0000
0:16 = 9f1f
0:18 = 0808
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0bc2
0:2a = 05f0
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 8080
0:38 = 0000
0:3a = 2000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0004
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 1438
0:66 = 0012
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0000
0:74 = c000
0:76 = 3833
0:78 = 0000
0:7a = 0000
0:7c = 434d
0:7e = 4983

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cmi9739a-muted-ac97-regs.txt"

0:00 = 0000
0:02 = 0101
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 801e
0:0c = 0000
0:0e = 9f1f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 0000
0:16 = 9f1f
0:18 = 0808
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0bc2
0:2a = 05f0
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 8080
0:38 = 0000
0:3a = 2000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0004
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 5400
0:66 = 0012
0:68 = 0000
0:6a = 0000
0:6c = 2001
0:6e = 0000
0:70 = 0100
0:72 = 0000
0:74 = c000
0:76 = 3833
0:78 = 0000
0:7a = 0000
0:7c = 434d
0:7e = 4983

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cmi9739a-muted-ac97.txt"

0-0/0: C-Media Electronics CMI9739A

Revision         : 0x01
Compat. Class    : 0x03
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     :
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=2 AMAP LDAC SDAC CDAC DSA=0 DRA
Extended status  : SPCV LDAC SDAC CDAC

--SUOF0GtieIMvvwua--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
