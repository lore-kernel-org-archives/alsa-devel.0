From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - IOPLUG DRAIN 0/2]
Date: Fri, 23 Mar 2018 07:43:10 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FE451@HI2EXCH01.adit-jv.com>
References: <1521726537-7651-1-git-send-email-twischer@de.adit-jv.com>,
 <s5h370rb68s.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id DD943267282
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 08:43:18 +0100 (CET)
In-Reply-To: <s5h370rb68s.wl-tiwai@suse.de>
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

> No, again, in non-blocking mode, the drain callback will get never
> called.  It's the responsibility of application to sync with poll()
> instead.

Sorry but I do not get it anyway.

The user application which is playing some audio has to do the following to drain in nonblocking mode, right?
snd_pcm_poll_descriptors(pfds)
while (snd_pcm_drain() == -EAGAIN) {
poll(pfds)
}


But in nonblocking mode the drain callback of the IO plugin will never be called with your solution.
Therefore in case of the pulse IO plugin which function should call pa_stream_drain()?
The user application will not do it directly and poll can also not call it.

Thanks for your time.

Best regards

Timo
