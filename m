From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound/soc/codecs: Add support for
	the	wm8727 DAC.
Date: Mon, 2 Nov 2009 13:25:15 +0000
Message-ID: <20091102132514.GA6840@sirena.org.uk>
References: <91f916b90911020354s7f22d0a8pba2ac82525663d8e@mail.gmail.com>
	<20091102120942.GI29351@sirena.org.uk>
	<91f916b90911020521p2cd1d001y5bdd44a4cdfe0642@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 354CE1038AC
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 14:25:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <91f916b90911020521p2cd1d001y5bdd44a4cdfe0642@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Neil Jones <neiljay@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 02, 2009 at 01:21:01PM +0000, Neil Jones wrote:
> On Mon, Nov 2, 2009 at 12:09 PM, Mark Brown <
> broonie@opensource.wolfsonmicro.com> wrote:

> > Please remember to CC maintainers on patches, this helps avoid them
> > getting missed on busy mailing lists.

>   Ok no probs, are you the maintainer ?

For ASoC, yes.  See the MAINTAINERS file in the kernel for a full list,
scripts/get_maintainer.pl might help though it does bring up false
positives.

> > There are some hints on MUA configuration in
> > Documentation/email-clients.txt
> > which might help.  If all else fails an attachment (without a copy of
> > the patch in the body of the mail) usually works.

>    Again ok, I've tried my gmail acount this time, as i have similar problem
> with
>    patches sent via exchange.

gmail mangles patches if you use the web interface, you'll need to
either submit over SMTP (eg, with git send-email) or use an attachment
if you're using the web interface.
