From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: ALSA driver 1.0.2c: divide by zero oops
Date: Mon, 15 Mar 2004 09:47:07 +1030 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403142317.i2ENH7q05456@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi all

I have been trying cinelerra 1.1.9 in OSS mode against the OSS emulation
driver (snd-pcm-oss) from ALSA driver 1.0.2c. Whenever anything is done to
start audio playback (such as playing a video clip) the ALSA driver panics
with a divide by zero error.  The decoded oops is found below.

Under native OSS from 2.4.23 cinelerra works fine.  Furthermore, all other
OSS applications I've tried against ALSA driver 1.0.2c seem to be fine. 
Thus the problem seems to be associated with the way cinelerra does things -
something it does is upsetting ALSA but is fine under native OSS.  Of
course, even a misbehaving application not running as root should not be
able to panic the kernel.

Tracing though this it appears that the substream's rate is zero heading
into snd_pcm_timer_resolution_change and the divide by zero occurs as a
result of the final statement in this function.  Why the rate is zero to
begin with though is a mystery to me.

I've checked cinelerra/audiooss.C and the order of the OSS ioctls during 
setup at least appears to be correct.

I'll check 1.0.3 in the next day or so but in a quick check of the CVS logs
I saw nothing to indicate that anything in this area might have changed.

Anyone have any ideas?

