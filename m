From: Felipe Pena <felipensp@gmail.com>
Subject: Re: [PATCH v2] sound: soc: fsl: Fix memory leak in imx-audmux.c
Date: Mon, 14 Oct 2013 09:05:44 -0300
Message-ID: <CA+5g0SJGMy+XJw91uE6doidbjiPJrwXdgSkidZHCfP4L=Xx7dg@mail.gmail.com>
References: <1381617306-18764-1-git-send-email-felipensp@gmail.com> <20131014115937.GR2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131014115937.GR2443@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Fabio Estevam <fabio.estevam@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, Bill Pemberton <wfp5p@virginia.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Oct 14, 2013 at 8:59 AM, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Oct 12, 2013 at 07:35:06PM -0300, Felipe Pena wrote:
>> When audmux_clk is used and clk_prepare_enable function succeed,
>> the memory alloc'd to buf variable is leaked
>
> Applied, thanks.  Please try to use subject lines appropriate for the
> subsystem and keep your CC lists focused - you want to send to
> maintainers and people working on the specific code but it's best to
> avoid people working on tree wide cleanups like Bill so they don't get
> too much spam.

Thanks guys for accepting the patch. Sorry for inconvenience about the
subject line.

About the CC list I just use the one that I get from scripts/get_maintainer.pl.

-- 
Regards,
Felipe Pena
