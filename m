From: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.17rc emu10k1 regression.
Date: Mon, 29 May 2006 10:50:31 -0400
Message-ID: <20060529145031.GA32274@redhat.com>
References: <20060528164015.GA13499@redhat.com> <s5hejydtbc3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 801B514E
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 16:50:34 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5hejydtbc3.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, May 29, 2006 at 11:43:56AM +0200, Takashi Iwai wrote:

 > > modprobe.conf has ..
 > > alias snd-card-0 snd-emu10k1
 > > options snd-card-0 index=0
 > > options snd-emu10k1 index=0
 > > remove snd-emu10k1 { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; }; /sbin/modprobe -r --ignore-remove snd-emu10k1
 > > 
 > > What changed ?
 > 
 > Nothing from ALSA side.  Maybe the module loading mechanism (or slot
 > order) was changed on your system.
 > 
 > The scenario is:
 > 
 > intel8x0 driver is first loaded on the first empty slot (index=0)
 > before snd-emu10k1.  Since you set index=0 module option for
 > snd-emu10k1, it tried to load on the same slot but failed.
 > 
 > A workaround is to set index=1 option for snd-intel8x0 in addition,
 > for using emu10k1 as the primary card.

The modprobe.conf also had an index=1 entry already for the intel driver.

		Dave
-- 
http://www.codemonkey.org.uk
