From: =?iso-8859-1?Q?Robert_Br=FCckmann?= <robert.brueckmann@stud.tu-ilmenau.de>
Subject: latency timer
Date: Tue, 26 Feb 2002 23:06:38 +0100
Message-ID: <002601c1bf11$e23a37e0$0300a8c0@wgilmenau>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

I wanted to use two RME hammerfalls to record 48 channels of audio via adat,
do some signal processing and play them back again. But I experienced a very
poor performance of my computer (dual pentium III 1.3GHz, 512MB RAM). It
wasn't even able to record 48 channels without xruns.

I modified aplay/arecord that it plays/records more than 32 channels (btw:
why did the developers insert such a silly check which didn't allow more
than 32 channels???), but arecord gave many xruns while recording (aplay
worked fine):

arecord --device="rme9652_dual32" --format=S_32LE --rate=44100 --channels=48

rme9652_dual_32 is a device defined in ~/.asoundrc.

I found out that increasing the latency timer in my BIOS helped out (I
increased it from 0x20 to 0x30), but if the computer gets too much xruns
after another, it locks.

Does anyone know, what the latency timer actually does? It affected the
performance of the cards rapdily. But what is the disadvantage of increasing
that value? Should I set it to maximum (0x80)?

Thanks,
Robert

BTW: Might the low latency check help with my problem?




_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
