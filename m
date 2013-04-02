From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH 08/10] ALSA: usb-audio: UAC2: auto clock
 selection module param
Date: Tue, 2 Apr 2013 22:27:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1304022220460.1104@xoschi>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
 <1364745152-1762-9-git-send-email-eldad@fogrefinery.com>
 <s5htxnp8geg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 91AB5265262
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2013 22:27:32 +0200 (CEST)
Received: by mail-bk0-f54.google.com with SMTP id q16so425798bkw.13
 for <alsa-devel@alsa-project.org>; Tue, 02 Apr 2013 13:27:32 -0700 (PDT)
In-Reply-To: <s5htxnp8geg.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org



On Tue, 2 Apr 2013, Takashi Iwai wrote:

> At Sun, 31 Mar 2013 17:52:30 +0200,
> Eldad Zack wrote:
> > 

> > +module_param(noautoclk, bool, 0444);
> > +MODULE_PARM_DESC(noautoclk, "Disables auto-clock selection for UAC2 devices.");
> 
> Don't use "no" for a boolean option.  You can pass "yes" or "no" as an
> option value, so it can confuse easily by passing noautoclk=yes.  See?

Ah, I understand. Good point. I'll change it to autoclock like you 
suggested (also internally).

Thanks!

I'll add some text to the other patch and repost.

Cheers,
Eldad
