From: Dan Hollis <goemon@anime.net>
Subject: Re: audio via ethernet (was: dolby digital output)
Date: Tue, 19 Feb 2002 13:48:48 -0800 (PST)
Message-ID: <Pine.LNX.4.44.0202191347360.9939-100000@sasami.anime.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20020219111527.B23723@ecs.soton.ac.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Feb 2002, Steve Harris wrote:
> However, on raw ethernet, the arrival of the packets + a timestamp should
> be enough synchronisation.

Yes, it should.

> >From what I remeber of magic, it ensures the packets are sent
> synchronosly.

No, it just tries very hard :-) by using fixed packet lengths, and strict 
inter-packet timings.

Still, it should be adequate for most cases. And definitely more flexible 
than most current systems.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
