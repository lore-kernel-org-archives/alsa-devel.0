From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - IOPLUG DRAIN 0/2]
Date: Fri, 23 Mar 2018 08:21:36 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FE478@HI2EXCH01.adit-jv.com>
References: <1521726537-7651-1-git-send-email-twischer@de.adit-jv.com>,
 <s5hwoy39q5c.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id C94452673B2
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 09:21:46 +0100 (CET)
In-Reply-To: <s5hwoy39q5c.wl-tiwai@suse.de>
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

> OK, now I understand your concern.  Yes it's another missing piece,
> snd_pcm_ioplug_hw_ptr_update() needs to check the current state, and
> it drops to SETUP state instead of XRUN when it was DRAINING.
> Then application can simply do poll() and status update until it goes
> out of DRAINING state.

Okay.
Therefore the pulse plugin has to call pa_stream_drain() from its IO plug pointer callback in case of state DRAINING, right?


> But still it's outside the plugin, drain callback isn't called there.

I think this is not the best design decision because there is an IO plug callback for each state transitions.
Only for transitions to draining in nonblocking mode there will be no IO plug callback.
I think this could be confusing for some IO plugin developers.
What do you think?

Timo
