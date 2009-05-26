From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V5 1/5] powerpc: introduce
	macro	spin_event_timeout()
Date: Tue, 26 May 2009 15:53:24 +0100
Message-ID: <20090526145324.GF8969@sirena.org.uk>
References: <20090526123235.17472.73912.stgit@terra>
	<20090526123406.17472.79948.stgit@terra>
	<20090526130301.GE8969@sirena.org.uk>
	<9e4733910905260612v40a70ad8haeb4c916a1a758b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 514D31038AA
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 16:53:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905260612v40a70ad8haeb4c916a1a758b5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2009 at 09:12:10AM -0400, Jon Smirl wrote:
> On Tue, May 26, 2009 at 9:03 AM, Mark Brown

> > As previously mentioned you need to submit any changes you want to make
> > here as incremental patches against the PowerPC tree rather than as an
> > entire new patch. ?If you are forwarding on copies of the patch you
> > really ought to preserve Timur's authorship too with a From line in the
> > mail.

> I have reverted back to TImur's original patch  so you can just drop
> this patch if that is easier for you.
> You'll just need to coordinate the landing so that things land in the
> right order.

Like I say, since it's a new driver I'm just going to ignore the
ordering since it'll sort itself out in the merge window and we're
rather close to that.  Worst case something that doesn't build isn't
that much different from something that isn't there in terms of
usability.
