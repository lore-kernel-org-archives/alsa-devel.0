From: Pilo <pilo.c@wanadoo.fr>
Subject: ADAT input for SBlive, need help...
Date: Sat, 30 Aug 2003 01:08:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308300108.43613.pilo.c@wanadoo.fr>
References: <E19shQj-0004BD-00@sc8-sf-list2.sourceforge.net>
Reply-To: pilo.c@wanadoo.fr
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19shQj-0004BD-00@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The emu10k1 (and emu10k2) are quite interesting chip : they have many=20
independant inputs and outputs. Under Windows, there is the KX driver whi=
ch=20
can use this via ASIO : 16 input channels. all FX input, physical input(I=
2S,=20
SPDIF), fx output and physical output(I2S SPDIF) can be routed to each ot=
her,=20
and so in a recording software we can have the 14 physical input which th=
e=20
emu10k1 offer (2 SPDIF, 5 I2S).
On a basic SBlive, there's 4 I2S which are not used. I am designing, with=
=20
other people a ADC board (with PCM1804 ADC, which can work up to=20
24bit/192khz). The first test board works, under windows I have one more=20
stereo input, which can be recorded indenpendantly. The goal is to add a =
ADAT=20
input (and maybe output) to the SBlive... which I think will be very easy=
, as=20
Alesis sells ADAT chip for about $5... So yes, a ADAT daughter board for =
the=20
SBlive can be VERY cheap.
I know I can used this under windows, with very good latency... but we wa=
nt it=20
to work under linux! We so need a new driver... like the KX driver under=20
windows...
Can somebody help us on that? I think people from KX driver can help us, =
as=20
their driver is free. (http://www.kxproject.com).

 Thanks you for reading ;)
 Pilo



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
