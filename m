From: Dan Hollis <goemon@anime.net>
Subject: Re: audio via ethernet (was: dolby digital output)
Date: Mon, 18 Feb 2002 15:11:11 -0800 (PST)
Message-ID: <Pine.LNX.4.44.0202181508150.28925-100000@sasami.anime.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <3C7187A7.E45BD28A@hardco.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: stef <stef@hardco.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Feb 2002, stef wrote:
> Anyway, which software/protocol/service do you use for
> your clock synchronisation? _very_ interesting!

Probably ntp. Works well, multicast mode should be excellent for this.

BTW if you use fixed size packets on fullduplex ethernet (as gibson's 
magic does), then sync should not be much of a problem. IIRC they also 
include synchronization data in the packets so that synchronization is 
easy.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
