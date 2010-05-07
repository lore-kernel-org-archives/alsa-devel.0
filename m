From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Support for limiting gain
Date: Fri, 7 May 2010 16:40:55 +0100
Message-ID: <20100507154055.GB25793@rakim.wolfsonmicro.main>
References: <1273131438-2716-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100506094942.GB30491@rakim.wolfsonmicro.main>
	<201005061421.29408.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 57F841038A5
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 17:40:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201005061421.29408.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, May 06, 2010 at 02:21:28PM +0300, Peter Ujfalusi wrote:

> What I was wondering about is the cases when you have a codec + amp in a 
> system..
> If we take for example twl4030 and the tpa6130 connected together:
> than we have 4 levels of gain control inside of twl, than one additional level 
> on the tpa side.
> What would be nice is to somehow limit the whole chain, but it seams really 
> complicated thing because of the big amount of combinations that you can 
> actually achieve the same level at the output.

Well, normally you'd only really vary one or possibly two gains in the
path at runtime - everything else would be fixed by the scenario - so
it's not so urgent to enforce anything over the full path, you can just
deal with the controls that actually get updated dynamically.

One of the bigger use cases here is to prevent physical damage if you've
got a speaker driver that can produce more power than the speaker
attached to it is rated for.
