From: Jan Depner <eviltwin69@cableone.net>
Subject: Re: Xruns with Audiophile 2496 M-audio
Date: Sat, 29 May 2004 06:31:17 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1085830277.21677.17.camel@eviltwin>
References: <20040529114908.2118135c@pentium233.krystal.net>
	 <Pine.LNX.4.58.0405291234350.566@autumn>
	 <20040529131601.641aa202@pentium233.krystal.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040529131601.641aa202@pentium233.krystal.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Remi Bernhard <rgbmlist2@free.fr>
Cc: Tim Goetze <tim@quitte.de>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-05-29 at 06:16, Remi Bernhard wrote:

> So i have 2.6.5 kernel, and not 2.4.x. Do you think i should install
> 2.4.25 instead ?
> 
> > 
> > (i gather that 2.4 is still the better choice for low-latency
> > operations.)
> > 
> 
> I read the alsa-* archives, and i saw a thread with two people who had
> good latency results with 2.6.x. 
> Could someone tell me if man can achieve a buffer size <=128 with
> audiophile 2496 and kernel 2.6.x ?
> 

Yes.  The 2.4 kernels with low latency patch are better than 2.6 at
present (even the mm series).  The buffer sizes you can achieve are
dependent on so many different things (disks, FSB, memory,
configuration...) that there is no way to tell.  You just have to try it
and find out.  As far as minimizing buffer size is concerned - if you
are doing live audio or you want to monitor recording with inboard
effects turned on you need to have a small buffer size.  With the envy24
chipset cards you can use hardware monitoring so you can set the buffer
size to 2048 and have zero latency monitoring.  Don't confuse monitoring
latency with system latency.

Jan





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
