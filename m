From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH]  ASoC: fix snd_soc_jack_add_gpiods stub
Date: Tue, 27 May 2014 17:52:30 +0200
Message-ID: <8227263.CLEDUAEo6x@wuerfel>
References: <7602265.lTCp4nNe4p@wuerfel> <20140527155044.GY12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E2D82658C2
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 17:52:37 +0200 (CEST)
In-Reply-To: <20140527155044.GY12304@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 27 May 2014 16:50:44 Mark Brown wrote:
> On Tue, May 27, 2014 at 05:46:05PM +0200, Arnd Bergmann wrote:
> > f025d3b9c64e1 ("ASoC: jack: Add support for GPIO descriptor defined jack
> > pins") added this new interface, but the stub function provided for
> > non-gpiolib builds was defined in the header file as a global function,
> > leading to lots of "multiple definition of `snd_soc_jack_add_gpiods'"
> > warnings.
> 
> I've already applied a fix for this from Jarkko.

Ok, cool. I should probably at some point subscribe to alsa-devel
so I can check better if someone posted a patch for a bug I find.
I did a google search but didn't find anything on this.

	Arnd
