From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: Add support for sequencing within
Date: Wed, 19 Jan 2011 10:07:51 +0000
Message-ID: <20110119100751.GA16288@opensource.wolfsonmicro.com>
References: <1295367614-12143-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1295367614-12143-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4D369E9A.1030501@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D247424390
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 11:07:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D369E9A.1030501@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 19, 2011 at 10:19:38AM +0200, Peter Ujfalusi wrote:

> I have been wondering, if we just go, and follow the sequence of the
> DAPM widgets in on the path on powerup, and follow the reverse sequence
> on powerdown.

It's certainly worth considering.  It's not unambiguously clear that
this is ideal - there's a few cases where you pretty much always want to
do things in a different order to the straight path, the primary one
being that since PGAs make everything more noisy you generally want to
power them on last.  There's also the issue that you don't want to
oversequence things, more often than not bringing things up in parallel
performs at least as well or even better.

> IMHO in this way we would have better control over the sequences, and we
> might be in better position to combat pop noises, since we have more
> explicit control over the sequence of events.

OOI, do we actually have issues here at the minute?  The only issue I'm
aware of is that we don't have a facility for keeping PGAs muted while
sequences are running.

> I have not looked how hard it would be to change the DAPM to do this.
> Anyways I would not started to do this without asking... I know there
> are really good reasons to have the current DAPM sequence handling, but
> I do wonder, if it make sense to do this.

It's potentially useful.  There are some considerations as above that
mean we don't want a straight graph walk but there's certainly some room
for using the infrastructure.
