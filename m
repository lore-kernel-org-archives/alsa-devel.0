From: Dan Hollis <goemon@anime.net>
Subject: Re: Writing a driver for this card: your thoughts?
Date: Thu, 6 Jun 2002 18:39:46 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0206061838560.19926-100000@sasami.anime.net>
References: <3D00AE55.11120.9CD4ED3@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D00AE55.11120.9CD4ED3@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Eliot Blennerhassett <bigblen@xtra.co.nz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 7 Jun 2002, Eliot Blennerhassett wrote:
> > What's minimum latency possible with the card?
> Historically our cards have very large buffers that contain seconds of audio, so 
> that they can keep playing flawlessly even if the CPU or network gets bogged 
> down.  Whether this is used or not is up to the application though.
> Low latency has not been a design goal.  I would say the latency is between 
> about 3000 to 5000 samples depending on processing details.

So it would be accurate to say this card is not suitable for live 
performance, but is mainly targeted toward post-production and archive 
broadcast?

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
