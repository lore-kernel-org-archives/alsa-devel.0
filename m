From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC PATCH 4/5] ASoC: remove those unnecessary
	#ifdef	CONFIG_PXA3xx .. #endif
Date: Thu, 23 Apr 2009 09:17:15 +0100
Message-ID: <20090423081715.GA30105@sirena.org.uk>
References: <f17812d70904222206h27c58e40t5c8383133df1a7d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BF85F103838
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 10:17:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70904222206h27c58e40t5c8383133df1a7d0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 23, 2009 at 01:06:55PM +0800, Eric Miao wrote:
> These are unnecessary since the compiler is smart enough to optimize
> the code away if CONFIG_PXA3xx is not defined, when cpu_is_pxa3xx()
> will just be expanded to constant 0.

This isn't done for compiler optimisation - it's done because the
register bit macros are only defined if PXA3xx support is being built
in.  I've no problem with removing those guards but without that you'll
get build failures on PXA2xx.
