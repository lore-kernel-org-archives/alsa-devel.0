From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/4] ALSA: ASoC: Davinci: Fixed
	missing	McBSP pinmux for SFFSDR
Date: Tue, 10 Mar 2009 19:42:52 +0000
Message-ID: <20090310194248.GA6484@sirena.org.uk>
References: <1236655929-31688-1-git-send-email-hugo@hugovil.com>
	<1236655929-31688-5-git-send-email-hugo@hugovil.com>
	<20090310102921.GA12297@sirena.org.uk>
	<20090310100341.cc08cc08.hugo@hugovil.com>
	<20090310151615.GB12297@sirena.org.uk>
	<20090310114211.4ad49269.hugo@hugovil.com>
	<87hc21tlt1.fsf@deeprootsystems.com>
	<20090310120434.0e6db8e7.hugo@hugovil.com>
	<874oy1tkn4.fsf@deeprootsystems.com>
	<20090310130734.c877b1f6.hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DEDD1037FB
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 20:43:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090310130734.c877b1f6.hugo@hugovil.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 10, 2009 at 01:07:34PM -0400, Hugo Villeneuve wrote:

> It is not easy following you guys. You say something and then do the
> opposite.

There's a very simple rule which works for all upstream submissions:
always generate patches against the tree which the patches are being
submitted to.  If there are changes that have cross-tree dependencies
then those need to be resolved on a case by case basis - normally the
best thing to there is for the affected patches to take the same path
as whatever they depend on.

It is normal and expected for the different trees people merge on to
diverge during a release cycle: for example, changes to a subsystem may
well affect large portions of that subsystem while architecture changes
may affect a wide range of drivers.
