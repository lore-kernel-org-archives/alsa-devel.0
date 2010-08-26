From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ice1712 and the delta 1010
Date: Thu, 26 Aug 2010 16:55:32 +0200
Message-ID: <4C768064.5050207@ladisch.de>
References: <20100826065854.519ee1d3@debussy>	<4C7665CC.5080302@ladisch.de>
	<20100826092713.3debd6c1@debussy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0F549103854
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 16:55:32 +0200 (CEST)
In-Reply-To: <20100826092713.3debd6c1@debussy>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Santamauro <david.santamauro@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

David Santamauro wrote:
> Clemens Ladisch <clemens@ladisch.de> wrote:
> > Does the 32-bit Linux use the same driver version?
> 
> To be honest, I'm not sure exactly how to check. They are the latest
> versions of fedora 11 (32-bit) and fedora 12 (64-bit).

> Linux beethoven 2.6.29.6-1.rt23.4.fc11.ccrma.i586.rt
> Linux debussy 2.6.31.12-1.rt21.1.fc12.ccrma.x86_64.rt

That's different.

> > If yes, then it's possible that the 32-bit and 64-bit kernels
> > configure the PC differently; for example, there might be noise on
> > the power line due to a different kind of power management.
> 
> another interesting angle... I thought it might be power or some kind
> of internal noise. How could I pursue that further?

Try running something on all CPU cores so that it doesn't switch into
power saving mode.


Regards,
Clemens
