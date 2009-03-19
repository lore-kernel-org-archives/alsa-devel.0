From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/3] ASoC: pxa-ssp: Don't
	use	SSCR0_SerClkDiv and SSCR0_SCR
Date: Thu, 19 Mar 2009 12:57:44 +0000
Message-ID: <20090319125743.GE1598@sirena.org.uk>
References: <1237451692.14402.10.camel@localhost.localdomain>
	<20090319114809.GC1598@sirena.org.uk>
	<74d0deb30903190504v1d1e7b5fm13eea63222019a24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4ECBE103919
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 13:57:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74d0deb30903190504v1d1e7b5fm13eea63222019a24@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, eric miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 19, 2009 at 01:04:16PM +0100, pHilipp Zabel wrote:

> Please ignore patch 3, then. I'll fix and resend that one when I have
> time to think properly about what I'm doing, but I fear the 2.6.29
> release will be first.

This should be OK for fixing in an early -rc given that multi-CPU
configs are supposed to be supported it's a bug fix.
