From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] AFEB9260 ASoC driver
Date: Fri, 8 May 2009 19:02:51 +0100
Message-ID: <20090508180251.GB3919@sirena.org.uk>
References: <1241702685-18877-1-git-send-email-slapin@ossfans.org>
	<20090507154611.GK27897@sirena.org.uk>
	<20090508143915.GA21623@build.ossfans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 529FB1038FA
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 20:02:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090508143915.GA21623@build.ossfans.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sergey Lapin <slapin@ossfans.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 08, 2009 at 06:39:15PM +0400, Sergey Lapin wrote:
> On Thu, May 07, 2009 at 04:46:11PM +0100, Mark Brown wrote:

> > Do you want to reverse your requst of the SSC port here?
> What would you suggest alternatively?

I don't know off hand but if there's a ssc_request() I'd assume that
there's something along the lines of ssc_release() to match it.
