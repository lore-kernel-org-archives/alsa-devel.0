From: Miro Hodak <mhodak127@gmail.com>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Mon, 21 Jan 2013 03:54:24 -0500
Message-ID: <CA+S_cwrxC3=_H-yzr166ZJQ1GqHZMUVqX3WFB6L_wcOOjC23BA@mail.gmail.com>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <s5hlibs154t.wl%tiwai@suse.de>
 <CA+S_cwoLe=2tUr=EyFM0TxvbBaB12DCE2yDPwf3OzoRcO8jQug@mail.gmail.com>
 <CAN8cciama4q0EOiUsjp-KyyzehcvjwmdPdBQ9vsitbnR8g1PgA@mail.gmail.com>
 <CA+S_cwrmHguxk6WBxjAJTOaV8xV-4PH0gkpibFKs1P8bRxAsAg@mail.gmail.com>
 <s5hfw1zomf2.wl%tiwai@suse.de> <20130117191224.44794728@gmail.com>
 <s5hfw1z1s6a.wl%tiwai@suse.de> <20130117214043.5a1574ee@gmail.com>
 <s5h7gnb0y5z.wl%tiwai@suse.de>
 <CA+S_cwqE6AgcVjp+wtPuJA_AcJqUvL0Ocoq_QA5JVWQVYCsYSg@mail.gmail.com>
 <20130118090839.4a0725f8@gmail.com>
 <CA+S_cwoKMERXHR14t4WK0Him=bjcRQQPJH+tX6BHyeBUv9tntg@mail.gmail.com>
 <s5hy5fqztge.wl%tiwai@suse.de> <20130118133753.3eabbb18@gmail.com>
 <s5hr4limwj2.wl%tiwai@suse.de>
 <CAN8ccibdPa+wOD99cY1sxfK0MSbUeL0MA6emiPCb93u3KMmrSg@mail.gmail.com>
 <s5hbocmmrtu.wl%tiwai@suse.de> <20130118174823.4795313b@gmail.com>
 <s5hmww6l96r.wl%tiwai@suse.de> <20130118185115.442a3d97@gmail.com>
 <20130118192047.403f52d0@gmail.com> <s5hr4liz5xi.wl%tiwai@suse.de>
 <CA+S_cwrH6mjunDsn2w76Vpyk7XovOKpH0k_KoU_8SXjmisLAYw@mail.gmail.com>
 <s5hhamdzau9.wl%tiwai@suse.de>
 <CA+S_cwqzWHf92zXj3gFHHB+SAr_7o=Z+70FMh39nKoxzvBXZRA@mail.gmail.com>
 <s5h8v7nymn7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f176.google.com (mail-ie0-f176.google.com
 [209.85.223.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 42CDB26172C
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 09:54:25 +0100 (CET)
Received: by mail-ie0-f176.google.com with SMTP id 13so9404763iea.21
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 00:54:24 -0800 (PST)
In-Reply-To: <s5h8v7nymn7.wl%tiwai@suse.de>
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>, basinilya@gmail.com, =?ISO-8859-1?Q?Manolo_D=EDaz?= <diaz.manolo@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 21, 2013 at 3:18 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 20 Jan 2013 14:54:39 -0500,
> Miro Hodak wrote:
> >
> > >
> >
> > Not always, most labels are one word long and can be open to different
> > interpretations. In alsamixer, ordering of capture controls is the
> > following:
> >
> > Master  Headphon   PCM     Front   Front Mi  Surround  Center    LFE
> > Side  Line Boo  S/PDIF  S/PDIF D Auto-Mut Independ <Rear Mic>
> >
> > and thus "Front" is next to "Front Mi" - that should connect at the
> front I
> > assume - rather then to other outputs at the back. Thus it is very easy
> to
> > get confused.
>
> I see.  Yes, the usage of the word "front" has been a problem since
> long time ago, basically because it can mean two different things: the
> position of the jack and the channel location.  But, this has been so,
> thus it's no regression to fix urgently.
>
>
> > Here are outputs as specified in my MB manual and my attempt to pair them
> > to items in alsamixer (Capture only):
> >
> > MB description                                   Alsa control (capture)
> > BACK PORTS:
> > Line In                                                  Line Boost (its
> > boost only, I know)
> > Front Speaker Out                             Front
> > Mic In                                                   Rear Mic Boost
> > Center/Subwoofer                             Center
> > Rear Speaker Out                             ???
> > Side Speaker Out                              Side
> >
> > FRONT PORTS:
> > Headphone Out                                Headphone
> > Front Mic In                                        Front Mic Boost
> >
> > There are two items that have not been assigned - Surround and LFE,
> > presumably one of them should correspond to the "Rear Speaker Out" for
> > which I could not identify ALSA control. Not being familiar with more
> than
> > 2-channle audio, I do not know how to assign these.
>
> "Surround" corresponds to the rear channel in ALSA term.
> "LFE" is a more official name of subwoofer.
>
>
> Takashi
>
Thanks for that explanation.

I have been playing with Independent HP feature and while I can get it to
work in aplay and mplayer, it does not seem to work on vlc and Skype. Both
applications seem to have options for sending sound to HPs ("AD1989B Analog
Front Speakers" or "AD1989B Analog (hw: 0,2)" - Skype only), but none of
those options sends sound to the HPs. Any thoughts on this?
