From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: Lockup with ALSA CVS on 2.4.19 SMP, 1 GB
Date: Sun, 22 Sep 2002 17:10:43 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020922161043.57962.qmail@web40606.mail.yahoo.com>
References: <s5hn0qgsyox.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0qgsyox.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 16 Sep 2002 22:58:34 +0100 (BST),
> is yours the vanilla kernel?

Yes, I compiled it myself using vanilla source.
(2.4.19, SMP, HighMem, SB Live!)

> i still don't figure out which part of the last
> change of pci_alloc_consistent hack affects it.
> it's nothing bug calling pci_alloc_consistent() with
> a proper dma_mask.

I have since rebooted the machine and reinstalled the
very latest ALSA CVS drivers *without* applying your
patch, and everything is currently working. However, I
have currently got only about 30% of my 1GB RAM in
use:

$ free -t
             total       used       free     shared   
buffers     cached
Mem:       1033544     311820     721724          0   
  16340     156860
-/+ buffers/cache:     138620     894924
Swap:       498004          0     498004
Total:     1531548     311820    1219728

It is possible that the lock-up only occurs when the
RAM is so heavily used that Linux has difficulty
finding a DMA-able buffer. I know that the old
snd_pci_hack_alloc_consistent() function failed
gracefully in this case because I witnessed just such
a failure (and posted it to this list). So maybe my
box is doomed to lock-up again in a few days? I will
be extra vigilant!

Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
