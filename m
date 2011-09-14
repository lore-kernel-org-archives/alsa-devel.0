From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: OSS emulation and hardware configuration
Date: Thu, 15 Sep 2011 00:23:16 +0100
Message-ID: <20110914232316.GA2953@opensource.wolfsonmicro.com>
References: <CA+jNppn4QPrNb_Jg00En1WZ0Gp97fJzfrFC9DCY2Qa6u004ymg@mail.gmail.com>
	<20110914161306.GA22952@sirena.org.uk>
	<CA+jNppnR+J58vp-7Q0Nd6DY4-Y1gfzZ6kCfCNE1WCGdddROzQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4B97D24513
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 01:23:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CA+jNppnR+J58vp-7Q0Nd6DY4-Y1gfzZ6kCfCNE1WCGdddROzQg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Crowe <drmikecrowe@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 14, 2011 at 12:27:05PM -0400, Mike Crowe wrote:
> On Wed, Sep 14, 2011 at 12:13 PM, Mark Brown

> > It should go through the ASoC core; it's possible that you've not
> > hooked things up properly there.

> Very possible.  Based on Sean's reply, I may want to disable OSS
> emulation and look at a userspace solution.

Yes, in general OSS emulation is a very bad move and less and less
supported by the kernel.
