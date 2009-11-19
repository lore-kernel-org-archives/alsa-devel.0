From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: i.MX audio support
Date: Thu, 19 Nov 2009 18:54:27 +0000
Message-ID: <20091119185426.GA2814@sirena.org.uk>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<20091119162830.GA31336@rakim.wolfsonmicro.main>
	<20091119175327.GV30179@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8443010385E
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 19:54:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091119175327.GV30179@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, javier.martin@vista-silicon.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 19, 2009 at 06:53:27PM +0100, Sascha Hauer wrote:

> My work isn't based on the mainline driver but some older (also
> Freescale based) code. Putting this into an incremental series would
> mean quite some work.

That's not really my point - my point is that one way or another the new
code needs to update the existing code.  I don't want to end up in a
situation where we have two different drivers in mainline since that
will create user confusion and a greater maintinence burden.  I'm not so
fussed about how exactly that is achieved.
