From: Martin Langer <martin-langer@gmx.de>
Subject: clock mode problem [was: possible problems with rc6 aplay]
Date: Tue, 17 Dec 2002 18:54:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021217175458.GO773@tuba.home>
References: <20021216143611.GN773@tuba.home> <20021216144807.8950gmx1@mx005-rz3.gmx.net>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20021216144807.8950gmx1@mx005-rz3.gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 16, 2002 at 09:51:34AM -0500, Paul Davis wrote:
> 
> >Alsa has copied here the documented rme way, but this seems to be wrong for
> >me. I have just checked the behaviour of rme32, but I'm very sure that the
> >bigger ones are working in the same style.
> 
> well, they have a more complex setup:
> 
>       * clock mode: AutoSync, Master or Word Clock
>       * preferred source for autosync: ADAT1/2/3 or S/PDIF
>       * S/PDIF sample rate
>       * ADAT sample rate
>       * system sample rate (the one the master clock runs at)
> 
> so its really not possible to define "the rate" in a straightforward
> way. but i see your point.
> 

Hmm, it's more complex, but it looks not so different. 

So, I will show you another corner of this problem.

Like every rme card you have to set the rate of your output with 2 or 3
bits. The funny thing is, they never talked about the zero position. I've
tried out this with my rme32 and it is the slave clock position. Let's call
it "switch off the internal master clock".

The datasheet is just talking about one specific Master Clock Bit and not
about zeroing the sample rate bits, if you want to use slave mode. Right?

A practical experiment: If you are in slave clock mode and you are changing
the input sample rate, the output doesn't follow automatically. But if
you've set the sample rate bits for output to 0-0 before, the output rate
will change on each input change (like it should be in a perfect slave mode).

And if you want to change from slave to master clock you have to set a
sample rate different from 0-0 again. So it is only possible to switch
between this clockmodes if you are setting the sample rate and the result is
a list of master modes with sample rate dependency.

output rate bits      Master/Slave bit	Mode    	    	 
0-0  	    	      Slave	   	Slave mode
0-1		      Master		Master mode (freq. #1)
1-0		      Master		Master mode (freq. #2)
...

Everything is without warranty, but I'm very sure that this is typical for
all other rme cards: rme96, rme9652, hdsp. But I've no possibility to check
it.


martin


-- 
"2b|!2b"


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
