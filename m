From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question about your DSP topic branch
Date: Fri, 1 Apr 2011 06:42:40 +0900
Message-ID: <20110331214239.GB21726@opensource.wolfsonmicro.com>
References: <4D2652C8.7030701@codeaurora.org> <4D939519.6040506@codeaurora.org>
	<4D9421DB.4010204@codeaurora.org> <1301607322.3549.211.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6EBA410381E
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 23:42:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1301607322.3549.211.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 31, 2011 at 10:35:22PM +0100, Liam Girdwood wrote:

> It should be possible to add support for the _E() macros in soc-dsp.c,
> but I'm not sure why it's required atm since we dont need this for OMAP4
> ABE.

Not sure why Patrick might need it but some of the DSPs I've seen
require a multiple write sequence to kick them into doing things - for
example, set the state up then do another write to tell it to apply the
new configuration.
