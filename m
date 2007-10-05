From: Timur Tabi <timur@freescale.com>
Subject: Re: ASoC v2 on PowerPC
Date: Fri, 05 Oct 2007 10:30:38 -0500
Message-ID: <4706589E.5000404@freescale.com>
References: <9e4733910710041012vb8e2a25w7a3b2cc7be80426d@mail.gmail.com>	
	<1191582477.12060.243.camel@localhost.localdomain>	
	<9e4733910710050555u5189efdp424fded7fe5f16c0@mail.gmail.com>	
	<4706444F.7000606@freescale.com>
	<9e4733910710050826h25d29827radec93e9eef17782@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id DE55124545
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Oct 2007 17:30:42 +0200 (CEST)
In-Reply-To: <9e4733910710050826h25d29827radec93e9eef17782@mail.gmail.com>
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

>> A lot of the i.MX code just sits in BSPs and is never forwarded to the main
>> repositories.
> 
> Aren't you fixing that?

No, I work on PowerPC only, and only some 8xxx chips.  The i.MX stuff is a 
completely different group, and I only know one person who works on it, and 
she's in India.

> I started looking at v2 because of the posts about modularizing it and
> using open firmware to identify and load the codecs. There doesn't
> seem to be that much difference.

My brain can only handle so much at one time. :-)

> We are on 5200 because it is cheaper and 5200 has all the peripherals
> we need. Now that I am writing code for it I see that BestComm adds a
> lot of complexity. Hopefully I can get i2s working on it, I'd hate to
> switch CPUs after doing all this work.

You might want to direct some questions to the linuxppc-dev@ozlabs.org.  Also, 
if you have an IRC client, you can find a bunch of us on irc.freenode.net, 
channel #mklinux.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
