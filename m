From: "Karsten Wiese" <annabellesgarden@yahoo.de>
Subject: AW: usb quattro
Date: Thu, 5 Sep 2002 21:02:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <DAELIEGDPLDDCIJPAICBGEHNCDAA.annabellesgarden@yahoo.de>
References: <3D77A319.3010703@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D77A319.3010703@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Here's what I get from ksymoops
>
> ----
> Warning (compare_maps): ksyms_base symbol
> vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.
> Ignoring ksyms_base entry
> Unable to handle kernel NULL pointer dereference at virtual
> address 00000020
> c01e52e4
> *pde = 00000000
> CPU:    0
> EIP:    0010:[<c01e52e4>]  Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010097
> eax: cf21cc84   ebx: cf21c480    ecx: d7efd3fc      edx: cf21c484
> esi: 00000000   ed1: 00000097     ebp: cf21cc84       esp: c0287f38
> Warning (Oops_set_regs): garbage 'ed1: 00000097     ebp: cf21cc84
> esp: c0287f38' at end of register line ignored
> ds: 0018        es: 0018       ss:0018
> Process swapper (pid: 0, stackpage=c0287000)
> Stack:  00000292 d7efd3fc 00000000 0000cc00 d7efd380 c0287fac c01e535b5
> d7efd380
>          d7efd380 d7eede80 04000001 0000000b c0109e8a 0000000b d7efd380
> c0287fac
>          c0287fac 0000000b c02bee80 d7eede80 c010a018 0000000b c0287fac
> d7eede80
> Call Trace: [<c01e53b5>] [<c0109e8a>] [<c010a018>] [<c0106f10>]
> [<c0106f10>]
>     [<c010c108>] [<c0106f10>] [<c0106f36>] {<c0106fc2>] [<c0105000>]
> Code: c7 46 20 98 ff ff ff 8b 43 10 8b 1b 80 b8 00 00 00 8b 48
>
>
>  >>EIP; c01e52e4 <uhci_remove_pending_qhs+44/90>   <=====
>

the Tascam US-428 driver (copied / changed from snd-usb-audio ) showed a
similar problem.
I worked around it by not using ASYNC_UNLINKing of the urbs.

uhci_remove_pending_qhs is called to unlink urbs in ASYNC mode.
seems as if uhci has a bug ? or may we asyncly unlink only 1 urb at a time?
any experiences with kernels > 2.4.18 ?

Karsten


__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Möchten Sie mit einem Gruß antworten? http://grusskarten.yahoo.de


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
