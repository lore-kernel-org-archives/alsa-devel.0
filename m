From: Glenn Golden <gdg@zplane.com>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
 mute LED non-workingness
Date: Mon, 4 May 2015 06:26:04 -0600
Message-ID: <20150504122604.GA577@huh.zplane.com>
References: <20150426152012.GE550@huh.zplane.com>
 <s5hvbgiho2o.wl-tiwai@suse.de>
 <CAN8cciZQBRz2Ty3YRt2+3KO9v1BWef-_8FU_d_SsE87mLdgY-w@mail.gmail.com>
 <s5hh9s2gj45.wl-tiwai@suse.de>
 <20150427135859.GI550@huh.zplane.com>
 <s5ha8xt4hsa.wl-tiwai@suse.de>
 <20150428000206.GK550@huh.zplane.com>
 <CAN8ccibSH6je=OpX6vOTG9PzETxikmpuX+7PDgiYNrsG+YavNw@mail.gmail.com>
 <20150502160003.GA557@huh.zplane.com>
 <1430735828.1027589.262340817.33A79FB3@webmail.messagingengine.com>
Reply-To: gdg@zplane.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.indra.com (smtp.indra.com [209.169.0.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C217A2604EF
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 14:26:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1430735828.1027589.262340817.33A79FB3@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Alex Hung <alex.hung@canonical.com>, Raymond Yau <superquad.vortex2@gmail.com>, bruno.mueller@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Henrique de Moraes Holschuh <hmh@hmh.eng.br> [2015-05-04 07:37:08 -0300]:
> On Sat, May 2, 2015, at 13:00, Glenn Golden wrote:
> > Henrique: Can you comment on how best to proceed further here? 
> >
>
> Please attach the full acpidump (use a recent enough acpidump utility,
> please) to the bugzilla report and reply to this thread after you did so.
> Also attach the output of dmidecode.  
>

Done:

    https://bugzilla.kernel.org/attachment.cgi?id=175781
    https://bugzilla.kernel.org/attachment.cgi?id=175771

Dmidump was invoked with no options. Acpidump was invoked with "-z" (verbose).

Acpidump reports version string "20150204-64 [May  3 2015]". That's the most
recent packaged version available for Arch Linux.

FYI, in case it may be relevant: Both dumps were generated under kernel 4.0.1,
not 3.19, because the machine is in heavy use with the new kernel and could
not conveniently be rebooted to 3.19.  I assumed -- perhaps wrongly -- that
the output of these dumps should be independent on kernel version, but if this
is wrong, and you need the dumps as taken under the 3.19 kernel, just let me
know, I will repost them the next time I reboot.

Thanks for your time on this.

Glenn
