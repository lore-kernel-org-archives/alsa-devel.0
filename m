From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [PATCH v3] ASoC CS4270 codec device driver
Date: Tue, 31 Jul 2007 11:34:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0707311122470.15067@shell2.speakeasy.net>
References: <1185896812320-git-send-email-timur@freescale.com>
	<s5h4pjkva0g.wl%tiwai@suse.de> <46AF5F7C.5020309@freescale.com>
	<s5h3az4v97m.wl%tiwai@suse.de> <s5hy7gwttzp.wl%tiwai@suse.de>
	<46AF6648.5000803@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.sea5.speakeasy.net (mail3.sea5.speakeasy.net
	[69.17.117.5]) by alsa0.perex.cz (Postfix) with ESMTP id 8A4CB1037F8
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Jul 2007 20:34:40 +0200 (CEST)
In-Reply-To: <46AF6648.5000803@freescale.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 31 Jul 2007, Timur Tabi wrote:
> Takashi Iwai wrote:
> > Also,
> >
> > #ifdef CONFIG_I2C
> >
> > isn't enough.  It should be
> >
> > #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
>
> I asked about that a while ago, and I never got an answer.  Where does CONFIG_I2C_MODULE
> come from?  I don't see it in any Kconfig or any header file.  And if I2C can be a module,
> then why wouldn't CONFIG_I2C also be defined?

If config FOO is compiled in (i.e.  it's "y"), CONFIG_FOO will be defined.
If it's a module, CONFIG_FOO_MODULE will be defined.  It's one or the
other, not both.

If you want your code to comple differently if it has i2c available, you should
do this:

#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
/* code that needs i2c goes here, i2c_transfer(), etc. */
#endif

Note that just checking defined(CONFIG_I2C_MODULE) isn't correct.  If your
code is compiled in and i2c is a module, you can't call i2c functions or
the kernel won't link.

Of course, if you need i2c to work in any reasonble way, you should just
have your driver depend on i2c in Kconfig.
