From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: DigiDesign MBox USB Audio device
Date: Wed, 07 Apr 2004 13:54:15 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404071342150.9498-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0404062154190.8104@pub6.ifh.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.58.0404062154190.8104@pub6.ifh.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Boettcher <patrick.boettcher@desy.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Boettcher wrote:
> I only applied the patch, loaded the module, pluged in the device
> ... result is attached.

> EIP is at __wake_up_common+0x13/0x50
> Call Trace:
>  [<c0119a0c>] __wake_up+0x32/0x57
>  [<c015cc1e>] pipe_readv+0x288/0x2d8
>  [<c015cca5>] pipe_read+0x37/0x3b
>  [<c0150d74>] vfs_read+0xd0/0x135
>  [<c0151007>] sys_read+0x42/0x63
>  [<c01071ef>] syscall_call+0x7/0xb
> note: sed[5839] exited with preempt_count 1
>
> EIP is at fasync_helper+0x39/0xed
> Call Trace:
>  [<c015d244>] pipe_read_fasync+0x48/0x68
>  [<c015d36b>] pipe_read_release+0x0/0x3f
>  [<c015d38a>] pipe_read_release+0x1f/0x3f
>  [<c0151e50>] __fput+0x116/0x128
>  [<c0150562>] filp_close+0x59/0x86
>  [<c01505f2>] sys_close+0x63/0x96
>  [<c01071ef>] syscall_call+0x7/0xb
> note: usb.agent[5828] exited with preempt_count 1

Strange.  But having two endpoints in one interface is not what the
driver was written for.  I think part of the driver needs to be
rewritten before this device can work.


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
