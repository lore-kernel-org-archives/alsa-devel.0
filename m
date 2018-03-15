From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - JACK 1/1] jack: Use internal
 snd_pcm_state to reduce amount of additional variables
Date: Thu, 15 Mar 2018 15:07:31 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FDCEB@HI2EXCH01.adit-jv.com>
References: <s5hefl3izpf.wl-tiwai@suse.de>
 <1521118587-6319-1-git-send-email-twischer@de.adit-jv.com>
 <1521118587-6319-2-git-send-email-twischer@de.adit-jv.com>,
 <s5hk1ud7744.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 56A4F267274
 for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2018 16:07:42 +0100 (CET)
In-Reply-To: <s5hk1ud7744.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> We need to check it, of course.  But the behavior of the prepare
> function is certainly different from others, so it's more likely a
> bug.

I could provide a fix for the IO plug API for prepare and draining.

> This should be notified to ioplug via snd_pcm_ioplug_set_state().

Without an additional variable snd_pcm_ioplug_set_state() has to be called =
from the JACK thread.
But snd_pcm_ioplug_set_state() is not thread safe.


> That'd be great if everything is ready, but this can't be a reason to
> add a shadow state and modify the code as in the patch for now.

At the end I would like to use functions similar to READ_ONCE() and WRITE_O=
NCE() to access the state (known from the Linux kernel [1]).
But I think this should not be part of the ALSA library because it is for m=
ost IO plugins not required.
Therefore I need to have an internal copy of the state which will only be a=
ccessed with READ_ONCE() and WRITE_ONCE().

You are right, it is not yet required but at the end I have to implement it.

Do you think we should implement such a synchronization into the ALSA lib?

[1] https://www.kernel.org/doc/Documentation/memory-barriers.txt

Best regards

Timo Wischer

Advanced Driver Information Technology GmbH
Engineering Software Base (ADITG/ESB)
Robert-Bosch-Str. 200
31139 Hildesheim
Germany

Tel. +49 5121 49 6938
Fax +49 5121 49 6999
twischer@de.adit-jv.com

ADIT is a joint venture company of Robert Bosch GmbH/Robert Bosch Car Multi=
media GmbH and DENSO Corporation
Sitz: Hildesheim, Registergericht: Amtsgericht Hildesheim HRB 3438
Gesch=E4ftsf=FChrung: Wilhelm Grabow, Ken Yaguchi
