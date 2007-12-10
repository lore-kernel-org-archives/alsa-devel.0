From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [PATCH 2/2] sis7019: add support for pre-2.6
	kernels
Date: Mon, 10 Dec 2007 08:53:02 +0100
Message-ID: <1197273182.31526.1225705529@webmail.messagingengine.com>
References: <1197158043.3588.52.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 99C381037F9
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 08:53:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1197158043.3588.52.camel@obelisk.thedillows.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dave Dillow <dave@thedillows.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dave Dillow wrote:
> The sis7019 driver uses __ffs(), which is available in 2.6 kernels, but
> not in most earlier ones. This patches the driver to use a local version
> assembly version, as the hardware is SiS 55x only (i486/Pentium-ish).
> 
> ++#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
> ++static inline unsigned long sis_ffs(unsigned long word)
> ++{
> ++	__asm__("bsfl %1,%0"
> ++		:"=r" (word)
> ++		:"rm" (word));
> ++	return word;
> ++}
> ++#endif

This should go into alsa-driver/include/adriver.h.


Regards,
Clemens
