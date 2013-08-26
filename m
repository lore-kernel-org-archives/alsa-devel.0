From: Proyecto MultiK <proyecto.multik@gmail.com>
Subject: Compiling pyalsa with the latest alsalib
Date: Mon, 26 Aug 2013 16:46:05 -0400
Message-ID: <CAJFtXBJKz1cm6nkHcBAJVsi3+qMz-PeKfHwjSs1jD+oH+KyDxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f196.google.com (mail-ve0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id D8439261B1F
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2013 22:46:06 +0200 (CEST)
Received: by mail-ve0-f196.google.com with SMTP id oz10so1015131veb.3
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2013 13:46:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: avasquezg@gmail.com
List-Id: alsa-devel@alsa-project.org

Hello,

Together with a team, I am working on a multiseat project for which we
need to access more than 32 sound cards on a Linux system (not all
used simultaneously).

We are running Ubuntu with a modified version of the 3.6.3 kernel. We
used the code from Takashi Iwai's sound repository to patch the
original 3.6.3 source to allow ALSA to recognize and name more than 32
devices (since there was a bug introduced in the 3.8 kernel which
threw a kernel panic when connecting more than 28 cards, we could not
use the latest kernel). Currently, we can detect more than 36 sound
cards, they have ids and names given in /proc/asound/cards. Before
applying Takashi's patches, they would stop being named at id = 31. So
this seems to be working all right.

The problem comes when trying to access the cards using pyalsa. We
downloaded the pyalsa 1.0.26 tar from
ftp://ftp.alsa-project.org/pub/pyalsa/pyalsa-1.0.26.tar.bz2. We need
to know how to compile pyalsa with the latest alsalib that supports
more than 32 cards. If we run  pyalsa.alsacard.asoundlib_version()
from the python interpreter, we get '1.0.25'. We know the latest
version is 1.0.27 and we have put the alsa headers in
pyalsa-1.0.26/pyalsa/alsa/ dir before compiling, but it doesn't seem
to compile using these files and keeps saying version is 1.0.25.

Guidance on this would be greatly appreciated.

Thanks,

Esteban Serrano
MultiK team
