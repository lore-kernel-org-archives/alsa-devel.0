From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: wrong print debugging message code
Date: Mon, 23 Jun 2008 19:51:01 +0100
Message-ID: <20080623185100.GA31751@sirena.org.uk>
References: <280b69ac0806202244s11e74363l4de3f020fed849be@mail.gmail.com>
	<s5habhc4dz6.wl%tiwai@suse.de>
	<280b69ac0806231118n2349bedbl1b9462ecd5f1ecf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C63EE24905
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 20:51:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <280b69ac0806231118n2349bedbl1b9462ecd5f1ecf3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jin-Young Park <mcjin02@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 24, 2008 at 03:18:49AM +0900, Jin-Young Park wrote:

> I defined "#define XXXX_DEBUG 0" and dbg() put into mute
> function(wm8960_digital_mute()).

The WM8960 driver isn't in the standard Linux kernel yet, it is currently
distributed via the Wolfson web site.  None of the drivers included in
the standard Linux kernel were using their dbg() macros, though some had
such macros present.

> I think, it maybe potential that reduce performance before one knows.

The performance impact should be very minor - the digital mute is not
used in any hot paths and the output will only go do the dmesg buffer by
default so won't have the overhead of writing to the console.

Out of interest, which platform are you working with?
