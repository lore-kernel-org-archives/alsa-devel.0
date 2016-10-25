From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] ASoC: cs42xx8: Mark chip ID as
 volatile and remove cache bypass
Date: Tue, 25 Oct 2016 16:16:05 +0100
Message-ID: <20161025151605.GC28180@localhost.localdomain>
References: <1477302949-28049-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20161024153342.GA17252@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CDA12614A0
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 17:15:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20161024153342.GA17252@sirena.org.uk>
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
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 24, 2016 at 04:33:42PM +0100, Mark Brown wrote:
> On Mon, Oct 24, 2016 at 10:55:44AM +0100, Charles Keepax wrote:
> > Rather than manually enabling cache bypass when reading the ID registers
> > simply mark them as volatile. The old code worked this is simply the
> > more standard way to implement this. There is a comment included in the
> 
> Even better just remove the register default, with rbtree regmap will do
> the read and then cache it - no need to mark as volatile.

:-) well if we are preferring that then some of the series can
just be dropped, as they were changing exactly that to be
explicitly marked volatile.

I will fixup the remaining patches and resend.

Thanks,
Charles
