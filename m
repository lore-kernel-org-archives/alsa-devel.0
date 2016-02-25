From: Thomas Klausner <tk@giga.or.at>
Subject: portability: types
Date: Fri, 26 Feb 2016 00:31:24 +0100
Message-ID: <20160225233124.GA13672@danbala.tuwien.ac.at>
References: <20160218154744.GA7454@danbala.tuwien.ac.at>
 <s5hy4ait3t8.wl-tiwai@suse.de>
 <20160223140906.GP19194@danbala.tuwien.ac.at>
 <s5h4mczzals.wl-tiwai@suse.de>
 <20160224131655.GA22682@danbala.tuwien.ac.at>
 <sfid-H20160224-163730-+070.31-1@spamfilter.osbf.lua>
 <s5h8u2adssb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from danbala.ifoer.tuwien.ac.at (danbala.ifoer.tuwien.ac.at
 [128.130.168.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 990F026145A
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 00:31:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h8u2adssb.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 24, 2016 at 04:36:36PM +0100, Takashi Iwai wrote:
> Applied now.  Thanks.

Thank you.

The next big issue is that multiple places include Linux specific
header files, easily recognizable by the path linux/*.h.

I think these are used to define unusual types like __u32, __u64,
__kernel_off_t, __kernel_pid_t. There are also a number of cases of
u_xxx_t (which don't exist on Solaris) vs. the uxxx_t defined in C99.

Many of these types have POSIX equivalents, like uint32_t, uint64_t,
off_t, pid_t.

Would it be better to switch to those, or should we define compat
#typedefs or #defines in local.h?

Cheers,
 Thomas
