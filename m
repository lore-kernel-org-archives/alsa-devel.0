From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [RFC][ASoC] New device/driver arch
Date: Fri, 15 Jun 2007 16:36:38 +0100
Message-ID: <1181921798.26658.77.camel@localhost.localdomain>
References: <1181842832.26658.42.camel@localhost.localdomain>
	<d35cec70706150801p2cd29fa4lbd2718048c461f5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id B798D103890
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 17:36:40 +0200 (CEST)
In-Reply-To: <d35cec70706150801p2cd29fa4lbd2718048c461f5b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seth Forshee <seth.forshee@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>, Nobin Mathew <nobin.mathew@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-06-15 at 10:01 -0500, Seth Forshee wrote:
> Hi Liam,
> 
> On 6/14/07, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
> 
> > Example machine driver for Mainstone with WM8753 is here :-
> >
> > http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=blob;f=sound/soc/pxa/mainstone_wm8753.c;h=a49c1c528063494aeadee26ea3e07405c3a8762e;hb=ppc-dev
> >
> > The machine driver now also does the I2C/SPI probing (instead of the
> > codec) and also does any codec IO (to better support multiple
> > controllers).
> >
> 
> The way in which the platform device is created in this file seems to
> have a problem.  The mainstone_wm8753_probe() function (along
> everything else after that point) seems to expect that the platform
> device will be encapsulated in a struct snd_soc_machine, but this
> doesn't seem to be the case since you are instantiating the device
> with platform_driver_probe().  Am I missing something?

Your right. This is a bug. Will fix.

Thanks

Liam
