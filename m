From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: Rawmidi and CONFIG_DEBUG_SPINLOCK_SLEEP
Date: Sun, 01 Feb 2004 15:30:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <401D0D6D.60601@undata.org>
References: <40196C9B.3050901@undata.org> <Pine.LNX.4.58.0401310942260.1876@pnote.perex-int.cz> <401CE08D.5070903@undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090403060801070507080007"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from satellite.undata.org (brln-d9b81122.pool.mediaWays.net [217.184.17.34])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA09489
	for <alsa-devel@alsa-project.org>; Sun, 1 Feb 2004 15:40:46 +0100
In-Reply-To: <401CE08D.5070903@undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090403060801070507080007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by alsa.alsa-project.org id PAA09489

Thomas Charbonnel wrote :
> Jaroslav Kysela a =E9crit :
>=20
>> On Thu, 29 Jan 2004, Thomas Charbonnel wrote:
>>
>>
>>> Hi,
>>>
>>> I noticed this problem today using midi on my setup (alsa 1.0.1,=20
>>> kernel 2.6.1 with CONFIG_DEBUG_SPINLOCK_SLEEP) :
>>>
>>> Debug: sleeping function called from invalid context at=20
>>> include/asm/uaccess.h:473
>>> in_atomic():1, irqs_disabled():1
>>> Call Trace:
>>>  [<c012139c>] __might_sleep+0xac/0xe0
>>>  [<c010b170>] handle_signal+0xd0/0x140
>>>  [<c03955ef>] snd_rawmidi_kernel_read1+0x10f/0x170
>>>  [<c03957e7>] snd_rawmidi_read+0x147/0x1b0
>>>  [<c01131cf>] restore_i387_fxsave+0x8f/0xa0
>>>  [<c015b2f3>] vfs_read+0xd3/0x140
>>>  [<c015b59f>] sys_read+0x3f/0x60
>>>  [<c010b4bb>] syscall_call+0x7/0xb
>>>
>>> I'm sorry I didn't check if this was fixed in 1.0.2, but though it=20
>>> was worth mentioning. This caused regular (~ 1/second) dropouts in pd=
=20
>>> while using midi.
>>
>>
>>
>> I'm not sure, but it looks like kernel problem. We don't call
>> handle_signal() function from snd_rawmidi_kernel_read1() - you may che=
ck
>> this function - scheduling is not involved. I wonder why this function=
 is
>> called from in the spinlock context.
>>
>> Please, report this problem to LKML or try the latest 2.6 kernel.
>>
>>                         Jaroslav
>>
>=20
> Hi Jaroslav,
>=20
> Doing some more tests I got also this message :
>=20
> Debug: sleeping function called from invalid context at
> include/asm/uaccess.h:498
> in_atomic():1, irqs_disabled():1
> Call Trace:
>  [<c012139c>] __might_sleep+0xac/0xe0
>  [<c0395c2d>] snd_rawmidi_kernel_write1+0x16d/0x200
>  [<c0395ea4>] snd_rawmidi_write+0x1b4/0x300
>  [<c010b2c1>] do_signal+0xe1/0xf0
>  [<c01131cf>] restore_i387_fxsave+0x8f/0xa0
>  [<c015b4f3>] vfs_write+0xd3/0x140
>  [<c015b5ff>] sys_write+0x3f/0x60
>  [<c010b4bb>] syscall_call+0x7/0xb
>=20
> The kernel functions pointed to in include/asm/usaccess.h are
> copy_to_user and copy_from_user. They are indeed called from a spinlock
> context from both snd_rawmidi_kernel_write1 and
> snd_rawmidi_kernel_read1, and are flagged might_sleep. The strange thin=
g
> is that they were already flagged might_sleep in 2.6.0, which I believe
> I compiled with CONFIG_DEBUG_SPINLOCK_SLEEP also, and I can't remember
> having the problem. On the other hand I only checked dmesg here because
> I could hear audio dropouts. Maybe the might_sleep detection code has
> been changed and is responsible for the dropouts ?
>=20
> Thomas
>=20

Hi Jaroslav,

The attached patch fixes the problem for me, but I took the obvious and=20
easy way - I may have missed something.

Thomas

--------------090403060801070507080007
Content-Type: text/plain;
 name="rawmidi.patch"
Content-Disposition: inline;
 filename="rawmidi.patch"
Content-Transfer-Encoding: 7bit

--- rawmidi.c.old	2003-10-23 16:34:52.000000000 +0200
+++ rawmidi.c	2004-02-01 15:04:15.000000000 +0100
@@ -909,10 +909,11 @@
 		if (kernel) {
 			memcpy(buf + result, runtime->buffer + runtime->appl_ptr, count1);
 		} else {
+			spin_unlock_irqrestore(&runtime->lock, flags);
 			if (copy_to_user(buf + result, runtime->buffer + runtime->appl_ptr, count1)) {
-				spin_unlock_irqrestore(&runtime->lock, flags);
 				return result > 0 ? result : -EFAULT;
 			}
+			spin_lock_irqsave(&runtime->lock, flags);
 		}
 		runtime->appl_ptr += count1;
 		runtime->appl_ptr %= runtime->buffer_size;
@@ -1133,10 +1134,13 @@
 		if (kernel) {
 			memcpy(runtime->buffer + runtime->appl_ptr, buf, count1);
 		} else {
+			spin_unlock_irqrestore(&runtime->lock, flags);
 			if (copy_from_user(runtime->buffer + runtime->appl_ptr, buf, count1)) {
+				spin_lock_irqsave(&runtime->lock, flags);
 				result = result > 0 ? result : -EFAULT;
 				goto __end;
 			}
+			spin_lock_irqsave(&runtime->lock, flags);
 		}
 		runtime->appl_ptr += count1;
 		runtime->appl_ptr %= runtime->buffer_size;

--------------090403060801070507080007--




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
