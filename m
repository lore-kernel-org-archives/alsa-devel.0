From: Andreas Mohr <andi@lisas.de>
Subject: sb_mixer.c/save_mixer() awfully buggy?
Date: Mon, 23 Jun 2008 00:46:35 +0200
Message-ID: <20080622224635.GA2431@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 844C52439C
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 00:46:35 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

with my ALS4000, I'm hitting this upon resume:

ALSA sound/isa/sb/sb_mixer.c:936: BUG? (num_regs > (sizeof(chip->saved_regs) / sizeof(
(chip->saved_regs)[0]) + (sizeof(char[1 - 2 * !!(__builtin_types_compatible_p(typeof(c
hip->saved_regs), typeof(&chip->saved_regs[0])))]) - 1)))
Pid: 4498, comm: my_sleep Not tainted 2.6.26-rc3 #1
 [<e097ac8c>] restore_mixer+0x6c/0x70 [snd_sb_common]
 [<e097ad07>] snd_sbmixer_resume+0x77/0x80 [snd_sb_common]
 [<e098030a>] snd_als4000_resume+0x5a/0xd0 [snd_als4000]
 [<c0281a72>] pci_device_resume+0x22/0x60
 [<c0303e76>] device_resume+0x86/0x100
 [<c0145bb7>] hibernation_snapshot+0xc7/0x180
 [<c0144f9f>] ? freeze_processes+0x3f/0x80
 [<c0145d4c>] hibernate+0xdc/0x180
 [<c0144980>] ? state_store+0x0/0xd0
 [<c0144a3f>] state_store+0xbf/0xd0
 [<c0144980>] ? state_store+0x0/0xd0
 [<c02743d4>] kobj_attr_store+0x24/0x30
 [<c01aaf5b>] sysfs_write_file+0xbb/0x110
 [<c016ee56>] vfs_write+0x96/0x130
 [<c01aaea0>] ? sysfs_write_file+0x0/0x110
 [<c016f3cd>] sys_write+0x3d/0x70
 [<c0103026>] syscall_call+0x7/0xb
 =======================

triggered by this line:

static void restore_mixer(struct snd_sb *chip, unsigned char *regs, int num_regs)
{
	unsigned char *val = chip->saved_regs;
	snd_assert(num_regs > ARRAY_SIZE(chip->saved_regs), return);
	for (; num_regs; num_regs--)
		snd_sbmixer_write(chip, *regs++, *val++);
}

Uhmm, forgive my utterly dumb state of mind, but isn't this assert
_exactly_ wrong?
We assert that the number of regs to copy is _higher_ than the array
size of the content we want to copy, IOW we want to make _certain_
that we'll hit a nice array overflow or segmentation violation later.
Doesn't make too much - well, exactly zero, zilch - sense to me.

Dito save_mixer().

Forgive me if this is already fixed in ALSA head (still exists in current
2.6.26-rc7).
Sounds like 2.6.26(!) material to me if it is indeed buggy.

Thanks,

Andreas Mohr
