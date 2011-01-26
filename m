From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2.6.38] ASoC: Fix module refcount for
	auxiliary devices
Date: Wed, 26 Jan 2011 20:27:24 +0000
Message-ID: <20110126202724.GA25597@opensource.wolfsonmicro.com>
References: <1296052777-3890-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 78521103A0B
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 21:27:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296052777-3890-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 26, 2011 at 04:39:37PM +0200, Jarkko Nikula wrote:

> However, the commit didn't remove try_module_get from soc_probe_aux_dev so
> the auxiliary device reference counts are incremented twice as the
> soc_probe_codec is called from soc_probe_aux_dev too.

Applied, thanks.
