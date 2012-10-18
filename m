From: "Porter, Matt" <mporter@ti.com>
Subject: Re: [PATCH v2 0/2] Convert davinci ASoC to genalloc
	SRAM
Date: Thu, 18 Oct 2012 14:40:28 +0000
Message-ID: <3098B0AA-7032-4A49-8D4E-EF1D726ED85A@ti.com>
References: <1349991229-32107-1-git-send-email-mporter@ti.com>
 <20121017135116.GU14199@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id AB0A12652E5
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 16:40:30 +0200 (CEST)
In-Reply-To: <20121017135116.GU14199@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <D9AA8773DB5A8E409437D571059D4D4F@owa.mail.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, "Nori, Sekhar" <nsekhar@ti.com>, Alsa Devel List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ben Gardiner <bengardiner@nanometrics.ca>, Daniel Mack <zonque@gmail.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org


On Oct 17, 2012, at 9:51 AM, Mark Brown wrote:

> On Thu, Oct 11, 2012 at 05:33:47PM -0400, Matt Porter wrote:
> 
>> This series converts davinci ASoC to use genalloc and enables
>> that support on DA850. It applies to mainline on top of the
>> uio_pruss/genalloc series [1] which allows DaVinci to provide
>> a gen_pool via pdata for driver use.
> 
> I tried to apply these patches but patch 2 doesn't apply against
> v3.7-rc1 I guess due to the series you mention.  What's the plan for
> merging that series?  It'd also be good to get Daniel's patch squashed
> in.

I will ping Hans about the uio_pruss driver portion. Sekhar was waiting
on a ack for that before applying all of the supporting genalloc patches
for mach-davinci/

-Matt
