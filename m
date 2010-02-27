From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Sat, 27 Feb 2010 09:07:39 +0800
Message-ID: <4f3252891002261707v25cab88fg35a5dd773e6a2567@mail.gmail.com>
References: <20100215192451.GA17938@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DEEBC103821
	for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2010 02:07:41 +0100 (CET)
Received: by pvg16 with SMTP id 16so201097pvg.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 17:07:40 -0800 (PST)
In-Reply-To: <20100215192451.GA17938@tango.0pointer.de>
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

2010/2/16 Lennart Poettering <mznyfn@0pointer.de>

> Heya,
>
>
> Invalid dB data from the driver is a real problem for the "flat
> volume" logic in PA. We basically allow each app to control the full
> hw volume range individually, and then set the hw volume to the max of
> what all apps wanted and attenuate the other streams accordingly. On
> the Aureon this doesn't work at all, since the attenuation of the
> streams is miscalculated due to the invalid dB data.
>
> Lennart
>

The real problem for the "flat volume" logic in PA is when you set the
hardware device volume to maximum, you cannot compensate the software attent
when PA software mixing two or more audio stream by increase the gain in
DAC
