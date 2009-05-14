From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 01/13] Temporarily
	undo	2008f137e92220b98120c4803499cdddb2b0fb06
Date: Thu, 14 May 2009 11:13:05 +0100
Message-ID: <20090514101305.GB28291@sirena.org.uk>
References: <20090514015729.28145.30483.stgit@terra>
	<20090514015901.28145.40556.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6888924406
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 12:13:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090514015901.28145.40556.stgit@terra>
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
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 09:59:01PM -0400, Jon Smirl wrote:

> Temporarily undo 2008f137e92220b98120c4803499cdddb2b0fb06 in sound/soc/fsl/mpc5200_psc_i2s.c so that it won't interfere with following patches that split mpc5200_psc_i2s.c.

I'm fairly sure it's possible to squash these in with the other two
patches but I guess it's not the end of the world :(
