From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 20:58:05 -0400
Message-ID: <9e4733910806161758l55429b08o645c0a040dd2fdad@mail.gmail.com>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>
	<1213612755.6599.51.camel@odin>
	<9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>
	<4856776B.7040300@freescale.com>
	<9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>
	<20080616150337.GB22229@sirena.org.uk>
	<9e4733910806160853o2970f281m239712d8a2619e91@mail.gmail.com>
	<48568E60.10206@freescale.com>
	<9e4733910806160923u1e7b3688tba4af776db2ddeef@mail.gmail.com>
	<485693BA.9010801@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F13124492
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jun 2008 02:58:07 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so2812478ywk.2
	for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2008 17:58:06 -0700 (PDT)
In-Reply-To: <485693BA.9010801@freescale.com>
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
To: Timur Tabi <timur@freescale.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 6/16/08, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
>
>  > The driver stays in sound/soc/fsl. It's only the creation of the
>  > device that moves. You just need to add this to
>  > arch/powerpc/platforms/86xx/mpc8610_hpcd.c and remove it from
>  > mpc8610_hpcd.c. Adding this to
>  > arch/powerpc/platforms/86xx/mpc8610_hpcd.c will have no effect if the
>  > mpc8610_hpcd.c driver is not to be found.
>
>
> Ok, I'll do that.

The architecture still doesn't appear right to me. fsl-dma.c is
another driver that is self-creating its own device. We can certainly
add code to arch/powerpc/platforms/86xx/mpc8610_hpcd.c to create a
"fsl-elo" device, but it's another fake device. Plus there's already a
driver for the real "fsl,eloplus-dma" hardware in the system. Needing
to create fake devices is a sign that the design is not correct. dma
support should probably be a library that is linked into the ssi
driver and not be a standalone device driver.

I'm going to be gone for a week with no email. When I get back I'll
work on where to do snd_soc_card_create("MPC8610"). If you do it in
the fabric driver, then the fabric driver can never be optional.  But
if you don't do it in the fabric driver, how does the fabric driver
find the soc_card? There's no call to retrieve the soc_card for
"MPC8610".

>
>
>  > You've complicated it by creating two fabric devices but I believe
>  > your code could be changed to only make one.
>  >
>  > static struct platform_device alsa_fabric = {
>  >       .name           = "MPC8610HPCD",
>  >       .id             = -1,
>  > };
>  >
>  > static struct platform_device *devices[] = {
>  >       &alsa_fabric,
>  > };
>  >
>  > platform_add_devices(&devices[0], ARRAY_SIZE(devices));
>  >
>  >
>  > I'd rename the driver to something less generic.
>  >       .name           = "MPC8610HPCD-fabric",
>
>
> These are all good ideas.  Thanks.
>
>
>  --
>
> Timur Tabi
>  Linux kernel developer at Freescale
>


-- 
Jon Smirl
jonsmirl@gmail.com
