From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] opti931: additional check for OPL3 device
Date: Mon, 17 Sep 2007 12:10:12 +0200
Message-ID: <46EE5284.9070202@gmail.com>
References: <8c74410a0709140735j3903a11dp23f783d45bffc55c@mail.gmail.com>	<1189781567.3648.1210664373@webmail.messagingengine.com>	<20070914184705.9ba48d80.krzysztof.h1@gmail.com>
	<1190016893.19336.1210994773@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040701050701080300010507"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 9542510384F
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 12:11:01 +0200 (CEST)
In-Reply-To: <1190016893.19336.1210994773@webmail.messagingengine.com>
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
--------------040701050701080300010507
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 09/17/2007 10:14 AM, Clemens Ladisch wrote:

> Krzysztof Helt wrote:

>> Should the OPL4 detection has the same fallback or just all Opti cards
>> should search the FM chip at the range + 8 address?
> 
> It appears a fallback shoudn't be needed because the chip always returns 
> a range suitable for an OPL4.
> 
> Since an OPL3 range is never larger than 8 bytes, and OPL4 needs 16 
> bytes, we could add 8 to get the FM address _if_ the range is at least 16
> bytes; thus we are safe even if a chip publishes an OPL3-only range.

At least 16 won't do -- the OPTi chip provides a 12-byte range. More than 8 
would work, but just +8 is fine. I have all OPTi ISA-PnP chips (924, 925, 
931, 933) and more aren't going to be produced. The 0x380 base is what it 
calls the OPL4Base and ALBase (AdLib) is at 0x388.

The chip can defer to external FM it seems, but even if there are OPTi/OPL4 
combo's out there in the wild (I sort of doubt it) the driver's just doing 
opl3 anyway. ie, still needs just the +8.

Rene.

--------------040701050701080300010507
Content-Type: text/plain;
 name="opti9xx-fm_port.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="opti9xx-fm_port.diff"

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 60c120f..8bda47a 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -1732,11 +1732,11 @@ static int __devinit snd_card_opti9xx_pnp(struct snd_opti9xx *chip,
 
 #ifdef OPTi93X
 	port = pnp_port_start(pdev, 0) - 4;
-	fm_port = pnp_port_start(pdev, 1);
+	fm_port = pnp_port_start(pdev, 1) + 8;
 #else
 	if (pid->driver_data != 0x0924)
 		port = pnp_port_start(pdev, 1);
-	fm_port = pnp_port_start(pdev, 2);
+	fm_port = pnp_port_start(pdev, 2) + 8;
 #endif	/* OPTi93X */
 	irq = pnp_irq(pdev, 0);
 	dma1 = pnp_dma(pdev, 0);

--------------040701050701080300010507
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040701050701080300010507--
