From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: maximum tolerable sampling frequency difference
	for a driver
Date: Wed, 12 Nov 2008 11:43:55 +0000
Message-ID: <20081112114354.GB8767@sirena.org.uk>
References: <cabda6420811110817u42eafc74wfde36de113c98df1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D97E0243CD
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 12:43:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cabda6420811110817u42eafc74wfde36de113c98df1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: chri <chripell@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 11, 2008 at 05:17:00PM +0100, chri wrote:
> Let's say that the driver cannot set the exact sampling frequency
> asked via hwparms but something near (because of the granularity of
> the result of the clock division). What is the maximum difference that
> should be accepted (in Hz or in %)? I guess that there are 2 factors
> playing a role:

It's relatively application-specific - it'll depend on things like how
accurate the clocks were in the first place and what the sound is being
used for (system beeps are going to tolerate a lot more than something
doing audiophile quality stuff).

> So what difference should be accepted instead of returning -EINVAL?

If this is for the Samsung boards you've been posting patches for then a
few percent should be OK most of the time.
