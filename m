From: arif setiawan <n.arif.setiawan@gmail.com>
Subject: Re: ALSA synchronization
Date: Sun, 23 Aug 2009 08:15:16 +0700
Message-ID: <c697747b0908221815w66d00cddrda40f7c505717e47@mail.gmail.com>
References: <c697747b0908210037g341b0a52mdff52c955d5814a1@mail.gmail.com>
	<4A8E654D.1040700@superbug.co.uk>
	<c697747b0908220450j79489e6fmc037a85024aaeecc@mail.gmail.com>
	<ad2655cb0908221510l30c42941x3140441a263e91fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f187.google.com (mail-iw0-f187.google.com
	[209.85.223.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 5981C2455D
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Aug 2009 03:15:17 +0200 (CEST)
Received: by iwn17 with SMTP id 17so617611iwn.16
	for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2009 18:15:16 -0700 (PDT)
In-Reply-To: <ad2655cb0908221510l30c42941x3140441a263e91fe@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>, maximlevitsky@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Thank you for the input. I think we have been neglecting digital-analog
conversion issue until now. We don't have any experiences in broadcast a
digital data over an analog channel.

I think we should learn encoding, modulation and error correction now using
google and others. That being said, I think this is not ALSA domain,
however, any references and working example would be helpful for us.

Thank you,

Best Regards

Arif



On Sun, Aug 23, 2009 at 5:10 AM, James Courtier-Dutton <
james.dutton@gmail.com> wrote:

> 2009/8/22 arif setiawan <n.arif.setiawan@gmail.com>:
> > Hi,
> >
> > We are working on audio processing (encryption-decryption) and audio will
> be
> > sent using radio.
> >
> > Our configuration is :
> >
> > Audio source - ALSA audio in - encryption - ALSA audio out - transmission
> > over radio (now we still use audio cable) - ALSA audio in - decryption -
> > ALSA audio out - speaker.
> >
> > So data will be sent through radio channel and its converted to analog
> form
> > by ALSA PCM during playback. We want to solve synchronization issue by
> using
> > data header so that we can decrypt correct data block. So far we still
> > unable to verify that data we received in the decryption side is similar
> to
> > data that we sent from encryption box. Supposed that we filled buffer in
> > encryption box with some values, when we check buffer in decryption box,
> we
> > can't get same data. Our guess that data somehow changed in
> > digital-analog/analog-digital conversion or we might make mistakes in
> > filling the buffer so data is not compatible with ALSA PCM.
> >
> > Any suggestion to solve this problem?
> >
>
> Where is the conversion from digital to analogue on the output direction?
> Where is the modulation and error correction happening on the radio
> bit, in between the encrypt and decrypt steps.
> You should probably do a test without the encrypt and decrypt stages,
> and just ensure the input equals the output.
>
> Kind regards
>
> James
>
