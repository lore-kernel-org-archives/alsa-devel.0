From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Badness in remove_proc_entry
Date: Fri, 2 Apr 2004 23:08:18 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040402230818.49d1a4de.pochini@shiny.it>
References: <20040327215238.6e3f0762.pochini@shiny.it>
	<Pine.LNX.4.58.0403280954360.1828@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0403280954360.1828@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 28 Mar 2004 09:54:46 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

> On Sat, 27 Mar 2004, Giuliano Pochini wrote:
> 
> > I'm not sure if this is alsa's fault. It happens when I unload the module.
> > Yup, snd_gina24 is the driver I'm developing, but it also happens with
> > snd-powermac and when I try to load a module for a card I don't have.
>
> It's fixed in 1.0.4rc1.

I ported my driver to 1.0.4rc2. There is no "badness" in the message anymore
:) but it still comes up. Now it only happens if I try two modules I'm
developing. Example:

modprobe snd-layla24

No errors, but I don't have that card. lsmod shows the module is
loaded.

modprobe snd-gina24 (my card) --> dmesg:


kobject_register failed for Echoaudio (-17)
Call trace:
 [c000bbe4] dump_stack+0x18/0x28
 [c00dfb24] kobject_register+0x68/0x6c
 [c012adec] bus_add_driver+0x50/0xf0
 [c012b2b4] driver_register+0x38/0x48
 [c00ec408] pci_register_driver+0x50/0x6c
 [e66669b0] alsa_card_Echo_init+0x1c/0x774 [snd_gina24]
 [c003de50] sys_init_module+0x200/0x3e0
 [c0007b1c] ret_from_syscall+0x0/0x44
Echoaudio soundcard not found or device busy


If I load snd-gina24 and then snd-layla24, it complains when I load the
latted, even if snd-gina24 is loaded and running fine. It does not happen if
the first module I load is something else (eg. hdsp). Maybe there is
something I'm not aware of... I already tried to use different
MODULE_DESCRIPTION and MODULE_DEVICES without success.


--
Giuliano.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
