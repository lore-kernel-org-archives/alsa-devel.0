From: "Peter Heatwole" <peter599@gotnet.net>
Subject: Re: SPDIF and cs46xx ?
Date: Sun, 16 Mar 2003 14:56:36 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3c5cea10bbf24b49ad05e59b269b4d69.peter599@gotnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Benny Sjostrand wrote:
> - The magic status bit's, I'm not sure if the current implementation in
> the cs46xx that set's the IEC958 is correct=2E I have not found any way to=

> verify

   If I may ask, what are the "magic status bits"?  Are they the same as the=

AES bits?  Speaking of which, what's the use of the AES# bits?  I looked on =
the
internet but couldn't find what these bits mean=2E =20

If AES# aren't the same as the magic bits, is there anything in there I can =
try
playing with?

(don't think you need these, but hey)
xine with dolby passthru: iec958:AES0=3D0x6,AES1=3D0x82,AES2=3D0x0,AES3=3D0x2=

ac3dec with -C:   iec958:AES0=3D0x2,AES1=3D0x82,AES2=3D0x0,AES3=3D0x2
ac3dec with -P:   iec958:AES0=3D0x87,AES1=3D0x0,AES2=3D0x0,AES3=3D0x0


   On a sidenote, ac3dec never makes the clicking noise; only xine does that=2E=

But, I noticed that ac3dec always makes a click when I first start playing=2E=

Could this be a result of the different AES# configuration?

   BTW, I am using a Cambridge Soundworks DTT2500 digital receiver=2E  Anoth=
er
user suggested switching to digital input _after_ starting the stream=2E  We=
ll, I
can't select digital or analog, but I can select analog or auto, so I leave =
it
on auto=2E
   This done, I tried playing a stream in xine _before_ turning the receiver=
 on,
I don't get the clicking sound=2E  The only sounds I hear then are a click/h=
iss
when I change chapters on the DVD=2E

   Question: does the first bit of the stream have to "setup" the receiver to=

receive an AC3 stream?  Some sort of "header"?


-- Peter Heatwole
"Murphy was just a well known pessimist=2E"



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
