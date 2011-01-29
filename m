From: Wolfram Nyaa~ <wolfram@ritsuka.org>
Subject: VIA VT1828S: crash in alsamixer, no mic input
Date: Sat, 29 Jan 2011 10:43:14 +0600
Message-ID: <4D439AE2.1010101@ritsuka.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070906000109020606040102"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id A6215243F2
	for <alsa-devel@alsa-project.org>; Sat, 29 Jan 2011 05:43:13 +0100 (CET)
Received: by bwz10 with SMTP id 10so4083849bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 20:43:13 -0800 (PST)
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

This is a multi-part message in MIME format.
--------------070906000109020606040102
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I've found crash in alsamixer and described it in comment 0023300 in the
following issue thread at bugtracker:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5249

Here is copypaste from it:
> Also I've found crash in alsamixer: when I'm trying to unmute "Smart 5.1" control it crashes with message "alsamixer: hcontrol.c:764: snd_hctl_handle_event: Assertion `elem' failed.", but control really unmutes. Muting control doesn't cause crash.
> 
> (gdb) bt
> #0 0x00007ffff6d45335 in raise () from /lib/libc.so.6
> #1 0x00007ffff6d465cf in abort () from /lib/libc.so.6
> #2 0x00007ffff6d3e4c1 in __assert_fail () from /lib/libc.so.6
> #3 0x00007ffff72d00d3 in snd_hctl_handle_events () from /usr/lib/libasound.so.2
> #4 0x00007ffff72d98c9 in snd_mixer_handle_events () from /usr/lib/libasound.so.2
> #5 0x0000000000405af1 in ?? ()
> #6 0x0000000000405096 in ?? ()
> #7 0x00007ffff6d31d2d in __libc_start_main () from /lib/libc.so.6
> #8 0x0000000000404679 in ?? ()
> #9 0x00007fffffffd688 in ?? ()
> #10 0x000000000000001c in ?? ()
> #11 0x0000000000000001 in ?? ()
> #12 0x00007fffffffda39 in ?? ()
> #13 0x0000000000000000 in ?? ()

Also could anybody give me some hints how to get microphone working with
my soundcard (problem is described in thread)?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEbBAEBAgAGBQJNQ5rfAAoJEN9tENx5d7sA1gUH9itsA4Hnly22lkei9FRRM22d
0ztVKKFiJq2kz4FAHgvUKr97OlW30b7O5ojbAXU3s6+//w8g//wt4+UsLHdWVKfC
RvFIb5sEUh2kdiwqcfAbNqrU27favRmKX9+ZjBXnw4Z6RNGiY8v/StwiuK/uB82h
xmC2Bx79Y5jHUnhSSS/kmSMgtiTxFqZrqxYyd/zA/yvth1CLIBgqKrl9oni29Y1n
VRFn45NB5DMbNREi4qS17lr37iUZ1j/VB6c9Odd4IWSnTCDn30QPZb8WZJNj2hHn
vqHemKdFKnPsMavs3OCjxcEplpoea3kQQjpfXjElPg+O3ZErcGvYqojsSW80fg==
=KPqa
-----END PGP SIGNATURE-----

--------------070906000109020606040102
Content-Type: application/pgp-keys;
 name="0x7977BB00.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0x7977BB00.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2.0.16 (GNU/Linux)

