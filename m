From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [PATCH] [ALSA] mpc8610: Add mmap support
Date: Thu, 17 Jan 2008 13:40:23 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0801171316070.16628@shell2.speakeasy.net>
References: <12005823754197-git-send-email-timur@freescale.com>
	<478F8129.5030408@gmail.com> <478F82E9.1050809@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail6.sea5.speakeasy.net (mail6.sea5.speakeasy.net
	[69.17.117.8]) by alsa0.perex.cz (Postfix) with ESMTP id 30A56246B9
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 22:40:27 +0100 (CET)
In-Reply-To: <478F82E9.1050809@freescale.com>
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
Cc: alsa-devel@alsa-project.org, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 17 Jan 2008, Timur Tabi wrote:
> Alexander E. Patrakov wrote:
> > Timur Tabi wrote:
> >> Enable mmap support in the MPC8610 ASoC driver.  The driver can use
> >> ALSA's
> >> default mmap functionality, it was just not enabled previously.
> >>
> >> Signed-off-by: Timur Tabi <timur@freescale.com>
> >
> > [sorry, I may be completely wrong below about the .page callback purpose
> > - in this case, just confirm that the testcase works]
> >
> > Hm, the "struct snd_pcm_ops fsl_dma_ops" doesn't contain the .page
> > callback. With saa7134-alsa, this led to the "device claims to support
> > mmap but actually doesn't work" bug, see the following subthread:
>
> Isn't that an ARM chip?  The default MMAP handler in ALSA doesn't support ARM,
> but it works for PowerPC.

Alexander is talking about the same thing I was in my previous message to
you.  saa7134, like cx88-alsa, uses vmalloc instead of ALSA to allocate the
DMA buffer, and so a special page callback is needed.

> I haven't tried record, but I did try playback, and it worked.  Without this
> patch, adding -M gives me this error:
>
> aplay: set_params:852: Access type not available
>
> After applying this patch, playback works fine.

The key thing to know is that you will not get an error message if your
page callback is wrong!  Everything will appear to work.  You just won't
hear any sound.
