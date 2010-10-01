From: Sayiram K N <sayiram.kothuri@gmail.com>
Subject: Re: ALSA AUDIOj support for PXA320
Date: Fri, 1 Oct 2010 10:47:01 +0530
Message-ID: <AANLkTi=fVO-tFn8z5JMCrL2VrX=aMX=JoBLj9W5wn5nz@mail.gmail.com>
References: <AANLkTinW0wQoeP3gm5bCZBJ27pJd5ubZ3S5Kq_Kaf6Cd@mail.gmail.com>
	<20100930165023.GC9431@sirena.org.uk>
	<AANLkTiniiGLVCSdc5cL+gWGHuaXuyC92t6=JSsMozFTE@mail.gmail.com>
	<20101001034947.GL4175@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 456B21039B8
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 07:17:03 +0200 (CEST)
Received: by pwj2 with SMTP id 2so956389pwj.38
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 22:17:02 -0700 (PDT)
In-Reply-To: <20101001034947.GL4175@opensource.wolfsonmicro.com>
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

when i tried to use the PXA2xx specific driver for PXA3xx  there are errors
pointing to PXA3xx. i will capture the error and will publish here.
thanks

On Fri, Oct 1, 2010 at 9:19 AM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Oct 01, 2010 at 08:58:45AM +0530, Sayiram K N wrote:
> > what i mean is under sound/soc/pxa/ i can see only pxa2xx-ac97 file but
> not
> > the sound/soc/pxa/pxa3xx-ac97 files which are required for pxa320.
>
> The IP is the same for both PXA2xx and PXA3xx so the same driver is
> used.
>
