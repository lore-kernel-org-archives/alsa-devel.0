From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Implement
 symmetric_channels and symmetric_samplebits
Date: Wed, 4 Dec 2013 15:27:03 +0800
Message-ID: <20131204072702.GE8609@MrMyself>
References: <1386067087-12243-1-git-send-email-b42378@freescale.com>
 <20131203145833.GV27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 37956261640
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 08:46:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131203145833.GV27568@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, timur@tabi.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 03, 2013 at 02:58:33PM +0000, Mark Brown wrote:
> On Tue, Dec 03, 2013 at 06:38:07PM +0800, Nicolin Chen wrote:
> > Since we introduced symmetric_channels and symmetric_samplebits, we implement
> > these two features to fsl_ssi so as to drop some no-more-needed code and make
> > the driver neat and clean.
> 
> Applied, thanks.

Sir, shall we also implement these two to other drivers like codecs?
I know this symmetry is a new feature and might be still immature.
By implementing it might bring some side effects. But meanwhile, it
would also allows us to engage more people to test it, although myself
have done a branch of tests with different user cases on my platform.

Or we just wait for people engaging by themselves?

Thank you,
Nicolin Chen
