From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: asoc tsc210x
Date: Fri, 25 Apr 2008 10:35:31 +0100
Message-ID: <1209116131.3286.133.camel@localhost.localdomain>
References: <B9D3C48C98930741A166756A50C44A610F17B3B5@helx1.corp.vaisala.com>
	<bd7b27490804250201t66eed57bw7201a0ceea6ea7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ECEDD2475B
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 11:35:32 +0200 (CEST)
In-Reply-To: <bd7b27490804250201t66eed57bw7201a0ceea6ea7c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-jukka.hynninen@vaisala.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2008-04-25 at 12:01 +0300, Jarkko Nikula wrote:
> On Fri, Apr 25, 2008 at 10:05 AM, <ext-jukka.hynninen@vaisala.com> wrote:
> 
> > Hello all,
> >
> > I'm assessing TSC2100 codec on an embdedded system.
> >
> > Any intentions on implementing an ASoC codec driver for TSC210x family?
> 
> 
> I'm not aware, but in linux-omap there are some non-ASoC and touchscreen
> implementations for them.
> 
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=tree;f=sound/arm/omap;h=06529db6de88ab1cdd08807706e71ef5d1b764dd;hb=HEAD
> 
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=tree;f=drivers/input/touchscreen;h=e48f7c3a3e2a1c77f52f6886e96658a2e43534a2;hb=HEAD
> 
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=tree;f=drivers/spi;h=4b16fb8682fdc018297e4a329689b537e77f3971;hb=HEAD
> 
> Could the multi-function nature of the chip raise some issues with ASoC
> > framework?
> >
> 
> Probably. E.g. in TSC2301 the touchscreen subsystem starts using audio MCLK
> input whenever the audio subsystem is powered on and some internal clock
> otherwise. So there can always be some undocumented subsystem dependencies.

Fwiw, we have handled a multi function PMIC with RTC, watchdog,
backlight, audio, regulator, LED and audio drivers under ASoC here :-

http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-audioplus.git;a=blob;f=sound/soc/imx/imx32ads-wm8350.c;h=026c48dfad3b6203a82948e47500eb72e2f81c8c;hb=imx31

All client drivers (including audio) are handled via a bus manager in
order to manage IO and generic device functions e.g. irq's

http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-audioplus.git;a=blob;f=drivers/regulator/wm8350/reg-wm8350-bus.c;h=9878a92d9368d462f94e392a4baafe88d2a31a8d;hb=imx31

The ASoC driver just becomes another client of the multi function device
bus manager.

HTH

Liam
