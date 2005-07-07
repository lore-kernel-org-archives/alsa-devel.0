From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [Alsa-user] sound blaster name
Date: Thu, 07 Jul 2005 18:50:38 +0200
Message-ID: <42CD5D5E.5040808@free.fr>
References: <42B3E474.7000301@free.fr> <42B3ECD5.6030500@superbug.co.uk>	 <42B3F28B.4030307@free.fr> <42B3F484.5060004@free.fr>	 <42B3F83C.90305@superbug.co.uk> <42B5A056.4010608@free.fr>	 <42BC6451.8020303@free.fr> <1119647048.3290.57.camel@mindpipe>	 <42C71EB1.1020207@free.fr> <42C722AD.1010603@superbug.co.uk>	 <42C7278C.5090100@free.fr> <42C7C7EF.9030201@free.fr>	 <42C7D322.1050100@superbug.co.uk>  <42C7E5C4.3030602@free.fr>	 <1120414451.7915.2.camel@mindpipe>  <42C82EB7.4000709@free.fr> <1120417637.7915.5.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030303060308060005020207"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1120417637.7915.5.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030303060308060005020207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Lee Revell wrote:
> On Sun, 2005-07-03 at 20:30 +0200, matthieu castet wrote:
> 
>>Lee Revell wrote:
>>
>>>On Sun, 2005-07-03 at 15:19 +0200, matthieu castet wrote:
>>>
>>>
>>>>I there an easy way to know if the .sblive51 flag is needed ?
>>>>Does it is needed only for 3G SB card  (SBxxx version or those marked as 
>>>>5.1) ?
>>>
>>>
>>>I think it's need for any SBLive! (not Audigy) that has an analog
>>>center/LFE output.
>>>
>>
>>On my card (CT4670) the 2 possibles analog output are normal (controled 
>>by master) and rear (controled by wave surround).
>>So it is not needed ?
> 
> 
I attach a patch a remove 5.1 flag for my card

--------------030303060308060005020207
Content-Type: text/x-patch;
 name="ct4670.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ct4670.patch"

--- emu10k1_main.c	2005-07-07 18:47:59.000000000 +0200
+++ emu10k1_main.c.new	2005-07-07 18:49:15.000000000 +0200
@@ -811,12 +811,12 @@
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
+	/* Tested by castet.matthieu@free.fr 7st July 2005 */
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x00201102,
 	 .driver = "EMU10K1", .name = "SBLive! Value [CT4670]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
-	 .ac97_chip = 1,
-	 .sblive51 = 1} ,
+	 .ac97_chip = 1,} ,
 	{.vendor = 0x1102, .device = 0x0002,
 	 .driver = "EMU10K1", .name = "SB Live [Unknown]", 
 	 .id = "Live",

--------------030303060308060005020207--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
