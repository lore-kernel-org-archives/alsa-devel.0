From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [2.6.29-rc3][PATCH 1/1] ASoC: OMAP:
	Initialize	XCCR and RCCR registers in McBSP DAI driver
Date: Thu, 29 Jan 2009 13:23:54 +0000
Message-ID: <20090129132352.GA12179@sirena.org.uk>
References: <1233228586-8894-1-git-send-email-jarkko.nikula@nokia.com>
	<1233228586-8894-2-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 421AB24435
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 14:24:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233228586-8894-2-git-send-email-jarkko.nikula@nokia.com>
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
Cc: alsa-devel@alsa-project.org, "ext Lopez Cruz, Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 29, 2009 at 01:29:46PM +0200, Jarkko Nikula wrote:

> This patch requires a counterpart in OMAP McBSP driver before
> to apply it. The required changes in McBSP were sent and approved
> in linux-omap mailing list and patch is going upstream
> (commit 3127f8f8595a064b3f1a1837fea2177902589ac3 from linux-omap-2.6
> tree).

That is now in Linus' tree so applied, thanks.  I've corrected Misael's
name since it had had the Nokia 'ext' added to it - might be worth
checking that when using git am.
