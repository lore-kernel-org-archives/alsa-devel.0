From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] ASoC: dapm: If one widget fails,
 do not force all subsequent widgets to fail too
Date: Tue, 31 Jul 2012 15:54:44 +0100
Message-ID: <20120731145443.GY4468@opensource.wolfsonmicro.com>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
 <20120731134214.GK4468@opensource.wolfsonmicro.com>
 <5017EAC3.3080504@linaro.org>
 <20120731142820.GW4468@opensource.wolfsonmicro.com>
 <5017EDCA.4020601@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2F7A7265D06
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 16:54:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5017EDCA.4020601@linaro.org>
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

On Tue, Jul 31, 2012 at 03:38:02PM +0100, Lee Jones wrote:

> Neither of those are in my Inbox. Blame Mozilla. :)

You might want to look at a better mail program.

> It's better because the whole audio system doesn't fail in the case
> of minor failure. It'd be like calling off a football game (or
> whatever you're into) because one of the substitutes ruptured an
> eyelash.

It shouldn't make any difference to startup - we should still be
checking errors and failing the init if we're failing to add links, 
this isn't something that's likely to randomly break on a particular
boot, it's more something that indicates nobody bothered testing.

It's certainly totally inappropriate for an "urgent" bugfix.

> During start-up the ux500 has a couple of very unimportant widgets
> fail. It's the wrong behavior to force failure on the everything
> audio just because of that.

Fixes for those errors, however...
