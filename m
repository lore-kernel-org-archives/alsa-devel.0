From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC][PATCH] pxa2xx-ac97: switch AC unit to
	correct state before	probing
Date: Tue, 11 Nov 2008 11:57:31 +0000
Message-ID: <20081111115731.GD7019@sirena.org.uk>
References: <20081110191124.GA2140@doriath.ww600.siemens.net>
	<20081111104739.GB7019@sirena.org.uk> <491971D3.8080604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 33712103800
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 12:57:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <491971D3.8080604@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 11, 2008 at 02:51:47PM +0300, Dmitry Baryshkov wrote:
> Mark Brown wrote:

> > expect that simply switching pxa25x to polling GSR for completion like
> > everything else does would deal with it but testing would be nice if
> > anyone has a board...

> I'll check on tosa (pxa255). However I didn't notice any additional 
> delay during startup.

The timeout is ~1ms so it's not going to be immediately obvious to a
human.
