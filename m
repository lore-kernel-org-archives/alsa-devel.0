From: Travis Place <wishie@wishie.net>
Subject: Problem regarding CA0106
Date: Sat, 14 Jun 2008 03:18:33 +1000
Message-ID: <1213377513.27630.5.camel@temp-fallen>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-089.dial.usertools.net
	[202.137.100.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 442AA103822
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 19:17:38 +0200 (CEST)
Received: from [192.168.0.7] (unknown [192.168.0.200])
	by www.wishie.net (Postfix) with ESMTP id 302BB2E9F9
	for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2008 17:39:08 +1000 (EST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Just been speaking with a guy in #alsa about the problems with his "MSI
K8N Diamond MB" which has an onboard "SB Live 24bit" or "Audigy".

While looking through ca0106_main.c in GIT, i saw the following section:

/* MSI K8N Diamond Motherboard with onboard SB Live 24bit without AC97
*/
	 /* SB0438
	  * CTRL:CA0106-DAT
	  * ADC: WM8775SEDS
	  * DAC: CS4382-KQZ
	  */
	 { .serial = 0x10091462,
	   .name   = "MSI K8N Diamond MB [SB0438]",
	   .gpio_type = 2,
	   .i2c_adc = 1 } ,

For this guys sound to work, we had to change the serial line to:

	 { .serial = 0x10091102,

Seems to be a bit hackish, and maybe some more investigation is required, but, it got sound to work, and the card is recognised.

Perhaps there is (for some odd reason) 2 variants of the onboard sound on that motherboard (Perhaps a rev 1.0 and rev 1.1 motherboard difference?)

Let me know if any more information is required, or if I can just make and submit a patch (ill add a new section for the new card, not the hackish way).

Thanks,
Travis Place
