From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - IOPLUG DRAIN 0/2]
Date: Thu, 22 Mar 2018 14:50:35 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FE3B3@HI2EXCH01.adit-jv.com>
References: <1521726537-7651-1-git-send-email-twischer@de.adit-jv.com>,
 <s5hr2ocp4ks.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 8581226739D
 for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2018 15:50:42 +0100 (CET)
In-Reply-To: <s5hr2ocp4ks.wl-tiwai@suse.de>
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

Hi Takashi,

but in this case each IO plugin has to have its own thread which checks for io->state == DRAINING to start draining.
For example the pulse plugin do not have an own thread.


Best regards

Timo Wischer
