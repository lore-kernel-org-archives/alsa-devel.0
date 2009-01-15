From: Hugo Villeneuve <hugo@hugovil.com>
Subject: Re: [PATCH 1/1] ASoC: Fix compilation error with
 davinci-sffsdr module
Date: Thu, 15 Jan 2009 14:54:54 -0500
Message-ID: <20090115145454.17178d53.hugo@hugovil.com>
References: <1231277025-2100-1-git-send-email-hugo@hugovil.com>
	<20090106213116.GA3549@sirena.org.uk>
	<20090106164120.bd2fb16b.hugo@hugovil.com>
	<20090106220005.GB3549@sirena.org.uk>
	<20090114155406.a086c6ef.hugo@hugovil.com>
	<20090115111806.GB2147@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 5632010381B
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 20:54:57 +0100 (CET)
In-Reply-To: <20090115111806.GB2147@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Thu, 15 Jan 2009 11:18:07 +0000
Mark Brown <broonie@sirena.org.uk> wrote:

> ")
> Fcc: +sent-mail
> =

> On Wed, Jan 14, 2009 at 03:54:06PM -0500, Hugo Villeneuve wrote:
> > Mark Brown <broonie@sirena.org.uk> wrote:
> =

> > > Speaking as the person who I expect most frequently tries that I =

> > > wouldn't worry about it - it's easy enough to see what's happened
> > > and there will still be errors at link time even with the extern.
> =

> > No, there won?t be errors when compiling as a module. Only when
> > actually loading the module.
> =

> Check again - the kernel will detect those errors at build time.  The
> module itself will compile but once all the modules are built Kbuild
> verifies that all the symbols they use can be found.

Hi Mark,
I just checked again and at first I tought you were wrong :)

Just to be sure, I cloned a fresh copy of linux-davinci-git kernel.
This tree doesn=B4t have the SFFSDR FPGA module with the
sffsdr_fpga_set_codec_fs() function.

If I compile this tree as is for the SFFSDR board, I sure have the
error for the missing header file <asm/plat-sffsdr/sffsdr-fpga.h>,
containing the declaration for the function sffsdr_fpga_set_codec_fs.
But if I remove the #include for that header file and add the following
extern declaration:

  extern int sffsdr_fpga_set_codec_fs(int fs);

I can successfully compile the whole kernel and all the selected
modules without any errors.

But in fact you were right, because I just found out that someone has
added the following check to sffsdr_init() in davinci-sffsdr.c:

        if (!machine_is_sffsdr())
                return -EINVAL;

For a reason that I don=B4t yet understand, that function doesn=B4t seem to
be defined (always return 0) and so gcc has correctly optimised my
module by removing the sffsdr_hw_params function, and thus also
removing the call to my sffsdr_fpga_set_codec_fs function, and this is
why Kbuild never complained!

> > > That's good news - previously it would fail to build at all.  What
> > > sort of breakage are you seeing (and what was the version you used
> > > when you developed the driver)?
> =

> > I developped the driver with version
> > 2.6.27-rc6-davinci1-05187-g91c2c53.
> =

> > The breakage I see when I run the aplay utility is this:
> =

> >   aplay: pcm_write:1394: write error: Input/output error
> =

> > davinci-git version is the latest as of january 14
> > (2.6.28-davinci1-06546-gcfb152b)
> =

> Hrm, OK.  That's not terribly informative - does the error get
> reported after about 10 seconds by any chance?  I suspect that DMA
> just isn't happening.

Sorry about the non-verbosity :)
Yes it happens almost exactly after 10 seconds. I=B4m not an expert with
audio nor DMA, but can you indicate me where I should be looking for
signs of trouble (which source files for example)?

Thank-you, Hugo.

---------------
Hugo Villeneuve
www.hugovil.com
---------------
