From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ALSA calling pcm_pointer excessively?
Date: Thu, 10 May 2012 19:18:49 +0100
Message-ID: <20120510181849.GF12727@n2100.arm.linux.org.uk>
References: <20120510160601.GC12727@n2100.arm.linux.org.uk>
	<20120510162930.GA17361@n2100.arm.linux.org.uk>
	<4FABF574.7090804@ladisch.de> <4FABF757.8080505@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 145F910BAE3
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 20:19:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4FABF757.8080505@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 10, 2012 at 07:13:59PM +0200, Clemens Ladisch wrote:
> I wrote:
> > This (untested) patch tries to avoid too many busy looping.
> 
> Oops, off-by-one error (avail == avail_min should not wait).

This is better - it now sits around 2-14% system time.  I guess the
five loops is rather arbitary?
