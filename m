From: Andy Green <andy@warmcat.com>
Subject: Re: Acer Aspire 8920g / snd-hda-intel / ALC889
Date: Tue, 06 May 2008 12:00:59 +0100
Message-ID: <48203A6B.7020408@warmcat.com>
References: <480C8260.70501@warmcat.com>	<s5hr6czb3po.wl%tiwai@suse.de>	<480CDC26.3010506@warmcat.com>	<s5h63uab2k1.wl%tiwai@suse.de>	<480DC787.9070208@warmcat.com>	<s5h3apeb0gq.wl%tiwai@suse.de>	<480DCBC6.3050203@warmcat.com>	<480FA5D5.9090208@warmcat.com>	<s5h3apakthj.wl%tiwai@suse.de>	<481F84FA.4060307@warmcat.com>
	<s5hod7jd8dc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.mog.warmcat.com (purr.warmcat.com [87.106.142.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 2614924364
	for <alsa-devel@alsa-project.org>;
	Tue,  6 May 2008 13:01:10 +0200 (CEST)
In-Reply-To: <s5hod7jd8dc.wl%tiwai@suse.de>
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

Somebody in the thread at some point said:

Hi -

> Is this above with model=acer-aspire *and* your additional verb?
> Or, is it without model option?

I tried it with model=acer (same as no forcing) and acer-aspire, I was 
able to play 2-channel PCM sounds OK only with the extra verb either 
way.  I got more controls in alsamixer with just "acer" (like low 
frequency channel), but they didn't seem to do anything useful.

> I found that one initialization is missing for auto-configuration mode
> of ALC889.  Please try the patch below and remove model=xxx option.

OK I will test this patch later today with no model forcing.

-Andy
