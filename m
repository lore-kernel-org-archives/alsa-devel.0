From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] Fix some minor errors in mpc5200 psc i2s
	driver
Date: Thu, 30 Oct 2008 09:09:26 +0000
Message-ID: <20081030090925.GA5747@sirena.org.uk>
References: <20081029212203.6940.61993.stgit@terra>
	<fa686aa40810291447h7fdfd745w5da90459eee61846@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D03F246F7
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 10:09:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <fa686aa40810291447h7fdfd745w5da90459eee61846@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 29, 2008 at 03:47:51PM -0600, Grant Likely wrote:
> On Wed, Oct 29, 2008 at 3:22 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> > Fix missing unsigned for irqsave flags in psc i2s driver
> > Make attribute visiblity static
> > Collect all sysfs errors before checking status
> >
> > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Takashi, I've got a batch of stuff I intend to push out to you today,
I'll add this to it.
