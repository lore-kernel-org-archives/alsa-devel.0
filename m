From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Amstrad Delta: fix NULL pointer
	dereference
Date: Tue, 1 Feb 2011 21:33:01 +0000
Message-ID: <20110201213301.GB12101@opensource.wolfsonmicro.com>
References: <201102011840.55512.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F372A103807
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 22:32:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201102011840.55512.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 01, 2011 at 06:40:55PM +0100, Janusz Krzysztofik wrote:

> It looks like the .card member of the snd_soc_pcm_runtime structure 
> pointed to by the snd_soc_dai_link.init() argument is no longer 
> initialized before the function being called. As the Amstrad Delta sound 
> card driver was making use of it for locating its snd_soc_card 
> structure, this resulted in actual or potential NULL pointer 
> dereferences.

Seems like it'd be better to fix this in the core - this is a reasonable
thing to want to have set up and the use ams-delta makes of it seems
perfectly sensible.  Care to do a patch?
