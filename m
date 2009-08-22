From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: ALSA synchronization
Date: Sat, 22 Aug 2009 23:10:23 +0100
Message-ID: <ad2655cb0908221510l30c42941x3140441a263e91fe@mail.gmail.com>
References: <c697747b0908210037g341b0a52mdff52c955d5814a1@mail.gmail.com>
	<4A8E654D.1040700@superbug.co.uk>
	<c697747b0908220450j79489e6fmc037a85024aaeecc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 84B5624437
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Aug 2009 00:10:24 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e21so351659fga.21
	for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2009 15:10:23 -0700 (PDT)
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

2009/8/22 arif setiawan <n.arif.setiawan@gmail.com>:
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
>

Where is the conversion from digital to analogue on the output direction?
Where is the modulation and error correction happening on the radio
bit, in between the encrypt and decrypt steps.
You should probably do a test without the encrypt and decrypt stages,
and just ensure the input equals the output.

Kind regards

James
