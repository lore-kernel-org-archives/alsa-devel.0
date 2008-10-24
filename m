From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: pxa2xx-ssp
Date: Fri, 24 Oct 2008 19:14:17 +0100
Message-ID: <20081024181416.GC3328@sirena.org.uk>
References: <1224809675.8330.4.camel@brutus>
	<1224863678.28382.54.camel@dell-desktop.example.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EB12103824
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 20:14:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1224863678.28382.54.camel@dell-desktop.example.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@kernel.org>
Cc: alsa-devel@alsa-project.org, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 24, 2008 at 04:54:38PM +0100, Liam Girdwood wrote:

> If so, I guess we could scratch off the more testing part and consider
> it for the next merge window. Iirc it was also waiting on some pxa
> dependencies going upstream, so it may wait a little longer.

Yes, the only reason it's not been submitted yet is the cross tree
merging with ARM.  The last of that stuff should have gone in in the
current merge window - it should have gone in for .27 but rmk bumped out
a bunch of things at the last minute.

I'm not too worried about the testing since it's not currently in
mainline so there won't be any regressions from it, though obviously any
testing is good.

> I'm sure it's on Mark's long todo list....

Yeah, I was going to look at it sometime next week hopefully since -rc1
is out now.
