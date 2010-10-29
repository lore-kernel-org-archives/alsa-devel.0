From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC_iii/iv 1/2] ASoC: Rename dai_link as dev_map
Date: Fri, 29 Oct 2010 14:22:49 -0700
Message-ID: <20101029212249.GJ3921@opensource.wolfsonmicro.com>
References: <1288353780-22041-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EF18010389F
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 23:22:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1288353780-22041-1-git-send-email-jhnikula@gmail.com>
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

On Fri, Oct 29, 2010 at 03:02:59PM +0300, Jarkko Nikula wrote:
> Thus far the struct snd_soc_dai_link is used to tie together platform, codec
> and cpu dai drivers in a machine driver and all of these devices has been
> required for a link.

My main thought with this now that I see the change is that it'd be
easier and probably clearer to add an explicit list of devices rather
than to repurpose the DAI links.  This will probably be simpler since we
can avoid things like having to work out if we've seen and initialised a
device before when it has multiple DAIs involved.
