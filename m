From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH V4 1/5] The macro spin_event_timeout()
 takes a condition and timeout value
Date: Tue, 26 May 2009 09:20:22 -0500
Message-ID: <4A1BFAA6.60309@freescale.com>
References: <20090525221406.21370.30326.stgit@terra>
	<ed82fe3e0905260432xdc9556cp74edc723eafe24f7@mail.gmail.com>
	<alpine.LRH.2.00.0905261348160.4897@vixen.sonytel.be>
	<200905261349.49832.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id CF7B11038C7
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 16:21:13 +0200 (CEST)
In-Reply-To: <200905261349.49832.arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

Arnd Bergmann wrote:
> On Tuesday 26 May 2009, Geert Uytterhoeven wrote:
>> However, you can still improve useability by making the macro return the rc,
>> instead of letting the caller pass it, cfr. wait_event_timeout() and friends.

I had that originally, but somewhere during the seven revisions of my macro, it got lost.

I'll post a v9 soon.  This version will take 3 parameters and return __ret, so Jon will need to change his code (sorry).

-- 
Timur Tabi
Linux kernel developer at Freescale
