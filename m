From: kasper@303.nu
Subject: es18xx - 1869 not working, debugging ALSA drivers
Date: Tue, 5 Nov 2002 20:33:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211052033.16712.kasper@303.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I've been trying to get ALSA running on my Compaq Armada 3500 for quite a=
=20
while now. The soundchip is a es1869, which is supposed to be supported b=
y=20
the es18xx driver. It only works 1 out of 10 times though - and I figured=
 out=20
when it works and when it doesn't... But that didn't help me much until n=
ow,=20
I tried to force it to always use the working mode, but that didn't work=20
out...

The OSS driver is working properly, but I use the Soundblaster driver, wh=
ich=20
is only half-duplex, and in fact, it's a different mode of the soundchip.

I've been trying to debug the driver, but it's not really my thing... May=
be=20
there are some handy tricks to debug ALSA drivers? Or is it just:
1) change the source
2) compile the source
3) see if it works (by loading the module.. and playing some audio)
4) if it doesn't work restart with 1)

Are there tools to control soundchips without using this laborious cycle?=
 Some=20
kind of framework to check out the stuff that is written in the chip's=20
datasheet?

greetz,
Kasper


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
