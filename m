From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH]ASoC: Create a common directory for AVR32
	and ARM9 atmel boards.
Date: Mon, 6 Oct 2008 15:27:18 +0100
Message-ID: <20081006142716.GB19835@sirena.org.uk>
References: <20081002181211.GA3345@sirena.org.uk> <48E613BB.6090003@atmel.com>
	<20081003131411.GC26035@sirena.org.uk> <48E62A89.8070803@atmel.com>
	<20081003143523.GE26035@sirena.org.uk>
	<20081003164901.7ebddcd9@hskinnemo-gx745.norway.atmel.com>
	<48E63158.9020708@atmel.com>
	<20081003170613.65c5ffd3@hskinnemo-gx745.norway.atmel.com>
	<48E6365A.6060803@atmel.com>
	<20081006161738.2059f19d@hskinnemo-gx745.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D8A924468
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Oct 2008 16:27:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081006161738.2059f19d@hskinnemo-gx745.norway.atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org, Geoffrey Wossum <geoffrey@pager.net>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 06, 2008 at 04:17:38PM +0200, Haavard Skinnemoen wrote:
> Sedji Gaouaou <sedji.gaouaou@atmel.com> wrote:

> > But you will still need to apply the patch where I removed all at32 and 
> > at91 directories([alsa-devel] [PATCH]ASoC: Remove at91 and at32 
> > directories).

> Can you please just send me the whole bunch so that I know what we're
> talking about?

The removal patch doesn't really need to be posted at all while we're
reviewing stuff (and it's rather too large for alsa-devel anyway).  The
other patches that Sedji is posting update the Makefile and Kconfig to
stop referencing the existing at91 and at32 directories anyway.
