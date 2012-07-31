From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] ASoC: dapm: If one widget fails,
 do not force all subsequent widgets to fail too
Date: Tue, 31 Jul 2012 16:18:20 +0100
Message-ID: <20120731151819.GC4468@opensource.wolfsonmicro.com>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
 <20120731134214.GK4468@opensource.wolfsonmicro.com>
 <5017EAC3.3080504@linaro.org>
 <20120731142820.GW4468@opensource.wolfsonmicro.com>
 <5017EDCA.4020601@linaro.org>
 <20120731145443.GY4468@opensource.wolfsonmicro.com>
 <5017F68B.3060400@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DB06A265D2A
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 17:18:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5017F68B.3060400@linaro.org>
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

On Tue, Jul 31, 2012 at 04:15:23PM +0100, Lee Jones wrote:
> On 31/07/12 15:54, Mark Brown wrote:

> >You might want to look at a better mail program.

> Willingly. Any good suggestions?

mutt works for me.

> >It's certainly totally inappropriate for an "urgent" bugfix.

> Well it just means that audio won't work for the ux500 for this
> kernel release, but as we're waiting on clocks, this isn't a big
> issue for us. If you do take it (with or without the return code),
> feel free to add it to for-next instead of the -rc:s

I'm not going to apply this patch.  This isn't a vendor BSP, we
shouldn't be putting random hacks like this in core code.
