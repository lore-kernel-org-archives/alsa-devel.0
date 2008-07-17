From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WRITING AN SOC DRIVER WITHOUT DMA
Date: Thu, 17 Jul 2008 11:56:14 +0100
Message-ID: <20080717105614.GC15333@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<1216199130.749.4.camel@dinesh.dua>
	<8d6898730807160307g4455597ck921d55da8f51455d@mail.gmail.com>
	<1216203206.9723.0.camel@dinesh.dua>
	<1216274611.18207.6.camel@dinesh.dua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3012A10381B
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 12:56:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1216274611.18207.6.camel@dinesh.dua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: dinesh <dinesh.dua@coraltele.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Nobin Mathew <nobin.mathew@gmail.com>, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 17, 2008 at 11:33:31AM +0530, dinesh wrote:

> What i want is that i have a buffer in driver code which is also handled
> by some other application i want that this buffer data is to be used for
> capture and playback  stream fills data to another buffer which i can
> passover to my other application.

Depending on what exactly you're doing here you may find that this is
best implemented in user space with an ALSA plugin rather than doing it
as part of a driver.  If you do want to do this in kernel space then the
parts of an ASoC driver which transfer audio data are just the same as
those for any other ALSA driver so things like sound/arm/aaci.c may
provide useful examples.
