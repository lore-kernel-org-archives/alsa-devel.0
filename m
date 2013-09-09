From: Ian Munsie <darkstarsword@gmail.com>
Subject: Re: No sound from internal speaker on 2013 Macbook Air
 6, 1
Date: Tue, 10 Sep 2013 02:32:55 +1000
Message-ID: <CAH4=b6JXFffa__GKqHep8DDCrLTB2Qv5dSe73=wcs5donSAONQ@mail.gmail.com>
References: <CAH4=b6KOs-WJ+_KVGiQ4LRC9-3J_A_xK64UcrMq6NZFxyycS_w@mail.gmail.com>
 <CAN8cciZuiRR9=iqkxYLoj==UXqYzEdVM2M85y5vg6zBYArjhSQ@mail.gmail.com>
 <CAH4=b6Km5E5v18bvKqV661kudaKkpfnHGUWNEeGEY7ngXVARnw@mail.gmail.com>
 <s5h61uabc4l.wl%tiwai@suse.de>
 <CAH4=b6+KtfWnWcY6NyP_Ls7bPGHBCnhkPJjVqDSeFUJ2Ltz=4g@mail.gmail.com>
 <s5hwqmq9vgb.wl%tiwai@suse.de>
 <CAH4=b6LM4fexo4QpFeP1Nn9X77BcGExaL8-WkQ5Q-9chioKpRQ@mail.gmail.com>
 <s5ha9jm9jeu.wl%tiwai@suse.de>
 <CAH4=b6K1d+kkbF5m72A=GALJPa59rPrg5K3FspG1_OxBcp_3dA@mail.gmail.com>
 <s5h4n9u9h3h.wl%tiwai@suse.de>
 <CAH4=b6L=+_zZ0MeELKkVi_wnLDCDi1ETCCp5PH9rgXn8JgNfZg@mail.gmail.com>
 <CAN8ccibUb-ghJZ6C6dD4BBtpeTKcGARKbStfrA=cQM9FhvaFgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f177.google.com (mail-ea0-f177.google.com
 [209.85.215.177])
 by alsa0.perex.cz (Postfix) with ESMTP id B980F26513A
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 18:33:16 +0200 (CEST)
Received: by mail-ea0-f177.google.com with SMTP id f15so3287933eak.36
 for <alsa-devel@alsa-project.org>; Mon, 09 Sep 2013 09:33:16 -0700 (PDT)
In-Reply-To: <CAN8ccibUb-ghJZ6C6dD4BBtpeTKcGARKbStfrA=cQM9FhvaFgA@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Raymond,

> Because the driver select the amp at the pin complex of the headphone
> instead of the amp at the audio output
>
> These amps have different dB min

Ahh - this is starting to make sense to me now. I'll have to look at
look_for_out_vol_nid like you suggested tomorrow.

Cheers,
-Ian

-- 
http://sites.google.com/site/DarkStarJunkSpace
--
http://darkstarshout.blogspot.com/
--
Please avoid sending me Word or PowerPoint attachments.
See http://www.gnu.org/philosophy/no-word-attachments.html
