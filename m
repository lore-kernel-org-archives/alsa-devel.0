From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [Alsa-user] sound blaster name
Date: Sun, 03 Jul 2005 01:47:24 +0200
Message-ID: <42C7278C.5090100@free.fr>
References: <42B3E474.7000301@free.fr> <42B3ECD5.6030500@superbug.co.uk>	 <42B3F28B.4030307@free.fr> <42B3F484.5060004@free.fr>	 <42B3F83C.90305@superbug.co.uk> <42B5A056.4010608@free.fr>	 <42BC6451.8020303@free.fr> <1119647048.3290.57.camel@mindpipe> <42C71EB1.1020207@free.fr> <42C722AD.1010603@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42C722AD.1010603@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

James Courtier-Dutton wrote:
> matthieu castet wrote:
> 
> 
> I thought I added those already to the CVS.
> Matthieu, are there some still missing?
> 
{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80611102,
	 .driver = "EMU10K1", .name = "SBLive! Player 5.1 [SB0060]",
	 .id = "Live",
	 .emu10k1_chip = 1,
	 .ac97_chip = 1,
	 .sblive51 = 1}
is present 2 times.

SBLive motherboard (PCI\VEN_1102&DEV_0002&SUBSYS_002F1102)
SBLive motherboard (PCI\VEN_1102&DEV_0002&SUBSYS_80251102)
SBLive motherboard (PCI\VEN_1102&DEV_0002&SUBSYS_80631102)
don't seem to be in cvs.

SB0103 don't seem to be a value version but a full version

Matthieu

PS :
I found other id on 
http://bbs.zol.com.cn/new/static_book2/17/924/17_226924.shtml, but I am 
too tired to list the missing one (there list 34 cards for EMU10K1, cvs 
has only 18, there are some for audigy)

[1102\0002]

; EMU10K1 Audio Chipset (SB Live!)

00201102=CT4850 SBLive! Value

00211102=CT4620 SBLive!

002F1102=Integrated SBLive!

00411102=CT4820 SBLive!

40011102=E-mu APS

80221102=CT4780 SBLive! Value

80231102=CT4790 SoundBlaster PCI512 OEM

80241102=CT4760 SBLive!

80251102=Integrated SBLive!

80261102=CT4830 SBLive! Value

80271102=CT4832 SBLive! Value

80281102=CT4870 SBLive! Value

80291102=CT4872 SBLive!

802A1102=CT4890 SB PCI256

802B1102=CT4891 SB PCI256

80311102=CT4831 SBLive! Value

80321102=CT4871 SBLive! Value

80331102=CT4893 SB PCI256

80351102=CT0060 SBLive!

80401102=CT4760 SBLive!

80501102=CT4820 SB PCI512

80511102=CT4850 SBLive! Value

80611102=SB0060 SBLive! 5.1

80621102=SB0100 SBLive! 5.1

80631102=Integrated SBLive! 5.1

80641102=SB0102 SBLive! 5.1

80651102=SB0220 SBLive! 5.1 Digital

80661102=SB0220 SBLive! 5.1 Digital

80671102=SB0220 SBLive! 5.1 Digital

80681102=CT0061 SBLive!

80691102=SB0101 SBLive! 5.1 Value

806A1102=SB0103 SBLive! 5.1

806B1102=SB0105 SBLive! 5.1

80711102=SB0150 Sound Blaster PCI512

[1102\0004]

; EMU10K2 Audio Chipset (SB Audigy Series)

00411102=CT4820 Audigy

00421102=CT0070 Audigy

00431102=CT0072 Audigy

00511102=SB0090 Audigy Platinum (EX)

00531102=CT0090 Audigy Player

10021102=SB0240 Audigy 2 Platinum 6.1

10031102=SB0243 Audigy 2 (OEM'd For Dell??)

10071102=SB0240 Audigy 2 Platinum 6.1

20021102=SB0350 Audigy ZS

20071102=SB0380 Audigy4 PRO

[1102\0007]

; Audigy LS Series

10011102=SB0310 Audigy LS

10021102=SB0312 Audigy LS


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
