From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] Allow more routing features for	tlv320aic3x
Date: Wed, 26 Nov 2008 18:34:53 +0000
Message-ID: <20081126183452.GJ6234@sirena.org.uk>
References: <20081126144854.GA20061@buzzloop.caiaq.de>
	<20081126150404.GE6234@sirena.org.uk>
	<20081126155645.GA20913@buzzloop.caiaq.de>
	<20081126162810.GF6234@sirena.org.uk>
	<20081126164736.GC20913@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 70FEC24796
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 19:34:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081126164736.GC20913@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 26, 2008 at 05:47:36PM +0100, Daniel Mack wrote:

> Sorry, once more. I was a little too quick with my last submission.

Applied, thanks.  BTW...

>  - control the volume of the PGA bypass path for the HPL, HPR, HPLCOM
>    and HPRCOM outputs individually

...that's not quite true; ALSA does allow left and right channels to be
controlled independently for stereo controls, it's just not the default
thing in UIs (and not always idiomatic when the left and right paths are
sufficiently independent so the change is OK).
