From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Input/output error while playing a file using aplay
Date: Tue, 26 Jun 2007 09:21:51 +0200
Message-ID: <1182842511.3512.1197069785@webmail.messagingengine.com>
References: <61445c750706221312t4449c847p72523339f228a101@mail.gmail.com>
	<1182754597.9211.1196859135@webmail.messagingengine.com>
	<61445c750706250156p42de468vecbf7ca4f373f2b0@mail.gmail.com>
	<1182769239.15228.1196888507@webmail.messagingengine.com>
	<61445c750706250504k23d02f75y52619c6cd081a5a8@mail.gmail.com>
	<61445c750706250635i61be8752lbf7a7b1930a8ca79@mail.gmail.com>
	<61445c750706251138r290c2a7br6b911be6da7e53ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 187B3103800
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2007 09:21:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750706251138r290c2a7br6b911be6da7e53ce@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> After rewriting the pointer function

It would really help if you'd show us the code of the version of the
driver that you're currently talking about.

> I am not getting the input/output error but I am getting underruns.
> ...
> ALSA sound/core/pcm_lib.c:167: BUG: stream = 0, pos = 0x1150000, buffer size = 0x4000, period size = 0x800

Here, "pos" is the value returned by your pointer callback.  This value
should have been a frame number somewhere in the buffer, i.e., in the
range 0..0x3fff.  Apparently, the pointer callback doesn't correctly
calculate this value.

Please remove most printk()s, and add some in the pointer callback to
show both the value that you get from the DMA controller, and the value
that this function returns.


Regards,
Clemens
