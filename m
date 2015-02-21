From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Intel HDA / ALC662 analog surround problem
Date: Sat, 21 Feb 2015 23:56:30 +0800
Message-ID: <CAN8ccibQh643hZ+owuNVj86ic2H55NOz5huwWhQVJu7fa1h=MQ@mail.gmail.com>
References: <CAN8cciZPhv1wCQosYjj9MEhi+Ybz+6mho0H7fDC48QB9=GdCKQ@mail.gmail.com>
 <CAN8cciZwTRY8HSpK9iXmfy7VGiPw1wGO1wwdfyHYkzEv2dRMAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C6B72606AB
 for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2015 16:56:31 +0100 (CET)
Received: by mail-oi0-f41.google.com with SMTP id z81so7294565oif.0
 for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2015 07:56:30 -0800 (PST)
In-Reply-To: <CAN8cciZwTRY8HSpK9iXmfy7VGiPw1wGO1wwdfyHYkzEv2dRMAQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, ib@wupperonline.de
List-Id: alsa-devel@alsa-project.org

> I'm using alsa 1.0.28 (lib and utils). Everything works fine so far, i.e.
stereo output through speakers and headphone as well as S/PDIF and all
possible capturing.

> According to my mainboard manual, the codec supports 5.1 (analog)
surround by using the rear "line out" jack (for rear surround) and "mic"
jack (for center and sub) - which doesn't work. (I don't have even a clue
what to do to activate.)

> My questions:

> 1) Does 5.1 analog surround work for the ALC662? If yes, how?

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/plain/Documentation/sound/alsa/HD-Audio-Controls.txt

Channel Mode
  This is an enum control to change the surround-channel setup,
  appears only when the surround channels are available.
  It gives the number of channels to be used, "2ch", "4ch", "6ch",
  and "8ch".  According to the configuration, this also controls the
  jack-retasking of multi-I/O jacks.

>2) If not, is it a limitation of the kernel oder alsa?

>HDA-Intel.conf says:

> HDA-Intel.pcm.surround51.0 cards.HDA-Intel.pcm.front.0

> Does this mean that 5.1 surround is restricted to stereo in any case?

This mean softvol plugin is also used by 5.1 and stereo

Do "pcm playback volume" affect the volume after you change channel mode
from 2ch to 6 ch so that mic and line in jacks are retasked as output ?
