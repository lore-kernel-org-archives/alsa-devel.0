From: Juan Pedro =?utf-8?Q?Bol=C3=ADvar?= Puente <raskolnikov@gnu.org>
Subject: Re: usb: Novation Twitch not working on Linux 4.7
Date: Wed, 21 Sep 2016 19:39:28 +0200
Message-ID: <877fa5p2y7.fsf@gnu.org>
References: <87intpbkkd.fsf@gnu.org>
 <aa460413-a017-cf4b-e35a-cfe3ed2eb890@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1784935707779637658=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eggs.gnu.org (eggs.gnu.org [208.118.235.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 77AE82666EB
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 19:39:48 +0200 (CEST)
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raskolnikov@gnu.org>) id 1bmlUo-0007sE-Dt
 for alsa-devel@alsa-project.org; Wed, 21 Sep 2016 13:39:47 -0400
In-Reply-To: <aa460413-a017-cf4b-e35a-cfe3ed2eb890@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Mark Hills <mark@xwax.org>
List-Id: alsa-devel@alsa-project.org

--===============1784935707779637658==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Clemens Ladisch <clemens@ladisch.de> writes:

> Juan Pedro Bol=C3=ADvar Puente wrote:
>>   $ aplay -D hw:Twitch -f S24_3LE -c 4 -r 44100 test.wav
>>
>>       Playing raw data 'prueba.wav' : Signed 24 bit Little Endian in 3by=
tes, Rate 44100 Hz, Channels 4
>>       aplay: set_params:1361: Unable to install hw params:
>
> Any error message in the system log?

Hmmm, today, the weirdest thing happened.  It worked!  For a while...
It worked with aplay, mplayer and jackd.  Then I tried with Mixxx (with
ALSA output) and it got "broken".  I reboot: it works again.  I even get
it to work on Mixxx.  But then I press "query devices" on Mixxx and it
gets "broken" again.  I reboot to try to see if I can make the sequence
reproducible: it does not work anymore.  I reboot: again and again and
again and it does not work.

When I say "it does not work" the symptons are exactly the same as I
said before.  Additionally, I just tried looking at `dmesg`, and I see
lots of this:

    [ 116.551873] usb 2-1.2: cannot submit urb 0, error -28: not enough
    bandwidth

Lol, one last funny thing.  I just tried again as I was writing this
Email: now it is working with all programs.  Oh, no!  I press "Query
devices" on Mixxx and it gets broken again.

I look at the logs for a while, nothing new.

Oh, now it works again!  This is driving me crazy...

Thanks anyways for the responses :-)

  JP

=2D-=20
                                 =E2=88=BF=E2=88=BF=E2=88=BF=E2=88=BF
                         https://sinusoid.es
                                 =E2=88=BF=E2=88=BF=E2=88=BF=E2=88=BF

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX4sXRAAoJEFKbqWJpCnCxMU4QAKO1Exno0Qqp3JUubAda9l0/
zJvZLZEz/KkYXQ71cK8t4aaglqHw0rXZnH/T6oe9XQ9I884JSDbN39tKpfNJPGnC
DLqJ9AiUfV4UWn1FhVT6yE8WG9SujH6l3zl4M21Gws69TFOYxrViR8hh3LVY0EUm
kmca8zf8MXBN4pjNRiC1Pk9pB5inZF/VkETx3ZbkCBBYmmwEETgj4JuAyzlzupBv
Il/Ww617+z6qPVGr4QlXI+VdM1Yo7GcXKMrJwjelR5R44MboOi7BWkwlBVuJKvWx
HMgngxPRyhc5O1wxD/8Fgi7p9PRup1ukA+ms4sV/IZTMj2ZYYJC87zVVrk7Thy6j
ZvH1Oe4XVEH7nBHY/EjohY1k2+gxmsqK33SnFbT62weYS4Pg2LL3eZADZx5yidyB
jB43MfhRPC/TkiZe4nsDQOq6jv4ke/WJ75shUBWXyqKc6bHEYNrpVl5ihKy4v6Xf
yV5BEqFuckMBab8Ijf8umpdlKEM9X4HdMAMPac8KB5C14o7+gHX2pBxXffWep4c/
hvbEPZCa28otjVnQlI2sT3mdYF+vqbH9BJSKBQzAiST0OZh3yfsdeMF36I7XEdKY
xOPGs6yzpX9qAYXsZMMYVW5CDblPvmgP2prfJ3/GE0Nsvc1hfbZp7lovpbRHrbSF
eeCwmW0Zlsx1GxNgo+/Z
=2jVC
-----END PGP SIGNATURE-----
--=-=-=--

--===============1784935707779637658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1784935707779637658==--
