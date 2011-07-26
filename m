From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - make IO calls return a valid
 errno on failure.
Date: Tue, 26 Jul 2011 12:43:21 +0100
Message-ID: <20110726114321.GE7285@opensource.wolfsonmicro.com>
References: <1311588959-3512-1-git-send-email-lrg@ti.com>
	<20110725212213.GD6086@opensource.wolfsonmicro.com>
	<1311679099.4088.6.camel@CNA0741383>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 414DB1038C5
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jul 2011 13:43:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1311679099.4088.6.camel@CNA0741383>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 26, 2011 at 12:18:19PM +0100, Liam Girdwood wrote:
> On Mon, 2011-07-25 at 23:22 +0200, Mark Brown wrote:

> > Yeah, it really should but it's kind of tricky for the reads as we're
> > returning errors in band and we could have 32 bit registers (I'm
> > guessing the platform versions already do) so we lose.  :/  Not sure
> > what the best thing to do there is, changing to return the errors out of
> > band for reads is more painful than I care to contemplate.

> Oh, I agree it would be painful for a rework here. But why did you
> suggest this sort of update in a previous patch comment ? (Unless I
> misunderstood).

Dunno the specific posting but there's two things I can think of:

- This isn't an issue for writes so they can and should pass back error
  codes, it's only reads that have trouble.

- If I see people converting an error code into -EINVAL or something I
  tend to complain about that.
