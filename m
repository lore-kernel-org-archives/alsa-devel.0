From: Giuliano Pochini <pochini@shiny.it>
Subject: Unexpected hw_pointer value
Date: Thu, 7 Aug 2003 23:05:02 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030807230502.081aa3cf.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


When I play something, depending on the buffer length and the period length,
sometimes ALSA complaints about a wrong hw_pointer value. pcm_hw_pointer()
returns the right value and the irq handler (not shown below) calls
snd_pcm_period_elapsed() only when the period is done. I can't understand what
happens. Below I report the first burst since I started playing something.
1.7MB transferred, buffer_size=32768 frames, period_size=1323 frames (25
periods). fr=the position (in frames) inside the buffer. I choosed that
setting because it makes alsa to spit the warning sooner than others. It seems
to happen when the period size is not a multiple of the buffer size, but I
failed to find a relation between bufsz/persz and the points where it prints
the errors.


pcm_hw_pointer=1699968 fr=31776
pcm_hw_pointer=1704064 fr=32
pcm_hw_pointer=1704064 fr=32
pcm_hw_pointer=1709312 fr=1344
pcm_hw_pointer=1709312 fr=1344
ALSA ../alsa-kernel/core/pcm_lib.c:155: Unexpected hw_pointer value (stream = 0, delta: -1, max jitter = 16384): wrong interrupt acknowledge?
pcm_hw_pointer=1714560 fr=2656
pcm_hw_pointer=1714560 fr=2656
pcm_hw_pointer=1714560 fr=2656
pcm_hw_pointer=1714560 fr=2656
pcm_hw_pointer=1714560 fr=2656
pcm_hw_pointer=1719936 fr=4000
pcm_hw_pointer=1719936 fr=4000
pcm_hw_pointer=1719936 fr=4000
pcm_hw_pointer=1725184 fr=5312
pcm_hw_pointer=1725184 fr=5312
ALSA ../alsa-kernel/core/pcm_lib.c:155: Unexpected hw_pointer value (stream = 0, delta: -2, max jitter = 16384): wrong interrupt acknowledge?
pcm_hw_pointer=1730432 fr=6624
pcm_hw_pointer=1730432 fr=6624
pcm_hw_pointer=1730432 fr=6624
pcm_hw_pointer=1730432 fr=6624
pcm_hw_pointer=1735808 fr=7968
pcm_hw_pointer=1735808 fr=7968
pcm_hw_pointer=1735808 fr=7968
pcm_hw_pointer=1741056 fr=9280
pcm_hw_pointer=1741056 fr=9280
ALSA ../alsa-kernel/core/pcm_lib.c:155: Unexpected hw_pointer value (stream = 0, delta: -3, max jitter = 16384): wrong interrupt acknowledge?
pcm_hw_pointer=1746304 fr=10592
pcm_hw_pointer=1746304 fr=10592
pcm_hw_pointer=1746304 fr=10592
pcm_hw_pointer=1746304 fr=10592
pcm_hw_pointer=1751680 fr=11936
pcm_hw_pointer=1751680 fr=11936
pcm_hw_pointer=1751680 fr=11936
pcm_hw_pointer=1756928 fr=13248
pcm_hw_pointer=1756928 fr=13248
ALSA ../alsa-kernel/core/pcm_lib.c:155: Unexpected hw_pointer value (stream = 0, delta: -4, max jitter = 16384): wrong interrupt acknowledge?
pcm_hw_pointer=1762176 fr=14560
pcm_hw_pointer=1762176 fr=14560
pcm_hw_pointer=1762176 fr=14560
pcm_hw_pointer=1762176 fr=14560
pcm_hw_pointer=1767552 fr=15904
pcm_hw_pointer=1767552 fr=15904
pcm_hw_pointer=1767552 fr=15904
pcm_hw_pointer=1772800 fr=17216
pcm_hw_pointer=1772800 fr=17216
ALSA ../alsa-kernel/core/pcm_lib.c:155: Unexpected hw_pointer value (stream = 0, delta: -5, max jitter = 16384): wrong interrupt acknowledge?
pcm_hw_pointer=1778048 fr=18528
pcm_hw_pointer=1778048 fr=18528
pcm_hw_pointer=1778048 fr=18528
pcm_hw_pointer=1778048 fr=18528
pcm_hw_pointer=1783424 fr=19872
pcm_hw_pointer=1783424 fr=19872
pcm_hw_pointer=1783424 fr=19872
pcm_hw_pointer=1788672 fr=21184
pcm_hw_pointer=1788672 fr=21184
ALSA ../alsa-kernel/core/pcm_lib.c:155: Unexpected hw_pointer value (stream = 0, delta: -6, max jitter = 16384): wrong interrupt acknowledge?
pcm_hw_pointer=1793920 fr=22496
pcm_hw_pointer=1793920 fr=22496
pcm_hw_pointer=1793920 fr=22496
pcm_hw_pointer=1793920 fr=22496
pcm_hw_pointer=1799296 fr=23840
pcm_hw_pointer=1799296 fr=23840
pcm_hw_pointer=1799296 fr=23840
pcm_hw_pointer=1804544 fr=25152
pcm_hw_pointer=1804544 fr=25152
ALSA ../alsa-kernel/core/pcm_lib.c:155: Unexpected hw_pointer value (stream = 0, delta: -7, max jitter = 16384): wrong interrupt acknowledge?
pcm_hw_pointer=1809792 fr=26464
pcm_hw_pointer=1809792 fr=26464
pcm_hw_pointer=1809792 fr=26464
pcm_hw_pointer=1809792 fr=26464
pcm_hw_pointer=1815168 fr=27808
pcm_hw_pointer=1815168 fr=27808
pcm_hw_pointer=1815168 fr=27808
pcm_hw_pointer=1820416 fr=29120
pcm_hw_pointer=1820416 fr=29120
ALSA ../alsa-kernel/core/pcm_lib.c:155: Unexpected hw_pointer value (stream = 0, delta: -8, max jitter = 16384): wrong interrupt acknowledge?
pcm_hw_pointer=1825664 fr=30432
pcm_hw_pointer=1825664 fr=30432
pcm_hw_pointer=1825664 fr=30432
pcm_hw_pointer=1825664 fr=30432
pcm_hw_pointer=1831040 fr=31776
pcm_hw_pointer=1831040 fr=31776
pcm_hw_pointer=1831040 fr=31776
pcm_hw_pointer=1835136 fr=32


--
Bye.
   Giuliano.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
