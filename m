From: Pascal Wichmann <pascal.wichmann@pa-w.de>
Subject: Re: Problems with the DP MST audio support patchset
Date: Sat, 1 Apr 2017 18:51:47 +0200
Message-ID: <9e87ff00-2676-1f0a-a630-644f845b82db@pa-w.de>
References: <6800ee6e-31c2-b5eb-fbb2-6826d8c66dc9@pa-w.de>
 <bceb4859-6dc9-b7a8-4d3a-81ac2a1fa907@pa-w.de>
 <96A12704CE18D347B625EE2D4A099D19524850F3@SHSMSX103.ccr.corp.intel.com>
 <63a71394-1cd4-e3e3-7364-37c2da90c791@pa-w.de>
 <96A12704CE18D347B625EE2D4A099D19524854BD@SHSMSX103.ccr.corp.intel.com>
 <49ff23f3-7c58-abf1-f1ff-87822f0b0585@pa-w.de>
 <96A12704CE18D347B625EE2D4A099D19524866B0@SHSMSX103.ccr.corp.intel.com>
 <s5hlgrl1mty.wl-tiwai@suse.de> <e92f2266-c911-cbad-643a-3ce5d757f4a5@pa-w.de>
 <s5hy3vlf80j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web02.pwsrv.de (web02.pwsrv.de [188.68.38.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D6D926680A
 for <alsa-devel@alsa-project.org>; Sat,  1 Apr 2017 18:51:49 +0200 (CEST)
In-Reply-To: <s5hy3vlf80j.wl-tiwai@suse.de>
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
Cc: "Yang, Libin" <libin.yang@intel.com>, Libin Yang <libin.yang@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Takashi,


> It's a general problem with many digital receivers.  When the 
> stream stops, a digital receiver turn itself off until it 
> re-receives a new stream.  And this on/off takes a few seconds.

> Thus, you must not stop the stream, but you'd need to keep sending
>  the silent stream even if you stop a playback.

Thank you for your explanation.

I have made sure that the following process is always running when
pulseaudio is:
> play -n -c1 synth sin gain -100 > /dev/null 2>&1 &
This way, there is always a stream that never stops. The problem of the
silent
second after starting new audio is solved by that. (I have made sure
that the correct output card is used.)

However, every few minutes, the stream still seems to be gone for half a
second; even during active additional audio playback (as well as the
above sox command), the audio output is silenced for a second and the
icons on my
receiver are gone meanwhile.
Though, pulseaudio does have an output stream all the time without any
pause. So there seems to be some other place where the outgoing DP MST
stream is lost, delayed or interrupted causing this issue.

During the last few hours, the period of this disruption has been quite
consistent between every 4 and 6 minutes.

Do you have any other ideas what might cause this or where parts of
the stream could get lost?


Regards,
Pascal

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE/gJ8Tpn0OtJz8hxD6+YIa34W/zYFAljf2psACgkQ6+YIa34W
/zYbuBAAqw9a8Zit8+Cz6enweiC+BibXUbD448yIPf9yGVxXNdPb9lYtvw/lpHi1
n+E9aY5yyBzI0k0Dd4MAtmecQFm33idwIjIGVQWZpSibkJL+uec+l8FtzNKzvP4o
TIai0TJqbrn8MNaHcxZQyDgXpew9JWoJS2iXu3RB6Gr/R3xo6o08yiwjvMEVaZAv
B/ZHEok+2G+pF1eW5j/47Ka+CD6tzJ2hx/8at19eY4Ulrca+b20jMQOxKSAShyWY
8FVasjF9VCA9labqRc0UNATaE+yjt/kHTKHHaWuMz+2NqMDxZy0UJEjAhQi6P6Wd
C5rqz6BcPm3cxCipBFLVU/QdumGx6Ym0vajPcT1Z2a0a7X0mQugL9tzDhZlTGRk7
fC6UNqbM3uqOmNvT9srIeBXJmpxKPP9uQ3yK2HYSQsXB6VVGcjgeWCVflihJrxK2
w4/ztFZTqXpSlryKnlH8YsKcZz2HOsRJnqpIYnDFjl4Urd8eyP+i4xMrCL7oNhsV
NdCMbK2/V9/eNldH3lyKmI/t/iYo9sR/xGKj7d1JnRw6ln2zFLSnAEV9jO1k8z1u
wbPblxmJN4rq9xi3PPym10m94PsCreTBy2RRCsf/9n69Qj+ZJSMKI8AI6VWxnHFB
AoqLP/Fif3ExdbUwFRUtUAj3e6CLRiBkYvkV4DbpBLb5USnLV2Y=
=oiIk
-----END PGP SIGNATURE-----
