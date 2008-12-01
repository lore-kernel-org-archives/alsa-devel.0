From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Merged upstream to topic/asoc branch
Date: Mon, 1 Dec 2008 17:24:55 +0000
Message-ID: <20081201172454.GJ13758@sirena.org.uk>
References: <s5h8wqzzv8r.wl%tiwai@suse.de>
	<20081201170633.GI13758@sirena.org.uk>
	<s5h3ah7zul7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 99A4324545
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 18:24:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h3ah7zul7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 01, 2008 at 06:14:12PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Hrm.  Which compiler are you using?

> gcc-4.1 for ARM, if I remember correctly...

I'm at 4.2.4 for ARM.

> >  The WM8903 warning patch you
> > introduced is not needed on any of my systems (primarily ARM and
> > x86-64).  It smells like a problem with the BUG() definition on your
> > platform...

> Possibly.  I'm not pretty sure on which systems, since I run test-builds
> regularly for ARM, PPC, x86 and x86-64 with cross compilers.

Could you investigate, please?  I'd rather not add annotations like that
since they mask genuine compiler warnings and are liable to crop up
elsewhere.  That particular function isn't likely to change but I'm
worried in case this sort of thing starts cropping up elsewhere.

For that particular function I'd rather add return statements after the
BUG()s...

As far as I'm aware the current ASoC code is warning free.
