From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Using ARRAY_SIZE macro when setting up ASoC audio
	map?
Date: Wed, 27 Feb 2008 22:01:22 +0000
Message-ID: <20080227220121.GA5414@sirena.org.uk>
References: <20080227134923.aa37870c.jarkko.nikula@nokia.com>
	<20080227123416.GA8730@sirena.org.uk>
	<20080227151151.547a3669.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AC931243F4
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 23:01:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080227151151.547a3669.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 27, 2008 at 03:11:51PM +0200, Jarkko Nikula wrote:

> Ok. Probably not worth to change now to n different drivers but worth
> to take into account when reviewing new ones or doing some other
> cleanups.

For ASoC v2 we've been adding bulk registration functions for everything
which should encourage that.  This hasn't been done for paths yet but
that should be done shortly.
