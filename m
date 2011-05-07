From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/12] ASoC: Create codec DAPM widgets
 before calling the codecs probe function
Date: Sat, 7 May 2011 19:21:15 +0100
Message-ID: <20110507182115.GB26700@opensource.wolfsonmicro.com>
References: <1304607560-15083-1-git-send-email-lars@metafoo.de>
	<1304791860.3470.15.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7D78103814
	for <alsa-devel@alsa-project.org>;
	Sat,  7 May 2011 20:21:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304791860.3470.15.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: device-driver-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>
List-Id: alsa-devel@alsa-project.org

On Sat, May 07, 2011 at 07:11:00PM +0100, Liam Girdwood wrote:

> These look all OK but I'm not fully following your commit message above
> with moving the call to snd_soc_dapm_new_controls() below. Could you
> explain why moving the call fixes your issue.

It means the widgets are present before the codec initialisation
callbacks get run so the callbacks can use them if they wish to.
