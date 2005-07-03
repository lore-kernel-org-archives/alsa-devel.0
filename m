From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: sound blaster name
Date: Sun, 03 Jul 2005 13:11:43 +0200
Message-ID: <42C7C7EF.9030201@free.fr>
References: <42B3E474.7000301@free.fr> <42B3ECD5.6030500@superbug.co.uk>	 <42B3F28B.4030307@free.fr> <42B3F484.5060004@free.fr>	 <42B3F83C.90305@superbug.co.uk> <42B5A056.4010608@free.fr>	 <42BC6451.8020303@free.fr> <1119647048.3290.57.camel@mindpipe> <42C71EB1.1020207@free.fr> <42C722AD.1010603@superbug.co.uk> <42C7278C.5090100@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030100030100000101090604"
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <42C7278C.5090100@free.fr>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: matthieu castet <castet.matthieu@free.fr>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030100030100000101090604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

matthieu castet wrote:
> Hi,
> 
> James Courtier-Dutton wrote:
> 
>> matthieu castet wrote:
>>
>>
>> I thought I added those already to the CVS.
>> Matthieu, are there some still missing?
>>
> {.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80611102,
>      .driver = "EMU10K1", .name = "SBLive! Player 5.1 [SB0060]",
>      .id = "Live",
>      .emu10k1_chip = 1,
>      .ac97_chip = 1,
>      .sblive51 = 1}
> is present 2 times.
> 
> SBLive motherboard (PCI\VEN_1102&DEV_0002&SUBSYS_002F1102)
> SBLive motherboard (PCI\VEN_1102&DEV_0002&SUBSYS_80251102)
> SBLive motherboard (PCI\VEN_1102&DEV_0002&SUBSYS_80631102)
> don't seem to be in cvs.
> 
> SB0103 don't seem to be a value version but a full version
> 
> Matthieu
> 
> PS :
> I found other id on 
> http://bbs.zol.com.cn/new/static_book2/17/924/17_226924.shtml, but I am 
> too tired to list the missing one (there list 34 cards for EMU10K1, cvs 
> has only 18, there are some for audigy)
> 
I attached a patch that sort the card by id, it will be a lot's easier 
to find the missing ones...

--------------030100030100000101090604
Content-Type: text/x-patch;
 name="emu_id.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="emu_id.patch"

--- emu10k1_main.c	2005-07-03 12:51:10.000000000 +0200
+++ emu10k1_main.c.new	2005-07-03 13:05:36.000000000 +0200
@@ -714,54 +714,49 @@
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ac97_chip = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x40011102,
-	 .driver = "EMU10K1", .name = "E-mu APS [4001]", 
-	 .id = "APS",
-	 .emu10k1_chip = 1,
-	 .ecard = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80611102,
-	 .driver = "EMU10K1", .name = "SBLive! Player 5.1 [SB0060]", 
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x806B1102,
+	 .driver = "EMU10K1", .name = "SBLive! [SB0105]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80641102,
-	 .driver = "EMU10K1", .name = "SB Live 5.1", 
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x806A1102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [SB0103]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80401102,
-	 .driver = "EMU10K1", .name = "SBLive! Platinum [CT4760P]", 
-	 .id = "Live",
-	 .emu10k1_chip = 1,
-	 .ac97_chip = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x00211102,
-	 .driver = "EMU10K1", .name = "SBLive! [CT4620]", 
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80691102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [SB0101]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x00201102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [CT4670]", 
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80641102,
+	 .driver = "EMU10K1", .name = "SB Live 5.1", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80221102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [CT4780]", 
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80611102,
+	 .driver = "EMU10K1", .name = "SBLive! Player 5.1 [SB0060]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80231102,
-	 .driver = "EMU10K1", .name = "SB PCI512 [CT4790]", 
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80511102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4850]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80261102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [CT4830]", 
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80401102,
+	 .driver = "EMU10K1", .name = "SBLive! Platinum [CT4760P]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80321102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4871]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
@@ -772,50 +767,49 @@
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80271102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [CT4832]", 
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80281102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4870]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80511102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [CT4850]", 
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80271102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4832]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80281102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [CT4870]", 
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80261102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4830]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80321102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [CT4871]", 
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80231102,
+	 .driver = "EMU10K1", .name = "SB PCI512 [CT4790]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80611102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [SB0060]", 
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80221102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4780]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80691102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [SB0101]", 
-	 .id = "Live",
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x40011102,
+	 .driver = "EMU10K1", .name = "E-mu APS [4001]", 
+	 .id = "APS",
 	 .emu10k1_chip = 1,
-	 .ac97_chip = 1,
-	 .sblive51 = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x806A1102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [SB0103]", 
+	 .ecard = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x00211102,
+	 .driver = "EMU10K1", .name = "SBLive! [CT4620]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
-	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x806B1102,
-	 .driver = "EMU10K1", .name = "SBLive! [SB0105]", 
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x00201102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4670]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,

--------------030100030100000101090604--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
