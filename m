From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Documentation Request
Date: Wed, 4 Sep 2013 08:04:17 +0200
Message-ID: <CAFz=ag42pNW3GOMcXed0PQvK1fgk3AtXQ0fizm=0LNGG9-KYgg@mail.gmail.com>
References: <CAPOzVs4y7qc6PGps+rPzAKUUXJPuJSBowaqc2jnb=vRe9QchNg@mail.gmail.com>
 <522685BA.2030904@blennerhassett.gen.nz>
 <CAPOzVs5XUZ8RvcC4wTRp1sYZz7PP4UjnKu=qUzUcwdHkB-ta6Q@mail.gmail.com>
 <CACckToUBiwJg1TUMuw3eFws_rvf9qc3ZPfSzy7MRCB8b0JEnRg@mail.gmail.com>
 <CAPOzVs4+Sd=UXZ3gMGSNwMk1EW_yKPK+7dTo_vuWD_acyrWw6g@mail.gmail.com>
 <CAPOzVs7TiHEA2Fc9k40X58P-a2QCUzXcLLSU_B27aFbsbO0ztQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A6242654C3
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 08:04:17 +0200 (CEST)
Received: by mail-la0-f48.google.com with SMTP id er20so5477213lab.35
 for <alsa-devel@alsa-project.org>; Tue, 03 Sep 2013 23:04:17 -0700 (PDT)
In-Reply-To: <CAPOzVs7TiHEA2Fc9k40X58P-a2QCUzXcLLSU_B27aFbsbO0ztQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carl Canuck <carl.canuck.official@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 04.09.2013 05:16 schrieb "Carl Canuck" <carl.canuck.official@gmail.com>:
>
> > 7.  Is it really so unreasonable to ask for a basic example of a common
> > use-case for ALSA without being told that I should just abandon the
quest
> > for that knowledge and put my faith in the Jack developers?

It is unreasonable to think of *your* use case as a *common* use case for
ALSA. It is a common use-case for Jack. I don't know of any program doing
all of this on plain ALSA grounds (maybe except for Pd which ironically
doesn't work for me with the ALSA driver but only with Jack.)
Moreover, using Jack is (almost) the only reliable way to get full duplex
audio on some implicit feedback USB interfaces because it implicitly works
around a current (still?) limitation of the ALSA driver.

Regards, Felix
