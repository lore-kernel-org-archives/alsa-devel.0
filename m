From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 17/18] ARM: ux500: Add all encompassing
 Sound node to DB8500 Device Tree
Date: Mon, 30 Jul 2012 14:42:21 +0100
Message-ID: <20120730134220.GD4468@opensource.wolfsonmicro.com>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-18-git-send-email-lee.jones@linaro.org>
 <20120729205227.GL4384@opensource.wolfsonmicro.com>
 <50163936.1050901@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DC23D2652D5
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 15:42:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <50163936.1050901@linaro.org>
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
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 30, 2012 at 08:35:18AM +0100, Lee Jones wrote:
> On 29/07/12 21:52, Mark Brown wrote:

> >...this is clearly the board-specific setup for the system, showing how
> >the CPU and CODEC are hooked up.  This should therefore be in the DT for
> >whatever board this is you're working on.

> I don't think it's board specific. I believe this is the setup on
> all db8500 platforms. I'm happy to be told I'm wrong here, in which
> case I can move it to the board specific files.

I think that's more a sign that all the platforms you've seen are just
cut'n'pasted from the reference design than anything else.  If the thing
you're describing is on the PCB it's generally board specific...
