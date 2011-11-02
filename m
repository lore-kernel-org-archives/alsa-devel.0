From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] ASoC don't clobber platform DMA driver ops
Date: Wed, 2 Nov 2011 03:40:48 +0000
Message-ID: <CAOZdJXULdoVU7qxwh+af=UO_ZxY5=Bu3PEO66DiMu-4Yr0gi4g@mail.gmail.com>
References: <1320181516-14186-1-git-send-email-alan.tull@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by alsa0.perex.cz (Postfix) with ESMTP id 633882459E
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2011 04:41:31 +0100 (CET)
In-Reply-To: <1320181516-14186-1-git-send-email-alan.tull@freescale.com>
Content-Language: en-US
Content-ID: <99639B0E51EC4E4386D9648937A0B69F@freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tull Alan-R80115 <R80115@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 1, 2011 at 4:05 PM, Alan Tull <alan.tull@freescale.com> wrote:
>
> This patch creates and populates a ops struct for each call
> to soc_pcm_new. =A0Also creates a common soc_pcm_ioctl function
> that calls all the driver components for ioctl calls.

Maybe I'm missing something, but it looks like the ioctl stuff is not
related to the ops stuff.  In other words, it looks like this patch
does two completely different things.  Shouldn't it be broken into two
patches?

-- =

Timur Tabi
Linux kernel developer at Freescale
