From: Grond <grond66@riseup.net>
Subject: [PATCH] [alsa-utils.git] Fix a strange regression in
 aplay's '-d' option
Date: Sat, 5 Sep 2015 02:39:10 -0700
Message-ID: <20150905093910.GA5618@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2059421414202467979=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by alsa0.perex.cz (Postfix) with ESMTP id AD52B261A5E
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2015 00:40:43 +0200 (CEST)
Received: from cotinga.riseup.net (unknown [10.0.1.161])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "*.riseup.net",
 Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
 by mx1.riseup.net (Postfix) with ESMTPS id 81ECEC1C0A
 for <alsa-devel@alsa-project.org>; Sun,  6 Sep 2015 15:40:42 -0700 (PDT)
Resent-Message-ID: <20150906224043.GF4281@localhost.localdomain>
Resent-To: alsa-devel@alsa-project.org
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2059421414202467979==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline


--XMCwj5IQnwKtuyBG
Content-Type: multipart/mixed; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Hello.
(J. Random Hacker here)

While using aplay/arecord (version 1.0.28) to generate some noise, I ran
across a regression in the use of the '-d' option.
Specifically:
According to the man page:
       -d, --duration=3D#
              Interrupt after # seconds.  A value of zero means infinity.
              The default is zero, so if this option is  omitted  then  the
              arecord process will run until it is killed.
[snip]
       arecord -d 10 -f cd -t wav -D copy foobar.wav
              will record foobar.wav as a 10-second, CD-quality wave file,
              using the PCM "copy" (which might be defined  in  the  user's
              .asoundrc file as:
              pcm.copy {
                type plug
                slave {
                  pcm hw
                }
                route_policy copy
              }
[snip]

So the behavior I expect to see (and have experienced in the past) is:

$ arecord -d 3 -f cd dump.wav
Recording WAVE 'dump.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Ste=
reo
$ ls -l
-rw------- 1 grond66 grond66 529244 Sep  5 00:34 dump.wav

What actually happens is:

$ arecord -d 3 -f cd dump.wav
Recording WAVE 'dump.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Ste=
reo
[ program hangs here until SIGINT ]
^CAborted by signal Interrupt...
arecord: pcm_read:2031: read error: Interrupted system call
$ ls -l
-rw------- 1 grond66 grond66 526444 Sep  5 00:39 dump-01.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-02.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-03.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-04.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-05.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-06.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-07.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-08.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-09.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-100.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-101.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-102.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-103.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-104.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-105.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-106.wav
-rw------- 1 grond66 grond66     44 Sep  5 00:39 dump-107.wav
[ etcetera... ]
$ aplay dump-01.wav
[ three seconds of hiss, as expected ]
$ less dump-02.wav
RIFF$^@^@^@WAVEfmt ^P^@^@^@^A^@^B^@D<AC>^@^@^P<B1>^B^@^D^@^P^@data^@^@^@^@
$

So arecord is recording the requested audio and putting it into the first f=
ile,
then spamming WAV headers into all the subsequent files.
This is not terribly useful.

The problem appears to be six lines of code in aplay/aplay.c, in the functi=
ons
pcm_read() and pcm_readv():

   2006 static ssize_t pcm_read(u_char *data, size_t rcount)
   2007 {
   2008         ssize_t r;
   2009         size_t result =3D 0;
   2010         size_t count =3D rcount;
   2011=20
)> 2012         if (count !=3D chunk_size) {
)> 2013                 count =3D chunk_size;
)> 2014         }
   2015=20
   2016         while (count > 0 && !in_aborting) {

   2045 static ssize_t pcm_readv(u_char **data, unsigned int channels, size=
_t rcount)
   2046 {
   2047         ssize_t r;
   2048         size_t result =3D 0;
   2049         size_t count =3D rcount;
   2050=20
)> 2051         if (count !=3D chunk_size) {
)> 2052                 count =3D chunk_size;
)> 2053         }
   2054=20
   2055         while (count > 0 && !in_aborting) {

In this case, the 'rcount' arguments are the number of PCM
integers to be read from the capture device.
In theory. Because what lines 2012-2014 and 2051-2053 do is effectively:

count =3D chunk_size;

In other words, the argument is completely disregarded,
and 'chunk_size' is used no matter what the functions are passed.

But capture() and family use the following logic:
"If pcm_read{,v}() returns with a value other than the
number integers we told it to read off the wire,
assume something went wrong":

   2925	static void capture(char *orig_name)
   2926	{
   2927		int tostdout=3D0;		/* boolean which describes output stream */
   2928		int filecount=3D0;	/* number of files written */
   2929		char *name =3D orig_name;	/* current filename */
   2930		char namebuf[PATH_MAX+1];
   2931		off64_t count, rest;		/* number of bytes to capture */
[...]
   2964		do {
   2965			/* open a file to write */
   2966			if(!tostdout) {
   2967				/* upon the second file we start the numbering scheme */
   2968				if (filecount || use_strftime) {
   2969					filecount =3D new_capture_file(orig_name, namebuf,
   2970								     sizeof(namebuf),
   2971								     filecount);
   2972					name =3D namebuf;
   2973				}
   2974			=09
   2975				/* open a new file */
   2976				remove(name);
   2977				fd =3D safe_open(name);
   2978				f (fd < 0) {
   2979					perror(name);
   2980					prg_exit(EXIT_FAILURE);
   2981				}
   2982				filecount++;
   2983			}
   2984=09
   2985			rest =3D count;
   2986			if (rest > fmt_rec_table[file_type].max_filesize)
   2987				rest =3D fmt_rec_table[file_type].max_filesize;
   2988			if (max_file_size && (rest > max_file_size))=20
   2989				rest =3D max_file_size;
   2990=09
   2991			/* setup sample header */
   2992			if (fmt_rec_table[file_type].start)
   2993				fmt_rec_table[file_type].start(fd, rest);
   2994=09
   2995			/* capture */
   2996			fdcount =3D 0;
   2997			while (rest > 0 && recycle_capture_file =3D=3D 0 && !in_aborting)=
 {
)> 2998				size_t c =3D (rest <=3D (off64_t)chunk_bytes) ?
)> 2999					(size_t)rest : chunk_bytes;
)> 3000				size_t f =3D c * 8 / bits_per_frame;
)> 3001				if (pcm_read(audiobuf, f) !=3D f)
)> 3002					break;
   3003				if (write(fd, audiobuf, c) !=3D c) {
   3004					perror(name);
   3005					prg_exit(EXIT_FAILURE);
   3006				}
   3007				count -=3D c;
   3008				rest -=3D c;
   3009				fdcount +=3D c;
   3010			}
   3011=09
