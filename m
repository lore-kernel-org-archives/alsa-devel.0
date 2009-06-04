From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: fix NULL pointer
	dereference	in soc_suspend()
Date: Thu, 4 Jun 2009 13:25:44 +0100
Message-ID: <20090604122543.GB11496@sirena.org.uk>
References: <1244043889-3024-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D63B9103928
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 14:25:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1244043889-3024-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2009 at 05:44:49PM +0200, Daniel Mack wrote:
> In case the initalization of an soc_device failed, there is no codec
> associated with it. soc_suspend() will still dereference the pointer
> and cause an Ooops when entering the sleep mode.
> 
> This happens on our board with a multi-target kernel image when booted
> on a machine without audio circuits.
> 
> This patch makes the code bail out very early in this special case.

A better fix would be to stop the device registering at all if the
initialsation fails but that's a bit more involved and in the meantime
this makes the situation better.  Probably best to wait for the real fix
until multiple cards are supported.

Thanks, I've applied this.
