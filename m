From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: question about sound/oss/vidc.c
Date: Sat, 20 Mar 2010 17:42:06 +0000
Message-ID: <20100320174206.GD14470@flint.arm.linux.org.uk>
References: <Pine.LNX.4.64.1003162258230.26076@ask.diku.dk>
	<s5hocinh0jj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 37FA1103817
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 18:42:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hocinh0jj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Julia Lawall <julia@diku.dk>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 17, 2010 at 08:25:52AM +0100, Takashi Iwai wrote:
> I guess these should be adev->dma_out->flags instead.

Yes, I think so too.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
