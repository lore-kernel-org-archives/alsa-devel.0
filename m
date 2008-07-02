From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ALSA SoC: Add Texas
	Instruments	TLV320AIC26 codec driver
Date: Wed, 02 Jul 2008 17:08:14 +0100
Message-ID: <1215014894.4882.100.camel@localhost.localdomain>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235340.16923.48024.stgit@trillian.secretlab.ca>
	<9e4733910807020652j59c9c742h965b4782667837f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7E74424475
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 18:08:15 +0200 (CEST)
In-Reply-To: <9e4733910807020652j59c9c742h965b4782667837f9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2008-07-02 at 09:52 -0400, Jon Smirl wrote:
> 
> I've been using asoc-v2 so it may not be possible to make this arch
> independent in asoc-v1.  Maybe try porting this to asoc-v2 and see if
> a bunch of the registration complexity disappears. Most of soc-of.c
> should be unnecessary.
> 
> Liam, when is asoc-v2 going into mainline?

Hopefully over the next 2 merge windows. I'm about to start queueing
patches....

This also assumes Mark and I remain at our current work load levels.

Liam
