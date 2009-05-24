From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 9/9] Support for AC97 on Phytec
	pmc030	base board.
Date: Sun, 24 May 2009 13:13:12 +0100
Message-ID: <20090524121311.GI4933@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231313.17919.93066.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C84502415E
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 14:13:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090523231313.17919.93066.stgit@terra>
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
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 23, 2009 at 07:13:13PM -0400, Jon Smirl wrote:
> Support for AC97 on Phytec pmc030 base board. A wm9712 AC97 codec is used.
> 
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

Same comments as for the previous driver - it's OK once the AC97 DAI
driver goes in.
