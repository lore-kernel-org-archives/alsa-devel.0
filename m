From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: Re: intel 8x0 went silent in 2.6.11
Date: Mon, 07 Mar 2005 21:13:23 +0100
Message-ID: <422CB5E3.3070208@drzeus.cx>
References: <4227085C.7060104@drzeus.cx>	 <29495f1d05030309455a990c5b@mail.gmail.com>	 <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>	 <1109875926.2908.26.camel@mindpipe>	 <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>	 <1109876978.2908.31.camel@mindpipe>	 <Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>	 <20050303154929.1abd0a62.akpm@osdl.org> <4227ADE7.3080100@drzeus.cx>	 <4228D013.8010307@drzeus.cx> <1110049247.12201.11.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110049247.12201.11.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, Mark Canter <marcus@vfxcomputing.com>, nish.aravamudan@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>So is there a bug or not?  Mark seems to be the only one affected.
>
>It's important to follow up, because these so-called "ALSA regressions"
>are generating bad press.
>
>Lee
>
>  
>
I can generate the error using the following procedure:

1. Boot in 2.6.10. Remove /etc/asound.conf and store the current mixer
settings.
2. Boot in 2.6.11 and let alsactl restore the mixer.

Provided the machine is powered down between each attempt this gives the
same result. 'Headphone Jack Sense' ends up not muted (which means that
the built-in speakers are dead).

I fail to find where FC saves/restores the mixer settings so I can't
test without it. There are commands in modprobe.conf but asound.conf
still gets updated when I remove these lines. So there must be some more
place[s] where alsactl gets called.

Rgds
Pierre



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
