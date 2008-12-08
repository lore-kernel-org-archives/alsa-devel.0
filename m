From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [patch] alsa-utils fix for intl support
Date: Mon, 8 Dec 2008 13:00:42 +0100
Message-ID: <20081208130042.1d061991@hcegtvedt>
References: <20081204152947.069fd146@hcegtvedt> <s5hhc5fp1et.wl%tiwai@suse.de>
	<20081208102905.245d257b@hcegtvedt> <s5h4p1foven.wl%tiwai@suse.de>
	<s5hbpvnvslg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (nat-132.atmel.no [80.232.32.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E043103832
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 13:00:43 +0100 (CET)
In-Reply-To: <s5hbpvnvslg.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 08 Dec 2008 12:01:15 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 08 Dec 2008 10:42:24 +0100,
> I wrote:
> > 

<snipp>

> > > Nope, still not able to find libintl.
> > 
> > Then something other is missing.
> 
> It was a typo.  Must be LDADD, not LIBADD.
> Fixed on git now.
> 

Ah, great, then I can understand that it will work :)

Just tested an updated patch (with LDADD instead of LIBADD), and it
works fine on my system.

Thanks for your help on my two patches.

-- 
Best regards,
Hans-Christian Egtvedt
