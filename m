From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Sat, 19 Jan 2013 13:49:26 +0800
Message-ID: <CAN8cciafDt7Upjn2WM-t8hg8=0MtntwE2_+r7zo-G=_PyQ3wNw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F53826510A
 for <alsa-devel@alsa-project.org>; Sat, 19 Jan 2013 06:49:27 +0100 (CET)
Received: by mail-ie0-f179.google.com with SMTP id k14so7333365iea.10
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 21:49:26 -0800 (PST)
In-Reply-To: <CA+S_cwrH6mjunDsn2w76Vpyk7XovOKpH0k_KoU_8SXjmisLAYw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Miro Hodak <mhodak127@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, basinilya@gmail.com, =?UTF-8?B?TWFub2xvIETDrWF6?= <diaz.manolo@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
>
> Testing latest updates in sound-unstable:
>
> commit f741c8a1f649379f8f3eb81119df2676c46075cf
> Merge: d821c1e 164a7ad
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Fri Jan 18 18:30:00 2013 +0100
>
> Playback and capture appear to work correctly with one possible caveats:
>
> Item labeled "Front" controls the level of sound through the speakers. I
would expect that it would only control sound from front HP. This happens
whether Independent HP is on and off.
>

Is it feasible to add a hint which disable the creation of virtual master
playback volume and switch ?
