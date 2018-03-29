From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - IOPLUG DRAIN 0/2]
Date: Thu, 29 Mar 2018 06:39:36 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FEC23@HI2EXCH01.adit-jv.com>
References: <1521726537-7651-1-git-send-email-twischer@de.adit-jv.com>
 <B0FB33DC1499054591F62C0EF1E013D7684FE451@HI2EXCH01.adit-jv.com>
 <s5hwoy39q5c.wl-tiwai@suse.de>
 <s5htvt79ptg.wl-tiwai@suse.de>,<s5hr2o4kwrn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 75B3B267063
 for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2018 08:39:43 +0200 (CEST)
In-Reply-To: <s5hr2o4kwrn.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> For the non-blocking mode, it's not supposed that drain() is called
> multiple times.  Instead, it should do the loop of snd_pcm_wait(), and
> status check, as ioplug_drain_vai_poll() actually does.

I fear the repeat call to snd_pcm_wait() when draining is active would end up in 100% CPU load as long as draining is not done because snd_pcm_wait() would immediate return due to the fact that avail > min_avail at the end of draining.

I have not tested it but I could also not find a line which would ignore the avail > min_avail short circuit of snd_pcm_wait().

Best regards

Timo
