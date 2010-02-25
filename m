From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: issues porting codec to s3c2443
Date: Thu, 25 Feb 2010 16:10:04 -0600
Message-ID: <1267135804.13721.101.camel@heelrod.ad.cirrus.com>
References: <C171323BB93CB94897E300CBB6D4537F1D94251A@CLMSG-01.ad.cirrus.com>
	<20100224175419.GI9018@sirena.org.uk>
Reply-To: brian.austin@cirrus.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 0E4D31039A9
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 22:45:28 +0100 (CET)
In-Reply-To: <20100224175419.GI9018@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-02-24 at 17:54 +0000, Mark Brown wrote:
> On Wed, Feb 24, 2010 at 11:43:41AM -0600, Austin, Brian wrote:
> 
> > sure that I am missing something because of that.  The question is, is
> > it ok to submit the codec standalone and have someone look at it to make
> > sure I made the correct changes.  No compiler warnings occur.  My port
> > was based off of the WM8750 if that helps any
> 
> Yes, it's entirely normal to submit CODEC drivers that aren't referenced
> by any machine drivers in mainline - please just go ahead and do this.
> 
> > soc-audio soc-audio: RXEN: Invalid MODE in IISMOD
> 
> ...
> 
> > It seems that the S3C2412 I2S is not setup correctly for my platform.
> 
> It'd probably be easier for folks to help if you post your machine
> driver...
> 
I submitted the codec driver today, however with the changes in S3C for
audio, my machine driver panics the kernel.  Once I get that fixed up
I'll submit the machine driver.

Thanks,
Brian
