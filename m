From: =?iso-8859-1?Q?Robert_Br=FCckmann?= <robert.brueckmann@stud.tu-ilmenau.de>
Subject: Re: latency timer
Date: Wed, 27 Feb 2002 08:48:13 +0100
Message-ID: <001501c1bf63$23656680$0300a8c0@wgilmenau>
References: <200202262319.SAA08267@renoir.op.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> i would also mention that you may have potential problems doing this
> with word-clock synced interfaces. its likely that they will generate
> interrupts sufficiently close in time that you could be severely
> stressing the full compliance of the PCI interrupt detect/CPU notify
> system. basically, each card is going to reach the interrupt point at
> almost exactly the same time, and this could cause problems even
> though it theoretically should not (the APIC should buffer the 2nd
> interrupt while the first is processed).
> 
> i would be very suprised if even RME have tried this experiment: I
> don't think ASIO has any way to link two physical devices together in
> the way that ALSA permits. i may be wrong about that.

So do you mean there is another way of synchronizing the cards?


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
