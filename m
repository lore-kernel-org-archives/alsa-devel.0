From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - JACK plugin 4/4] jack: Support
 snd_pcm_drain()
Date: Wed, 21 Mar 2018 17:02:18 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FE1C7@HI2EXCH01.adit-jv.com>
References: <s5hd10qyg05.wl-tiwai@suse.de>
 <1519910048-19732-1-git-send-email-twischer@de.adit-jv.com>
 <1519910048-19732-5-git-send-email-twischer@de.adit-jv.com>
 <3f0f0873-9544-050d-ef69-35d4b23e8c6c@perex.cz>
 <B0FB33DC1499054591F62C0EF1E013D7684FDEA1@HI2EXCH01.adit-jv.com>,
 <s5hlgelqsl1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DA402670F8
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 18:02:25 +0100 (CET)
In-Reply-To: <s5hlgelqsl1.wl-tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>It means that the pulse plugin is buggy.  And fixing in ioplug will
> fix the whole.

Possibly it is to late but I have no idea how to change the IO plug API implementation that draining of all IO plugins is working 
without changing the IO plugins it self.
When ever I am calling the drain callback of an IO plugin it is blocking
but I have to call it to signal to the IO plugin that I want to drain.

Could you possibly provide an example how to fix it?
