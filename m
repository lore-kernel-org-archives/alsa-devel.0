From: "Medisetty, Naresh" <naresh@ti.com>
Subject: Re: [PATCH 3/9] ARM: DaVinci: ASoC: Adds header
	file	for McASP Audio Layer for TI DM646X processor
Date: Wed, 18 Mar 2009 17:12:05 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B67017069809B097@dbde02.ent.ti.com>
References: <1237205002-30106-1-git-send-email-naresh@ti.com>,
	<20090316151510.GE16539@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id BE2C0243EE
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 12:42:47 +0100 (CET)
In-Reply-To: <20090316151510.GE16539@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: naresh [mailto:x0090427@ti.com]
> Sent: Wednesday, March 18, 2009 5:05 PM
> To: 'naresh'
> Subject:
>
> On Mon, Mar 16, 2009 at 08:03:22AM -0400, Naresh Medisetty wrote:
>
> > +/*
> > + * DAVINCI_MCASP_PWREMUMGT_REG - Power Down and Emulation Management
> > + *     Register Bits
> > + */
> > +#define FREE         BIT(0)
> > +#define SOFT         BIT(1)
>
> These (and most of your other register bit names) really need to be
> namespaced.  I'd also suggest considering moving the register
> definitions out of here and into the C file - it looks like nothing
> else
> ever ought to be peering at them?



I will take care of the namespace and move these

definitions to the C file
