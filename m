From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: arecord: main:552: audio open error:
	Invalid	argument
Date: Wed, 4 Aug 2010 21:01:18 +0100
Message-ID: <20100804200117.GB5864@sirena.org.uk>
References: <4C59C5C1.50504@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 17F1C246AB
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 22:01:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C59C5C1.50504@freescale.com>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 04, 2010 at 02:55:45PM -0500, Timur Tabi wrote:

> I created a log with some printks that kinda show what's going on.  In one
> process I run speaker-test, and then I start arecord in another process.

You might want to provide a little more context on what you're trying to
do here for the benefit of readers...

> In summary, the problem appears to be that asoc calls
> soc_pcm_apply_symmetry() in soc_pcm_open(), but this occurs before
> soc_pcm_hw_params() can set rtd->rate.  So rtd->rate is always zero when
> soc_pcm_apply_symmetry() is called.

> For some reason, this isn't a problem when arecord is started before
> speaker-test.  In that case, rtd->rate is 48000 when speaker-test is started:

The symmetric_rates infrastructure was only ever really intended to work
over a single DAI so I'd not be at all surprised if it gets a little
confused (though I'm surprised it's doing anything at all).
