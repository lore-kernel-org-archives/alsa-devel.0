From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK plugin] jack: Use internal snd_pcm_state
	to reduce amount of additional variables
Date: Thu, 15 Mar 2018 13:56:26 +0100
Message-ID: <1521118587-6319-1-git-send-email-twischer@de.adit-jv.com>
References: <s5hefl3izpf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 988F0267252
 for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2018 13:56:52 +0100 (CET)
In-Reply-To: <s5hefl3izpf.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hello Takashi,

> So in which situation would io->state and jack->state differ with each
> other?  Only DRAINING and XRUN, or in other cases?

I have extended the commit message:

Therefore this internal state variable is not always in sync with
io->state. In addition the internal state variable will be updated after
the corresponding callback function was processed and not before the
callback function was called (e.g. PREPARE and RUNNING).

Therefore the internal state will always contain the state
which is currently active.
It will keep the old state as long as the transition to the new one was successfully finished

See attached the updated patch which can be applied without conflicts.

Best regards,

Timo
