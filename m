From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC_ii/iv 1/3] ASoC: Move DAPM paths from DAPM
 context to snd_soc_card
Date: Fri, 29 Oct 2010 13:51:52 -0700
Message-ID: <20101029205151.GG3921@opensource.wolfsonmicro.com>
References: <1288353742-22005-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 61A3C10385E
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 22:51:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1288353742-22005-1-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 29, 2010 at 03:02:20PM +0300, Jarkko Nikula wrote:
> Decoupling DAPM paths from DAPM context is a first prerequisite when
> extending ASoC core to cross-device paths. This patch is almost a nullop and
> does not allow to construct cross-device setup but the path clean-up part in
> dapm_free_widgets is prepared to remove cross-device paths between a device
> being removed and others.

> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

This looks good to me.
