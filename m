From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 15:37:26 +0800
Message-ID: <4f3252891002162337t29300687k57d7c3fc709c8949@mail.gmail.com>
References: <20100215192451.GA17938@tango.0pointer.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<4B7B2E9F.3080809@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f193.google.com (mail-px0-f193.google.com
	[209.85.216.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 73540103853
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 08:37:27 +0100 (CET)
Received: by pxi31 with SMTP id 31so3062106pxi.26
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 23:37:26 -0800 (PST)
In-Reply-To: <4B7B2E9F.3080809@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/17 Eliot Blennerhassett <linux@audioscience.com>

> >
>
> There are two separate issues here.
> 1) Incorrect dB<->linear mapping
> ALSA Volume/Gain controls returning incorrect information about mapping
> from linear values to dB.  E.g. adding "6dB" to the Volume controls
> while subtracting 6dB in software does not result in 0dB overall gain.
>
> For volume controls the convention is  0dB == multiply by 1.0 == no
> change. Any sane digital volume control should obey this.
> For analog volumes, the 0dB position is entirely arbtrary, as I discuss
> below.
>
>
For the alsa db values are in step of  1.5 dB or 3.dB ,

but the software shift one bit is 10 log 2 = 3.0102996* dB

*
That 's why adding "6dB" to the Volume controls
while subtracting 6dB in software does not result in 0dB overall gain.
