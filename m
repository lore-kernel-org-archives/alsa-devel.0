From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 5/5] ASoC:
	Blackfin	I2S: fix resuming when device hasn't been used
Date: Thu, 17 Sep 2009 15:08:36 +0100
Message-ID: <20090917140836.GJ20676@sirena.org.uk>
References: <1253147112-5801-1-git-send-email-vapier@gentoo.org>
	<1253147112-5801-5-git-send-email-vapier@gentoo.org>
	<20090917095202.GB30736@rakim.wolfsonmicro.main>
	<8bd0f97a0909170702q41b6081ch32566976f339344e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DD1231037F2
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 16:08:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a0909170702q41b6081ch32566976f339344e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 17, 2009 at 10:02:26AM -0400, Mike Frysinger wrote:

> unfortunately, the system is already completely broken when more than
> one is used.  ive opened an item to get this fixed, but it's going to
> require a few core pieces to be rewritten.  so i'd like to have this
> merged since it improves the current situation.

OK, I suspected something like that was going on.  I'll apply the patch.
