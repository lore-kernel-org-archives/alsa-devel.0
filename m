From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: DaVinci: pcm,
 rename variables in prep for ping/pong
Date: Wed, 2 Sep 2009 23:01:53 +0100
Message-ID: <20090902220152.GB4495@sirena.org.uk>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
	<1251761505-11353-2-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A8BFD2438D
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 00:02:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1251761505-11353-2-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: avm@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 31, 2009 at 04:31:44PM -0700, Troy Kisky wrote:
> Rename variable master_lch to asp_master_lch
> Rename variable slave_lch to asp_link_lch[0]
> Rename local variables:
> 	count to asp_count
> 	src to asp_src
> 	dst to asp_dst

These other two patches are OK but I'll wait for after the merge window
to apply them partly due to the dependency on the merged tree and also
since it's very near to the merge window opening and there's already
been a fair bit of churn and testing with the DaVinci drivers for
2.6.32.

I'll probably also apply the first patch since nobody else seems to care
one way or another, but I would urge you to look at changing the default
for the platform data to at most select the workaround only on CPUs that
have problems with channel swapping - it's going to cause confusion for
people to have it on by default.
