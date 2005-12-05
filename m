From: Pierre-Antoine Champin <alsa-050822@champin.net>
Subject: Re: Input gain on M-Audio Audiophile USB
Date: Mon, 05 Dec 2005 12:24:54 +0100
Message-ID: <43942386.10807@champin.net>
References: <8a0c36780512050019k3ef806c3h2cb8b9b5edb03088@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060405060104060909070204"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <8a0c36780512050019k3ef806c3h2cb8b9b5edb03088@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Richard Smith <smithbone@gmail.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060405060104060909070204
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Richard Smith a =C3=A9crit :
> Anybody have any idea how to change the line in input gain on the
> M-Audio Audiophile USB?  The way its currently set renders it useless.
>  It's just too hot.   If you connect any normal line level source up
> to it it just bangs the input rails.
>=20
> Alsamixer tells me there is not a mixer.
>=20
> I know its possible because if you try the same setup under win2k then =
it works.
>=20
> I've tried 1.0.9 and 1.0.10rc3 and they have the same behavior.

I've not tried it recenrly, but the last time I did, I first thought I
had a gain problem, while this was actually a wrong byte order: it was
neither low-endian nor big-endian, but a strange mix, causing low-weight
values to be considered high-weight, hence the saturation impresson.

Filtering the input through a program which changes the order of the
bytes (a,b,c -> c,a,b) gives a good sound; but of course, it kills latenc=
y!

I attach the script I used to test that. I'm not sure this is the
problem you have, but it is worth a try.

  Pierre-Antoine



--------------060405060104060909070204
Content-Type: text/x-python;
 name="swap2.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swap2.py"

#!/usr/bin/python
import sys

while True:
    try:
        a,b,c = sys.stdin.read (3)
        sys.stdout.write ("".join ((c,a,b)))
    except ValueError:
        break

--------------060405060104060909070204--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
