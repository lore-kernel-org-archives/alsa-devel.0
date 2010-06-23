From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: IEC switch issues
Date: Wed, 23 Jun 2010 21:21:12 +0800
Message-ID: <AANLkTinR9JTLJwG0ti7STn-lHkqiChpBZxLkc0-rftdU@mail.gmail.com>
References: <AANLkTinpl5hs7NRAm38uF7FbGCOuIOxCvohD70jOQxam@mail.gmail.com>
	<4C21F88C.6000200@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0572124492
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 15:21:14 +0200 (CEST)
Received: by vws20 with SMTP id 20so914997vws.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 06:21:13 -0700 (PDT)
In-Reply-To: <4C21F88C.6000200@ladisch.de>
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

2010/6/23 Clemens Ladisch <clemens@ladisch.de>

> pl bossart wrote:
> > If I play my AC3 data on my HDAudio/SPDIF output using the hw:0,1
> > device, I can use alsamixer/amixer to mute/unmute.
> >
> > Now if I use the iec958: plugin, I can't control the mute switch any
> longer:
>
> Muting an AC-3 stream would require encoding a stream of silent PCM
> samples (no data is not the same as silence); therefore, the iec958
> plugin disallows muting.
>
>
> Regards,
> Clemens
>
>
Does it mean that rewind is not allowed too ?
