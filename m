From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
 mute LED non-workingness
Date: Mon, 04 May 2015 10:16:21 -0300
Message-ID: <1430745381.1616962.262389473.6ABEC97F@webmail.messagingengine.com>
References: <20150426152012.GE550@huh.zplane.com>
 <s5hvbgiho2o.wl-tiwai@suse.de>
 <CAN8cciZQBRz2Ty3YRt2+3KO9v1BWef-_8FU_d_SsE87mLdgY-w@mail.gmail.com>
 <s5hh9s2gj45.wl-tiwai@suse.de> <20150427135859.GI550@huh.zplane.com>
 <s5ha8xt4hsa.wl-tiwai@suse.de> <20150428000206.GK550@huh.zplane.com>
 <CAN8ccibSH6je=OpX6vOTG9PzETxikmpuX+7PDgiYNrsG+YavNw@mail.gmail.com>
 <20150502160003.GA557@huh.zplane.com>
 <1430735828.1027589.262340817.33A79FB3@webmail.messagingengine.com>
 <20150504122604.GA577@huh.zplane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id AFEB6261A57
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 15:16:22 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 0E9F120C2A
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 09:16:21 -0400 (EDT)
In-Reply-To: <20150504122604.GA577@huh.zplane.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Glenn Golden <gdg@zplane.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Alex Hung <alex.hung@canonical.com>, Raymond Yau <superquad.vortex2@gmail.com>, bruno.mueller@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 4, 2015, at 09:26, Glenn Golden wrote:
> Henrique de Moraes Holschuh <hmh@hmh.eng.br> [2015-05-04 07:37:08 -0300]:
> > On Sat, May 2, 2015, at 13:00, Glenn Golden wrote:
> > > Henrique: Can you comment on how best to proceed further here? 
> > >
> >
> > Please attach the full acpidump (use a recent enough acpidump utility,
> > please) to the bugzilla report and reply to this thread after you did so.
> > Also attach the output of dmidecode.  
> >
> 
> Done:

Well, your firmware does not have SSMS, at all.  It is not that thinkpad-acpi can't find it due to some change in the acpi core, it simply isn't there to be found.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
