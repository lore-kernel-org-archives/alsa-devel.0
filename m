From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - IOPLUG DRAIN 0/2]
Date: Thu, 29 Mar 2018 07:38:57 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FEC75@HI2EXCH01.adit-jv.com>
References: <1521726537-7651-1-git-send-email-twischer@de.adit-jv.com>
 <B0FB33DC1499054591F62C0EF1E013D7684FE451@HI2EXCH01.adit-jv.com>
 <s5hwoy39q5c.wl-tiwai@suse.de>
 <s5htvt79ptg.wl-tiwai@suse.de>,<s5hzi2r738x.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id D6B9F26709D
 for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2018 09:39:04 +0200 (CEST)
In-Reply-To: <s5hzi2r738x.wl-tiwai@suse.de>
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

> We have to skip the avail_min check during draining.  It's already
> done in the kernel code, but forgotten in alsa-lib side.

> The fix patch is below.

Perfect.
Thanks a lot.

So I am waiting for your patch and will then adapt/test the JACK implementation with draining.

Best regards

Timo
