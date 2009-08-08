From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: DaVinci: i2s,
 reduce underruns by combining into 1 element
Date: Sat, 8 Aug 2009 10:07:04 +0100
Message-ID: <20090808090704.GF4519@sirena.org.uk>
References: <1249602935-1267-1-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-2-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-3-git-send-email-troy.kisky@boundarydevices.com>
	<20090808085911.GE4519@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B1CE524367
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Aug 2009 11:07:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090808085911.GE4519@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 08, 2009 at 09:59:11AM +0100, Mark Brown wrote:

> I'll apply the patch, copying the comment here into the commit message
> to make things more discoverable, but I'd strongly suggest considering a
> followup patch which changes the default to the original behaviour.  It
> might even be worth making the behaviour runtime configurable.

...or not, the change to asp.h doesn't apply at all in ASoC - the
platform data is only present in Kevin's tree at the minute.  I'm happy
for it to get merged that way, but best to check for cross tree issues
and I would like to see something about the L/R swap in the commit log
for discoverabiity (or the default changing).

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
