From: Paul Fertser <fercerpav@gmail.com>
Subject: Re: [Intel-gfx] Problems with HDMI audio on
	Intel	DG45FC motherboard
Date: Thu, 12 Nov 2009 12:49:56 +0300
Message-ID: <20091112094956.GE22476@home.pavel.comp>
References: <0323437dc2fc33a33ec9285505a36434.squirrel@www.hardeman.nu>
	<20091029094602.GA3589@localhost>
	<20091029222932.GA1109@hardeman.nu>
	<20091102091108.GB13363@localhost>
	<20091105004655.GA25580@hardeman.nu>
	<20091105074731.GB3016@localhost>
	<b3e8c2bfd1e1ff82a1e68a4e03950238.squirrel@www.hardeman.nu>
	<20091105092209.GA23782@localhost>
	<5a703067d8395f3f80e4fb6a5227d117.squirrel@www.hardeman.nu>
	<20091111070540.GC15854@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f209.google.com (mail-fx0-f209.google.com
	[209.85.220.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AC0C1037F1
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 10:49:57 +0100 (CET)
Received: by fxm1 with SMTP id 1so5195355fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 01:49:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091111070540.GC15854@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, alsa-devel@alsa-project.org, David H??rdeman <david@hardeman.nu>
List-Id: alsa-devel@alsa-project.org

Hi,

To all the folks reading this on alsa list, sorry for the offtopic, i hope
pressing 'd' one extra time is "ok" for you.

On Wed, Nov 11, 2009 at 03:05:40PM +0800, Wu Fengguang wrote:
> > Do you think you could ask your colleagues at Intel to explain how they've
> > implemented silentstream in the windows driver?
> 
> Hmm, I'm not sure if it would be possible. I'll check it.

I'm sorry for a silly comment but that sounds so wrong in so many ways that
i just can't resist.

I'm sure you're not lying and that means that Intel internally works in a
really freaking ridiculously strange ineffective way that even bears some
signs of insanity, right?

How on Earth can it be not possible to obtain details about driver
implementation? It can't be unmaintained, therefore there're developers who
understand the codebase and for whom it shouldn't be hard to give a precise
answer. Moreover it's unlikely it's hard to determine the original author
of the feature (using git blame like facilities) and ask him about it. At
least that's how things like that generally work. I can't even imagine how
much a process must be screwed up to not allow that.

Another example about Intel is their WiMax drivers. They've written some (i
assume decent since they were accepted mainline) drivers for their
high-quality wimax chipsets. But to actually use them they require
user-space supplicant (a bit like wpa_supplicant but different enough). And
somehow it happened that the supplicant is binary x86-only (not even
amd64!). At the same time they're working on a binary supplicant for arm
(n810 wimax edition) and at the same time they're working on a "open
source" supplicant.

One less obvious manifistation of "suboptimal" code is the intel's X.org
drivers. For quite some time they relied on video bios in one way or
another instead of doing proper register-level modesetting, of course with
all ill effects attached.  And when i needed to use i915resolution to get
native mode for my laptop panel i felt like i got in some kind of absurdist
tale, and not in a nice way.

I'm sure there's some important reason behind all that but to an outsider
that looks just really frustratingly fucked up.

Wu, thank you personally for all your work and involvment and efforts! And
if you by any chance can forward my mail to some sane PR guys, please do,
it would be nice to understand that things like that are _bad_ PR.

Good luck and happy hacking, Wu :)
-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
