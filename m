From: Gilles Degottex <gilles.degottex@net2000.ch>
Subject: Re: Lowest latency: JACK, or ALSA directly?
Date: Fri, 12 Nov 2004 15:47:04 +0100
Message-ID: <200411121547.05145.gilles.degottex@net2000.ch>
References: <200411111534.iABFY8UK012314@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200411111534.iABFY8UK012314@localhost.localdomain>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 11 November 2004 16:34, Paul Davis wrote:
> it doesn't *add* any latency at all. what it might conceivably do is
> to prevent a given application from reaching the lowest possible
> latency, because of the extra context switching involved in JACK. so
> far, however, this doesn't appear to be the case - people have JACK
> running at the same latency settings as they could get with ALSA. so
> the effect is marginal if its measurable at all.

no latency ?? so why qjackctl show latency information ? (around 50ms for me)

> >Although I so far barely have gotten into ALSA programming, it does seem
> >to be manageable in difficulty. (Don't laugh, I am an aconcy austican, not
> > a=20 programmer.)  How is programming against JACK in comparison?

I already meet A LOT of difficulties when programming with ALSA: at the time I 
did (about 6 month) doc was not synchronized to my devel library and examples 
I found was completly obsolete ...
But you can control more things with ALSA (and so ALSA code is longer than 
JACK code). Personnaly I recommend you start with JACK, If there is no 
latency problem and you wont fight with the library.

regards
Gilles


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
