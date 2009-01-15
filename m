From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ALSA: ASoC: DaVinci: Fix SFFSDR init
	bug.
Date: Thu, 15 Jan 2009 21:09:12 +0000
Message-ID: <20090115210908.GK12768@sirena.org.uk>
References: <20090108121613.1ef53112.hugo@hugovil.com>
	<1232051992-31817-1-git-send-email-hugo@hugovil.com>
	<20090115205748.GJ12768@sirena.org.uk>
	<20090115160257.f35c440d.hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E667103890
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 22:09:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090115160257.f35c440d.hugo@hugovil.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 15, 2009 at 04:02:57PM -0500, Hugo Villeneuve wrote:
> On Thu, 15 Jan 2009 20:57:53 +0000
> Mark Brown <broonie@sirena.org.uk> wrote:

> > This should be replaced with the appropriate machine_is_() call for
> > the system.

> It is the appropriate call, but at compile time it always return false.

Sounds like that should be fixed instead, then?
