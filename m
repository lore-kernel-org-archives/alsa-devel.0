From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: Audio capture on embedded system (via USB port)
Date: Tue, 2 Apr 2013 23:56:04 +0200
Message-ID: <CAOf5uwkEY08eOBVN+aGLAw_02kgF78LPCAQaLZ=Ynxg1Mdp=5A@mail.gmail.com>
References: <BLU150-W51D42B9941715DD322B6328FDF0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f178.google.com (mail-ia0-f178.google.com
 [209.85.210.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 47A0426525F
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2013 23:56:06 +0200 (CEST)
Received: by mail-ia0-f178.google.com with SMTP id r13so708251iar.23
 for <alsa-devel@alsa-project.org>; Tue, 02 Apr 2013 14:56:05 -0700 (PDT)
In-Reply-To: <BLU150-W51D42B9941715DD322B6328FDF0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Israel Alejandro Arriaga Trejo <israel.alejandro.arriaga.trejo@outlook.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

Il giorno 02/apr/2013 23:47, "Israel Alejandro Arriaga Trejo" <
israel.alejandro.arriaga.trejo@outlook.com> ha scritto:
>
> Hello,
>
> I am writing to kindly ask for assistance with ALSA on an embedded
platform, in particular to record audio via a USB headset. The embedded
platform I am currently using has analog inputs and outputs for audio (mic
and headphone). So far I have been able to play and capture audio using the
analog audio inputs/outputs with the commands aplay and arecord
respectively from ALSA without any problems. However this is not the case
when I am trying to use a USB headset via the USB port, at least while
trying to record audio (playing audio is not a problem, it works perfectly
fine for different rates and formats and the devices are recognized when I
type aplay =96l or arecord -l).  However, when I try to capture audio, using
the ALSA command line arecord as in:
>
> $ arecord =96d 10 =96r 16000 =96f S16_LE =96t wav  =96Dhw:1,0  test.wav
>

I have done recently the same but with highter frequency and resolution.
What kernel version you have?

My version is 3.8 Series on omap3 cpu + ehci fix for isoc transaction.

Michael

> even though the following message appears:
>
> $ Recording WAVE  =91test.wav=92 : Signed 16 bit Little Endian, Rate 16000
Hz, Mono
>
> the application seems =93to freeze=94.  In fact, the recording does not s=
top
in the indicated 10 seconds, instead it continues =93working=94 for a long
period of time and creates the file test.wav which after is played it
contains fragments of what actually was recorded via the microphone
nonetheless, its content is unintelligible. In some cases the following
error also appears:
>
> $ arecord: pcm_read:1617: read error: Input/Output error
>
> As mentioned previously this behavior is only observed during capture
mode (while attempting to record using the microphone) since the playback
mode using the USB headphone works properly. After browsing for a while I
have found similar situations reported, however I have not been able to
find a solution to my problem.
> I would highly appreciate for any hint that could help me to solve this
issue.
>
> Best regards,
>
> Alejandro
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
