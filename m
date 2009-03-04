From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 7/9] ASoC: Ensure codec check
	hw_write	error at probe
Date: Wed, 4 Mar 2009 19:57:27 +0000
Message-ID: <20090304195727.GD7680@sirena.org.uk>
References: <20090304004925.530566010@fluff.org.uk>
	<20090304005139.164366737@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 39D77103880
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 20:57:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090304005139.164366737@fluff.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-alsa@fluff.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 12:49:32AM +0000, Ben Dooks wrote:

> Add checks to see if wmXXXX_reset() failed and notify
> the user of the problem. This is generally due to a
> problem on the i2c bus such as an un-powered or 
> non-connected codec.

This doesn't apply against the current branch (and similar changes have
already been merged anyway).
