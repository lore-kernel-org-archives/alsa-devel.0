From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: Re: ALSA issue on DA850/OMAP-L138/AM18x
Date: Thu, 20 Jan 2011 10:35:53 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024850919E@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>
	<AANLkTi=X3KRngiNz5iQzojh_-h4W-iRDsbq8Hvy6Lm1x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id D288D1037E3
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 06:06:05 +0100 (CET)
In-Reply-To: <AANLkTi=X3KRngiNz5iQzojh_-h4W-iRDsbq8Hvy6Lm1x@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Sharon <dansharon@nanometrics.ca>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Dan,

Thanks for testing this patch. I'll add your Tested-by tag when I submit this patch.

On Wed, Jan 19, 2011 at 00:32:21, Dan Sharon wrote:
> These patches apply cleanly to 'v2.6.37' 
> 3c0eee3fe6a3a1c745379547c7e7c904aa64f6d5
> 
> of
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git.
> 
> The kernel was built with the 'da8xx_omapl_defconfig' from the omap-l1tree,
> and 'make menuconfig' to enable ASoC (the defconfig already has CONFIG_REGULATOR=y,
> CONFIG_REGULATOR_DUMMY=y, and CONFIG_REGULATOR_TPS6507X=y).
> 
> Testing was done on a da850evm by tftp'ing the kernel into ram, and using the
> SPI-flash-based rootfs from the PSP that shipped with the board.
> 
> Using 'arecord -r 48000 -c 2 -f S32_BE -t raw -v -d 1 > /tmp/arecord.cap' produced
> a file of 384000 bytes (48000 x 2 x 4 bytes/sample).  
> 'arecord -r 48000 -c 2 -f S32_BE -t raw -v > /dev/null' ran flawlessly for several
> hours.
> 
> I was not able to reproduce Sudhakar's problems with 'arecord -f dat | aplay -f dat'.
> 

Did you try the above, immediately after the da850evm boots? I am not
facing the issue if I run arecod and aplay together after executing
arecord or aplay individually.

Thanks,
Sudhakar
