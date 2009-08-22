From: arif setiawan <n.arif.setiawan@gmail.com>
Subject: Re: ALSA synchronization
Date: Sat, 22 Aug 2009 18:50:14 +0700
Message-ID: <c697747b0908220450j79489e6fmc037a85024aaeecc@mail.gmail.com>
References: <c697747b0908210037g341b0a52mdff52c955d5814a1@mail.gmail.com>
	<4A8E654D.1040700@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f187.google.com (mail-iw0-f187.google.com
	[209.85.223.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 796AB246A8
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Aug 2009 13:50:15 +0200 (CEST)
Received: by iwn17 with SMTP id 17so523155iwn.16
	for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2009 04:50:14 -0700 (PDT)
In-Reply-To: <4A8E654D.1040700@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

We are working on audio processing (encryption-decryption) and audio will be
sent using radio.

Our configuration is :

Audio source - ALSA audio in - encryption - ALSA audio out - transmission
over radio (now we still use audio cable) - ALSA audio in - decryption -
ALSA audio out - speaker.

So data will be sent through radio channel and its converted to analog form
by ALSA PCM during playback. We want to solve synchronization issue by using
data header so that we can decrypt correct data block. So far we still
unable to verify that data we received in the decryption side is similar to
data that we sent from encryption box. Supposed that we filled buffer in
encryption box with some values, when we check buffer in decryption box, we
can't get same data. Our guess that data somehow changed in
digital-analog/analog-digital conversion or we might make mistakes in
filling the buffer so data is not compatible with ALSA PCM.

Any suggestion to solve this problem?

Thank you,

Best Regards,

Arif
