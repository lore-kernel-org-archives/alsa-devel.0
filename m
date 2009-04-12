From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] General fix for Palm27x aSoC driver
Date: Sun, 12 Apr 2009 19:00:29 +0100
Message-ID: <20090412180028.GB8209@sirena.org.uk>
References: <200904121858.42931.marek.vasut@gmail.com>
	<20090412170626.GD4295@sirena.org.uk>
	<200904121920.15488.marek.vasut@gmail.com>
	<200904121924.24781.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 91AA6103815
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Apr 2009 20:00:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904121924.24781.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 12, 2009 at 07:24:24PM +0200, Marek Vasut wrote:
> On Sunday 12 of April 2009 19:20:15 Marek Vasut wrote:
> > On Sunday 12 of April 2009 19:06:26 Mark Brown wrote:j

> > > No, the WM9712 is not a platform device.

> btw mio_a701 uses it the same way ... why can I ? Why was the mio code merged 
> then?

mio_a701 is buggy, the device should be removed from there.  I didn't
review that code so didn't have a chance to notice that the device was
there.
