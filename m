From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA Control Interface - default values?
Date: Mon, 10 May 2010 16:31:57 +0100
Message-ID: <20100510153156.GA29568@rakim.wolfsonmicro.main>
References: <20100510133516.41930@gmx.net>
	<20100510135407.GF5199@sirena.org.uk>
	<20100510142507.41960@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 148C824796
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 17:31:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100510142507.41960@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Max Klein <mein_name@ist-einmalig.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 10, 2010 at 04:25:07PM +0200, Max Klein wrote:

> thanks for fast reply, may you tell me how the driver can set the defaults?

> EDIT: whoops, I guess it was an	error in reasoning from myself...as I have the control of all those variables outputted by the get and put callbacks, I just have to initialize those variables before initializing the control interface, right?

Yes, the driver just needs to make sure that whatever it uses to return
the current setting when queried is going to give the right answer from
the time the control is set up, normally by initialising variables
though if you're doing things like read data back from hardware then you
may be able to rely on the hardware defaults.

[Re-adding CC to alsa-devel - it's normal to do a reply to all for Linux
lists.]
