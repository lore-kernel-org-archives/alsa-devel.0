From: "Seth Forshee" <seth.forshee@gmail.com>
Subject: Re: [RFC][ASoC] New device/driver arch
Date: Fri, 15 Jun 2007 10:01:12 -0500
Message-ID: <d35cec70706150801p2cd29fa4lbd2718048c461f5b@mail.gmail.com>
References: <1181842832.26658.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 8114C10388C
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 17:01:14 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so887965nzf
	for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2007 08:01:13 -0700 (PDT)
In-Reply-To: <1181842832.26658.42.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>, Nobin Mathew <nobin.mathew@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Liam,

On 6/14/07, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:

> Example machine driver for Mainstone with WM8753 is here :-
>
> http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=blob;f=sound/soc/pxa/mainstone_wm8753.c;h=a49c1c528063494aeadee26ea3e07405c3a8762e;hb=ppc-dev
>
> The machine driver now also does the I2C/SPI probing (instead of the
> codec) and also does any codec IO (to better support multiple
> controllers).
>

The way in which the platform device is created in this file seems to
have a problem.  The mainstone_wm8753_probe() function (along
everything else after that point) seems to expect that the platform
device will be encapsulated in a struct snd_soc_machine, but this
doesn't seem to be the case since you are instantiating the device
with platform_driver_probe().  Am I missing something?

Cheers,
Seth
