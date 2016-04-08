From: Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH - alsa-lib 1/1] Change card/pid get
 functions to return -ENOSYS if the kernel is too old
Date: Fri, 8 Apr 2016 19:56:33 +0200
Message-ID: <20160408175633.GA14123@mail.zuhause>
References: <1459532030-6387-1-git-send-email-agoode@google.com>
 <20160401211558.GA20661@mail.zuhause>
 <s5hpou5a0g0.wl-tiwai@suse.de>
 <CAOf41NmK6V1MMUrQ=UwO=nttYuk3a5b63jH5VTBxeJM9px1yow@mail.gmail.com>
 <20160407201041.GB26683@mail.zuhause>
 <s5hpou0mm87.wl-tiwai@suse.de> <5707AA7C.5030804@perex.cz>
 <s5hegagmekc.wl-tiwai@suse.de>
 <CAOf41N=vdhUu+y08JZLs7c=DL_LYx4wQgxxnMkWw-eQCUT-etw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe02-2.mx.upcmail.net
 (vie01a-dmta-pe02-2.mx.upcmail.net [62.179.121.158])
 by alsa0.perex.cz (Postfix) with ESMTP id 469E626531F
 for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2016 19:56:36 +0200 (CEST)
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
 by vie01a-dmta-pe02.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <martin.koegler@chello.at>) id 1aoae3-0005uP-RT
 for alsa-devel@alsa-project.org; Fri, 08 Apr 2016 19:56:35 +0200
Content-Disposition: inline
In-Reply-To: <CAOf41N=vdhUu+y08JZLs7c=DL_LYx4wQgxxnMkWw-eQCUT-etw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Goode <agoode@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Martin Koegler <martin.koegler@chello.at>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 08, 2016 at 11:21:57AM -0400, Adam Goode wrote:
> So there are 2 alternatives I can think of:
> 
> option 1: introduce snd_seq_client_info_get_pid_2() and leave the existing
> function alone. This new function can return a new constant,
> SND_SEQ_CLIENT_INFO_PID_UNKNOWN for missing kernel support. Same for card.
> option 2: introduce snd_seq_client_info_pid_known() that returns a bool if
> there is kernel support. Same for card.

I wouldn't implement option 1. Using that methode for API changes will result in lots of rarely used functions.

Chrome will probable need that information to enable a fallback-code - if a application has no fallback code, 
it has no need for different returncodes. In a few years, most distributions will likely ship kernel including that functions,
so there is no need to for fallback-code and the kernel support check any more.

Why not a snd_seq_client_info_get_capatibilites() returing bit flags: .._CAP_CARD_NUMBER | .._CAP_PID ?

Regards,
Martin
