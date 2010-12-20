From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: Add optional pointer to machine
 audio routes to snd_soc_card
Date: Mon, 20 Dec 2010 14:17:00 +0200
Message-ID: <20101220141700.f33cae2e.jhnikula@gmail.com>
References: <1292607580-27040-1-git-send-email-jhnikula@gmail.com>
	<201012201322.49437.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f65.google.com (mail-ew0-f65.google.com
	[209.85.215.65]) by alsa0.perex.cz (Postfix) with ESMTP id AC8F624558
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 13:15:06 +0100 (CET)
Received: by ewy7 with SMTP id 7so364441ewy.8
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 04:15:06 -0800 (PST)
In-Reply-To: <201012201322.49437.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 20 Dec 2010 13:22:49 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> For sure we need to have the card level DAPM map, when we have more than one 
> codec in the system.
> What I was thinking is more like to move the DAPM map from codec domain up to 
> card level.
> What I mean is, that when you build up your ASoC card, the DAPM map/routes are 
> going to be attached to the card, and not to the codec.

Actually paths and widgets are already decoupled from codec and moved
to card domain. Map/route is initialization time thing which still has
dependency to codec. I.e. snd_soc_dapm_add_route favors a widget from
a calling dapm context (codec).

This is due if there are machines with multiple codecs that are not
cross-connected but if they have widgets with a same name and I didn't
want to force them to use name prefixing and thus causing
userspace-kernel space breakage (kcontrol names changed) compared to
current implementation.

-- 
Jarkko
