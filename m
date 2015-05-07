From: Glenn Golden <gdg@zplane.com>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
 mute LED non-workingness
Date: Wed, 6 May 2015 19:47:56 -0600
Message-ID: <20150507014756.GK554@huh.zplane.com>
References: <20150427135859.GI550@huh.zplane.com>
 <s5ha8xt4hsa.wl-tiwai@suse.de>
 <20150428000206.GK550@huh.zplane.com>
 <CAN8ccibSH6je=OpX6vOTG9PzETxikmpuX+7PDgiYNrsG+YavNw@mail.gmail.com>
 <20150502160003.GA557@huh.zplane.com>
 <1430735828.1027589.262340817.33A79FB3@webmail.messagingengine.com>
 <20150504122604.GA577@huh.zplane.com>
 <1430745381.1616962.262389473.6ABEC97F@webmail.messagingengine.com>
 <20150507001557.GH554@huh.zplane.com>
 <CAN8cciZXQFfEYd_vSJ+iZS=xpdGbgrK--zV4He9wbcPLpXL=Tw@mail.gmail.com>
Reply-To: gdg@zplane.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.indra.com (smtp.indra.com [209.169.0.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 831E5264F3F
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 03:48:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAN8cciZXQFfEYd_vSJ+iZS=xpdGbgrK--zV4He9wbcPLpXL=Tw@mail.gmail.com>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Alex Hung <alex.hung@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, bruno.mueller@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Raymond Yau <superquad.vortex2@gmail.com> [2015-05-07 09:03:53 +0800]:
>
> Do your volume up/down key still work with soft_mute=1 ?
> 

Yes. But just to be clear, they are soft keys that just invoke amixer to
perform the action. No behavioral change noticed from 3.18 to 3.19 (the
latter with default boot opts, i.e. soft_mute=1)
