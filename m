From: Paul Davis <pbd@op.net>
Subject: Re: HDSP start problem
Date: Mon, 24 Jun 2002 17:02:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206242100.g5OL0gf21906@post2.fast.net>
References: <3D17542B.FCCC63EB@telia.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 24 Jun 2002 19:17:31 +0200."
             <3D17542B.FCCC63EB@telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Marcus Andersson <054185595@telia.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Starting sound driver: snd-hdsp PCI: Found IRQ 10 for device 00:0d.0
>PCI: Sharing IRQ 10 with 00:07.2
>PCI: Sharing IRQ 10 with 00:07.3
>ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:452: wait for FIFO status <= 0
>failed 
>after 100 iterations
>looks like a multiface
>done
>
>When this happens, the card will not work. I must reboot and hope it
>doesn't happen again.

sounds like a definite bug. apparently, there is some condition that
leads to the h/w not being ready quickly enough but we ignore it.

there are other problems right now. myself and a few others have no
playback whatsoever, even with the old version (1.1) of the driver.

work continues.

--p


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
