From: Marek Peca <marek@duch.cz>
Subject: Re: Should snd_pcm_drop() interrupt snd_pcm_writei()
 call?
Date: Fri, 15 May 2009 16:41:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0905151639100.3095@tesla>
References: <Pine.LNX.4.64.0905121806240.8364@tesla>
	<Pine.LNX.4.64.0905151555550.3095@tesla>
	<s5hd4aa9z19.wl%tiwai@suse.de> <Pine.LNX.4.64.0905151625320.3095@tesla>
	<s5h4ovm9yer.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from max.feld.cvut.cz (max.feld.cvut.cz [147.32.192.36])
	by alsa0.perex.cz (Postfix) with ESMTP id D1F7D244A6
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 17:36:16 +0200 (CEST)
In-Reply-To: <s5h4ovm9yer.wl%tiwai@suse.de>
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

> A safer option is the single thread access if you want your app to
> support many different systems including old ALSA.  In addition, you
> could add a different approach depending on the version, e.g. by
> checking in configure script.

Well, I must think about it. It seems, that our app will be closely 
distributed with well-defined and recent OS/ALSA version. It may be useful 
for me to know, whether this particular two-thread access to these 
functions should be supported in present and future.

> Anyway, checking with the latest version is helpful for us ;)

Yes, I will try to check it against new ALSA version and I will tell you 
any interesting observations.


Many thanks,
Marek.
