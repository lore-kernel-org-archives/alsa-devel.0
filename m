From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Fri, 25 Jun 2010 06:51:21 +0800
Message-ID: <AANLkTin8lse_YECMjVaZRbROMfg02dxx3CW_Wy8Q8krC@mail.gmail.com>
References: <20100215192451.GA17938@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1C83924334
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 00:51:52 +0200 (CEST)
Received: by vws20 with SMTP id 20so2974723vws.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 15:51:52 -0700 (PDT)
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
> a while back I wrote a little tool "dbmeasure" which can be used to
> determine dB attenuation data for alsa mixer controls. I have now
> extended this little dB tools suite to include a tiny tool "dbverify"
> that can be used to verify the correctness of existing dB data exposed
> by the drivers. It should be relatively easy to use that tool,
> suitable even for non-guru folks who want to debug the dB information
> from alsa.
>
> http://git.0pointer.de/?p=dbmeasure.git
> git://git.0pointer.de/dbmeasure.git
>
> Just run "make" in a git checkout and then try:
>
>   $ ./dbverify Aureon51MkII Master 30 200
>
> That will verify the dB data of the "Master" control of the sound card
> that goes by the id "Aureon51MkII". It will compare the discrete
> volume steps 30 and 200: first it will play a full amplitude sine wave
> at mixer volume step 30, and then will change to mixer volume step
> 200, but attenuate the sine wave in software compensating for the
> volume change. So once you hear the sine wave attenuated by the hw,
> and once by the software. If the card's dB data is correct both sines
> should have the same volume.
>
>
> Lennart
>
>
Finally have time and an analog loop back cable to test your program
dbverify.c

It really depend on your ear to do the verifcation which is not really
scientific

Unfortunately , I am unable to run dbmeasure on both of my au8830 and HDA
sound card

Can you provide any test result of your HDA sound card ?

!) The program dbmeasure.c seem underrun easily since you start the device
and waiting for the user to press enter key

2) it expect the sound driver can provide exactly 1 second buffer because
your logic is generate one second sample,  Neither au8830 nor HDA driver can
provide exactly one second buffer
