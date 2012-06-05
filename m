From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/8] Rework KERN_<LEVEL>
Date: Tue, 5 Jun 2012 15:17:54 -0700
Message-ID: <20120605151754.a794ac7c.akpm@linux-foundation.org>
References: <cover.1338889066.git.joe@perches.com>
	<20120605142826.d92316a0.akpm@linux-foundation.org>
	<1338934303.5780.8.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
	[140.211.169.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BF511043C9
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2012 00:17:57 +0200 (CEST)
In-Reply-To: <1338934303.5780.8.camel@joe2Laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, Kay Sievers <kay.sievers@vrfy.org>, Sievers <kay@vrfy.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kay@alsa-project.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-btrfs@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 05 Jun 2012 15:11:43 -0700
Joe Perches <joe@perches.com> wrote:

> On Tue, 2012-06-05 at 14:28 -0700, Andrew Morton wrote:
> > Unfortunately the <n> thing is part of the kernel ABI:
> > 
> > 	echo "<4>foo" > /dev/kmsg
> 
> Which works the same way it did before.

I didn't say it didn't.

What I did say is that echo "\0014">/dev/kmsg will subvert the intent
of the new logging code.  Or might.  But you just ignored all that,
forcing me to repeat myself, irritatedly.
