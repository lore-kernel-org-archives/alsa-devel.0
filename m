From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: PCM formats for AC97
Date: Sun, 9 Aug 2009 15:37:47 +0100
Message-ID: <20090809143747.GA9121@sirena.org.uk>
References: <9e4733910908081144s27f4b7fes1e22f838a203c3cf@mail.gmail.com>
	<20090809104830.GC4773@sirena.org.uk>
	<9e4733910908090632m1178daceya0269966fde54529@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CF7B72436B
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Aug 2009 16:37:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910908090632m1178daceya0269966fde54529@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 09, 2009 at 09:32:22AM -0400, Jon Smirl wrote:

> I agree with you, but I think the second form better indicates the
> wildcard than the first form. It makes it look like endianess is not a
> factor.

You need to specify both - the controller may be able to handle data in
either endianness, not just the native format.
