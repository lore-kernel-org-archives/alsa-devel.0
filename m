From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA AUDIOj support for PXA320
Date: Thu, 30 Sep 2010 22:22:00 -0700
Message-ID: <20101001052159.GN4175@opensource.wolfsonmicro.com>
References: <AANLkTinW0wQoeP3gm5bCZBJ27pJd5ubZ3S5Kq_Kaf6Cd@mail.gmail.com>
	<20100930165023.GC9431@sirena.org.uk>
	<AANLkTiniiGLVCSdc5cL+gWGHuaXuyC92t6=JSsMozFTE@mail.gmail.com>
	<20101001034947.GL4175@opensource.wolfsonmicro.com>
	<AANLkTi=fVO-tFn8z5JMCrL2VrX=aMX=JoBLj9W5wn5nz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 40EE91039BA
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 07:21:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=fVO-tFn8z5JMCrL2VrX=aMX=JoBLj9W5wn5nz@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sayiram K N <sayiram.kothuri@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 01, 2010 at 10:47:01AM +0530, Sayiram K N wrote:
> when i tried to use the PXA2xx specific driver for PXA3xx  there are errors
> pointing to PXA3xx. i will capture the error and will publish here.
> thanks

Please stop top posting.  Please also note that the 2.6.29 kernel is
extremely old - if there are problems your most useful course of action
if you can't upgrade to something current will be to look at the current
kernel version and backport any changes which are required to fix the
AC'97 support to that kernel.
