From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ASoC: sgtl5000: Do not read registers
	prior to turning on the supplies
Date: Fri, 31 May 2013 00:36:11 +0200
Message-ID: <201305310036.11681.marex@denx.de>
References: <1369749858-21579-1-git-send-email-fabio.estevam@freescale.com>
 <20130528143255.GK3660@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 00681261A6A
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 00:36:14 +0200 (CEST)
In-Reply-To: <20130528143255.GK3660@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark, Fabio,

> On Tue, May 28, 2013 at 11:04:18AM -0300, Fabio Estevam wrote:
> > Commit b871f1ad (ASoC: sgtl5000: Read SGTL5000_CHIP_ID in i2c_probe())
> > placed the code for reading the codec revision prior to turning on the
> > power supplies.
> > 
> > Even though this works on some systems that always have the codec power
> > supplies enabled, this is not correct, so revert this commit.
> 
> It seems like a better fix for this is to just enable the supplies while
> doing the device identification?

This patch does kinda fix it for me, but the system takes quite some time to 
init the soundcard now (a few seconds). After reverting these two patches, the 
soundcard works just fine (like before):

    ASoC: sgtl5000: Fix driver probe after reset
    ASoC: sgtl5000: Read SGTL5000_CHIP_ID in i2c_probe()

Best regards,
Marek Vasut
