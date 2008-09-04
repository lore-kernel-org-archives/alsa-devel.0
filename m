From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: snd-soc-cs4270: Convert to a new-style i2c driver
	(work in progress)
Date: Thu, 4 Sep 2008 11:42:24 +0100
Message-ID: <20080904104224.GE13828@sirena.org.uk>
References: <20080831161843.227b31f3@hyperion.delvare>
	<ed82fe3e0808310928v18eed8bdh98faa6796a516142@mail.gmail.com>
	<20080831190928.2931b0ed@hyperion.delvare>
	<ed82fe3e0809031247t3085e409x3141f9712ad962a9@mail.gmail.com>
	<ed82fe3e0809031330s5036e9d0g1c2b3e73096f2a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DB7A24371
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 12:55:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ed82fe3e0809031330s5036e9d0g1c2b3e73096f2a6@mail.gmail.com>
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
Cc: Jean Delvare <khali@linux-fr.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 03, 2008 at 03:30:33PM -0500, Timur Tabi wrote:
> On Wed, Sep 3, 2008 at 2:47 PM, Timur Tabi <timur@freescale.com> wrote:

> > I'm working on a fix for this, but there's something you need to know.
> >  I don't think ASoC V1 modules can be unloaded.

> Correction: ASoC drivers can't be compiled as modules, not even the
> codec drivers.  I had to hack up the Kconfigs to get this to work, but

They can be - I do this on a regular basis during development.  If it
weren't possible I'd probably get annoyed enough to make it so :)

> there is no way to compile the drivers as modules.  If you try, you
> get this:

>   CC [M]  sound/soc/codecs/cs4270.o
>   LD [M]  sound/soc/codecs/snd-soc-cs4270.o
> ...
> sound/built-in.o: In function `mpc8610_hpcd_probe':
> /temp/alsa.1994/sound/soc/fsl/mpc8610_hpcd.c:455: undefined reference
> to `cs4270_dai'

If you build the codec driver as a module then you also need to build
the machine driver as a module.  Your Kconfig ought to be enforcing
that which I guess is the hack you had to put in?
