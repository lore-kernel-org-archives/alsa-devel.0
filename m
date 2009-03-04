From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 3/4] pxa-ssp: don't touch ssp
	registers	when stream is running
Date: Wed, 4 Mar 2009 21:39:11 +0100
Message-ID: <20090304203911.GA18917@buzzloop.caiaq.de>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
	<1236197820-21022-3-git-send-email-daniel@caiaq.de>
	<20090304203350.GB10731@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D7449103882
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 21:39:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090304203350.GB10731@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Tim Ruetz <tim@caiaq.de>, Liam Girdwood <lrg@kernel.org>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 08:33:52PM +0000, Mark Brown wrote:
> > In pxa_ssp_set_dai_fmt(), don't modify the SSP registers in case the
> > stream is already running. With that patch applied, loop-thru tests like
> > 'acrecord -f cd | aplay -f cd' succeed.
> 
> > +	/* we can only change the settings if the port is not in use */
> > +	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
> > +		return 0;
> 
> I'd expect an error to be reported here - if we needed to change the
> settings and can't things could go wrong.  Ideally it'd check to see if
> the DAI format was being changed and only error if it was.

In my tests, pxa_ssp_set_dai_fmt() was simply called twice, once for the
input, once for the ouput. Hence I believed a silent exit in such a case
fine. Does 'arecord -f cd | aplay -f cd' work for you?

Daniel
