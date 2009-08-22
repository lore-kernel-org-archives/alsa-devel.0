From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: ALSA synchronization
Date: Sat, 22 Aug 2009 15:12:10 +0300
Message-ID: <1250943130.14167.113.camel@maxim-laptop>
References: <c697747b0908210037g341b0a52mdff52c955d5814a1@mail.gmail.com>
	<4A8E654D.1040700@superbug.co.uk>
	<c697747b0908220450j79489e6fmc037a85024aaeecc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
	by alsa0.perex.cz (Postfix) with ESMTP id D01AF1037F2
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Aug 2009 14:12:15 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 13so273813eye.56
	for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2009 05:12:15 -0700 (PDT)
In-Reply-To: <c697747b0908220450j79489e6fmc037a85024aaeecc@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: arif setiawan <n.arif.setiawan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2009-08-22 at 18:50 +0700, arif setiawan wrote:
> Hi,
> 
> We are working on audio processing (encryption-decryption) and audio will be
> sent using radio.
> 
> Our configuration is :
> 
> Audio source - ALSA audio in - encryption - ALSA audio out - transmission
> over radio (now we still use audio cable) - ALSA audio in - decryption -
> ALSA audio out - speaker.
> 
> So data will be sent through radio channel and its converted to analog form
> by ALSA PCM during playback. We want to solve synchronization issue by using
> data header so that we can decrypt correct data block. So far we still
> unable to verify that data we received in the decryption side is similar to
> data that we sent from encryption box. Supposed that we filled buffer in
> encryption box with some values, when we check buffer in decryption box, we
> can't get same data. Our guess that data somehow changed in
> digital-analog/analog-digital conversion or we might make mistakes in
> filling the buffer so data is not compatible with ALSA PCM.
> 
> Any suggestion to solve this problem?

Are you trying to say that you broadcast a digital data  over an analog
channel, and expect it to be unchanged, without any form of encoding,
error correction, etc...?

This is crazy!


Best regards,
	Maxim Levitsky
