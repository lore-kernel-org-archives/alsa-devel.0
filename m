From: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Subject: Re: audio via ethernet (was: dolby digital output)
Date: Tue, 19 Feb 2002 11:15:27 +0000
Message-ID: <20020219111527.B23723@ecs.soton.ac.uk>
References: <3C7187A7.E45BD28A@hardco.de> <Pine.LNX.4.44.0202181508150.28925-100000@sasami.anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0202181508150.28925-100000@sasami.anime.net>; from goemon@anime.net on Mon, Feb 18, 2002 at 03:11:11 -0800
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 18, 2002 at 03:11:11 -0800, Dan Hollis wrote:
> On Tue, 19 Feb 2002, stef wrote:
> > Anyway, which software/protocol/service do you use for
> > your clock synchronisation? _very_ interesting!
> 
> Probably ntp. Works well, multicast mode should be excellent for this.

It's not reasonable to compare ntp to word clock, ntp resyncs every few
minuites and works by using some incredible maths.

However, on raw ethernet, the arrival of the packets + a timestamp should
be enough synchronisation.

>From what I remeber of magic, it ensures the packets are sent
synchronosly.

- Steve  

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
