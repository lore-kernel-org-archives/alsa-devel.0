From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core - make IO calls return a valid
 errno on failure.
Date: Tue, 26 Jul 2011 12:18:19 +0100
Message-ID: <1311679099.4088.6.camel@CNA0741383>
References: <1311588959-3512-1-git-send-email-lrg@ti.com>
	<20110725212213.GD6086@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id B1B7F2451A
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jul 2011 13:18:24 +0200 (CEST)
In-Reply-To: <20110725212213.GD6086@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-07-25 at 23:22 +0200, Mark Brown wrote:
> On Mon, Jul 25, 2011 at 11:15:59AM +0100, Liam Girdwood wrote:
> > IO call failures should return an errno instead of -1
> 
> Yeah, it really should but it's kind of tricky for the reads as we're
> returning errors in band and we could have 32 bit registers (I'm
> guessing the platform versions already do) so we lose.  :/  Not sure
> what the best thing to do there is, changing to return the errors out of
> band for reads is more painful than I care to contemplate.

Oh, I agree it would be painful for a rework here. But why did you
suggest this sort of update in a previous patch comment ? (Unless I
misunderstood).

Liam
