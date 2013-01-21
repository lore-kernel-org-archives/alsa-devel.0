From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Mon, 21 Jan 2013 17:18:51 +0800
Message-ID: <CAN8cciY0wv4Nn9SAMzDxDUSRtp4ab_sdQyOch+p27i64SakmaQ@mail.gmail.com>
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
 <CA+S_cwrxC3=_H-yzr166ZJQ1GqHZMUVqX3WFB6L_wcOOjC23BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 46CC32616F4
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 10:18:52 +0100 (CET)
Received: by mail-ie0-f169.google.com with SMTP id c14so9578511ieb.28
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 01:18:51 -0800 (PST)
In-Reply-To: <CA+S_cwrxC3=_H-yzr166ZJQ1GqHZMUVqX3WFB6L_wcOOjC23BA@mail.gmail.com>
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

> I have been playing with Independent HP feature and while I can get it to
work in aplay and mplayer, it does not seem to work on vlc and Skype. Both
applications seem to have options for sending sound to HPs ("AD1989B Analog
Front Speakers" or "AD1989B Analog (hw: 0,2)" - Skype only), but none of
those options sends sound to the HPs. Any thoughts on this?

Because the driver should not allow user to change the independent
headphone switch when there is any playing stream
