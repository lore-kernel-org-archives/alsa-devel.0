From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1-mm2
Date: Thu, 24 Mar 2005 15:49:20 -0800
Message-ID: <20050324154920.4e506d76.akpm@osdl.org>
References: <20050324044114.5aa5b166.akpm@osdl.org>
	<1111682812.23440.6.camel@mindpipe>
	<20050324121722.759610f4.akpm@osdl.org>
	<200503242331.46985.rjw@sisk.pl>
	<42434E59.2060805@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <42434E59.2060805@free.fr>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: rjw@sisk.pl, rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>, Greg KH <greg@kroah.com>
List-Id: alsa-devel@alsa-project.org

Laurent Riffard <laurent.riffard@free.fr> wrote:
>
> hello,
> 
> Same kinds of problem here. It depends on the removed module. I mean:
> "rmmod loop" or "rmmod pcspkr" works. But "rmmod snd_ens1371" or "rmmod
> ohci1394" hangs.
> 
> Sysrq-T when rmmoding snd_ens1371 :
> 
>   rmmod         D C92EBE8C     0  8231   8159                     (NOTLB)
>   c92ebea0 00000082 00000003 c92ebe8c 00000000 5685fc00 000f4253 cd624530
>          cd624658 cff60874 cff60844 c92ebebc c92ebef0 c02618c7 00000000
> cd624530
>          c0113137 00000000 00000000 00000282 cd248c20 cd248c07 00000001
> cd624530
>   Call Trace:
>    [wait_for_completion+124/193] wait_for_completion+0x7c/0xc1
>    [<c02618c7>] wait_for_completion+0x7c/0xc1
>    [device_release_driver+52/116] device_release_driver+0x34/0x74
>    [<c01f0ae3>] device_release_driver+0x34/0x74
>    [__remove_driver+8/12] __remove_driver+0x8/0xc
>    [<c01f0b2b>] __remove_driver+0x8/0xc
>    [driver_for_each_device+50/87] driver_for_each_device+0x32/0x57
>    [<c01f0bd8>] driver_for_each_device+0x32/0x57
>    [driver_detach+17/19] driver_detach+0x11/0x13
>    [<c01f0b40>] driver_detach+0x11/0x13
>    [bus_remove_driver+76/130] bus_remove_driver+0x4c/0x82
>    [<c01f05eb>] bus_remove_driver+0x4c/0x82
>    [driver_unregister+14/23] driver_unregister+0xe/0x17
>    [<c01f0cb2>] driver_unregister+0xe/0x17
>    [pci_unregister_driver+14/23] pci_unregister_driver+0xe/0x17
>    [<c019b242>] pci_unregister_driver+0xe/0x17
>    [sys_delete_module+322/379] sys_delete_module+0x142/0x17b
>    [<c0128356>] sys_delete_module+0x142/0x17b

It looks like we're getting stuck in the wait_for_completion() in the new
klist_remove().



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
