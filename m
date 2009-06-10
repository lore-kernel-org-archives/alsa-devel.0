From: Lex Wassenberg <lex.wassenberg@gmail.com>
Subject: Re: Sound streaming application: which device to use?
Date: Wed, 10 Jun 2009 11:42:47 +0200
Message-ID: <45c981ab0906100242g234bfa08u8137c58bd08b9960@mail.gmail.com>
References: <45c981ab0906040428v3910cbcfq7e3024b23f6653e1@mail.gmail.com>
	<45c981ab0906090701t209abbc6jda420e4e666c5198@mail.gmail.com>
	<75b66ecd0906091942vae43f8bq2162fe3832ec424e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f218.google.com (mail-fx0-f218.google.com
	[209.85.220.218])
	by alsa0.perex.cz (Postfix) with ESMTP id 041361037F8
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 11:42:47 +0200 (CEST)
Received: by fxm18 with SMTP id 18so600457fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2009 02:42:47 -0700 (PDT)
In-Reply-To: <75b66ecd0906091942vae43f8bq2162fe3832ec424e@mail.gmail.com>
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

On Wed, Jun 10, 2009 at 4:42 AM, Lee Revell<rlrevell@joe-job.com> wrote:
> On Tue, Jun 9, 2009 at 10:01 AM, Lex Wassenberg<lex.wassenberg@gmail.com>=
 wrote:
>> Is there nobody that can help me out on the questions above? I figured
>> the answer to question 4 (passing a pointer to an uninitialized
>> integer; I thought the integer was only used for reporting back, which
>> is not true), but all other questions still stand. Nobody??
>
> You don't provide enough info. =A0What soundcard? =A0What distro? =A0What=
 is
> the output of =A0"aplay -v file.wav" when file.wav is the same audio
> format your app uses?
>
> Lee
>

The distro is OpenSuse 10.3 , the soundcard doesn't (or shouldn't)
matter: the application program knows nothing about the soundcard and
it doesn't want to either. It should just use that sound card that is
present on the machine where it runs. I thought that it would be ALSA
that takes care of the particularites of the underlying hardware.
That's why I programmed the device to be "default" or "plughw".

For the requested output of the aplay program I would first have to
find a wave file with the specific format.

Lex
