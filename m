From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: period/buffer bug on pmac ?
Date: Tue, 16 Nov 2004 10:57:54 +0100 (CET)
Message-ID: <XFMail.20041116105754.pochini@shiny.it>
References: <Pine.HPX.4.33n.0411151745210.1491-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0411151745210.1491-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net, danny@mailmij.org
List-Id: alsa-devel@alsa-project.org


On 15-Nov-2004 Clemens Ladisch wrote:
> danny@mailmij.org wrote:
>> In the process of fixing up the alsa output plugin of bmp a bit I've come
>> upon a weird problem. The mp3s I was playing played to fast, with a
>> audible click each few millisecond. This seemed to only happen when the
>> period size was not a power of 2 (the output plugin used to set
>> period_time). I've now calculated the period_size myself from the rate and
>> set it to the nearest power of 2. Which seems to work fine,
> 
> There is no general power-of-2 requirement in ALSA.  The pmac driver
> doesn't set a hardware constraint; if the hardware requires power-of-2
> periods, it's a bug in the driver.

There in so such constraint set in the driver indeed. I don't know
that hardware, but it seems (at least on my G4MDD which has a Snapper
chip) that po2 is required.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
