From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/8] Rework KERN_<LEVEL>
Date: Tue, 5 Jun 2012 17:46:38 -0700
Message-ID: <20120605174638.69bcfa31.akpm@linux-foundation.org>
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
	<20120605165808.cd255b93.akpm@linux-foundation.org>
	<1338941247.11962.16.camel@joe2Laptop>
	<CAPXgP12OFnh6FZO4zFGCw=Ea4U6Ne5OoCg_9BPxRX62x0EVnng@mail.gmail.com>
	<1338941971.11962.20.camel@joe2Laptop>
	<CAPXgP10VE2huY4gGpeFPe=YKYM+nDBfoMgpHnGmQwn0jdPxhbw@mail.gmail.com>
	<20120605173751.65a2e1ee.akpm@linux-foundation.org>
	<1338943205.11962.28.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
	[140.211.169.12])
	by alsa0.perex.cz (Postfix) with ESMTP id D5AE6243AF
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2012 02:46:07 +0200 (CEST)
In-Reply-To: <1338943205.11962.28.camel@joe2Laptop>
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

On Tue, 05 Jun 2012 17:40:05 -0700 Joe Perches <joe@perches.com> wrote:

> On Tue, 2012-06-05 at 17:37 -0700, Andrew Morton wrote:
> > On Tue, 05 Jun 2012 17:07:27 -0700 Joe Perches <joe@perches.com> wrote:
> > 
> > > On Tue, 2012-06-05 at 16:58 -0700, Andrew Morton wrote:
> > > >  echo "\0014Hello Joe" > /dev/kmsg
> > > 
> > > # echo -e "\x014Hello Me" > /dev/kmsg
> > > gives:
> > > 12,778,4057982669;Hello Me
> > 
> > That's changed behavior.
> 
> Which is an improvement too.

No it isn't.  It exposes internal kernel implementation details in
random weird inexplicable ways.  It doesn't seem at all important
though.

> I very much doubt a single app will change
> because of this.

I doubt it as well.

> > printk_emit() does parse the leading \0014, and then skips over it,
> > removing it from the output stream.  printk_emit() then throws away the
> > resulting level because devkmsg_writev() did not pass in level==-1.
> 
> I'm glad you know how it works now.

It's nice to see you learning about it as well.
