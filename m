From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: Add optional pointer to machine
 audio routes to snd_soc_card
Date: Tue, 21 Dec 2010 10:16:59 +0200
Message-ID: <20101221101659.4fde5a83.jhnikula@gmail.com>
References: <1292607580-27040-1-git-send-email-jhnikula@gmail.com>
	<201012201322.49437.peter.ujfalusi@nokia.com>
	<20101220141700.f33cae2e.jhnikula@gmail.com>
	<201012210930.46971.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by alsa0.perex.cz (Postfix) with ESMTP id 50BA3243D3
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 09:15:03 +0100 (CET)
Received: by bwz13 with SMTP id 13so4451423bwz.29
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 00:15:02 -0800 (PST)
In-Reply-To: <201012210930.46971.peter.ujfalusi@nokia.com>
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

On Tue, 21 Dec 2010 09:30:46 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> > This is due if there are machines with multiple codecs that are not
> > cross-connected but if they have widgets with a same name and I didn't
> > want to force them to use name prefixing and thus causing
> > userspace-kernel space breakage (kcontrol names changed) compared to
> > current implementation.
> 
> If you have multiple codecs in your device, it is likely that those codecs will 
> have colliding widget names for sure.
> IMHO using prefixes for multi codec cards shall not break the userspace-kernel 
> interface, since with old ASoC we had one codec per one card.
> So if you move your machine to real multi-comp, then you anyway break the 
> userspace-kernel interface by moving the PCMs to one card from the original PCM 
> per card way.
> If you have one codec in your system you do not need to prefix that, so you 
> break nothing.
> I would use prefixes in real multi codec cases...
>
It's not entirely sure. Before cross-device set, i.e. in 2.6.37 it's
possible to build a machine driver with multiple codecs that can have
the same widgets names since the paths and widgets are per codec.
Collision could come only from kcontrol names.

But I agree. Prefixing new machines sounds safer in long run. Then it's
more unlikely that changes in one codec driver causes hard to see
problems to machines with multiple codecs.

> Are we using the prefixes for the non DAPM kcontrols as well? I think we shall, 
> if the prefix is defined.
> 
Yep, prefix is put to all codec kcontrols, widget and route names.

-- 
Jarkko
