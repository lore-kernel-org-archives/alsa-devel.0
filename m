From: Patrick Welche <prlw1@cam.ac.uk>
Subject: Re: alsa on non-linux
Date: Thu, 16 Jan 2014 13:27:17 +0000
Message-ID: <20140116132717.GB10286@quark.internal.precedence.co.uk>
References: <20140110153700.GC1173@quark.internal.precedence.co.uk>
 <s5hwqi4t6zg.wl%tiwai@suse.de>
 <20140114101709.GB160@quark.internal.precedence.co.uk>
 <52D5440A.6080508@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-33.csi.cam.ac.uk (ppsw-33.csi.cam.ac.uk [131.111.8.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 97F4526171E
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 14:27:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <52D5440A.6080508@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 14, 2014 at 03:04:58PM +0100, Clemens Ladisch wrote:
> Patrick Welche wrote:
> > I started out, writing the attached patch in November, but then it looked
> > as though the boundaries of application library interface and linux sound
> > chip driver had become so blurred that I thought that a decision had been
> > taken to bin all OSes bar linux, hence the question. Can you give me a
> > hint on how you think it is supposed to work?
> 
> Only the "hw" plugins access the Linux kernel drivers.  Anything else
> should be portable (with the exception of plugins like "dmix" that
> require a "hw" plugin as their slave).
> 
> For most device types (hwdep/seq/rawmidi/timer), the hw plugin is the
> only implementation, so a portable alsa-lib has only control and pcm
> devices at the moment.

So, rephrasing for the novice that I am, e.g., include/local.h contains

#include <endian.h>
...
#if __BYTE_ORDER == __LITTLE_ENDIAN
...
#include <linux/types.h>
#include <linux/ioctl.h>

which are portability headaches. local.h is included by

src/alisp/alisp.c:#include "local.h"
src/conf.c:#include "local.h"
src/confmisc.c:#include "local.h"
src/control/control_local.h:#include "local.h"
src/control/namehint.c:#include "local.h"
src/control/setup.c:#include "local.h"
src/dlmisc.c:#include "local.h"
src/error.c:#include "local.h"
src/hwdep/hwdep_local.h:#include "local.h"
src/input.c:#include "local.h"
src/mixer/mixer_local.h:#include "local.h"
src/names.c:#include "local.h"
src/output.c:#include "local.h"
src/pcm/pcm_local.h:#include "local.h"
src/rawmidi/rawmidi_local.h:#include "local.h"
src/seq/seq_event.c:#include "local.h"
src/seq/seq_local.h:#include "local.h"
src/seq/seq_midi_event.c:#include "local.h"
src/seq/seq_old.c:#include "local.h"
src/socket.c:#include "local.h"
src/timer/timer_local.h:#include "local.h"
src/ucm/ucm_local.h:#include "local.h"

That is fine except for files under directories src/control and src/pcm
which ought to be portable? Or is it stronger, and everything should be
portable except files under directory src/hwdep?

Cheers,

Patrick