mQENBEt9gKIBCADoXrpv0rG/GfmnrHxnU/y/v+/8jX6Vi53kE7GvE/IL91W19+0D
EUdAoqpVtCs1OaVDYbv8bC1/2zerGWL2T7jyhxMzOKSRYkArLqYWdxIg9f2ZtC0/
BQJ299WkYFyHPZKPH8uSR4/iRSePASKFVHYcqk2n7Fq5AFVFtcDVeKscHcxEuVCD
4+iLobIxjbujiNGiLlnN2jfn2vS7gu+s9rDA4JdkmAGqwXLYS2o76anXQSxvBNOI
RNNaUd/AYgjum548kEIvxV1uBKG0yBvx1mvwNAw3OzXw1WTcOpAgKkukpXjin2Av
HrZINwD+xe7v6UJcat7akyC9fknITgHth0ejABEBAAG0I1dvbGZyYW0gTnlhYX4g
PHdvbGZyYW1Acml0c3VrYS5vcmc+iQE+BBMBAgAoBQJLfYCiAhsjBQkJZgGABgsJ
CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDfbRDceXe7AI0RB/4gdJZ7aAQBLxD7
8EU62joFBdnAjaWqNFYlCxWyvh8ZqSc4X87z6Zq9bGJ/wyCzX0zvTUBsKxm0Zg6f
1/0V0XPQlg7eXSDml6xB23pmFcytcy3vGQM+P3JJZ4491Vax0eb2dQJVNG93MqYO
aczSEBJd010BsoOLxgqSdN73mDaxacBSVZf9hXQHhj6/hzGo1ptn1MVCXWm+9NbU
eCgrQ8IZ5idBqWrF9UKajDoakc16TpvPvWueXBi1CKkdZC4wKgrGO3bj0HvMKZC+
fJVM4Jlaq1Zrhqfj0M1p6nLtwqChSzZawtylpZ5722edr/LLP5YgbpE7DqNTnY21
9aAbIrXquQENBEt9gKIBCAC3NiRrYWgQQgX20tt2xF/Tc6b4jBBNi8UsEIYLCYq/
pu8fJ40Y+1J7f9LbUtltu6nDTJG5k129qRDnFP0zIWNqBA+aSJlkotIPuCwRKiP6
ylEVS1O8JdTScmB9sPlEGqyPppYaVLDbOHCTrycvMbcjtThgpa4Lnx0crF94Atr9
vUWX3VEe9atZp8TcHQTflmFe1hGiUViB8el+PeeKz0llm3hYQ1rSniLjXqluUw++
y61rkPDwH6lOsNU7bvUdfIbz9OqHqkr4WhIsJzkpTU/liC91pegAgx9N1kb+1y3o
8Mzz6/L4AYmZnZFKSjlDOVfB8AgD87OEK4pQCTXUi4JlABEBAAGJASUEGAECAA8F
Akt9gKICGwwFCQlmAYAACgkQ320Q3Hl3uwBMpgf/adH26oGIJBGkLoY3o4Whv7p2
is7aFwt9wTOjIMv2gj8OTEj9nGMTgqajr46Xw14wCTz5CQU27jAzTd2w2miD/cKn
Wy8p1hLZvuYPlgUXaiErV07wJMiuUs+6GAUyd8aGRQjVJ0M2TFuTmDXTZUWs3/so
ZGUv1fbX7yXaZrWieHQLqIrWylWwiLG/6UqudoKhwfd02kkKoCGVTrR3Vckz0TER
KwgCxGtrh8nvGcFBfZyUNbTzekA5c+Tl1Ld24A+lizV4jJPnXszSCIC6gPu2hK11
8vNdSDp83SLW2WhGcuc4I9wHWeM/o2ISmSFbkx42I0xO3cKO2A2J1tTdOmDKyQ==
=msSC
-----END PGP PUBLIC KEY BLOCK-----

--------------070906000109020606040102
Content-Type: application/pgp-signature;
 name="0x7977BB00.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0x7977BB00.asc.sig"

iQEcBAABAgAGBQJNQ5rfAAoJEN9tENx5d7sAOD0H/iOeLuTrSZjy+gn8IPyv/ZiTXReeEAtL
YXSbbBqMyWmgAX56x33THBb6er6kW92V9l+qCU3Ffdcx6DezRnZW4t0qeAwtYHArFGyefSxD
731VOFfORI+FDaIN9srOofvYBtdTwheuY92l6wC0hZ1NQ9263MD1L4QbRcYeGOoNByolgDNF
gs+WjRMkA1L36P61eEVLS3Sd6uH2jf90yDcXT8AuNu4amBP0UjPHxUC+bMtIH9Y8uSOVzxJd
oJGHdaXDYEd78o2rq9gg/GohX8KaugiYliL7isIhmPU3fM5N862uwO1+ki8lZmgan4qGtEg9
HcCNGAl0vfctGutxE2rJeOA=
--------------070906000109020606040102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070906000109020606040102--
