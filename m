From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: possible problem in s3c24xx-pcm.c in git-devel
	branch
Date: Thu, 13 Nov 2008 16:09:36 +0000
Message-ID: <20081113160936.GH31592@sirena.org.uk>
References: <cabda6420811130657k4079884cge643c1b33b319b14@mail.gmail.com>
	<20081113151701.GG31592@sirena.org.uk>
	<cabda6420811130740u325cf60bse8401af768fb7340@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 96E51103809
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 17:09:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cabda6420811130740u325cf60bse8401af768fb7340@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: christian pellegrin <chripell@gmail.com>
Cc: David Anders <dave123_aml@yahoo.com>, alsa-devel@alsa-project.org, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 13, 2008 at 04:40:03PM +0100, christian pellegrin wrote:

> AFAIK it's limited to 2 transfers, one loaded and one running. It

Yes, exactly - meaning that when DMA is idle there's only the loaded
buffer.

> could beneficial to have more of them (so the DMA doesn't stop if one
> interrupt is delayed for too much time). But I don't know if it's so
> critical. A period (4k) with cd quality sound takes 23 ms to be
> played. An embedded system not responding to irqs for all this time
> probably has worse issues.

AIUI it's a bootstrapping issue: the problem is what happens when the
first DMA buffer completes if there isn't a new buffer ready.  Once
there's a loaded buffer ready things are happy.

I'm wondering if adding a call to s3c24xx_pcm_enqueue() in the start
trigger after enabling the DMA might help matters, but I've not thought
that through at all.
