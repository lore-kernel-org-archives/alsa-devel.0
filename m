From: <danny@mailmij.org>
Subject: Re: period/buffer bug on pmac ?
Date: Tue, 16 Nov 2004 19:37:39 +0100 (CET)
Message-ID: <Pine.LNX.4.33.0411161931330.15251-100000@luna.ellen.dexterslabs.com>
References: <Pine.HPX.4.33n.0411151745210.1491-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Nov 2004, Clemens Ladisch wrote:

> danny@mailmij.org wrote:
> > In the process of fixing up the alsa output plugin of bmp a bit I've come
> > upon a weird problem. The mp3s I was playing played to fast, with a
> > audible click each few millisecond. This seemed to only happen when the
> > period size was not a power of 2 (the output plugin used to set
> > period_time). I've now calculated the period_size myself from the rate and
> > set it to the nearest power of 2. Which seems to work fine,
> 
> There is no general power-of-2 requirement in ALSA.  The pmac driver
> doesn't set a hardware constraint; if the hardware requires power-of-2
> periods, it's a bug in the driver.
> 
Thanks for the reply!
I've been hacking around a bit in the driver and think it needs some 
contraints, although its not (like i first thought) limited to a power of 
2. Constraining periods to integer and requiring at least 3 periods seem 
to fix all issues i have. However, these requirements sometimes 
drastically affect the period AND buffersize requested by the app. I play 
with it a bit more and submit a patch soon. 

d.




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
