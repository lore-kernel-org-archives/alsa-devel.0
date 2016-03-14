From: moosotc@gmail.com
Subject: Re: No audio output via built-in speaker on a
	MacMini	while headphone jack is plugged in
Date: Mon, 14 Mar 2016 21:59:25 +0300
Message-ID: <8760wo51iq.fsf@gmail.com>
References: <87pouxtr6p.fsf@gmail.com> <s5hwpp5gfx3.wl-tiwai@suse.de>
 <87r3fd3rqc.fsf@gmail.com> <s5hlh5lvtcg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 by alsa0.perex.cz (Postfix) with ESMTP id B15FC2604EF
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2016 19:59:27 +0100 (CET)
Received: by mail-lb0-f181.google.com with SMTP id oe12so15767791lbc.0
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2016 11:59:27 -0700 (PDT)
In-Reply-To: <s5hlh5lvtcg.wl-tiwai@suse.de> (Takashi Iwai's message of "Mon,
 14 Mar 2016 18:53:51 +0100")
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> On Mon, 14 Mar 2016 18:16:11 +0100,
> moosotc@gmail.com wrote:
[..snip..]

>
> As mentioned, make sure that you disable auto-mute mode:
>   amixer set "Auto-Mute Mode" "Disabled"
>
> If you still have no speaker output even after that, give alsa-info.sh
> output with non-working state, and also the alsa-info.sh output from
> the working state on the earlier kernel.

I would like to avoid checking out and building the earlier kernel if at
all possible, will do it if there's no other way forward...

-- 
mailto:moosotc@gmail.com
