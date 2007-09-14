From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] opti931: additional check for OPL3 device
Date: Fri, 14 Sep 2007 18:33:35 +0200
Message-ID: <46EAB7DF.8010707@gmail.com>
References: <8c74410a0709140735j3903a11dp23f783d45bffc55c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080409010304060202020507"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AC7324502
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Sep 2007 18:34:00 +0200 (CEST)
In-Reply-To: <8c74410a0709140735j3903a11dp23f783d45bffc55c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080409010304060202020507
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 09/14/2007 04:35 PM, Krzysztof Helt wrote:

> This patch adds additional check for OPL3 device. I found that PNP region
> returned by the card is 0x380 - 0x38f but the OPL3 device is located at
> 0x388 (standard FM device address). The driver checks start of the range
> (0x380) which is incorrect.

> The same problem appears on two cards I have with Opti chipset: opti931
> and opti933. If someone can test if the opti92x PnP has the same problem
> I would be grateful.

Yes, same for OPT0924/OPT0925 (928, 929 and 930 are Non-PnP).

I'd rather simply adjust the resource in snd_card_opti9xx_pnp though -- that 
way, you don't go second guessing a user-specified value.

Untested, but looks as though this should do it:

Rene.

--------------080409010304060202020507
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

--------------080409010304060202020507
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080409010304060202020507--
