From: Zsolt Barat <barat@medien.uni-weimar.de>
Subject: Re: Problem with RME 9632 and Plug
Date: Wed, 04 Aug 2004 17:03:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4110FAC3.3000009@medien.uni-weimar.de>
References: <200408041301.i74D1omu022274@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200408041301.i74D1omu022274@localhost.localdomain>
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

Paul Davis wrote:

>Yeah, but bio2jack is a (working) hack and half. And it doesn't
>support lowlatency work properly either, because the thread that
>*really* does audio isn't scheduled as part of the JACK graph and
>doesn't get SCHED_FIFO status. I see this in xmms all the time when I
>do a multiway compile - JACK has no (or almost no) xruns, but the
>audio in xmms skips because the "feeder" thread doesn't get scheduled
>in time to fill the intermediate buffer.
>
>  
>
mplayer_g2 will probably change its architecture, so a poll like 
behaviour like jack uses will be possible. developers are still welcome 
to port (write) ao_jack for mplayer_g2 though.
on the other side, adding low latency features to mplayer aren't really 
possible, cause mplayer is designed intentionally as a movie player, so 
while you watching movies you will never get low latency audio. adding 
some low-lat features when it will be used as stand-alone audio app 
could be possible. but there are several audio-only-apps which already 
have full jack and alsa support (alsaplayer) so i don't really see a 
need for blown up low-lat audio support in mplayer.

regards

Zsolt



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
