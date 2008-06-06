From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Add WM8510 driver
Date: Fri, 6 Jun 2008 17:12:21 +0100
Message-ID: <20080606161221.GA11803@rakim.wolfsonmicro.main>
References: <1212670174-19810-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<200806050917.23252.geoffrey@pager.net>
	<20080605144655.GA24582@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A856F2442C
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jun 2008 18:12:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080605144655.GA24582@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Geoffrey Wossum <geoffrey@pager.net>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lg@opensource.wolfsonmicro.com>, Brett Saunders <breton.saunders@ntlworld.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 05, 2008 at 03:46:55PM +0100, Mark Brown wrote:
> On Thu, Jun 05, 2008 at 09:17:23AM -0500, Geoffrey Wossum wrote:

> > Mark, were able to verify that the default value SPKMIX differs from the 
> > datasheet?  Is this a datasheet mistake, or an issue in the WM8510 part I 
> > have?  The full markings on the part are "WM8510G / 63AETV9", and the 
> > datasheet is "February 2008, Rev 4.4".

> It's most likely a typo in the datasheet; I should have confirmed this
> by tomorrow.

I've confirmed your patch now, thanks again for the report.
