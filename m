From: Ian Munsie <darkstarsword@gmail.com>
Subject: Re: No sound from internal speaker on 2013 Macbook Air
 6, 1
Date: Mon, 9 Sep 2013 23:26:11 +1000
Message-ID: <CAH4=b6LM4fexo4QpFeP1Nn9X77BcGExaL8-WkQ5Q-9chioKpRQ@mail.gmail.com>
References: <CAH4=b6KOs-WJ+_KVGiQ4LRC9-3J_A_xK64UcrMq6NZFxyycS_w@mail.gmail.com>
 <CAN8cciZuiRR9=iqkxYLoj==UXqYzEdVM2M85y5vg6zBYArjhSQ@mail.gmail.com>
 <CAH4=b6Km5E5v18bvKqV661kudaKkpfnHGUWNEeGEY7ngXVARnw@mail.gmail.com>
 <s5h61uabc4l.wl%tiwai@suse.de>
 <CAH4=b6+KtfWnWcY6NyP_Ls7bPGHBCnhkPJjVqDSeFUJ2Ltz=4g@mail.gmail.com>
 <s5hwqmq9vgb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f50.google.com (mail-ee0-f50.google.com [74.125.83.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EBC6265050
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 15:26:32 +0200 (CEST)
Received: by mail-ee0-f50.google.com with SMTP id d51so3110904eek.23
 for <alsa-devel@alsa-project.org>; Mon, 09 Sep 2013 06:26:32 -0700 (PDT)
In-Reply-To: <s5hwqmq9vgb.wl%tiwai@suse.de>
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> OK, then try the patch below.

Great - that patch seems to do the trick, the speakers now are working
perfectly :)

One question - what is supposed to be responsible for muting the
speakers with the headphones plugged in? I can switch between
headphones and speakers with pavucontrol which works fine (alsamixer
shows it simply mutes the speaker control when headphones are
selected), but the speaker is not being automatically muted when
headphones are plugged in - is that something that the driver is
supposed to handle, or is that a userspace problem?

Cheers,
-Ian

-- 
http://sites.google.com/site/DarkStarJunkSpace
--
http://darkstarshout.blogspot.com/
--
Please avoid sending me Word or PowerPoint attachments.
See http://www.gnu.org/philosophy/no-word-attachments.html
