From: Wolfram Nyaa~ <wolfram@ritsuka.org>
Subject: Re: VIA VT1828S: crash in alsamixer, no mic input
Date: Sat, 29 Jan 2011 23:09:12 +0600
Message-ID: <4D4449B8.1080906@ritsuka.org>
References: <4D439AE2.1010101@ritsuka.org> <s5hlj24artp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070102030106050301030808"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A8DA8103803
	for <alsa-devel@alsa-project.org>; Sat, 29 Jan 2011 18:09:02 +0100 (CET)
Received: by fxm5 with SMTP id 5so4414862fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 29 Jan 2011 09:09:02 -0800 (PST)
In-Reply-To: <s5hlj24artp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070102030106050301030808
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

All information attached to linked thread.

On 01/29/2011 05:10 PM, Takashi Iwai wrote:
> At Sat, 29 Jan 2011 10:43:14 +0600,
> Wolfram Nyaa~ wrote:
>>
>> Hash: SHA1
>>
>> Hi.
>>
>> I've found crash in alsamixer and described it in comment 0023300 in the
>> following issue thread at bugtracker:
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5249
> 
> Could you attach the output of alsa-info.sh (run with --no-upload
> option)?  Which kernel version, alsa-driver version exactly?
> 
> 
> Takashi
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJNREm3AAoJEN9tENx5d7sAwUIIAJN5jbpKL7tz+qtTdgzLIr0c
mL7PBxZgRZRimkH8x37luO/F0MtxXO0m1FJVixXQhoZwP7I0q42JZgLyBwKp9ntS
/IPAWMnBrR2e7BkAwJGc5RMCEvlEpWR+p4EEOySs22hLM1LjPulmHnrbzTbP7+RY
WgIcWNAiTORnZs54FkkMwe7ffQ7CfObCZ+P74CTGh79ONKchulFtg8q8x6Y45fKE
iH2X0wyUMXaOqv4S9kG53TFdT8HnUwtYwjnkb8ZhZ6p19QrkeOmODTZzxt+8k9fj
1v3UaFjEW7Q7ohyk4/lK1FIXUhEk//oTtQX/tLUazfZBrCPYb3ZjOzatyGvbsIs=
=ryap
-----END PGP SIGNATURE-----

--------------070102030106050301030808
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

--------------070102030106050301030808
Content-Type: application/pgp-signature;
 name="0x7977BB00.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0x7977BB00.asc.sig"

iQEcBAABAgAGBQJNREm3AAoJEN9tENx5d7sAAJsH/12CI69qeWT7dj6UONzNI//yOHhtZJ5B
BNdWMqVilBJNDQEDZWbfZ7Hl5Fm4hHYNYHU3RcXePmtcY/sAOOkeRFdiYLRSjwxcJoZEPz6P
DT0PBysjZu+D4Kv0YrSb4sLvtIjtImYdFBpRfundcP6NLYLrvCI3xbyzMgEXRK7BesmGHuTH
mwRinSsA1uWesLGxgY2mgKmAVBuApjhyl3re+UK9Vgnz19r8hT+X/0ogdaozEoSDKPrqA+wc
UzneA50YMYc9zq+e3O/mNKLpvxsiVzUxwvWrGnzda23BI/njqtHC7MJ8uwbykdiTJC5WkeVq
k9aOOnVfdYVOFUdhThRFef0=
--------------070102030106050301030808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070102030106050301030808--
