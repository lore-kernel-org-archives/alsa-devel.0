From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Rates/formats available upstream from the plug
	plugin
Date: Tue, 3 Aug 2010 23:35:55 +0800
Message-ID: <AANLkTiktnkVj2MmHZ1TiX67hcYe7qA0xURe2zyanQCnS@mail.gmail.com>
References: <4C5815E6.9010803@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A41B51037EE
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 17:35:58 +0200 (CEST)
Received: by eye27 with SMTP id 27so1595894eye.38
	for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2010 08:35:57 -0700 (PDT)
In-Reply-To: <4C5815E6.9010803@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/8/3 Pavel Hofman <pavel.hofman@ivitera.com>

> Hi,
>
> mplayer checks hw_params for availability of the current format
>
> http://mplayer-ww.git.sourceforge.net/git/gitweb.cgi?p=mplayer-ww/mplayer-ww;a=blob;f=libao2/ao_alsa.c;h=57f0bd07cb5ec300d327682a0b5209ba9dc10e30;hb=09ab9f6346aaf15d20792ca3df761a45fe46d83d#l514
> . If the check fails, it uses 16bits as fixed default.
>
> Now if we define the card to be plughw:0, the check still fails for
> formats unsupported directly by the card. Which in fact is incorrect
> since the plug plugin takes care of most formats known. The same holds
> for sample rates.
>
> IMO either the plug plugin should reconfigure hw_params for upstream
> use, or mplayer should use a different API call for checking parameters
> of the actual alsa device (not just the hardware itself, as defined by
> its alsa driver) - which one?
>
> Thanks a lot,
>
> Pavel.
>

AFAIK , "plug" plugin does not support AC3 encode/decode , and alsa spdif
device support AC3 passthrough
