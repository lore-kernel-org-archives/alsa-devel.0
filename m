From: Timur Tabi <timur@freescale.com>
Subject: Re: CS4279 and hw_read_t/hw_write_t
Date: Mon, 21 Jul 2008 10:18:56 -0500
Message-ID: <4884A8E0.3040907@freescale.com>
References: <9e4733910807210806v4caf49f1ke90cefda07b63579@mail.gmail.com>	
	<4884A641.80304@freescale.com>
	<9e4733910807210816i624618fy8093dc2609e0922d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 426432432F
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 17:19:00 +0200 (CEST)
In-Reply-To: <9e4733910807210816i624618fy8093dc2609e0922d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:

> You'd have to read the CS4270 datasheet in detail to see if can even
> be hooked up to an smbus controller. smbus is a subset of full i2c.

There's no mention of SM Bus anywhere in the CS4270 datasheet.  Can I assume
that it won't work?

I remember now trying to use a standard I2C-only function and it didn't work,
but that was a long time ago before I knew much about the hardware.  I'll have
to try it again.

-- 
Timur Tabi
Linux kernel developer at Freescale
