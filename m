From: Daniel Mack <zonque@gmail.com>
Subject: Re: DT support for Davinci ASoC platform
Date: Thu, 05 Jul 2012 18:05:08 +0200
Message-ID: <4FF5BB34.9070002@gmail.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA35352@DBDE01.ent.ti.com>
	<4FF5733E.6000604@gmail.com> <201207051536.45920.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0865D24422
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 18:05:13 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so1136626bkc.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Jul 2012 09:05:12 -0700 (PDT)
In-Reply-To: <201207051536.45920.arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Rajashekhara,
	Sudhakar" <sudhakar.raj@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Nori, Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Hebbar,
	Gururaja" <gururaja.hebbar@ti.com>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "Girdwood, Liam" <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 05.07.2012 17:36, Arnd Bergmann wrote:
> On Thursday 05 July 2012, Daniel Mack wrote:
>> On 04.07.2012 14:48, Hebbar, Gururaja wrote:
>>> All,
>>>
>>> Are there any plans or work going on for providing Device Tree Support for Davinci
>>> ASoC?
>>>
>>> I am planning to add DT support for TI AM335x (McASP) and I don't want to do duplicate
>>> task.
>>
>> That's good to know. But isn't there a dependency on the EDMA engine? Is
>> that part ported yet?
> 
> None of the dma engines are ported yet, because the generic binding for dma
> engines is still under debate. So far, all DMA channels are described using
> auxdata on platforms that use DT, with the exception of exynos, but that one
> will have to change once we have the common code.

You're talking about the DT bindings here, right? But the code itself is
also only present in TI's BSP kernel sources, and not in mainline.


Daniel
