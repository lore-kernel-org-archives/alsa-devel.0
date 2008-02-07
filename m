From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: HG vs GIT
Date: Thu, 7 Feb 2008 19:27:48 +0000
Message-ID: <20080207192747.GA30831@sirena.org.uk>
References: <Pine.LNX.4.61.0802071024530.8113@tm8103.perex-int.cz>
	<s5habmdknw0.wl%tiwai@suse.de>
	<76366b180802070345u705c1a72ibebb27d909028405@mail.gmail.com>
	<s5hhcglynw7.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0802070440430.9968@shell4.speakeasy.net>
	<20080207150022.GA8453@rakim.wolfsonmicro.main>
	<Pine.LNX.4.58.0802070759200.9968@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D647F10383E
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 20:27:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0802070759200.9968@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 07, 2008 at 08:03:57AM -0800, Trent Piepho wrote:
> On Thu, 7 Feb 2008, Mark Brown wrote:

> > Judging from what I've seen on the IRC channels I hang around on I get
> > the impression that relatively few people doing this on a user level
> > (typically people with shiny new laptops and so on) are using hg to
> > access the drivers - they mostly seem to be using either the snapshot or

> grab the code from Hg.  Certainly a lot of people just grab the tip tarball
> with wget and don't use hg clone, but they have the same codebase that
> developers using Hg have.

Sure, that's my point, pretty much - for a user grabbing a tarball it's
immaterial where the contents of the taball come from so long as they
correspond to the software they want.  A change from hg to git wouldn't
affect them so long as the tarballs continue to be provided and provide
access to current ALSA code.

If your concern is more that people using the tarball will be using it
in combination with an unknown distribution kernel rather than the rest
of the tree (assuming ALSA decides to change to git and go for a full
kernel tree, which I hope happens) then surely this isn't much of a
change from the current situation?
