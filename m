From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [2.6.29-rc3][PATCH 1/1] ASoC: OMAP: Initialize
 XCCR and RCCR registers in McBSP DAI driver
Date: Thu, 29 Jan 2009 15:38:58 +0200
Message-ID: <20090129153858.3e81b133.jarkko.nikula@nokia.com>
References: <1233228586-8894-1-git-send-email-jarkko.nikula@nokia.com>
	<1233228586-8894-2-git-send-email-jarkko.nikula@nokia.com>
	<20090129132352.GA12179@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C6D010387F
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 14:40:36 +0100 (CET)
In-Reply-To: <20090129132352.GA12179@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ext Lopez Cruz, Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 29 Jan 2009 14:23:54 +0100
ext Mark Brown <broonie@sirena.org.uk> wrote:

> On Thu, Jan 29, 2009 at 01:29:46PM +0200, Jarkko Nikula wrote:
> 
> > This patch requires a counterpart in OMAP McBSP driver before
> > to apply it. The required changes in McBSP were sent and approved
> > in linux-omap mailing list and patch is going upstream
> > (commit 3127f8f8595a064b3f1a1837fea2177902589ac3 from linux-omap-2.6
> > tree).
> 
> That is now in Linus' tree so applied, thanks.  I've corrected
> Misael's name since it had had the Nokia 'ext' added to it - might be
> worth checking that when using git am.

Oops, thanks for removing the ext part. I forgot to remove that usual
prefix added by our mail server :-)


Jarkko
