From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: Intel HDA / ALC662 analog surround problem
Date: Mon, 23 Feb 2015 20:27:52 +0100
Message-ID: <54eb7f49.4a51f1ff.bm000@wupperonline.de>
References: <CAN8ccibQh643hZ+owuNVj86ic2H55NOz5huwWhQVJu7fa1h=MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout4.wup.tal.de (mout4.wup.tal.de [195.8.224.254])
 by alsa0.perex.cz (Postfix) with ESMTP id 4760B260436
 for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2015 20:28:56 +0100 (CET)
In-Reply-To: <CAN8ccibQh643hZ+owuNVj86ic2H55NOz5huwWhQVJu7fa1h=MQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote on Sat, 21 Feb 2015 23:56:30 +0800:

>> 1) Does 5.1 analog surround work for the ALC662? If yes, how?

> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/plain/Documentation/sound/alsa/HD-Audio-Controls.txt
> Channel Mode
>   [...]

I know this document and while I do have the auto-mute control a channel
control is missing.

So, is the ALC662 supposed to have a channel control? (Maybe I'm missing a
kernel configuration for it, or what else could affect it?)

> Do "pcm playback volume" affect the volume after you change channel mode
> from 2ch to 6 ch so that mic and line in jacks are retasked as output ?

I can't answer, because of the lack of channel mode.

Any further help is appreciated.

Ingo
