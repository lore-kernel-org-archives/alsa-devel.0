From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH v3 00/11] ALSA: usb-audio: fix
 playback/capture concurrent usage
Date: Sun, 1 Sep 2013 10:54:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309011046440.1341@heraclitus>
References: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
 <CALGY4fuux1=qy14eCfcGDcPmARAw6C+MqEEuwL=KF_-mVmUJ+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-116058531-1378025651=:1341"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f43.google.com (mail-ee0-f43.google.com [74.125.83.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A00DA2607D7
 for <alsa-devel@alsa-project.org>; Sun,  1 Sep 2013 10:54:12 +0200 (CEST)
Received: by mail-ee0-f43.google.com with SMTP id e52so1709386eek.2
 for <alsa-devel@alsa-project.org>; Sun, 01 Sep 2013 01:54:12 -0700 (PDT)
In-Reply-To: <CALGY4fuux1=qy14eCfcGDcPmARAw6C+MqEEuwL=KF_-mVmUJ+g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nikolay Martynov <mar.kolya@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-116058531-1378025651=:1341
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


On Mon, 26 Aug 2013, Nikolay Martynov wrote:

> Hi.
>=20
> =A0 I've tried this patch and can confirm that it fixes the issue with =
CM108 based USB headset I've described on the list several days ago (trie=
d with Skype).
> =A0 Thank you!

That's great - I'm glad it solved your issue and thank you for testing!

There's still some issues I bump into at the moment, hopefully I will=20
find the time to resolve them before the 3.13 window.

Cheers,
Eldad

>=20
>=20
> 2013/8/25 Eldad Zack <eldad@fogrefinery.com>
>       Hi,
>=20
>       This patch series attempts to fix a long standing problem with th=
e concurrent
>       usage of playback and capture on implicit feedback devices.
>=20
>       Applies against current for-next (HEAD 68538bf2bce557c3b5fe8c59b0=
34d45352500db1 ).
>=20
>       v2:
>       =A0http://mailman.alsa-project.org/pipermail/alsa-devel/2013-Augu=
st/065649.html
>       v1:
>       =A0http://mailman.alsa-project.org/pipermail/alsa-devel/2013-Augu=
st/065517.html
>=20
>       =A0* Changed "altset_idx" to "altsetting" thanks to Clemens' clar=
ification.
>=20
>       =A0#3: Thanks to Daniel's test, fixed a NULL dereference caused b=
y userspace calling
>       =A0 =A0 =A0snd_pcm_open() and then snd_pcm_close() immediately.
>       =A0#8: subs->altset_idx was left intact, since it corresponds to =
the array index.
>       =A0#10: this patch now removed subs->altset_idx, but also changes=
 the check to be
>       =A0 =A0 =A0 performed against fmt->altsetting.
>       =A0#11: New. This changes the name of snd_usb_endpoint member alt=
_idx to altsetting
>       =A0 =A0 =A0 for the same reason Clemens described.
>=20
>       Clemens and Daniel - thank you very much for your help!
>=20
>       Cheers,
>       Eldad
>=20
>       Eldad Zack (11):
>       =A0 ALSA: usb-audio: remove unused parameter from sync_ep_set_par=
ams
>       =A0 ALSA: usb-audio: remove deactivate_endpoints()
>       =A0 ALSA: usb-audio: prevent NULL dereference on stop trigger
>       =A0 ALSA: usb-audio: don't deactivate URBs on in-use EP
>       =A0 ALSA: usb-audio: void return type of snd_usb_endpoint_deactiv=
ate()
>       =A0 ALSA: usb-audio: clear SUBSTREAM_FLAG_SYNC_EP_STARTED on erro=
r
>       =A0 ALSA: usb-audio: correct ep use_count semantics (add set_para=
m flag)
>       =A0 ALSA: usb-audio: conditional interface altsetting
>       =A0 ALSA: usb-audio: conditional concurrent usage of endpoint
>       =A0 ALSA: usb-audio: remove altset_idx from snd_usb_substream
>       =A0 ALSA: usb-audio: rename alt_idx to altsetting
>=20
>       =A0sound/usb/card.h =A0 =A0 | =A0 4 +-
>       =A0sound/usb/endpoint.c | =A082 ++++++++++++++++++-------
>       =A0sound/usb/endpoint.h | =A011 +++-
>       =A0sound/usb/pcm.c =A0 =A0 =A0| 168 +++++++++++++++++++++++++++++=
+++++++++-------------
>       =A0sound/usb/pcm.h =A0 =A0 =A0| =A0 2 +
>       =A0sound/usb/proc.c =A0 =A0 | =A0 4 +-
>       =A06 files changed, 201 insertions(+), 70 deletions(-)
>=20
>       --
>       1.8.1.5
>=20
>       _______________________________________________
>       Alsa-devel mailing list
>       Alsa-devel@alsa-project.org
>       http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>=20
>=20
>=20
>=20
> --
> Martynov Nikolay.
> Email: mar.kolya@gmail.com
>=20
>=20
--8323328-116058531-1378025651=:1341
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--8323328-116058531-1378025651=:1341--
