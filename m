From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: Re: intel 8x0 went silent in 2.6.11
Date: Mon, 07 Mar 2005 21:16:10 +0100
Message-ID: <422CB68A.1050900@drzeus.cx>
References: <4227085C.7060104@drzeus.cx>	<29495f1d05030309455a990c5b@mail.gmail.com>	<Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>	<1109875926.2908.26.camel@mindpipe>	<Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>	<1109876978.2908.31.camel@mindpipe>	<Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>	<20050303154929.1abd0a62.akpm@osdl.org>	<4227ADE7.3080100@drzeus.cx>	<4228D013.8010307@drzeus.cx> <s5hmztfwon1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hmztfwon1.wl@alsa2.suse.de>
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
Cc: Andrew Morton <akpm@osdl.org>, Mark Canter <marcus@vfxcomputing.com>, rlrevell@joe-job.com, nish.aravamudan@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Fri, 04 Mar 2005 22:16:03 +0100,
>Pierre Ossman wrote:
>  
>
>>It seems I spoke too soon. The defaults picked by the driver are 
>>actually fine. It seems to be alsactl store/restore that did something 
>>strange when coming from an older kernel.
>>    
>>
>
>My guess is that kmix is the cuplrit.
>kmix tends to turn on all mixer switches uncoditionally, and
>saves/restores the mixer config by itself.
>  
>
I use Gnome, not KDE so kmix is not an issue.

>Look at /etc/asound.state whether it contains the value of "Headphone
>Jack Sense" control true or false.
>  
>
It saves the setting once I've been in 2.6.11. From an earlier kernel
there is no such entry.

>BTW, the default value of this control switch was fixed for ThinkPads
>on ALSA tree since long time ago, but unfortunately the patch wasn't
>accepted for 2.6.11...
>  
>
My machine is a hp/compaq, not a thinkpad, so I don't know if it would
have any effect here.

Rgds
Pierre



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
