From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Opti92x-ad1848 won't take Opti924 card
Date: Mon, 22 Sep 2003 11:56:27 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309221153001.8132-100000@studcom.urz.uni-halle.de>
References: <3F6EBA30.28AC216F@srr.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <3F6EBA30.28AC216F@srr.ro>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrei Boros <andrei@srr.ro>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Andrei Boros wrote:
> options snd-cs46xx              mmap_valid=1 index=0 id="Fortissimo-II"
> enable=1
> options snd-opti-92x-ad1848     index=1 isapnp=1 id="Opti924" port=0x220
> irq=5 dma1=0 fm_port=0x38

I hope these lines aren't wrapped in the original.
Shouldn't fm_port be 0x388?


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
