From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/6] ARM: ux500: Enable HIGHMEM on all
	mop500 platforms
Date: Tue, 31 Jul 2012 20:50:02 +0000
Message-ID: <201207312050.03113.arnd@arndb.de>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <5017EBDC.6010005@linaro.org> <20120731143732.GS6802@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AFC3265D31
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 22:50:17 +0200 (CEST)
In-Reply-To: <20120731143732.GS6802@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, Lee Jones <lee.jones@linaro.org>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 31 July 2012, Russell King - ARM Linux wrote:
> I still fail to see how not having highmem enabled would ever cause memory
> corruption errors (unless something dealing with memory in a very very
> wrong way - iow, not using one of the reservation or memory allocation
> methods provided by the kernel.)

The problem is that all users of ux500 systems pass a command line like

vmalloc=256M mem=128M@0 mali.mali_mem=32M@128M hwmem=168M@160M mem=48M@328M mem_issw=1M@383M mem=640M@384M

This is of course totally bogus and should not be done. If I understand
Lee correctly, one of the issues resulting from passing a command
line like this without enabling highmem is memory corruption.

"Doctor it hurts when I do this ..."

	Arnd
