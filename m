From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3 v3] alsa-lib: fixed coverity
	reported	issues under "FORWARD_NULL" checker.
Date: Mon, 4 Apr 2011 12:49:15 +0100
Message-ID: <20110404114915.GA26494@opensource.wolfsonmicro.com>
References: <1301907239-1873-1-git-send-email-sudarshan.bisht@nokia.com>
	<20110404091823.GA18247@sirena.org.uk>
	<s5hpqp2ticg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84733243BE
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 13:49:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpqp2ticg.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, sudarshan.bisht@nokia.com
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 04, 2011 at 12:35:11PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > > -	if (h == NULL)
> > > +	if (h)
> > >  		snd_dlclose(h);

> > This is a coding style change, the two conditions are equivalent.

> I thought too at the first glance ;)
> It's the advantage of a systematic check.

Hrm, yes.  Actually the issue here was that due to many of the other
changes I was reading very quickly - the patch looks a lot like a
misfiring automation.
