From: Luuk van Dijk <lvd@mndmttr.nl>
Subject: Re: full/half duplex support
Date: 18 Nov 2004 19:06:45 +0100
Message-ID: <1100801204.490.4.camel@wonder>
References: <courier.4198D349.0001155D@outpost.mndmttr.nl>
	 <s5hpt2bqosz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpt2bqosz.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-11-18 at 14:17, Takashi Iwai wrote:
> At Mon, 15 Nov 2004 17:03:21 +0100,
> Luuk van Dijk wrote:
> > 
> Sorry, the situation is not clear for me.
> Do you mean substream as the ALSA term?

yes. 

> So, you have two or more substreams assigned to a single PCM device,
> and the DMAs are free-running when the substreams are unused?

yes, one capture and one playback substream, both of 2,4,6 or 8
channels.  when one of the two is not used the dma is free running and I
disable its irq's.  the problem is: they have to be started and stopped
simultaneously and cannot be paused.

i think the problem would be solved if the mid layer would just accept
the current pointer, and adjust its communication to userspace based on
that instead of trying to force the dma to sync with its idea of what it
should be.  but I could be talking out of my *ss here, since I'm
relatively new to alsa.  (this is my first alsa driver :-)


thanks
	Luuk



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
