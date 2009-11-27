From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: sh: fsi: Add runtime
	PM	support
Date: Fri, 27 Nov 2009 11:06:57 +0000
Message-ID: <20091127110656.GA29512@sirena.org.uk>
References: <ud43sjtaf.wl%morimoto.kuninori@renesas.com>
	<20091109105858.GB1245@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A428103922
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2009 12:07:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091109105858.GB1245@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Magnus Damm <damm@igel.co.jp>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 09, 2009 at 10:58:58AM +0000, Mark Brown wrote:
> On Mon, Nov 09, 2009 at 11:54:47AM +0900, Kuninori Morimoto wrote:

> > +	pm_suspend_ignore_children(&pdev->dev, true);
> > +	pm_runtime_enable(&pdev->dev);
> > +	pm_runtime_resume(&pdev->dev);

> Why pm_suspend_ignore_all_children()?  I'd not expect the device to have
> any children and if it did it doesn't seem like an entirely safe
> assumption.

I've not yet seen any response to this query?
