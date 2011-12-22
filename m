From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3 v5] sound/soc/codecs: add LAPIS
	Semiconductor ML26124
Date: Thu, 22 Dec 2011 10:50:00 +0000
Message-ID: <20111222104959.GB4546@opensource.wolfsonmicro.com>
References: <1324349144-12784-1-git-send-email-tomoya.rohm@gmail.com>
	<20111220104047.GE2866@opensource.wolfsonmicro.com>
	<CANKRQngonz+kV3e8tHjvjub-7Pp_5ejqk89Mk7c+Rop9J+_WvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DA065244A7
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 11:50:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANKRQngonz+kV3e8tHjvjub-7Pp_5ejqk89Mk7c+Rop9J+_WvA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 22, 2011 at 05:31:08PM +0900, Tomoya MORINAGA wrote:
> 2011/12/20 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > How have you tested this code?

> No, I haven't tested at all. (Of course, I tested before ASoC.)
> I'll test the new these drivers after you say "Roughly, how to use
> ASoC framework is OK"

Don't do this unless you really have to, and if for some reason it's
needed or useful then indicate that this is what you're doing.  People
shouldn't be finding issues on review that mean that the code will never
run.  If the testing is very light that's fine but you need to make some
effort to verify that things will work.
