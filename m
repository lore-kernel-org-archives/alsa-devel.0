From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: soc-cache: Use
	reg_def_copy	instead of reg_cache_default
Date: Wed, 5 Jan 2011 23:29:47 +0000
Message-ID: <20110105232947.GA8514@sirena.org.uk>
References: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1291306266-4907-2-git-send-email-dp@opensource.wolfsonmicro.com>
	<AANLkTi=yFRw-c+LeQGEUkKuAGCV+tkEYEpo=q22F0ZUq@mail.gmail.com>
	<20110105230339.GB5476@opensource.wolfsonmicro.com>
	<4D24F9E4.1080704@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 232F52443D
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 00:29:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D24F9E4.1080704@freescale.com>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 05, 2011 at 05:08:20PM -0600, Timur Tabi wrote:

> My concern is that I think it's unwise to hard-code the default values of the
> registers in the source file.  Who's to say that a newer version of the chip
> won't have different power-on defaults?

In practical terms this is vanishingly unlikely; 

> I do want to support a register cache, but I don't want to hard-code the default
> values into cs4270.c.  Is this supported?

If something you'd like to do doesn't seem to be working or is otherwise
not there and you can see a way to implement it sensibly then the most
obvious thing would seem to be to implement it.

Please remember that this isn't a frozen commercial OS release from a
third party, you can contribute to the core code if you see a need to.
None of this is fixed in stone and a lot of it comes from looking at the
code and taking opportunities to add appropriate abstractions - look at
symmetric_rates, or the creation of soc-cache for example.

> > As you will doubtless have seen when you looked at the code every other
> > reference to reg_cache_default checks to see if it's set before using
> > it.  This does rather suggest that the intention of the code is that it
> > be optional.

> So are you saying that there's a bug in this patch?  Perhaps that code should
> look like this:

Perhaps it should, though my immediate question (without looking at the
existing code again) is why the existing tests are being removed.
