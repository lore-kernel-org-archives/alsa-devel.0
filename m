From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] regulator: Allow modular build
	of	mc13xxx-core
Date: Wed, 15 Dec 2010 14:09:56 +0000
Message-ID: <20101215140956.GG5723@sirena.org.uk>
References: <1292421973-27410-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 522E610385A
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 15:09:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1292421973-27410-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 15, 2010 at 02:06:13PM +0000, Mark Brown wrote:
> Since the MFD core for this device and the regulator drivers for these
> devices can be built modular we should also support modular build of
> the shared code for the regulator drivers, otherwise we try to link
> built in code against modular code with unfortunate results.

Bash history has done something odd here, sorry.
