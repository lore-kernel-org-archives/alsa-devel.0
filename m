From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Change of cold reset and ac97
	register	cache
Date: Thu, 17 Jan 2008 13:28:27 +0000
Message-ID: <20080117132827.GA1248@rakim.wolfsonmicro.main>
References: <87k5m91k93.fsf@polgara.paysbobval>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 310102437C
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 14:47:16 +0100 (CET)
Resent-Message-ID: <20080117134715.GB22123@opensource.wolfsonmicro.com>
Resent-To: alsa-devel@alsa-project.org
Content-Disposition: inline
In-Reply-To: <87k5m91k93.fsf@polgara.paysbobval>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <rjarzmik@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 16, 2008 at 11:24:56PM +0100, Robert Jarzmik wrote:

> The actual implementation of the wm9713 codec provides a cache of AC97
> registers. After cold reset, the cache and hardware are not in sync. When
> using wm9713 logic, oring a GPIO triggers many other GPIOS.

> The solution of this patch reads from hardware to cache upon cold reset.
> Another one would be to write the cache to hardware upon init. If decided so,
> I would gladly change my patch.

Neither option is entirely safe - something more involved like the code
in wm9713_soc_resume() would be required to bring the chip back safely.
Writing the current cache values is unsafe due to ordering requirements
and in any case the information required to configure the PLL can't be
recovered from the cache alone.  Reading the values currently set in the
chip for the cache is safer will leave the chip without basic
initialisation and the driver out of sync with the state of the chip.

Could you outline why you need to reset the codec?  I'd like to
understand the use case here.
