From: Thomas Scheunemann <thomas.scheunemann@uni-duisburg-essen.de>
Subject: Re: Backported sbxfi driver, possible fix
Date: Sat, 25 Oct 2008 21:42:55 +0200
Message-ID: <20081025194255.GA27872@rzle423.uni-duisburg.de>
References: <4900A4FA.7020300@jasonline.co.uk> <s5h63njw2c0.wl%tiwai@suse.de>
	<4900B523.3020801@jasonline.co.uk> <s5h8wsf3spl.wl%tiwai@suse.de>
	<4900DBBD.2020806@jasonline.co.uk> <s5hljwee68t.wl%tiwai@suse.de>
	<49017FBF.4030005@jasonline.co.uk> <s5hfxmm47kb.wl%tiwai@suse.de>
	<20081025130652.GA27621@rzle423.uni-duisburg.de>
	<s5hej24psn6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rzle423.uni-duisburg.de (rzle423.uni-duisburg.de [134.91.2.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 4249C2436C
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Oct 2008 21:43:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hej24psn6.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

> My solution is to use roundup_pow_of_two() instead of the own
> funciton.  This should work better in general.

I certainly agree that it is better to use an already defined function
instead of reinventing the wheel.

> Anyway, I updated the repo (and rebased, sorry), updated the snapshot,
> too.

But this new version causes an immediate reboot on my machine even with
the previously working speaker-test. If I interpret linux/log2.h correctly
the desired function should be order_base_2 instead of roundup_pow_of_two.
At least it works for me after that exchange.
