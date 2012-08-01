From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/6] ARM: ux500: Ensure probing of Audio
	devices when Device Tree is enabled
Date: Wed, 1 Aug 2012 13:32:01 +0000
Message-ID: <201208011332.02500.arnd@arndb.de>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <201207312054.13818.arnd@arndb.de> <5018DBEE.9090203@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A4A5265B7B
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 15:32:13 +0200 (CEST)
In-Reply-To: <5018DBEE.9090203@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, broonie@opensource.wolfsonmicro.com, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 01 August 2012, Lee Jones wrote:
> > Looks like you're adding the same call to each of the three cases:
> > mop500, snowball and hrefv60+. How about moving it before or after
> > the if/elseif block?
> 
> The Snowball one is different 'mop500_msp_init' -> 'mop500_of_msp_init'.

Ah, I see. Is there a problem in always using mop500_of_msp_init then?
I would guess that this just means you'd have to put the msp into the
device tree files, which don't yet exist for mop500 and hrefv60.

	Arnd