[...]
   3027			/* repeat the loop when format is raw without timelimit or
   3028			 * requested counts of data are recorded
   3029			 */
   3030		} while ((file_type =3D=3D FORMAT_RAW && !timelimit) || count > 0);
   3031	}

These two modes of operation are incompatible.
However, if we nix the strange requirement that all calls to pcm_read{,v}()
must be for exactly 'chunk_size' samples, the problem goes away.
This is the purpose of the patch I've included below.

--ftEhullJWpWg/VHq
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0001-aplay-Remove-weird-code-in-pcm_read-v.patch"
Content-Transfer-Encoding: quoted-printable

=46rom eaa3b4acc17bbd7180a46d5c9f3e63442b159cd7 Mon Sep 17 00:00:00 2001
=46rom: Grond66 <grond66@riseup.net>
Date: Fri, 4 Sep 2015 20:05:19 -0700
Subject: [PATCH 1/1] aplay: Remove weird code in pcm_read{,v}

This fixes a regression in aplay/arecord which causes
arecord to loop creating numerous empty numbered output files
when the '-d' is used.

Signed-off-by: Grond66 <grond66@riseup.net>

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 459f7dd..a26dbdb 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -2009,10 +2009,6 @@ static ssize_t pcm_read(u_char *data, size_t rcount)
 	size_t result =3D 0;
 	size_t count =3D rcount;
=20
-	if (count !=3D chunk_size) {
-		count =3D chunk_size;
-	}
-
 	while (count > 0 && !in_aborting) {
 		if (test_position)
 			do_test_position();
@@ -2048,10 +2044,6 @@ static ssize_t pcm_readv(u_char **data, unsigned int=
 channels, size_t rcount)
 	size_t result =3D 0;
 	size_t count =3D rcount;
=20
-	if (count !=3D chunk_size) {
-		count =3D chunk_size;
-	}
-
 	while (count > 0 && !in_aborting) {
 		unsigned int channel;
 		void *bufs[channels];
--=20
2.1.4


--ftEhullJWpWg/VHq
Content-Type: application/pgp-keys
Content-Description: PGP Key 0x55D89FD9.
Content-Disposition: attachment

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1

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
X7cL9f2ZeuNykQ4D27N2
=vwEG
-----END PGP PUBLIC KEY BLOCK-----

--ftEhullJWpWg/VHq--

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV6rg9AAoJECxT2PpV2J/ZZ7wQAIihvYxnygPjazuTgwI6a5h9
asIpOUrkcApmDYW3lVvIWPB3jAJwOHxI98OjzqCUF8CRMDOCo3PxMAyPbXNMvsNw
4Jmgp79Oy2L8zzeJXMG00fdY5ELafSbX6hHLTnGxRRDdYXM35hqUGrRl0Ej+CY5V
ZE2gx2+uEsZ9q4tVP/lpZS7KEkEEbgWydGh0UEzFoayOwhzeFySNh2KI9Jwg4RSZ
FbaWDU7uB5dMrfGxm3OZbCaXhYp1W8LUxRjQ48QbMsPua1Uy+IozdPccisYqk337
6vtC6yrFiJ87hJi8U4BeAUBui0IcAe6BGM8xlaHrW0R5Ur51HRmVNtd0cmSBz5Ff
FRLTW3L0jjkXL+hoGxgwmzZvkdWvicQXVV4JnDoGJvjigkO+kOO8OVhmtie9hgZO
vHejkUi6zz4XxFqwyMXZFTRTym+B8ESTdwDH1Otb3XiYu7JgskBveRiogt2cxXi1
ARyg4oZat4pIvoFOyem7P53dCTG3X0TPW8T5KjDhjgw6QJsCnaprG0QnP0M/1cCf
Qb6KoXXSlvUCd1XP998jNbUd9fwM+0TjeDfyU9pDAmvFDP3Bjb70zsy/NRRVRBRe
Y5/OEbFtaZcf5BSwVF4iS+4+j8+/xBXMDzS/flB8QOcQ+ulBvDipz1M7LY9ce5xl
Jj6lXoegS5uOm/PSQv5+
=CMm5
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--

--===============2059421414202467979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2059421414202467979==--
