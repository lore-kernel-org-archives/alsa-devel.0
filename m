From: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] 2.6.10, oops in snd_usb_audio after unplugging audio device
Date: Wed, 15 Dec 2004 17:48:55 -0800
Message-ID: <20041216014855.GA12042@kroah.com>
References: <20041214211116.GA21561@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20041214211116.GA21561@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Olaf Hering <olh@suse.de>
Cc: linux-usb-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 14, 2004 at 10:11:16PM +0100, Olaf Hering wrote:
> 
> Oops: kernel access of bad area, sig: 11 [#1]
> NIP: C000F748 LR: C00AB5E4 SP: C18DDD10 REGS: c18ddc60 TRAP: 0300    Not tainted
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 00000000, DSISR: 40000000
> TASK = e7fc14e0[3] 'events/0' THREAD: c18dc000Last syscall: 120 
> GPR00: C00F0400 C18DDD10 E7FC14E0 00000000 FFFFFFFF DFE3D358 0000001A E6397858 
> GPR08: 000003A8 DFE3D6D4 FFFFFFFF 00000003 357F36F0 00000000 00000000 00000000 
> GPR16: 00000000 00000000 00000000 00000000 00230000 0012F000 C01C0000 E6AC46C0 
> GPR24: 00000000 000003A8 E6397858 E7F2B6E4 DFE3D6CC 000000D0 00000001 E7F2B6E4 
> NIP [c000f748] strlen+0x4/0x18
> LR [c00ab5e4] kobject_get_path+0x28/0xc4
> Call trace:
>  [c00f0400] class_hotplug+0x88/0x194

Ick.  I thought we fixed up the reference counting issues :(

Anyway, can you enable kobject debugging, and driver core debugging
(both are config options now) and duplicate this?  If so, can we see the
log messages that lead up to the oops?  It should give us a clue as to
what is happening here.

thanks,

greg k-h


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
