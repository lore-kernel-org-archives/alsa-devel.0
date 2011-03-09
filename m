From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix prefixing of DAPM controls by
 factoring prefix into snd_soc_cnew()
Date: Wed, 9 Mar 2011 11:03:14 +0000
Message-ID: <20110309110314.GF6923@opensource.wolfsonmicro.com>
References: <1299605103-13079-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1299607281.3374.13.camel@odin>
	<20110309101951.18c804f5.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5A087245AD
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 12:03:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110309101951.18c804f5.jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 09, 2011 at 10:19:51AM +0200, Jarkko Nikula wrote:

> Unfortunately this leads to double prefixing to mixer and mux controls
> on Nokia RX-51/N900 in today's head. Reason there is that the
> snd_soc_dapm_new_control has already added the prefix to widget name
> and the dapm_new_mixer/mux takes this prefixed w->name and prefixes it
> again.

The system I'm using isn't affected as there's no unnamed mixers in it.
I rather suspect this means that the old code is broken for named
mixers.  Working on a fix just now.
