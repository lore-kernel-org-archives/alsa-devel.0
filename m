From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 3/6] asoc: Add SOC_DOUBLE_R_SX_TLV control
Date: Thu, 13 May 2010 10:30:53 +0100
Message-ID: <20100513093051.GA29881@sirena.org.uk>
References: <20100511162342.640158675@mandriva.com>
	<20100511162601.913930263@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7ABCE24404
	for <alsa-devel@alsa-project.org>;
	Thu, 13 May 2010 11:30:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100511162601.913930263@mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: apatard@mandriva.com
Cc: alsa-devel@alsa-project.org, tbm@cyrius.com, saeed@marvell.com, nico@fluxnic.net
List-Id: alsa-devel@alsa-project.org

On Tue, May 11, 2010 at 06:23:45PM +0200, apatard@mandriva.com wrote:
> This patch is adding a new control which has the following capabilities:
> - tlv
> - variable data size (for instance, 7 ou 8 bit)
> - double mixer
> 
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

So, after discussing with Liam on IRC I was going to rewrite the commit
message and apply this but it doesn't apply to current ASoC.  Please
make sure any patches for ASoC apply to:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

(or whatever the latest kernel version there's a branch for is.)
