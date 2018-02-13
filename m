From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - JACK PCM plugin] jack: Use boundary as
 hw_ptr wrap around
Date: Tue, 13 Feb 2018 14:56:08 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684F8B9B@HI2EXCH01.adit-jv.com>
References: <1516794545-9868-1-git-send-email-twischer@de.adit-jv.com>,
 <s5heflp4fcl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 92312267955
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 15:56:21 +0100 (CET)
In-Reply-To: <s5heflp4fcl.wl-tiwai@suse.de>
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

Hello Takashi,

> This has nothing to do with the reported position.  If this happens,
it simply means an XRUN.  You should report the error instead.

When the ALSA buffer is full and the JACK daemon is requesting exactly the =
amount of samples of the buffer size
I do not see an under run here.
After such an operation the ALSA buffer is empty
but the JACK daemon has not read more samples than available.

Exactly in this case we would increment the hw_ptr +=3D buffer_size
but this would not be recognized by the ALSA library
when we are using a wrap around of  buffer_size.


> No, the ioplug backend has to report the position from 0 to buffer_size.

I know but I think the ioplug API implementation has possibly to be changed=
 to allow exactly such use cases
as described above.

Or do you have another idea how to report such a hw_ptr change?

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
