From: Ralf Baechle <ralf@linux-mips.org>
Subject: i8253 locking and PC speaker on non-{mips,x86}
Date: Sat, 28 May 2011 12:21:20 +0100
Message-ID: <20110528112120.GA9027@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from duck.linux-mips.net (h5.dl5rb.org.uk [81.2.74.5])
	by alsa0.perex.cz (Postfix) with ESMTP id C925924538
	for <alsa-devel@alsa-project.org>;
	Sat, 28 May 2011 13:21:20 +0200 (CEST)
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
To: linux-arch@linux-mips.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

No longer terribly relevant these days but ...

drivers/input/misc/pcspkr.c:

#if defined(CONFIG_MIPS) || defined(CONFIG_X86)
/* Use the global PIT lock ! */
#include <asm/i8253.h>
#else
#include <asm/8253pit.h>
static DEFINE_RAW_SPINLOCK(i8253_lock);
#endif

sound/drivers/pcsp/pcsp.h:

#if defined(CONFIG_MIPS) || defined(CONFIG_X86)
/* Use the global PIT lock ! */
#include <asm/i8253.h>
#else
#include <asm/8253pit.h>
static DEFINE_RAW_SPINLOCK(i8253_lock);

$ git grep -F pcsp.h sound/drivers/pcsp
sound/drivers/pcsp/pcsp.c:#include "pcsp.h"
sound/drivers/pcsp/pcsp_input.c:#include "pcsp.h"
sound/drivers/pcsp/pcsp_lib.c:#include "pcsp.h"
sound/drivers/pcsp/pcsp_mixer.c:#include "pcsp.h"
$ git grep -w i8253_lock sound/drivers/pcsp/
sound/drivers/pcsp/pcsp.h:static DEFINE_RAW_SPINLOCK(i8253_lock);
sound/drivers/pcsp/pcsp_input.c:        raw_spin_lock_irqsave(&i8253_lock, flags
sound/drivers/pcsp/pcsp_input.c:        raw_spin_unlock_irqrestore(&i8253_lock, 
sound/drivers/pcsp/pcsp_lib.c:          raw_spin_lock_irqsave(&i8253_lock, flags
sound/drivers/pcsp/pcsp_lib.c:          raw_spin_unlock_irqrestore(&i8253_lock, 
sound/drivers/pcsp/pcsp_lib.c:  raw_spin_lock(&i8253_lock);
sound/drivers/pcsp/pcsp_lib.c:  raw_spin_unlock(&i8253_lock);
sound/drivers/pcsp/pcsp_lib.c:  raw_spin_lock(&i8253_lock);
sound/drivers/pcsp/pcsp_lib.c:  raw_spin_unlock(&i8253_lock);

Locks are great, everybody should have their own lock!

$ find . -name 8253pit.h
./arch/powerpc/include/asm/8253pit.h
./arch/alpha/include/asm/8253pit.h
$ cat arch/*/include/asm/8253pit.h
/*
 * 8253/8254 Programmable Interval Timer
 */
/*
 * 8253/8254 Programmable Interval Timer
 */
$

Eh...

$ git grep -w PCSPKR_PLATFORM 
arch/mips/Kconfig:      select PCSPKR_PLATFORM
arch/mips/Kconfig:      select PCSPKR_PLATFORM
arch/mips/Kconfig:      select PCSPKR_PLATFORM
arch/powerpc/platforms/amigaone/Kconfig:        select PCSPKR_PLATFORM
drivers/input/misc/Kconfig:     depends on PCSPKR_PLATFORM
init/Kconfig:config PCSPKR_PLATFORM
sound/drivers/Kconfig:  depends on PCSPKR_PLATFORM && X86 && HIGH_RES_TIMERS

So works on MIPS and x86.  Compiles on PowerPC but locking is wrong.  On
Alpha can't even be selected though it sees otherwise right except the
locking and even worse for the rest.

  Ralf
