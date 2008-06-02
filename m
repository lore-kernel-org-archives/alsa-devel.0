From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH][ASoC V2] Make Freescale MPC8610 drivers
	more dynamic
Date: Mon, 02 Jun 2008 09:18:11 -0500
Message-ID: <48440123.5070508@freescale.com>
References: <1212187311-22901-1-git-send-email-timur@freescale.com>
	<20080602110101.GE9031@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 19FF2245ED
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jun 2008 16:18:17 +0200 (CEST)
In-Reply-To: <20080602110101.GE9031@rakim.wolfsonmicro.main>
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

Mark Brown wrote:

> This change means that if someone builds another board with the same CPU
> on it then they'll have to add all the objects for the core CPU support
> to the Makefile entry for their board.

They'll need to update Kconfig and the Makefile anyway, so I decided to cut out
the "middle man" -- the SOC.

>  There should at least be a
> separate Kconfig thing, even if it's not user visible.  I've committed a
> patch backing this bit out for now.

Grrr...

>> +#define DEBUG
>> +
> 
> This probably shouldn't be on by default?

For now, I want it on.

> In general, it'd be a bit easier to review the changes you're making if
> you were able to submit individual changes in separate patches, 

Yes, that would be nice :-)

> though I
> appreciate that at the minute you're making a lot of changes that go
> over large portions of the code and can't be easily separated out so I
> wouldn't worry about it too much.

Normally, I would submit everything as one final patch, but I hate hanging on to
uncommitted code for too long.

-- 
Timur Tabi
Linux kernel developer at Freescale
