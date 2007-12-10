From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [PATCH 2/2] sis7019: add support for pre-2.6
	kernels
Date: Mon, 10 Dec 2007 15:48:44 +0100
Message-ID: <1197298124.31051.1225761969@webmail.messagingengine.com>
References: <1197158043.3588.52.camel@obelisk.thedillows.org>
	<1197273182.31526.1225705529@webmail.messagingengine.com>
	<1197296683.3994.11.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id E93E51038E1
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 15:48:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1197296683.3994.11.camel@obelisk.thedillows.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dave Dillow <dave@thedillows.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dave Dillow wrote:
> On Mon, 2007-12-10 at 08:53 +0100, Clemens Ladisch wrote:
> > Dave Dillow wrote:
> > > The sis7019 driver uses __ffs(), which is available in 2.6 kernels, but
> > > not in most earlier ones. This patches the driver to use a local version
> > > assembly version, as the hardware is SiS 55x only (i486/Pentium-ish).
> > > 
> > > ++#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
> > > ++static inline unsigned long sis_ffs(unsigned long word)
> > > ++{
> > > ++	__asm__("bsfl %1,%0"
> > > ++		:"=r" (word)
> > > ++		:"rm" (word));
> > > ++	return word;
> > > ++}
> > > ++#endif
> > 
> > This should go into alsa-driver/include/adriver.h.
> 
> I'm not sure -- there's no other inline assembly there, and if I provide
> an x86 _ffs() fallback, then it'll break on other architectures...

It won't break unless another driver actually uses __ffs(), and then we
can still add a generic implementation.


Regards,
Clemens
