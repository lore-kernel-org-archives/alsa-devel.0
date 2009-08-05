From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: MPC5200: Support for buffer wrap
	around
Date: Wed, 5 Aug 2009 18:05:19 +0100
Message-ID: <20090805170519.GA26086@rakim.wolfsonmicro.main>
References: <20090729153844.18131.68062.stgit@riker>
	<1249490672.4582.65.camel@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C6C7244FD
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 19:05:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1249490672.4582.65.camel@riker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Bonesio <bones@secretlab.ca>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 05, 2009 at 09:44:32AM -0700, John Bonesio wrote:

> This is another patch for ALSA on the MPC5200 that was sent to the ALSA
> devel list. I'm not sure if you noticed it.

> Since I've submitted the patch to the list, we've been able to test it,
> and audio continues to play right through appl_ptr wrapping back around
> to the beginning of the buffer.

> I've attached the patch, for your convenience.

I've been waiting for one of the driver maintainers (Grant or Jon) to
comment on it.
