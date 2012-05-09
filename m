From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Fast Track Ultra latency and new streaming logic.
Date: Wed, 9 May 2012 17:07:40 +0200
Message-ID: <CAFz=ag5On49cB90kKL7R_APQW1-BwyBsmvPhahzZNyXdxQYeJw@mail.gmail.com>
References: <CACckToWK=Si8-8rPKgo-ZWA+ncTVb7zW8jHZvf7VbKT1sMM32Q@mail.gmail.com>
	<CAFz=ag5d8PFYoA2KsWKMZ+yX=1gLQmGWx7wFn1cTVf4CW_jDiA@mail.gmail.com>
	<CAFz=ag6d+zcHrNhxKwaTHQYb04GJEKDXjowz4NhXtERAV-zjag@mail.gmail.com>
	<CAFz=ag4j2OZTZqzeo+h210AaVgToA93hTs5QPL1UPHCCCLJkZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 72401245D6
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 17:07:41 +0200 (CEST)
Received: by yenl1 with SMTP id l1so374106yen.38
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2012 08:07:40 -0700 (PDT)
In-Reply-To: <CAFz=ag4j2OZTZqzeo+h210AaVgToA93hTs5QPL1UPHCCCLJkZg@mail.gmail.com>
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

(For the list..)

>
> Is this a
> flaw in Alsa, Jack or the USB stack?

I'm starting to think that this is a Jack issue. At least I can set
rather small period and buffer sizes in aplay without any xruns.
