From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Thu, 24 Sep 2009 22:53:44 -0700
Message-ID: <20090925055338.GA4438@sirena.org.uk>
References: <E1Mqrlf-0002YF-9O@amazonia.comcast.net>
	<E1MqwwK-0004BR-Kz@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s-utl01-sjpop.stsn.net (s-utl01-sjpop.stsn.net [72.254.0.201])
	by alsa0.perex.cz (Postfix) with SMTP id 3577D1037E3
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 07:54:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <E1MqwwK-0004BR-Kz@amazonia.comcast.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rick Bronson <rick@efn.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 24, 2009 at 03:37:28PM -0700, Rick Bronson wrote:

>   Also noticed that the beagleboard is getting DMA interrupts when I
> "aplay":

> cat /proc/interrupts | grep DMA

>  12:       4646        INTC  DMA   

That's just the same symptom - the I/O error that aplay reports is a
lack of interrupts reporting that audio is moving through the system.

>   but I'm not.  As I mentioned, I'm at "2.6.29-rc3-omap1", anyone
> think there is a problem with pcm DMA's in that version?
