From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/8] Rework KERN_<LEVEL>
Date: Tue, 5 Jun 2012 16:58:08 -0700
Message-ID: <20120605165808.cd255b93.akpm@linux-foundation.org>
References: <cover.1338889066.git.joe@perches.com>
	<20120605142826.d92316a0.akpm@linux-foundation.org>
	<1338934303.5780.8.camel@joe2Laptop>
	<20120605151754.a794ac7c.akpm@linux-foundation.org>
	<1338936572.5780.29.camel@joe2Laptop>
	<20120605162910.caccb0d4.akpm@linux-foundation.org>
	<1338939316.11962.3.camel@joe2Laptop>
	<CAPXgP13J+8-dPpZkSfh9sM3xXujC2Rb9tJaOvGoEPghgdr8jiw@mail.gmail.com>
	<1338939792.11962.4.camel@joe2Laptop>
	<CAPXgP10DEsqtz9xbPUQ3xCwdFGTTYyTGSd7yEcU2vUr3SJ83Sw@mail.gmail.com>
	<1338940345.11962.9.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
	[140.211.169.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F7922438A
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2012 01:58:10 +0200 (CEST)
In-Reply-To: <1338940345.11962.9.camel@joe2Laptop>
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
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, Kay Sievers <kay@vrfy.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-btrfs@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 05 Jun 2012 16:52:25 -0700
Joe Perches <joe@perches.com> wrote:

> On Wed, 2012-06-06 at 01:48 +0200, Kay Sievers wrote:
> > On Wed, Jun 6, 2012 at 1:43 AM, Joe Perches <joe@perches.com> wrote:
> > > On Wed, 2012-06-06 at 01:39 +0200, Kay Sievers wrote:
> > 
> > >> > # echo "\001Hello Andrew" > /dev/kmsg
> > >> > /dev/kmsg has
> > >> > 12,774,2462339252;\001Hello Andrew
> > >>
> > >> Try "echo -e"? The stuff is copied verbatim otherwise.
> > >
> > > # echo -e "\001Hello Kay" > /dev/kmsg
> > > gives
> > > 12,776,3046752764;\x01Hello Kay
> > 
> > Don't you need two bytes to trigger the logic?
> 
> Yes.  Angle brackets fore and aft.

he means

	echo "\0014Hello Joe" > /dev/kmsg
	          ^

It needs one of [0-7cd] to trigger the prefix handling.
