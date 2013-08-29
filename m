From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Compiling pyalsa with the latest alsalib
Date: Thu, 29 Aug 2013 21:52:24 +0800
Message-ID: <CAN8cciau3wZZMaEEOxe_6p4bSi7a1+iYwZA-DkmTHqWXH_rn3w@mail.gmail.com>
References: <CAJFtXBJKz1cm6nkHcBAJVsi3+qMz-PeKfHwjSs1jD+oH+KyDxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id D8ABD26172B
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 15:52:25 +0200 (CEST)
Received: by mail-ie0-f169.google.com with SMTP id 10so734323ied.14
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 06:52:24 -0700 (PDT)
In-Reply-To: <CAJFtXBJKz1cm6nkHcBAJVsi3+qMz-PeKfHwjSs1jD+oH+KyDxg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Proyecto MultiK <proyecto.multik@gmail.com>
Cc: alsa-devel@alsa-project.org, avasquezg@gmail.com
List-Id: alsa-devel@alsa-project.org

>
> Together with a team, I am working on a multiseat project for which we
> need to access more than 32 sound cards on a Linux system (not all
> used simultaneously).
>
> We are running Ubuntu with a modified version of the 3.6.3 kernel. We
> used the code from Takashi Iwai's sound repository to patch the
> original 3.6.3 source to allow ALSA to recognize and name more than 32
> devices (since there was a bug introduced in the 3.8 kernel which
> threw a kernel panic when connecting more than 28 cards, we could not
> use the latest kernel). Currently, we can detect more than 36 sound
> cards, they have ids and names given in /proc/asound/cards. Before
> applying Takashi's patches, they would stop being named at id = 31. So
> this seems to be working all right.
>
> The problem comes when trying to access the cards using pyalsa. We
> downloaded the pyalsa 1.0.26 tar from
> ftp://ftp.alsa-project.org/pub/pyalsa/pyalsa-1.0.26.tar.bz2. We need
> to know how to compile pyalsa with the latest alsalib that supports
> more than 32 cards. If we run  pyalsa.alsacard.asoundlib_version()
> from the python interpreter, we get '1.0.25'. We know the latest
> version is 1.0.27 and we have put the alsa headers in
> pyalsa-1.0.26/pyalsa/alsa/ dir before compiling, but it doesn't seem
> to compile using these files and keeps saying version is 1.0.25.
>

You need to install alsa-lib 1.0.27.2

http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=2f43b66c06ece64529e482a6dcc95cde37648252
