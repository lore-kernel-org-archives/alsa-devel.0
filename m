From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC_iii/iv 1/2] ASoC: Rename dai_link as dev_map
Date: Sun, 31 Oct 2010 20:12:15 +0200
Message-ID: <20101031201215.9591a614.jhnikula@gmail.com>
References: <1288353780-22041-1-git-send-email-jhnikula@gmail.com>
	<20101029212249.GJ3921@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AEF7103801
	for <alsa-devel@alsa-project.org>; Sun, 31 Oct 2010 19:10:53 +0100 (CET)
Received: by mail-ew0-f51.google.com with SMTP id 22so2430312ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 31 Oct 2010 11:10:53 -0700 (PDT)
In-Reply-To: <20101029212249.GJ3921@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Oct 2010 14:22:49 -0700
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Oct 29, 2010 at 03:02:59PM +0300, Jarkko Nikula wrote:
> > Thus far the struct snd_soc_dai_link is used to tie together platform, codec
> > and cpu dai drivers in a machine driver and all of these devices has been
> > required for a link.
> 
> My main thought with this now that I see the change is that it'd be
> easier and probably clearer to add an explicit list of devices rather
> than to repurpose the DAI links.  This will probably be simpler since we
> can avoid things like having to work out if we've seen and initialised a
> device before when it has multiple DAIs involved.

My concern was mostly that we end up having somewhat similar struct
than snd_soc_dai_link and adding pointer to such table in snd_soc_card.
But that's not necessary reduncandy at all if it makes cleanier move to
other cases like codec-codec etc. I'll experiment that in next version.


-- 
Jarkko
