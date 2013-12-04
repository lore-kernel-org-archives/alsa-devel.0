From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Implement
 symmetric_channels and symmetric_samplebits
Date: Wed, 4 Dec 2013 18:33:07 +0800
Message-ID: <20131204103306.GF8609@MrMyself>
References: <1386067087-12243-1-git-send-email-b42378@freescale.com>
 <20131203145833.GV27568@sirena.org.uk>
 <20131204072702.GE8609@MrMyself>
 <20131204104230.GD29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 672C5265378
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 11:50:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131204104230.GD29268@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, lgirdwood@gmail.com, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 04, 2013 at 10:42:30AM +0000, Mark Brown wrote:
> On Wed, Dec 04, 2013 at 03:27:03PM +0800, Nicolin Chen wrote:
> 
> > Sir, shall we also implement these two to other drivers like codecs?
> > I know this symmetry is a new feature and might be still immature.
> > By implementing it might bring some side effects. But meanwhile, it
> > would also allows us to engage more people to test it, although myself
> > have done a branch of tests with different user cases on my platform.
> 
> > Or we just wait for people engaging by themselves?
> 
> It makes sense to roll it out, since it's in the core if there is a
> problem we only need to fix it in one place to fix all the users which
> makes life easier.

Fully Agreed. I'll try to generate patches to do the rolling job and send
them later.

Thank you for your reply,
Nicolin Chen
