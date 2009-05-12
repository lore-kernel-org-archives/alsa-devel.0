From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: pxa2xx-pcm and dma_request
Date: Tue, 12 May 2009 23:06:02 +0100
Message-ID: <20090512220601.GA12038@sirena.org.uk>
References: <87vdo6c9pt.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BE4510386F
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 00:06:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87vdo6c9pt.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: dbaryshkov@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 12, 2009 at 11:06:22PM +0200, Robert Jarzmik wrote:

> One main difference is that in "arm context", pxa_dma_request() is called, while
> in "asoc context", it is not.

> I'd like one of you to cross-check, as I must admit I'm not following all the
> impacts of the pcm code split-up.

AFAICT this isn't a result of the code unification but rather is a case
of the code unification mirroring exactly the pre-merge state.  It's all
pre-git but my best guess would be that the ASoC version was done before
the DMA API was introduced - I expect the ASoC variant ought to be
updated to use the DMA API but I've not looked closely enough to be
certain.
