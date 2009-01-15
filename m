From: Hugo Villeneuve <hugo@hugovil.com>
Subject: Re: [PATCH 1/1] ALSA: ASoC: DaVinci: Fix SFFSDR init
 bug.
Date: Thu, 15 Jan 2009 16:02:57 -0500
Message-ID: <20090115160257.f35c440d.hugo@hugovil.com>
References: <20090108121613.1ef53112.hugo@hugovil.com>
	<1232051992-31817-1-git-send-email-hugo@hugovil.com>
	<20090115205748.GJ12768@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id B2CEF103890
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 22:02:59 +0100 (CET)
In-Reply-To: <20090115205748.GJ12768@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Thu, 15 Jan 2009 20:57:53 +0000
Mark Brown <broonie@sirena.org.uk> wrote:

> On Thu, Jan 15, 2009 at 03:39:52PM -0500, Hugo Villeneuve wrote:
> > Removed call to machine_is_sffsdr() in module init
> > function because it always returns zero and causes
> > GCC to optimise and remove all functions of the module.
> 
> > Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>
> 
> This should be replaced with the appropriate machine_is_() call for
> the system.

It is the appropriate call, but at compile time it always return false.

Hugo.

---------------
Hugo Villeneuve
www.hugovil.com
---------------
