From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Opti92x-ad1848 won't take Opti924 card
Date: Tue, 23 Sep 2003 09:06:44 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309230903041.1405-100000@studcom.urz.uni-halle.de>
References: <3F6FEDEE.9E5D3FF8@srr.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <3F6FEDEE.9E5D3FF8@srr.ro>
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
> options snd-opti-92x-ad1848     index=1 isapnp=1 id="Opti924" port=0x220
> irq=5 dma1=0 fm_port=0x380 mpu_port=0x300 mpu_irq=7

You've specified all parameters manually, so you could try to disable
ISA PnP (isapnp=0).

And fm_port must be 0x388 (0x380 is the OPL4 port, which is detected
automatically if you have an OPL4).


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
