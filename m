From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - JACK plugin 4/4] jack: Support
 snd_pcm_drain()
Date: Wed, 21 Mar 2018 16:47:35 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FE1A0@HI2EXCH01.adit-jv.com>
References: <s5hd10qyg05.wl-tiwai@suse.de>
 <1519910048-19732-1-git-send-email-twischer@de.adit-jv.com>
 <1519910048-19732-5-git-send-email-twischer@de.adit-jv.com>
 <3f0f0873-9544-050d-ef69-35d4b23e8c6c@perex.cz>
 <B0FB33DC1499054591F62C0EF1E013D7684FDEA1@HI2EXCH01.adit-jv.com>,
 <s5hpo3xqtfh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id B46E02670F8
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 17:47:44 +0100 (CET)
In-Reply-To: <s5hpo3xqtfh.wl-tiwai@suse.de>
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

> And this check can be done even in
> snd_pcm_ioplug_drain(), so we can fix all in a shot.

For example the drain callback of the pulse IO plugin is blocking
but we need to call this callback to inform the IO plugin that it should drain.

Therefore which solution do you have in your mind?

Best regards

Timo
