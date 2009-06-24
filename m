From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Proposal for more reliable audio DMA.
Date: Wed, 24 Jun 2009 17:28:23 +0100
Message-ID: <378E7985-7CD3-4009-AA14-127391A819F2@opensource.wolfsonmicro.com>
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BE08C10384D
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 18:28:34 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>, James Courtier-Dutton <james.dutton@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 24 Jun 2009, at 17:07, Jon Smirl <jonsmirl@gmail.com> wrote:

> Trying to directly expose the ring buffer to the app seems like a good
>
> way to avoid a copy, but it isn't achieving that. pulse is not
> decoding audio straight into the ring buffer, it decodes first and
> then copies into the buffer. Pulse is using the timers to estimate the
> destination for the copy.  Move this copy down into the drivers, the
> drivers know the correct destination for the copy.

Pulse isn't just doing straight playback, a large part of what it's  
there for is to do software mixing. When you have multiple sources  
active pulse is going to be forced to do the copy as part of the  
mixing process so putting that bit of the buffer management in kernel  
won't help in the way you think it does. Part of what's going on here  
is that the kernel code is trying to give userspace access to the data  
for as long as possible.
