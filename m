From: Lars Schotte <lars.schotte@schotteweb.de>
Subject: C-Media CMI8738-LX noise in recording from line in
Date: Thu, 1 Apr 2010 03:18:25 +0200
Message-ID: <20100401031825.557be2bc@romy.gusto>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ms16-1.1blu.de (ms16-1.1blu.de [89.202.0.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 5246910380C
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 03:18:31 +0200 (CEST)
Received: from [78.99.186.124] (helo=romy.gusto)
	by ms16-1.1blu.de with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69) (envelope-from <lars.schotte@schotteweb.de>)
	id 1Nx93D-000755-QO
	for alsa-devel@alsa-project.org; Thu, 01 Apr 2010 03:18:27 +0200
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

I have this Sweex Sorround sound card PCI and I want to use it for
recording / digitalizing / magnetic and other media types through
line-in. I have to use that card (or another) because the built-in
sound card doesnt work /is broken/.

The soundcard has following chipset - C-Media CMI8738-LX.

So I try to record from the line in input, which works for listening,
so line in input is played good through line out then. I dont know if
there is a passthrought or sth. however, when I record it, using
audacity, or even alsarecord / it doesnt matter / the sound is reported
and also actually is too silent and there is a lot of noise. So with
that noise, this card is for digitalizing useless.

this soundcard has physically no shared connector with the rear, or
bass or whatever. so there are 5 connectors, line in, mic in, front,
rear and cent/sub. each for himself. maybe thats the case, that the old
ones did have shared one and therefore it breaks the recording or
whatever, just a theory. because a few years ago i had an old cmipci
and that one worked fine.

just to be clear, there is sound, so it records, the problem is that
its too silent and there is a lot of noise in it. i write this note
because I saw some reports that suggest that it produces _only_ noise
in recording. thats not the case here.

-- 
-------------------
Lars Schotte @ romy
