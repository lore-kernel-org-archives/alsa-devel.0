From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 0/9] S3C24XX/S3C64XX updates
Date: Wed, 4 Mar 2009 20:29:54 +0000
Message-ID: <20090304202952.GA10731@sirena.org.uk>
References: <20090304004925.530566010@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 705F1103828
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 21:30:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090304004925.530566010@fluff.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-alsa@fluff.org>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 12:49:25AM +0000, Ben Dooks wrote:
> This is a set of patches for 2.6.30 to add more
> s3c24xx machine support and support for the S3C64XX
> series of SoC.

I've merged everything I didn't specifically comment on, plus some of
the rest.  I also added JIVE and fixed the review issues myself.  Thanks
a lot for doing this!

As previously discussed I'll update my IISv4 driver from the Samsung BSP
for mainline and take care of AC97 and the on board audio for the
SMDK6410 too.

> It would be very useful to get the header moves merged
> as soon as possible, to help clear out the old ARM
> include directories (and make it easier for the merges
> from other s3c branches that need to take place in the
> merge window). As such, they're only moves and should
> not affect the actual build.

Takashi, what do you think about this?  Should I send a 2.6.29 update
(it's very late in the game...) or would it be better to deal with this
by trying to merge ALSA early in the merge window?  Either way works for
me.
