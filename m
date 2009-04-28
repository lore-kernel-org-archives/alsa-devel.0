From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Tue, 28 Apr 2009 12:15:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904281206260.25064@eeebox2.perex-int.cz>
References: <9e4733910904270650g204d2660y7e3b9ea03446a752@mail.gmail.com>
	<20090427135737.GA20591@sirena.org.uk>
	<9e4733910904270702w317c8c62vbee38230979ad121@mail.gmail.com>
	<20090427140554.GB20591@sirena.org.uk>
	<9e4733910904270716v289e6d5exaf6e17331786ea11@mail.gmail.com>
	<20090427142437.GF20591@sirena.org.uk>
	<9e4733910904270742l751e660bg66844b98fe261f23@mail.gmail.com>
	<s5h4owa5f1y.wl%tiwai@suse.de>
	<9e4733910904270804k6ed079d4h16b433b6f8a06fc7@mail.gmail.com>
	<alpine.LNX.2.00.0904271707000.25064@eeebox2.perex-int.cz>
	<20090427151512.GI20591@sirena.org.uk>
	<alpine.LNX.2.00.0904281022210.25064@eeebox2.perex-int.cz>
	<s5hiqkp16w6.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0904281131440.25064@eeebox2.perex-int.cz>
	<s5h7i1514bn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DEEA1037F1
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 12:15:26 +0200 (CEST)
In-Reply-To: <s5h7i1514bn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 28 Apr 2009, Takashi Iwai wrote:

> Well, I think it'd be better, at this moment for 2.6.30, to allow
> problematic drivers to skip the jiffies check.  Adding the fundamental
> change at this late stage is bad, especially if the change wasn't
> tested much by many others and has an influence on user-side API.
>
> So, as I proposed, we can simply add the pcm info check, and add
> BATCH flag to needed drivers.  Of course, it still requires some
> more testing, but basically it'll take back to the old behavior and
> should be safer.
>
> Meanwhile, applying the delay account patch now for 2.6.31 should be
> good (ealier is better).  It doesn't conflict with the info flag
> check, so we can work parallel.

Could we just add the runtime->delay variable without touching other code 
(pcm status), to correct the jiffies based check now? It seems like a good 
step forward to me and the lowlevel drivers will be more prepared for next 
PCM midlevel code changes.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
