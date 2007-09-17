From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] opti931: additional check for OPL3 device
Date: Mon, 17 Sep 2007 14:26:25 +0200
Message-ID: <46EE7271.2050303@gmail.com>
References: <8c74410a0709140735j3903a11dp23f783d45bffc55c@mail.gmail.com>
	<1189781567.3648.1210664373@webmail.messagingengine.com>
	<20070914184705.9ba48d80.krzysztof.h1@gmail.com>
	<1190016893.19336.1210994773@webmail.messagingengine.com>
	<46EE5284.9070202@gmail.com>
	<1190025593.12774.1211014755@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050006060700080808050502"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A2E71037F7
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 14:27:14 +0200 (CEST)
In-Reply-To: <1190025593.12774.1211014755@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050006060700080808050502
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 09/17/2007 12:39 PM, Clemens Ladisch wrote:

> Rene Herman wrote:

>> At least 16 won't do -- the OPTi chip provides a 12-byte range. More
>> than 8 would work, but just +8 is fine. I have all OPTi ISA-PnP chips
>> (924, 925, 931, 933) and more aren't going to be produced. The 0x380
>> base is what it calls the OPL4Base and ALBase (AdLib) is at 0x388.
> 
> Are there chips that have both OPL4Base and ALBase?

Not as seperate PnP resources no. Here are pnpdumps for the 4 PnP chips:

http://members.home.nl/rene.herman/opti/

(yes, OPTi 933 is OPT0931 same as OPTi 931)

>> The chip can defer to external FM it seems, but even if there are
>> OPTi/OPL4 combo's out there in the wild (I sort of doubt it)
> 
> Why?

Because an OPL4 is fairly rarely seen as is and all OPTi (PnP) chips I have 
ever seen are on dirt cheap mass-market soundcards. It does not make a lot 
of sense from a business standpoint to put a cheap chip with integrated OPL3 
on a card and then wire up an expensive OPL4 to it. Admittedly, some of 
early OPTi chips may have been somewhat less junky -- 931/3 are worst in 
that respect.

>> the driver's just doing opl3 anyway. ie, still needs just the +8.
> 
> Only the 93x driver; the 92x driver has OPL4 support.

You're right, somehow managed to miss that. According to the code, there's 
overlap with PnP at the 924 which is unfortunate since it means we can't 
just add 8 (unconditionally, nor when the area is larger than 8) to the PnP 
resource -- an OPL4 would be probed for at the wrong address.

How about this? This adds 8 to fm_port only if we're checking for an OPL3 at 
a 16-byte aligned address (such as the 0x380-0x3f0 from the PnP chips). Is 
still second guessing the user if (s)he supplied the value, but what can you 
do. Ack?

Rene.


--------------050006060700080808050502
Content-Type: text/plain;
 name="opti9xx-fm_port2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="opti9xx-fm_port2.diff"

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 60c120f..1f5af7b 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -1890,12 +1890,15 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 			}
 		}
 #endif	/* !OPTi93X */
-		if (!opl3 && snd_opl3_create(card,
-					     chip->fm_port,
-					     chip->fm_port + 2,
-					     OPL3_HW_AUTO, 0, &opl3) < 0) {
-			snd_printk(KERN_WARNING "no OPL device at 0x%lx-0x%lx\n",
-				   chip->fm_port, chip->fm_port + 4 - 1);
+		if (!opl3) {
+			if ((chip->fm_port & 15) == 0)
+				chip->fm_port += 8;
+			error = snd_opl3_create(card, chip->fm_port,
+						chip->fm_port + 2,
+						OPL3_HW_AUTO, 0, &opl3);
+			if (error < 0)
+				snd_printk(KERN_WARNING "no OPL device at 0x%lx-0x%lx\n",
+					   chip->fm_port, chip->fm_port + 4 - 1);
 		}
 		if (opl3) {
 #ifdef CS4231

--------------050006060700080808050502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050006060700080808050502--
