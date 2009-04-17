From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/1] ASoC: TWL4030: Constraint
	setting	rework
Date: Fri, 17 Apr 2009 14:38:46 +0100
Message-ID: <20090417133845.GC10992@sirena.org.uk>
References: <1239972908-4158-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 400992434A
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 15:38:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1239972908-4158-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 17, 2009 at 03:55:07PM +0300, Peter Ujfalusi wrote:

> Note that I'm not using the just introduced symmetric_rates feature of ASoC
> introduced by Mark Brown recently, since I think that also suffers from this
> problem (or not, I have to try it out first to be sure about it)

Yes, pretty much all the code to handle this sort of issue has that
problem in some form.  There's issues with the constraints not getting
seen in time - people had a look at it when we started doing constraints
like this properly.

The symmetric rate setting tries to cover it a bit by enforcing the last
constraint that was seen so you only get the zero problem on first open.
For a lot of applications this actually ends up doing the right thing,
though obviously it's not ideal.
