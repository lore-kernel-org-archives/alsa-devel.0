From: sylvain.bertrand@gmail.com
Subject: Re: right way to enumerate pcm devices
Date: Wed, 13 Feb 2019 22:25:18 +0000
Message-ID: <20190213222518.GA974@freedom>
References: <20190212123333.GB6441@freedom> <s5hr2cd3z9b.wl-tiwai@suse.de>
 <20190212203324.GA1399@freedom> <s5hpnrwciie.wl-tiwai@suse.de>
 <20190213141328.GA358@freedom>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 01F59267978
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2019 23:26:12 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id y185so2910386wmd.1
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2019 14:26:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20190213141328.GA358@freedom>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Ok, I think got it.

Jaroslav Kysela, thx for your intervention, actually my device does
not need fixing, it's a simple USB mic.

Takashi Iwai, ok, then it's actually the alsa-lib configuration system
which seems to be the problem, where the "bugs" should be squashed.

If I want to do the thing which I think it's right, then I would have to move
the "lines" between the user application'S' and the alsa-lib. Something
"middleground", nothing extreme like the excessively massive pulseaudio.

It boils down to how and how much the alsa-lib shares pcm devices among user
applications. I would beef up only the user applications sharing code, aka dmix
and dsnoop, and would move all the rest into the user application realm, aka
trashing almost everything else.

Each "hardware pcm" would get only 1 pcm device with integrated beefed up dmix
or dsnoop.

The "hardware fixing" would go into the kernel where I think it belongs.

As for a user application sharing policy, as I said, I would avoid the extreme
like the excessively massive pulseaudio, and would go for the middleground: the
first user application to program the pcm device does set the configuration of
it (channels,formats,etc). The other concurrent user applications
would have a way to know they were beaten in speed, and could be given the
chance to adapt (new return codes in current pcm api) to the current
configuration of the pcm device or take other action.

Access rights would be those from the file system. 

The beefed up dmix and dsnoop would expose as much as they can of the
underlying hw regarding what they can do (available mixing formats for dmix).
No more graph/chain of plugins which would be moved into the user
applications).

The configuration would be limited to THE default (maybe one for playback and
one for capture).

As for now, I would present to basic users the default pcms and filter out
anything else (at best, give a chance to input the pcm string of a specific pcm
for the most advanced basic users).

regards,

-- 
Sylvain
