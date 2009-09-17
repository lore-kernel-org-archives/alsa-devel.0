From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: Blackfin I2S: fix resuming when
 device hasn't been used
Date: Thu, 17 Sep 2009 10:52:02 +0100
Message-ID: <20090917095202.GB30736@rakim.wolfsonmicro.main>
References: <1253147112-5801-1-git-send-email-vapier@gentoo.org>
	<1253147112-5801-5-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4F557103813
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 11:52:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253147112-5801-5-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 16, 2009 at 08:25:12PM -0400, Mike Frysinger wrote:
> From: Cliff Cai <cliff.cai@analog.com>

> If the sound system hasn't been utilized yet and we suspend, then we
> attempt to save/restore using state that doesn't exist.  So use a global
> handle instead to reconfigure properly.

I expect that this will break if more than one DAI is in use, which can
happen if people are using multiple DACs to do 5.1 or hardware mixing.
Would it not make sense to allocate the SPORT when the DAI is probed?

I've applied the other four patches - thanks.
