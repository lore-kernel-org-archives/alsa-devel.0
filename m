From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: Re: success (WAS: playback audio overwritten before it is sent to the card)
Date: Tue, 30 Jul 2002 12:07:41 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020730190741.6476.qmail@web11505.mail.yahoo.com>
References: <s5hvg6x8dhi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11505.mail.yahoo.com (web11505.mail.yahoo.com [216.136.172.37])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id VAA05233
	for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2002 21:07:44 +0200
In-Reply-To: <s5hvg6x8dhi.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

I have now the playout AND recording alright, thanks to your explanation. Now,
I reset my pointers in prepare(), which makes pointer() return a value
meaningful to the rest of the ALSA framework.

A big THANK YOU!
Guilhem.

PS: Regarding ADPCM, I hope that we'll manage to get other bit rates in there -
I will look into this at my return from holidays (2nd-12th of August). Then
remains the problem of how one should distinguish different bit rates (I think
of checking on the driver side the runtime->sample_bits).


__________________________________________________
Do You Yahoo!?
Yahoo! Health - Feel better, live better
http://health.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
