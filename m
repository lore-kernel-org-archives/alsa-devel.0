From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: Re: Mo' better modem support
Date: Wed, 07 Sep 2005 19:33:04 +0300
Message-ID: <20050907163304.GC11357@sashak.softier1.local>
References: <s5h64tfs8wm.wl%tiwai@suse.de> <431D554E.8050500@netvigator.com>
 <20050906142917.GA30523@sashak.softier1.local>
 <431E3771.8090303@netvigator.com> <20050907064449.GA8391@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20050907064449.GA8391@titan.lahn.de>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: Raymond <rayau@netvigator.com>, alsa-devel@lists.sourceforge.net, rbrancaleoni@skynet.be, Manuel Jander <manuel.jander@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08:44 Wed 07 Sep     , Philipp Matthias Hahn wrote:
> 
> Yes, I still have it and use it:
> 
> $ lspci -s 0:6.0
> 0000:00:06.0 Multimedia audio controller: Aureal Semiconductor AU8810 Vortex Digital Audio Processor (rev 03)
> walker:~# lspci -nv -s 0:6.0
> 0000:00:06.0 0401: 12eb:0003 (rev 03)
>         Subsystem: 1043:1043
>         Flags: bus master, medium devsel, latency 32, IRQ 255
>         Memory at fedc0000 (32-bit, non-prefetchable) [size=256K]
>         I/O ports at fce0 [size=8]
>         I/O ports at fce8 [size=8]
>         Capabilities: [dc] Power Management version 2
> 
> If you need something else (data, testing, etc), just ask.

Do you know is there data sheet available?
The driver in pci/au88x0 looks like AC97 for all supported ships.

Sasha.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
