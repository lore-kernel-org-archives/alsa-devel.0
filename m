From: b_lkasam@codeaurora.org
Subject: KASAN tool mem leak issue
Date: Thu, 28 Dec 2017 12:13:36 +0530
Message-ID: <5c1e3d2f911602ada500b2dedd7ea2c5@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A1EA26717C
 for <alsa-devel@alsa-project.org>; Thu, 28 Dec 2017 07:43:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: rohkumar@qti.qualcomm.com, lkasam@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org

hi ALSA team,
Recently when running KASAN on our devices,
we found below KASAN failure wrt uninitialized mem access(or null-ptr 
deref) in file sound/core/timer.c.

And our codebase already have this fix 
https://www.spinics.net/lists/alsa-devel/msg63410.html
Seems issue is still present, please help check and comment.

Let me know if you need any other inputs.

Observed Result:-
==================================================================
sde_rotator ae00000.qcom,mdss_rotator: <SDEROT_WARN> invalid ioctl type 
c040563d
sde_rotator ae00000.qcom,mdss_rotator: <SDEROT_WARN> invalid ioctl type 
4c81
BUG: KASAN: null-ptr-deref in copy_to_user 
arch/arm64/include/asm/uaccess.h:398 [inline]
BUG: KASAN: null-ptr-deref in snd_timer_user_read+0x33c/0x458 
sound/core/timer.c:2010
Read of size 32 at addr           (null) by task syz-executor/2171
sde_rotator ae00000.qcom,mdss_rotator: <SDEROT_WARN> invalid output 
format 0x00000000 7x2305
CPU: 6 PID: 2171 Comm: syz-executor Tainted: G    B   W  O    4.9.65+ #1
Hardware name: Qualcomm Technologies, Inc. SDM670 PM660 + PM660L MTP 
(DT)
Call trace:
[<ffffff9ed988d390>] dump_backtrace+0x0/0x428 
arch/arm64/kernel/traps.c:76
[<ffffff9ed988d7e0>] show_stack+0x28/0x38 arch/arm64/kernel/traps.c:226
[<ffffff9ed9e2d9b8>] __dump_stack lib/dump_stack.c:15 [inline]
[<ffffff9ed9e2d9b8>] dump_stack+0xd4/0x124 lib/dump_stack.c:51
[<ffffff9ed9b1d77c>] kasan_report_error mm/kasan/report.c:345 [inline]
[<ffffff9ed9b1d77c>] kasan_report.part.2+0xdc/0x2f0 
mm/kasan/report.c:371
[<ffffff9ed9b1df44>] kasan_report+0x5c/0x70 mm/kasan/report.c:372
[<ffffff9ed9b1c434>] check_memory_region_inline mm/kasan/kasan.c:301 
[inline]
[<ffffff9ed9b1c434>] check_memory_region+0x12c/0x1c0 
mm/kasan/kasan.c:315
[<ffffff9ed9b1c4e0>] kasan_check_read+0x18/0x20 mm/kasan/kasan.c:320
[<ffffff9edad44144>] copy_to_user arch/arm64/include/asm/uaccess.h:398 
[inline]
[<ffffff9edad44144>] snd_timer_user_read+0x33c/0x458 
sound/core/timer.c:2010
[<ffffff9ed9b425e0>] __vfs_read+0xe0/0x2a0 fs/read_write.c:452
[<ffffff9ed9b43e68>] vfs_read+0xb8/0x1c0 fs/read_write.c:475
[<ffffff9ed9b461d4>] SYSC_read fs/read_write.c:591 [inline]
[<ffffff9ed9b461d4>] SyS_read+0xcc/0x170 fs/read_write.c:584
[<ffffff9ed9883f70>] el0_svc_naked+0x24/0x28
==================================================================

Thank You,
Laxminath Kasam
