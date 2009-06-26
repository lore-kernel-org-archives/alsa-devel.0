From: Aditya Shankar <mc.aditya@gmail.com>
Subject: Re: IMX31 Audio Driver issue
Date: Fri, 26 Jun 2009 16:10:33 +0530
Message-ID: <24a2bfdf0906260340m209d3011ree920ee93889a34@mail.gmail.com>
References: <7df11cd50906250152u500a6a06ud7093d996c3e2b67@mail.gmail.com>
	<20090626094636.GC5415@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C6852481D
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Jun 2009 12:40:34 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id l33so267941rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2009 03:40:33 -0700 (PDT)
In-Reply-To: <20090626094636.GC5415@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Harish Kumar <harishkumarb7@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 26, 2009 at 3:16 PM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Thu, Jun 25, 2009 at 02:22:14PM +0530, Harish Kumar wrote:
>
> > Hi... playing on /dev/sound/adsp
> > (SSI1) Configuration : 16 8000 2
> > audio driver write error: Input/output error
> > audio driver write error: Input/output error a
>
> It looks like DMA is not happening.  Probably the problem is that the
> system clocking is wrong, most likely as a result of the audio clocking
> being wrong.  Check that you are seeing signals on the BCLK and LRCLK
> and that your audio mux setup is correct.
>
> You're probably better off asking whoever provided the BSP to you for
> support, there is no i.MX31 audio support in standard Linux.


Hi Harish,

check_audio.out was a test app to test the old OSS driver ( which by my
guess is no longer maintained on that platform) or the *OSS emulation *mode
supported by ALSA on i.mx31. Please check the clocks as Mark suggested. In
most of the cases I tried using I.mx31, the app wouldn't exit in cases where


1. Clock to the PMIC was not supplied.
2. Clock to the SSI was not OK.
3. The AUDMUX ports are not correctly configured.
4. The PMIC chip's bias was not enabled .

The drivers seem to be loaded properly from your log. Do not look for
"pmic_audio"  under /dev coz it's only a hardware abstraction layer and is
not registered as a char dev.

Thanks,
Aditya

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
