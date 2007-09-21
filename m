From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Pending patches for 1.0.15
Date: Fri, 21 Sep 2007 08:34:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0709210833210.8148@tm8103.perex-int.cz>
References: <s5hbqbyjuyd.wl%tiwai@suse.de>
	<1190270397.1203.1211622015@webmail.messagingengine.com>
	<s5hmyvhr6gm.wl%tiwai@suse.de>
	<1190356276.15047.1211823011@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 93D671037F6
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Sep 2007 08:34:12 +0200 (CEST)
In-Reply-To: <1190356276.15047.1211823011@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 21 Sep 2007, Clemens Ladisch wrote:

> Takashi Iwai wrote:
> > Clemens Ladisch wrote:
> > > Takashi Iwai wrote:
> > > > we're planning to release 1.0.15rc3 tomorrow.  This should be the
> > > > last candidate before 1.0.15 (hopefully).
> > > 
> > > emu10k1 doesn't work with older kernels because of the kthread stuff.
> > 
> > Doesn't work or build error?
> 
> Doesn't load because the kernel doesn't have the kthread_* functions.
> 
> > As a simplest workaround, we can put if KERNEL_VERSION >= 2.6.0 for
> > the relevant part as a patch.
> 
> Okay, did that, and a bunch of other compatibility hacks.

Thank you very much. I'm going to prepare 1.0.15rc3 now.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
