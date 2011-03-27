From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Device-drivers-devel] [PATCH v2] ASoC: add
	SSM2604 codec	driver
Date: Sun, 27 Mar 2011 11:41:16 +0100
Message-ID: <20110327104116.GB11148@opensource.wolfsonmicro.com>
References: <1281160447-10393-1-git-send-email-vapier@gentoo.org>
	<1301130440-11532-1-git-send-email-vapier@gentoo.org>
	<20110326121239.GC28537@opensource.wolfsonmicro.com>
	<AANLkTim71QcpBTXLC2fFnqqW+SMJnNFpJB9qwn8EzeWv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BC2A0103833
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Mar 2011 12:41:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTim71QcpBTXLC2fFnqqW+SMJnNFpJB9qwn8EzeWv@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 27, 2011 at 12:11:54AM -0400, Mike Frysinger wrote:
> On Sat, Mar 26, 2011 at 08:12, Mark Brown wrote:

> > If the device only supports I2C then there's no need for the ifdefs.

> i thought in the past you wanted these things because you wanted to be
> able to build codecs regardless of the bus support (for testing iirc?)

That has never been the case, SND_SOC_ALL_CODECS has always built things
only if there is a bus for them.  If you support mulitple busses they
should be conditional so that you only need one of them to build but if
there's only one supported this is not relevant.