Mar 14 14:26:04 marble kernel: CPU:    0
Mar 14 14:26:04 marble kernel: EIP:    0010:[<d8c31a28>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 14 14:26:04 marble kernel: EFLAGS: 00010246
Mar 14 14:26:04 marble kernel: eax: ee6b0000   ebx: 00008000   ecx: 00008000   edx: 00000000
Mar 14 14:26:04 marble kernel: esi: 00000000   edi: ee6b0000   ebp: d3805800   esp: ce88b918
Mar 14 14:26:04 marble kernel: ds: 0018   es: 0018   ss: 0018
Mar 14 14:26:04 marble kernel: Process cinelerra (pid: 354, stackpage=ce88b000)
Mar 14 14:26:04 marble kernel: Stack: 00000fa9 00008000 d3805800 00000001 ce88b95c c15a8d60 d8c28469 c15a8d60 
Mar 14 14:26:04 marble kernel:        00010000 ce88a000 ce88b95c cdba7400 ce88bca4 d8c28584 c15a8d60 ce88b95c 
Mar 14 14:26:04 marble kernel:        0000025c 00000000 00000008 00000000 00000000 00000000 00000000 00000000 
Mar 14 14:26:04 marble kernel: Call Trace:    [<d8c28469>] [<d8c28584>] [<d8c2b756>] [<d8c2fe96>] [<d8c2be18>]
Mar 14 14:26:04 marble kernel:   [<d8c6dad1>] [<d8c6df0e>] [<d8c6ee93>] [<c014f4c6>] [<c01a98b0>] [<c014f782>]
Mar 14 14:26:04 marble kernel:   [<c01a98b0>] [<c01a9951>] [<c0133134>] [<d8c0b6cf>] [<d8c2e65c>] [<d8c2a9dd>]
Mar 14 14:26:04 marble kernel:   [<d8c6fc92>] [<d8c6ff57>] [<c014726e>] [<d8bf3d40>] [<d8c760e0>] [<d8bf365f>]
Mar 14 14:26:04 marble kernel:   [<c013a58c>] [<c023f38e>] [<c0124fc3>] [<c013a6ee>] [<d8c6efdc>] [<d8c705cb>]
Mar 14 14:26:04 marble kernel:   [<c0148689>] [<c01090ef>]
Mar 14 14:26:04 marble kernel: Code: f7 f6 89 85 0c 02 00 00 83 c4 08 5b 5e 5f 5d c3 90 8d b4 26 


>>EIP; d8c31a28 <[snd-pcm]snd_pcm_timer_resolution_change+88/a0>   <=====

>>ebp; d3805800 <_end+13491b1c/1881c37c>
>>esp; ce88b918 <_end+e517c34/1881c37c>

Trace; d8c28469 <[snd-pcm]snd_pcm_hw_params+209/2b0>
Trace; d8c28584 <[snd-pcm]snd_pcm_hw_params_user+74/a0>
Trace; d8c2b756 <[snd-pcm]snd_pcm_playback_ioctl1+56/340>
Trace; d8c2fe96 <[snd-pcm]snd_pcm_hw_param_near+256/320>
Trace; d8c2be18 <[snd-pcm]snd_pcm_kernel_playback_ioctl+38/50>
Trace; d8c6dad1 <[snd-pcm-oss]snd_pcm_oss_change_params+3e1/7d0>
Trace; d8c6df0e <[snd-pcm-oss]snd_pcm_oss_get_active_substream+4e/60>
Trace; d8c6ee93 <[snd-pcm-oss]snd_pcm_oss_get_formats+23/140>
Trace; c014f4c6 <get_new_inode+146/160>
Trace; c01a98b0 <reiserfs_find_actor+0/40>
Trace; c014f782 <iget4+e2/f0>
Trace; c01a98b0 <reiserfs_find_actor+0/40>
Trace; c01a9951 <reiserfs_iget+61/80>
Trace; c0133134 <__alloc_pages+64/280>
Trace; d8c0b6cf <[snd]snd_kcalloc+1f/50>
Trace; d8c2e65c <[snd-pcm]snd_pcm_hw_constraint_minmax+3c/40>
Trace; d8c2a9dd <[snd-pcm]snd_pcm_hw_constraints_complete+1fd/230>
Trace; d8c6fc92 <[snd-pcm-oss]snd_pcm_oss_open_file+162/240>
Trace; d8c6ff57 <[snd-pcm-oss]snd_pcm_oss_open+1e7/2c0>
Trace; c014726e <page_follow_link+4e/50>
Trace; d8bf3d40 <[soundcore]sound_loader_lock+0/0>
Trace; d8c760e0 <[snd-pcm-oss]snd_pcm_oss_f_reg+0/48>
Trace; d8bf365f <[soundcore]soundcore_open+df/190>
Trace; c013a58c <get_chrfops+ec/100>
Trace; c023f38e <sock_write+ae/c0>
Trace; c0124fc3 <in_group_p+23/30>
Trace; c013a6ee <chrdev_open+5e/70>
Trace; d8c6efdc <[snd-pcm-oss]snd_pcm_oss_set_format+2c/60>
Trace; d8c705cb <[snd-pcm-oss]snd_pcm_oss_ioctl+4fb/790>
Trace; c0148689 <sys_ioctl+c9/250>
Trace; c01090ef <system_call+33/38>

Code;  d8c31a28 <[snd-pcm]snd_pcm_timer_resolution_change+88/a0>
00000000 <_EIP>:
Code;  d8c31a28 <[snd-pcm]snd_pcm_timer_resolution_change+88/a0>   <=====
   0:   f7 f6                     div    %esi   <=====
Code;  d8c31a2a <[snd-pcm]snd_pcm_timer_resolution_change+8a/a0>
   2:   89 85 0c 02 00 00         mov    %eax,0x20c(%ebp)
Code;  d8c31a30 <[snd-pcm]snd_pcm_timer_resolution_change+90/a0>
   8:   83 c4 08                  add    $0x8,%esp
Code;  d8c31a33 <[snd-pcm]snd_pcm_timer_resolution_change+93/a0>
   b:   5b                        pop    %ebx
Code;  d8c31a34 <[snd-pcm]snd_pcm_timer_resolution_change+94/a0>
   c:   5e                        pop    %esi
Code;  d8c31a35 <[snd-pcm]snd_pcm_timer_resolution_change+95/a0>
   d:   5f                        pop    %edi
Code;  d8c31a36 <[snd-pcm]snd_pcm_timer_resolution_change+96/a0>
   e:   5d                        pop    %ebp
Code;  d8c31a37 <[snd-pcm]snd_pcm_timer_resolution_change+97/a0>
   f:   c3                        ret    
Code;  d8c31a38 <[snd-pcm]snd_pcm_timer_resolution_change+98/a0>
  10:   90                        nop    
Code;  d8c31a39 <[snd-pcm]snd_pcm_timer_resolution_change+99/a0>
  11:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi

Regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
